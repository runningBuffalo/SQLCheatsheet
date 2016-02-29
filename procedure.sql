

CheckAppointmentTimeForDateOfInjury
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# variable
	DECLARE var_assesmentType VARCHAR(50);
	DECLARE var_patientId INT;
	DECLARE var_dateOfInjury DATE;
	DECLARE var_dateOfInjuryCount INT;

	# get patient id
	SELECT patient_id, dateOfInjury
	INTO var_patientId
		, var_dateOfInjury
	FROM appointment_time as at
	WHERE at.auto = _appointmentTimeId;

	IF (var_dateOfInjury IS null OR var_dateOfInjury = ''0000-00-00'') THEN
		# if date of injury is null, it''s initial
		SET var_assesmentType = ''INITIAL'';
	ELSE
		# check if previous appointment has same date of injury
		SELECT COUNT(*)
		INTO var_dateOfInjuryCount
		FROM appointment_time as at
		WHERE at.auto <= _appointmentTimeId
			AND at.patient_id = var_patientId
			AND at.dateOfInjury = var_dateOfInjury;

		IF (var_dateOfInjuryCount > 1) THEN
			SET var_assesmentType = ''UPDATE'';
		ELSE
			SET var_assesmentType = ''INITIAL'';
		END IF;
	END IF;

	SELECT var_assesmentType as type;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


CreateNewAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# declare variables
	DECLARE var_appointment_id INT;

	# main query
	INSERT INTO appointment_time (office_id
								 , patient_id
								 , doctor_id
								 , date
								 , starts
								 , ends)
	VALUES (_officeId
			, _patientId
			, _doctorId
			, _date
			, _startTime
			, _endTime);

	# get last appointment time id
	SELECT LAST_INSERT_ID() INTO var_appointment_id FROM appointment_time LIMIT 1;

	INSERT INTO medical_encounter (id
									, date
									, chief_complaint
									, doctor
									, appointment_id
									, office_id)
	VALUES (_patientId
			, _date
			, _chiefComplaint
			, _doctorId
			, var_appointment_id
			, _officeId);

	INSERT INTO vitals (id
						, appointment_id
						, date)
	VALUES (_patientId
			, var_appointment_id
			, _date);

	INSERT INTO visit_status (appointment_id, office_id, patient_id)
	VALUES (var_appointment_id, _officeId, _patientId);

	INSERT INTO selfassesment (appointmentID)
	VALUES (var_appointment_id);

	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteAccidentReport
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM accident_report
	WHERE auto = _accidentReportId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteActiveRehabAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM active_rehab_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteActiveRehabilitation
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM activerehabilitation
	WHERE ActiveRehabilitationId = _activeRehabilitationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteAllergy
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM allergies
	WHERE auto = _allergyId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteAppointmentTimeByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM appointment_time
	WHERE auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteCondition
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM conditions
	WHERE auto = _conditionId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteCPTAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM cpt_by_aapointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteDermatomeAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM dermatome_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteFamilyHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM family_history
	WHERE auto = _familyHistoryId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteFavCPT
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM favouritecptcodes
	WHERE auto = _favCPTId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteFavIDC
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM favouriteidctcodes
	WHERE auto = _favIDCId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteIDCAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM idc_by_aapointment
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteLabOrder
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM lab_orders
	WHERE auto = _orderID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteLabOrderByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM lab_orders
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteMedicalEncounterByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM medical_encounter
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteMedication
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM medications
	WHERE auto = _medicationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteMedicationByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM medications
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteMessage
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM messages
	WHERE auto = _messageId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteMuscularSystemAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM muscular_system_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePainAggravatingFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM pain_aggravating_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePainAlleviatingFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM pain_alleviating_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePainFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM pain_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePatientFile
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE
	FROM patient_files
	WHERE auto = _pictureId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePhysicalRehabCount
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM physicalrehabcount
	WHERE administrationInputId = _administrationInputId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeletePhysicalRehabUtilizationCount
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM physicalrehabutilizationcount
	WHERE PhysicalRehabUtilizationId = _physicalRehabUtilizationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteProcedure
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM procedures
	WHERE auto = _procedureId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteRadiologyOrderByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM radiologyorder
	WHERE AppointmentId = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteReferral
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM referals
	WHERE auto = _ReferralID;

	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteReferralByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM referals
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


DeleteVitalByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	DELETE FROM vitals
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAccidentReportByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM accident_report
	WHERE patient_id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAccidentReportByPatientIdAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM accident_report
	WHERE patient_id = _patientId
		AND appointment_id = _appointmentTimeId;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetActiveRehabAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM active_rehab_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetActiveRehabAppointmentWithValueByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT ar.ActiveRehabilitationId as activerehabilitation_ActiveRehabilitationId
		, ar.Name as activerehabilitation_Name
		, ar.DoctorId as activerehabilitation_DoctorId
		, ar.Category as activerehabilitation_Category
		, ara.auto as active_rehab_by_appointment_auto
		, ara.appointmentID as active_rehab_by_appointment_appointmentID
		, ara.ActiveRehabilitationId as active_rehab_by_appointment_ActiveRehabilitationId
		, ara.Duration as active_rehab_by_appointment_Duration
		, ara.Unit as active_rehab_by_appointment_Unit
		, ara.Set as active_rehab_by_appointment_Set
		, ara.Rep as active_rehab_by_appointment_Rep
		, ara.Weight as active_rehab_by_appointment_Weight
		, ara.Goal as active_rehab_by_appointment_Goal
	FROM activerehabilitation as ar
	LEFT JOIN (SELECT * FROM active_rehab_by_appointment WHERE appointmentID = _appointmentTimeId) as ara ON ar.ActiveRehabilitationId = ara.ActiveRehabilitationId
	WHERE ar.DoctorId = _doctorId
	ORDER BY ar.Category, ar.Name;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetActiveRehabilitationByActiveRehabilitationId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM activerehabilitation
	WHERE ActiveRehabilitationId = _activeRehabilitationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetActiveRehabilitationSheetFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`contact_info`.`auto` AS `contact_info_auto`,
		`contact_info`.`id` AS `contact_info_id`,
		`contact_info`.`street_address` AS `contact_info_street_address`,
		`contact_info`.`city` AS `contact_info_city`,
		`contact_info`.`state` AS `contact_info_state`,
		`contact_info`.`zip` AS `contact_info_zip`,
		`contact_info`.`county` AS `contact_info_county`,
		`contact_info`.`country` AS `contact_info_country`,
		`contact_info`.`home_phone` AS `contact_info_home_phone`,
		`contact_info`.`mobile_phone` AS `contact_info_mobile_phone`,
		`contact_info`.`work_phone` AS `contact_info_work_phone`,
		`contact_info`.`email` AS `contact_info_email`,
		`insurance_info`.`auto` AS `insurance_info_auto`,
		`insurance_info`.`id` AS `insurance_info_id`,
		`insurance_info`.`member_id` AS `insurance_info_member_id`,
		`insurance_info`.`no_insurance` AS `insurance_info_no_insurance`,
		`insurance_info`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`insurance_info`.`policy_group` AS `insurance_info_policy_group`,
		`insurance_info`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`insurance_info`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`insurance_info`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`insurance_info`.`relationship` AS `insurance_info_relationship`,
		`insurance_info`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`insurance_info`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`insurance_info`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`insurance_info`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`insurance_info`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`insurance_info`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`insurance_info`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`insurance_info`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`insurance_info`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`insurance_info`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`insurance_info`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`insurance_info`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`insurance_info`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`insurance_info`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`insurance_info`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`insurance_info`.`plan_name` AS `insurance_info_plan_name`,
		`insurance_info`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`medical_encounter`.`auto` AS `medical_encounter_auto`,
		`medical_encounter`.`id` AS `medical_encounter_id`,
		`medical_encounter`.`date` AS `medical_encounter_date`,
		`medical_encounter`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`medical_encounter`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`medical_encounter`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`medical_encounter`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`medical_encounter`.`assesment` AS `medical_encounter_assesment`,
		`medical_encounter`.`plan` AS `medical_encounter_plan`,
		`medical_encounter`.`progress_notes` AS `medical_encounter_progress_notes`,
		`medical_encounter`.`doctor` AS `medical_encounter_doctor`,
		`medical_encounter`.`appointment_id` AS `medical_encounter_appointment_id`,
		`medical_encounter`.`referral_number` AS `medical_encounter_referral_number`,
		`medical_encounter`.`office_id` AS `medical_encounter_office_id`,
		`medical_encounter`.`checked_in` AS `medical_encounter_checked_in`,
		`medical_encounter`.`vitals` AS `medical_encounter_vitals`,
		`medical_encounter`.`visit_status` AS `medical_encounter_visit_status`,
		`medical_encounter`.`no_show` AS `medical_encounter_no_show`
	FROM `appointment_time`
	LEFT JOIN `users` ON `appointment_time`.`patient_id` = `users`.`auto`
	INNER JOIN `doctors` ON `appointment_time`.`doctor_id` = `doctors`.`auto`
	INNER JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	INNER JOIN `contact_info` ON `appointment_time`.`patient_id` = `contact_info`.`id`
	INNER JOIN `insurance_info` ON `appointment_time`.`patient_id` = `insurance_info`.`id`
	INNER JOIN `medical_encounter` ON `appointment_time`.`auto` = `medical_encounter`.`appointment_id`
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAdministrationInputByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM administrationinput
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAdministrationInputCompleteByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, DATE_FORMAT(at.dateOfInjury, ''%m/%d/%Y'') as appointment_time_dateOfInjury
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		#		, d.password as doctors_password
#		, d.doctor_ssn as doctors_doctor_ssn
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, me.otherNotes as medical_encounter_other_notes
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.height as vitals_height
		, v.temperature as vitals_temperature
		, v.bmi as vitals_bmi
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
		, ai.auto as administrationinput_auto
		, ai.physicalRehabStartDate as administrationinput_physicalRehabStartDate
		, ai.physicalRehabEndDate as administrationinput_physicalRehabEndDate
		, ai.physicalRehabApprovedVisit as administrationinput_physicalRehabApprovedVisit
		, ai.physicalRehabExtensionDate as administrationinput_physicalRehabExtensionDate
		, ai.insuranceIsRelatedToWork as administrationinput_insuranceIsRelatedToWork
		, ai.insuranceIsMVA as administrationinput_insuranceIsMVA
		, ai.insuranceFormOfPayment as administrationinput_insuranceFormOfPayment
		, ai.insuranceCompany as administrationinput_insuranceCompany
		, ai.insuranceCompanyAddress as administrationinput_insuranceCompanyAddress
		, ai.insuranceCompanyCity as administrationinput_insuranceCompanyCity
		, ai.insuranceCompanyState as administrationinput_insuranceCompanyState
		, ai.insuranceCompanyZip as administrationinput_insuranceCompanyZip
		, ai.insuranceCompanyAdjustor as administrationinput_insuranceCompanyAdjustor
		, ai.insuranceCompanyPhone as administrationinput_insuranceCompanyPhone
		, ai.insuranceCompanyFax as administrationinput_insuranceCompanyFax
		, ai.insuredName as administrationinput_insuredName
		, ai.relationshipToInsured as administrationinput_relationshipToInsured
		, ai.insurancePolicyNumber as administrationinput_insurancePolicyNumber
		, ai.insuranceGroupNumber as administrationinput_insuranceGroupNumber
		, ai.insuranceType as administrationinput_insuranceType
		, ai.insuranceEffectiveDate as administrationinput_insuranceEffectiveDate
		, ai.insuranceCalendarYear as administrationinput_insuranceCalendarYear
		, ai.insurancePlanYearFrom as administrationinput_insurancePlanYearFrom
		, ai.insurancePlanYearTo as administrationinput_insurancePlanYearTo
		, ai.insuranceplanRequiresReferral as administrationinput_insuranceplanRequiresReferral
		, ai.insurancePlanRequiresDeductible as administrationinput_insurancePlanRequiresDeductible
		, ai.insuranceIndividualDeductibleAmount as administrationinput_insuranceIndividualDeductibleAmount
		, ai.insuranceFamilyDeductibleAmount as administrationinput_insuranceFamilyDeductibleAmount
		, ai.insuranceDeductibleSatisfied as administrationinput_insuranceDeductibleSatisfied
		, ai.insuranceDeductibleRemainingAmount as administrationinput_insuranceDeductibleRemainingAmount
		, ai.insuranceCoverageAfterDeductibleAmount as administrationinput_insuranceCoverageAfterDeductibleAmount
		, ai.insuranceCoverageAfterDeductiblePercent as administrationinput_insuranceCoverageAfterDeductiblePercent
		, ai.insuranceMaximumAmountPerYear as administrationinput_insuranceMaximumAmountPerYear
		, ai.insuranceMaximumAmountPerYearAmount as administrationinput_insuranceMaximumAmountPerYearAmount
		, ai.insuranceMaximumAmountBeenUsed as administrationinput_insuranceMaximumAmountBeenUsed
		, ai.insuranceMaximumAmountBeenUsedCount as administrationinput_insuranceMaximumAmountBeenUsedCount
		, ai.insuranceMaximumAmountPerVisit as administrationinput_insuranceMaximumAmountPerVisit
		, ai.insuranceMaximumAmountPerVisitCount as administrationinput_insuranceMaximumAmountPerVisitCount
		, ai.insuranceLimitVisitPerYear as administrationinput_insuranceLimitVisitPerYear
		, ai.insuranceLimitVisitPerYearCount as administrationinput_insuranceLimitVisitPerYearCount
		, ai.CPT99202 as administrationinput_CPT99202
		, ai.CPT99214 as administrationinput_CPT99214
		, ai.insuranceEvalManagementExamCodeSeparateCopay as administrationinput_insuranceEvalManagementExamCodeSeparateCopay
		, ai.insuranceEvalManagementExamCodeSeparateCopayAmount as administrationinput_insuranceEvalManagementExamCodeSeparateCopayAmount
		, ai.IDC97010 as administrationinput_IDC97010
		, ai.IDC97035 as administrationinput_IDC97035
		, ai.IDC97012 as administrationinput_IDC97012
		, ai.IDC97014 as administrationinput_IDC97014
		, ai.insuranceModalitiesSeparateCopay as administrationinput_insuranceModalitiesSeparateCopay
		, ai.insuranceModalitiesSeparateCopayAmount as administrationinput_insuranceModalitiesSeparateCopayAmount
		, ai.insuranceModalitiesMaxVisit as administrationinput_insuranceModalitiesMaxVisit
		, ai.IDC97112 as administrationinput_IDC97112
		, ai.IDC97530 as administrationinput_IDC97530
		, ai.IDC97110 as administrationinput_IDC97110
		, ai.IDC97140 as administrationinput_IDC97140
		, ai.insurancePhysicalMedicineRehabSeparateCopay as administrationinput_insurancePhysicalMedicineRehabSeparateCopay
		, ai.insurancePhysicalMedicineRehabSeparateCopayAmount as administrationinput_insurancePhysicalMedicineRehabSeparateCopayAmount
		, ai.insurancePhysicalMedicineRehabMaxPerVisit as administrationinput_insurancePhysicalMedicineRehabMaxPerVisit
		, ai.IDC98940 as administrationinput_IDC98940
		, ai.IDC98941 as administrationinput_IDC98941
		, ai.insuranceChiropracticSeparateCopay as administrationinput_insuranceChiropracticSeparateCopay
		, ai.insuranceChiropracticSeparateCopayAmount as administrationinput_insuranceChiropracticSeparateCopayAmount
		, ai.insuranceClaimAddress as administrationinput_insuranceClaimAddress
		, ai.insuranceClaimCity as administrationinput_insuranceClaimCity
		, ai.insuranceClaimState as administrationinput_insuranceClaimState
		, ai.insuranceClaimZip as administrationinput_insuranceClaimZip
		, ai.insuranceClaimNumber as administrationinput_insuranceClaimNumber
		, ai.insuranceClaimCallDate as administrationinput_insuranceClaimCallDate
		, ai.insuranceClaimCallTime as administrationinput_insuranceClaimCallTime
		, ai.insuranceClaimCallSpokenTo as administrationinput_insuranceClaimCallSpokenTo
		, ai.insuranceClaimCallLogNumber as administrationinput_insuranceClaimCallLogNumber
		, ai.workerCompClaimNumber as administrationinput_workerCompClaimNumber
		, ai.dateOfInjury as administrationinput_dateOfInjury
		, ai.isInNetwork as administrationinput_isInNetwork
		, ai.nurseCaseManager as administrationinput_nurseCaseManager
		, ai.nurseCaseManagerPhone as administrationinput_nurseCaseManagerPhone
		, ai.nurseCaseManagerFax as administrationinput_nurseCaseManagerFax
		, ai.compensableInjuries as administrationinput_compensableInjuries
		, ai.preauthorizationCode as administrationinput_preauthorizationCode
		, ai.preauthorizationCodePhone as administrationinput_preauthorizationCodePhone
		, ai.preauthorizationCodeFax as administrationinput_preauthorizationCodeFax
		, ai.referralDoctorName as administrationinput_referralDoctorName
		, ai.referralDoctorSpecialty as administrationinput_referralDoctorSpecialty
		, ai.referralDoctorAddress as administrationinput_referralDoctorAddress
		, ai.referralDoctorCity as administrationinput_referralDoctorCity
		, ai.referralDoctorState as administrationinput_referralDoctorState
		, ai.referralDoctorZip as administrationinput_referralDoctorZip
		, ai.referralDoctorPhone as administrationinput_referralDoctorPhone
		, ai.referralDoctorFax as administrationinput_referralDoctorFax
		, ai.attorneyName as administrationinput_attorneyName
		, ai.attorneyLegalAssistant as administrationinput_attorneyLegalAssistant
		, ai.attorneyAddress as administrationinput_attorneyAddress
		, ai.attorneyCity as administrationinput_attorneyCity
		, ai.attorneyState as administrationinput_attorneyState
		, ai.attorneyZip as administrationinput_attorneyZip
		, ai.attorneyPhone as administrationinput_attorneyPhone
		, ai.attorneyFax as administrationinput_attorneyFax
		, ai.compensableInjuriesVerifiedByName as administrationinput_compensableInjuriesVerifiedByName
		, ai.compensableInjuriesSpokenTo as administrationinput_compensableInjuriesSpokenTo
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM medical_encounter
				WHERE appointment_id = _appointmentTimeId
				ORDER BY date DESC
				LIMIT 1) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				WHERE appointment_id = _appointmentTimeId
				ORDER BY auto DESC
				LIMIT 1) as v ON at.auto = v.appointment_id
	LEFT JOIN administrationinput as ai ON at.auto = ai.appointmentID
	WHERE at.auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAllergyByAllergy
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM allergies
	WHERE allergy = _name AND id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAllergyByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM allergies
	WHERE id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM appointment_time
	WHERE auto = _appointmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# declare variables for subquery in join statement in main query
	DECLARE var_patient_id, var_doctor_id INT;

	# populate variables
	SELECT at.patient_id
		, at.doctor_id
	INTO var_patient_id
		, var_doctor_id
	FROM appointment_time as at
	WHERE at.auto = _appointmentTimeId;

	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, at.dateOfInjury as appointment_time_dateOfInjury
		, at.appointment_status as appointment_time_appointment_status
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, if(p.profilePicture is null, "patientPicture/noPicture.png", CONCAT(''patientThumbnails/'',p.profilePicture)) as patient_profilePicture
		, pg.auto as patient_gallery_auto
		, pg.patient_id as patient_gallery_patient_id
		#		, pg.appointment_in as patient_gallery_appointment_in
#		, pg.office_id as patient_gallery_office_id
		, pg.date as patient_gallery_date
		, pg.path as patient_gallery_path
		, CONCAT(''patientPicture/'', pg.file_name) as patient_gallery_file_name
		, pg.notes as patient_gallery_notes
		, pg.profile as patient_gallery_profile
		, pg.profile_date as patient_gallery_profile_date
		, ci.auto as contact_info_auto
		, ci.id as contact_info_id
		, ci.street_address as contact_info_street_address
		, ci.city as contact_info_city
		, ci.state as contact_info_state
		, ci.zip as contact_info_zip
		, ci.county as contact_info_county
		, ci.country as contact_info_country
		, ci.home_phone as contact_info_home_phone
		, ci.mobile_phone as contact_info_mobile_phone
		, ci.work_phone as contact_info_work_phone
		, ci.email as contact_info_email
		, ec.auto as emergency_contact_auto
		, ec.userID as emergency_contact_userID
		, ec.first_name as emergency_contact_first_name
		, ec.middlename as emergency_contact_middlename
		, ec.last_name as emergency_contact_last_name
		, ec.street_address as emergency_contact_street_address
		, ec.city as emergency_contact_city
		, ec.state as emergency_contact_state
		, ec.zip as emergency_contact_zip
		, ec.relationship as emergency_contact_relationship
		, ec.home_number as emergency_contact_home_number
		, ec.cell_number as emergency_contact_cell_number
		, e.auto as employment_auto
		, e.userID as employment_userID
		, e.ocupation as employment_ocupation
		, e.employer as employment_employer
		, e.street_address as employment_street_address
		, e.city as employment_city
		, e.state as employment_state
		, e.zip as employment_zip
		, e.student_fulltime as employment_student_fulltime
		, e.student_part_time as employment_student_part_time
		, e.school_name as employment_school_name
		, e.date as employment_date
		, e.telephone as employment_telephone
		, e.fax as employment_fax
		, ii.auto as insurance_info_auto
		, ii.id as insurance_info_id
		, ii.member_id as insurance_info_member_id
		, ii.no_insurance as insurance_info_no_insurance
		, ii.insurance_Company as insurance_info_insurance_Company
		, ii.policy_group as insurance_info_policy_group
		, ii.primary_beneficiary_first_name as insurance_info_primary_beneficiary_first_name
		, ii.primary_beneficiary_middle_name as insurance_info_primary_beneficiary_middle_name
		, ii.primary_beneficiary_last_name as insurance_info_primary_beneficiary_last_name
		, ii.relationship as insurance_info_relationship
		, ii.beneficiary_id as insurance_info_beneficiary_id
		, ii.beneficiary_ssn as insurance_info_beneficiary_ssn
		, ii.beneficiary_DOB as insurance_info_beneficiary_DOB
		, ii.beneficiary_sex as insurance_info_beneficiary_sex
		, ii.beneficiary_employment as insurance_info_beneficiary_employment
		, ii.beneficiary_address as insurance_info_beneficiary_address
		, ii.beneficiary_city as insurance_info_beneficiary_city
		, ii.beneficiary_state as insurance_info_beneficiary_state
		, ii.beneficiary_zip as insurance_info_beneficiary_zip
		, ii.beneficiary_phone as insurance_info_beneficiary_phone
		, ii.beneficiary_insurance_copmany as insurance_info_beneficiary_insurance_copmany
		, ii.beneficiary_plan_name as insurance_info_beneficiary_plan_name
		, ii.beneficiary_policy_group as insurance_info_beneficiary_policy_group
		, fr.auto as financial_responsability_auto
		, fr.userID as financial_responsability_userID
		, fr.self_responsable as financial_responsability_self_responsable
		, fr.first_name as financial_responsability_first_name
		, fr.middlename as financial_responsability_middlename
		, fr.last_name as financial_responsability_last_name
		, fr.street_address as financial_responsability_street_address
		, fr.city as financial_responsability_city
		, fr.state as financial_responsability_state
		, fr.zip as financial_responsability_zip
		, fr.home_phone as financial_responsability_home_phone
		, fr.mobile_number as financial_responsability_mobile_number
		, fr.relationship financial_responsability_relationship
		, fr.sex as financial_responsability_sex
		, fr.ss_number as financial_responsability_ss_number
		, fr.driver_lisence as financial_responsability_driver_lisence
		, fr.birth_date as financial_responsability_birth_date
		, fr.employer as financial_responsability_employer
		, fr.employer_address as financial_responsability_employer_address
		, fr.employer_city as financial_responsability_employer_city
		, fr.employer_state as financial_responsability_employer_state
		, fr.employer_zip as financial_responsability_employer_zip
		, fr.employer_phone as financial_responsability_employer_phone
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		#		, d.password as doctors_password
#		, d.doctor_ssn as doctors_doctor_ssn
		, dg.auto as doctor_gallery_auto
		, dg.doctor_id as doctor_gallery_doctor_id
		#		, dg.office_id as doctor_gallery_office_id
		, dg.date as doctor_gallery_date
		, dg.path as doctor_gallery_path
		, dg.file_name as doctor_gallery_file_name
		, dg.notes as doctor_gallery_notes
		, dg.extra as doctor_gallery_extra
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, me.otherNotes as medical_encounter_other_notes
		, vs.auto as visit_status_auto
		#		, vs.office_id as visit_status_office_id
		, vs.appointment_id as visit_status_appointment_id
		#		, vs.patient_id as visit_status_patient_id
		, vs.in_waiting_room as visit_status_in_waiting_room
		, vs.check_in as visit_status_check_in
		, vs.vitals_start as visit_status_vitals_start
		, vs.vitals_end as visit_status_vitals_end
		, vs.encounter_start as visit_status_encounter_start
		, vs.encounter_room as visit_status_encounter_room
		, vs.encounter_end as visit_status_encounter_end
		, vs.checkout as visit_status_checkout
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.height as vitals_height
		, v.temperature as vitals_temperature
		, v.bmi as vitals_bmi
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN (SELECT *
				FROM patient_gallery
				WHERE patient_id = var_patient_id
				AND profile = 1
				ORDER BY auto DESC
				LIMIT 1) as pg ON p.auto = pg.patient_id
	LEFT JOIN (SELECT *
				FROM contact_info
				WHERE id = var_patient_id
				ORDER BY auto DESC
				LIMIT 1) as ci ON p.auto = ci.id
	LEFT JOIN (SELECT *
				FROM emergency_contact
				WHERE userID = var_patient_id
				ORDER BY auto DESC
				LIMIT 1) as ec ON p.auto = ec.userID
	LEFT JOIN (SELECT *
				FROM employment
				WHERE userID = var_patient_id
				ORDER BY auto DESC
				LIMIT 1) as e ON p.auto = e.userID
	LEFT JOIN (SELECT *
				FROM insurance_info
				WHERE id = var_patient_id
				ORDER BY auto DESC
				LIMIT 1) as ii ON p.auto = ii.id
	LEFT JOIN (SELECT *
				FROM financial_responsability
				WHERE userID = var_patient_id
				ORDER BY auto DESC
				LIMIT 1) as fr ON p.auto = fr.userID
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM doctor_gallery
				WHERE doctor_id = var_doctor_id
				ORDER BY auto DESC
				LIMIT 1) as dg ON d.auto = dg.doctor_id
	LEFT JOIN (SELECT *
				FROM medical_encounter
				WHERE appointment_id = _appointmentTimeId
				ORDER BY date DESC
				LIMIT 1) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM visit_status
				WHERE appointment_id = _appointmentTimeId
				ORDER BY auto DESC
				LIMIT 1) as vs ON at.auto = vs.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				WHERE appointment_id = _appointmentTimeId
				ORDER BY auto DESC
				LIMIT 1) as v ON at.auto = v.appointment_id
	WHERE at.auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentRequestConfirmedByOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM appointment_request
	WHERE comfirmed = 0
	AND office_id = _officeId
	ORDER BY date DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointments
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		-- , DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.date as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, p.auto as users_auto
		, p.account as users_account
		-- , p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
	FROM appointment_time as at
	JOIN users as p ON at.patient_id = p.auto
	ORDER BY at.date DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentsByDateOfficeIdDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, at.date as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, at.appointment_status as appointment_appointment_status
		, at.dateOfInjury as appointment_date_of_injury
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, pg.auto as patient_gallery_auto
		, pg.patient_id as patient_gallery_patient_id
		#		, pg.appointment_in as patient_gallery_appointment_in
#		, pg.office_id as patient_gallery_office_id
		, pg.date as patient_gallery_date
		, pg.path as patient_gallery_path
		, pg.file_name as patient_gallery_file_name
		, pg.notes as patient_gallery_notes
		, pg.profile as patient_gallery_profile
		, pg.profile_date as patient_gallery_profile_date
		, ci.auto as contact_info_auto
		, ci.id as contact_info_id
		, ci.street_address as contact_info_street_address
		, ci.city as contact_info_city
		, ci.state as contact_info_state
		, ci.zip as contact_info_zip
		, ci.county as contact_info_county
		, ci.country as contact_info_country
		, ci.home_phone as contact_info_home_phone
		, ci.mobile_phone as contact_info_mobile_phone
		, ci.work_phone as contact_info_work_phone
		, ci.email as contact_info_email
		, ec.auto as emergency_contact_auto
		, ec.userID as emergency_contact_userID
		, ec.first_name as emergency_contact_first_name
		, ec.middlename as emergency_contact_middlename
		, ec.last_name as emergency_contact_last_name
		, ec.street_address as emergency_contact_street_address
		, ec.city as emergency_contact_city
		, ec.state as emergency_contact_state
		, ec.zip as emergency_contact_zip
		, ec.relationship as emergency_contact_relationship
		, ec.home_number as emergency_contact_home_number
		, ec.cell_number as emergency_contact_cell_number
		, e.auto as employment_auto
		, e.userID as employment_userID
		, e.ocupation as employment_ocupation
		, e.employer as employment_employer
		, e.street_address as employment_street_address
		, e.city as employment_city
		, e.state as employment_state
		, e.zip as employment_zip
		, e.student_fulltime as employment_student_fulltime
		, e.student_part_time as employment_student_part_time
		, e.school_name as employment_school_name
		, e.date as employment_date
		, e.telephone as employment_telephone
		, e.fax as employment_fax
		, ii.auto as insurance_info_auto
		, ii.id as insurance_info_id
		, ii.member_id as insurance_info_member_id
		, ii.no_insurance as insurance_info_no_insurance
		, ii.insurance_Company as insurance_info_insurance_Company
		, ii.policy_group as insurance_info_policy_group
		, ii.primary_beneficiary_first_name as insurance_info_primary_beneficiary_first_name
		, ii.primary_beneficiary_middle_name as insurance_info_primary_beneficiary_middle_name
		, ii.primary_beneficiary_last_name as insurance_info_primary_beneficiary_last_name
		, ii.relationship as insurance_info_relationship
		, ii.beneficiary_id as insurance_info_beneficiary_id
		, ii.beneficiary_ssn as insurance_info_beneficiary_ssn
		, ii.beneficiary_DOB as insurance_info_beneficiary_DOB
		, ii.beneficiary_sex as insurance_info_beneficiary_sex
		, ii.beneficiary_employment as insurance_info_beneficiary_employment
		, ii.beneficiary_address as insurance_info_beneficiary_address
		, ii.beneficiary_city as insurance_info_beneficiary_city
		, ii.beneficiary_state as insurance_info_beneficiary_state
		, ii.beneficiary_zip as insurance_info_beneficiary_zip
		, ii.beneficiary_phone as insurance_info_beneficiary_phone
		, ii.beneficiary_insurance_copmany as insurance_info_beneficiary_insurance_copmany
		, ii.beneficiary_plan_name as insurance_info_beneficiary_plan_name
		, ii.beneficiary_policy_group as insurance_info_beneficiary_policy_group
		, fr.auto as financial_responsability_auto
		, fr.userID as financial_responsability_userID
		, fr.self_responsable as financial_responsability_self_responsable
		, fr.first_name as financial_responsability_first_name
		, fr.middlename as financial_responsability_middlename
		, fr.last_name as financial_responsability_last_name
		, fr.street_address as financial_responsability_street_address
		, fr.city as financial_responsability_city
		, fr.state as financial_responsability_state
		, fr.zip as financial_responsability_zip
		, fr.home_phone as financial_responsability_home_phone
		, fr.mobile_number as financial_responsability_mobile_number
		, fr.relationship financial_responsability_relationship
		, fr.sex as financial_responsability_sex
		, fr.ss_number as financial_responsability_ss_number
		, fr.driver_lisence as financial_responsability_driver_lisence
		, fr.birth_date as financial_responsability_birth_date
		, fr.employer as financial_responsability_employer
		, fr.employer_address as financial_responsability_employer_address
		, fr.employer_city as financial_responsability_employer_city
		, fr.employer_state as financial_responsability_employer_state
		, fr.employer_zip as financial_responsability_employer_zip
		, fr.employer_phone as financial_responsability_employer_phone
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		, d.password as doctors_password
		, d.doctor_ssn as doctors_doctor_ssn
		, dg.auto as doctor_gallery_auto
		, dg.doctor_id as doctor_gallery_doctor_id
		#		, dg.office_id as doctor_gallery_office_id
		, dg.date as doctor_gallery_date
		, dg.path as doctor_gallery_path
		, dg.file_name as doctor_gallery_file_name
		, dg.notes as doctor_gallery_notes
		, dg.extra as doctor_gallery_extra
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, vs.auto as visit_status_auto
		#		, vs.office_id as visit_status_office_id
		, vs.appointment_id as visit_status_appointment_id
		#		, vs.patient_id as visit_status_patient_id
		, vs.in_waiting_room as visit_status_in_waiting_room
		, vs.check_in as visit_status_check_in
		, vs.vitals_start as visit_status_vitals_start
		, vs.vitals_end as visit_status_vitals_end
		, vs.encounter_start as visit_status_encounter_start
		, vs.encounter_room as visit_status_encounter_room
		, vs.encounter_end as visit_status_encounter_end
		, vs.checkout as visit_status_checkout
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.temperature as vitals_temperature
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN (SELECT *
				FROM patient_gallery
				WHERE profile = 1
				GROUP BY patient_id
				ORDER BY auto DESC) as pg ON p.auto = pg.patient_id
	LEFT JOIN (SELECT *
				FROM contact_info
				GROUP BY id
				ORDER BY auto DESC) as ci ON p.auto = ci.id
	LEFT JOIN (SELECT *
				FROM emergency_contact
				GROUP BY userID
				ORDER BY auto DESC) as ec ON p.auto = ec.userID
	LEFT JOIN (SELECT *
				FROM employment
				GROUP BY userID
				ORDER BY auto DESC) as e ON p.auto = e.userID
	LEFT JOIN (SELECT *
				FROM insurance_info
				GROUP BY id
				ORDER BY auto DESC) as ii ON p.auto = ii.id
	LEFT JOIN (SELECT *
				FROM financial_responsability
				GROUP BY userID
				ORDER BY auto DESC) as fr ON p.auto = fr.userID
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM doctor_gallery
				GROUP BY doctor_id
				ORDER BY auto DESC) as dg ON d.auto = dg.doctor_id
	LEFT JOIN (SELECT *
				FROM medical_encounter
				GROUP BY appointment_id
				ORDER BY date DESC) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM visit_status
				GROUP BY appointment_id
				ORDER BY auto DESC) as vs ON at.auto = vs.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				GROUP BY appointment_id
				ORDER BY auto DESC) as v ON at.auto = v.appointment_id
	WHERE at.date = _date
		AND at.office_id = _officeId
		AND at.doctor_id = _doctorId
	ORDER BY at.starts;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentsByDoctorIdOfficeIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, at.date as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, pg.auto as patient_gallery_auto
		, pg.patient_id as patient_gallery_patient_id
		#		, pg.appointment_in as patient_gallery_appointment_in
#		, pg.office_id as patient_gallery_office_id
		, pg.date as patient_gallery_date
		, pg.path as patient_gallery_path
		, pg.file_name as patient_gallery_file_name
		, pg.notes as patient_gallery_notes
		, pg.profile as patient_gallery_profile
		, pg.profile_date as patient_gallery_profile_date
		, ci.auto as contact_info_auto
		, ci.id as contact_info_id
		, ci.street_address as contact_info_street_address
		, ci.city as contact_info_city
		, ci.state as contact_info_state
		, ci.zip as contact_info_zip
		, ci.county as contact_info_county
		, ci.country as contact_info_country
		, ci.home_phone as contact_info_home_phone
		, ci.mobile_phone as contact_info_mobile_phone
		, ci.work_phone as contact_info_work_phone
		, ci.email as contact_info_email
		, ec.auto as emergency_contact_auto
		, ec.userID as emergency_contact_userID
		, ec.first_name as emergency_contact_first_name
		, ec.middlename as emergency_contact_middlename
		, ec.last_name as emergency_contact_last_name
		, ec.street_address as emergency_contact_street_address
		, ec.city as emergency_contact_city
		, ec.state as emergency_contact_state
		, ec.zip as emergency_contact_zip
		, ec.relationship as emergency_contact_relationship
		, ec.home_number as emergency_contact_home_number
		, ec.cell_number as emergency_contact_cell_number
		, e.auto as employment_auto
		, e.userID as employment_userID
		, e.ocupation as employment_ocupation
		, e.employer as employment_employer
		, e.street_address as employment_street_address
		, e.city as employment_city
		, e.state as employment_state
		, e.zip as employment_zip
		, e.student_fulltime as employment_student_fulltime
		, e.student_part_time as employment_student_part_time
		, e.school_name as employment_school_name
		, e.date as employment_date
		, e.telephone as employment_telephone
		, e.fax as employment_fax
		, ii.auto as insurance_info_auto
		, ii.id as insurance_info_id
		, ii.member_id as insurance_info_member_id
		, ii.no_insurance as insurance_info_no_insurance
		, ii.insurance_Company as insurance_info_insurance_Company
		, ii.policy_group as insurance_info_policy_group
		, ii.primary_beneficiary_first_name as insurance_info_primary_beneficiary_first_name
		, ii.primary_beneficiary_middle_name as insurance_info_primary_beneficiary_middle_name
		, ii.primary_beneficiary_last_name as insurance_info_primary_beneficiary_last_name
		, ii.relationship as insurance_info_relationship
		, ii.beneficiary_id as insurance_info_beneficiary_id
		, ii.beneficiary_ssn as insurance_info_beneficiary_ssn
		, ii.beneficiary_DOB as insurance_info_beneficiary_DOB
		, ii.beneficiary_sex as insurance_info_beneficiary_sex
		, ii.beneficiary_employment as insurance_info_beneficiary_employment
		, ii.beneficiary_address as insurance_info_beneficiary_address
		, ii.beneficiary_city as insurance_info_beneficiary_city
		, ii.beneficiary_state as insurance_info_beneficiary_state
		, ii.beneficiary_zip as insurance_info_beneficiary_zip
		, ii.beneficiary_phone as insurance_info_beneficiary_phone
		, ii.beneficiary_insurance_copmany as insurance_info_beneficiary_insurance_copmany
		, ii.beneficiary_plan_name as insurance_info_beneficiary_plan_name
		, ii.beneficiary_policy_group as insurance_info_beneficiary_policy_group
		, fr.auto as financial_responsability_auto
		, fr.userID as financial_responsability_userID
		, fr.self_responsable as financial_responsability_self_responsable
		, fr.first_name as financial_responsability_first_name
		, fr.middlename as financial_responsability_middlename
		, fr.last_name as financial_responsability_last_name
		, fr.street_address as financial_responsability_street_address
		, fr.city as financial_responsability_city
		, fr.state as financial_responsability_state
		, fr.zip as financial_responsability_zip
		, fr.home_phone as financial_responsability_home_phone
		, fr.mobile_number as financial_responsability_mobile_number
		, fr.relationship financial_responsability_relationship
		, fr.sex as financial_responsability_sex
		, fr.ss_number as financial_responsability_ss_number
		, fr.driver_lisence as financial_responsability_driver_lisence
		, fr.birth_date as financial_responsability_birth_date
		, fr.employer as financial_responsability_employer
		, fr.employer_address as financial_responsability_employer_address
		, fr.employer_city as financial_responsability_employer_city
		, fr.employer_state as financial_responsability_employer_state
		, fr.employer_zip as financial_responsability_employer_zip
		, fr.employer_phone as financial_responsability_employer_phone
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		, d.password as doctors_password
		, d.doctor_ssn as doctors_doctor_ssn
		, dg.auto as doctor_gallery_auto
		, dg.doctor_id as doctor_gallery_doctor_id
		#		, dg.office_id as doctor_gallery_office_id
		, dg.date as doctor_gallery_date
		, dg.path as doctor_gallery_path
		, dg.file_name as doctor_gallery_file_name
		, dg.notes as doctor_gallery_notes
		, dg.extra as doctor_gallery_extra
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, vs.auto as visit_status_auto
		#		, vs.office_id as visit_status_office_id
		, vs.appointment_id as visit_status_appointment_id
		#		, vs.patient_id as visit_status_patient_id
		, vs.in_waiting_room as visit_status_in_waiting_room
		, vs.check_in as visit_status_check_in
		, vs.vitals_start as visit_status_vitals_start
		, vs.vitals_end as visit_status_vitals_end
		, vs.encounter_start as visit_status_encounter_start
		, vs.encounter_room as visit_status_encounter_room
		, vs.encounter_end as visit_status_encounter_end
		, vs.checkout as visit_status_checkout
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.temperature as vitals_temperature
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN (SELECT *
				FROM patient_gallery
				WHERE profile = 1
				GROUP BY patient_id
				ORDER BY auto DESC) as pg ON p.auto = pg.patient_id
	LEFT JOIN (SELECT *
				FROM contact_info
				GROUP BY id
				ORDER BY auto DESC) as ci ON p.auto = ci.id
	LEFT JOIN (SELECT *
				FROM emergency_contact
				GROUP BY userID
				ORDER BY auto DESC) as ec ON p.auto = ec.userID
	LEFT JOIN (SELECT *
				FROM employment
				GROUP BY userID
				ORDER BY auto DESC) as e ON p.auto = e.userID
	LEFT JOIN (SELECT *
				FROM insurance_info
				GROUP BY id
				ORDER BY auto DESC) as ii ON p.auto = ii.id
	LEFT JOIN (SELECT *
				FROM financial_responsability
				GROUP BY userID
				ORDER BY auto DESC) as fr ON p.auto = fr.userID
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM doctor_gallery
				GROUP BY doctor_id
				ORDER BY auto DESC) as dg ON d.auto = dg.doctor_id
	LEFT JOIN (SELECT *
				FROM medical_encounter
				GROUP BY appointment_id
				ORDER BY date DESC) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM visit_status
				GROUP BY appointment_id
				ORDER BY auto DESC) as vs ON at.auto = vs.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				GROUP BY appointment_id
				ORDER BY auto DESC) as v ON at.auto = v.appointment_id
	WHERE at.doctor_id = _doctorId
		AND at.office_id = _officeId
		AND at.date >= _fromDate
		AND at.date <= _toDate
	ORDER BY at.auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentsByOfficeIdAndPatientID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM appointment_time
	WHERE office_id = _officeId AND patient_id = _patientId AND date = _date
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentsByOfficeIdAndPatientIDCompleteList
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT auto
		, office_id
		, patient_id
		, doctor_id
		, DATE_FORMAT(date, ''%m/%d/%Y'') as date
		, starts
		, ends
		, confirmation
		, referral_number
		, appointment_status
	FROM appointment_time
	WHERE office_id = _officeId AND patient_id = _patientId
	ORDER BY `auto` DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetAppointmentsForCalendar
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, at.date as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, vs.auto as visit_status_auto
		#		, vs.office_id as visit_status_office_id
		, vs.appointment_id as visit_status_appointment_id
		#		, vs.patient_id as visit_status_patient_id
		, vs.in_waiting_room as visit_status_in_waiting_room
		, vs.check_in as visit_status_check_in
		, vs.vitals_start as visit_status_vitals_start
		, vs.vitals_end as visit_status_vitals_end
		, vs.encounter_start as visit_status_encounter_start
		, vs.encounter_room as visit_status_encounter_room
		, vs.encounter_end as visit_status_encounter_end
		, vs.checkout as visit_status_checkout
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN (SELECT *
				FROM visit_status
				GROUP BY appointment_id
				ORDER BY auto DESC) as vs ON at.auto = vs.appointment_id
	WHERE at.date = _date
		AND at.office_id = _officeId
		AND at.doctor_id = _doctorId
	ORDER BY at.auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetBalanceByOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM balance
	WHERE id = _patientId
		AND office_id = _officeId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetBalanceByPatientID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `appointment_time`.*,
		`balance2`.*,
		`transactiont_type`.*
		FROM `appointment_time`
		INNER JOIN `balance2` ON(
			`balance2`.`appointment_id`= `appointment_time`.`auto`
		)
		INNER JOIN `transactiont_type` ON(
			`transactiont_type`.`id`= `balance2`.`transactiont_type_id`
		)
		WHERE `appointment_time`.`patient_id` = _patientId AND `doctor_id` = _doctor;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetChargeByChargeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM charge
	WHERE ChargeId = _chargeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetClaimNumber
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT claim_number
	FROM insurance_claim
	WHERE claim_number = _claimNumber;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetConditionByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM conditions
	WHERE id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetContactInfoByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM contact_info
	WHERE id = _patientId
	ORDER BY auto;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetCPTAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM cpt_by_aapointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetCPTCodeByAppointmentIdOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedure_codes_app
	WHERE appointment_id = _appointmentTimeId
		AND office_id = _officeId;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetCurrentMedicationsByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medications
	WHERE id = _patientId AND end_date >= _todayDate;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDermatomeAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM dermatome_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDermatomeByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM dermatome_diagram
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDiagnosisCodeByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM diagnosis_codes
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDisplaySetting
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT * FROM `income_report_display_setting`
	WHERE `office_id` = _officeId
		AND `reportId` = _reportId
		AND `doctor_id` = _doctorId
		AND `name` = _settingName;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorByBadge
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM doctors
	WHERE id_badge = _badge;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM doctors
	WHERE auto = _doctorId
	ORDER BY auto LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorByEmail
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM doctors
	WHERE email = _email
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorByOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM doctors
	WHERE office_id = _officeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorBySearchTerm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT d.auto as doctor_auto
		, d.office_id as doctor_office_id
		, d.id_badge as doctor_id_badge
		, d.first_name as doctor_first_name
		, d.middle_name as doctor_middle_name
		, d.last_name as doctor_last_name
		, d.title as doctor_title
		, d.practice as doctor_practice
		, d.street as doctor_street
		, d.city as doctor_city
		, d.zip as doctor_zip
		, d.state as doctor_state
		, d.telephone as doctor_telephone
		, d.email as doctor_email
		#		, d.password as doctor_password
		, d.doctor_ssn as doctor_doctor_ssn
		, dg.auto as doctor_gallery_auto
		, dg.doctor_id as doctor_gallery_doctor_id
		#		, dg.office_id as doctor_gallery_office_id
		, dg.date as doctor_gallery_date
		, dg.path as doctor_gallery_path
		, dg.file_name as doctor_gallery_file_name
		, dg.notes as doctor_gallery_notes
		, dg.extra as doctor_gallery_extra
	FROM doctors as d
	LEFT JOIN doctor_gallery as dg ON d.auto = dg.doctor_id
	WHERE ((d.first_name RLIKE _searchTerm)
		OR (d.middle_name RLIKE _searchTerm)
		OR (d.last_name RLIKE _searchTerm)
		OR (d.title RLIKE _searchTerm))
	LIMIT 10;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDoctorMembershipByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM doctors_membership
	WHERE doctors_id = _doctorId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetDrinkingHistoryByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM drinking_history
	WHERE id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetEmergencyContactByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	IF (_tableNumber = 1) THEN
		SELECT *
		FROM emergency_contact
		WHERE userID = _patientId
		ORDER BY auto DESC
		LIMIT 1;
	ELSEIF (_tableNumber = 2) THEN
		SELECT *
		FROM emergency_contact2
		WHERE userID = _patientId
		ORDER BY auto DESC
		LIMIT 1;
	ELSEIF (_tableNumber = 3) THEN
		SELECT *
		FROM emergency_contact3
		WHERE userID = _patientId
		ORDER BY auto DESC
		LIMIT 1;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetEmploymentByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM employment
	WHERE userID = _patientId
	ORDER BY auto DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetExaminationInputByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT ei.ExaminationInputId as examinationinput_ExaminationInputId
		, ei.ChiefComplaint as examinationinput_ChiefComplaint
		, ei.Date as examinationinput_Date
		, ei.HistoryOfPresentInjury as examinationinput_HistoryOfPresentInjury
		, ei.Chiro as examinationinput_Chiro
		, ei.Injection as examinationinput_Injection
		, ei.PainProgram as examinationinput_PainProgram
		, ei.Diagnostic as examinationinput_Diagnostic
		, ei.PainFreq as examinationinput_PainFreq
		, ei.PainLocation as examinationinput_PainLocation
		, ei.PainRadiation as examinationinput_PainRadiation
		, ei.PainRadiationDuration as examinationinput_PainRadiationDuration
		, ei.PainVAS as examinationinput_PainVAS
		, ei.CurrentMedication as examinationinput_CurrentMedication
		, ei.PastMedication as examinationinput_PastMedication
		, ei.Allergy as examinationinput_Allergy
		, ei.PertinentMedicalHistory as examinationinput_PertinentMedicalHistory
		, ei.SubstanceAbuse as examinationinput_SubstanceAbuse
		, ei.Neuropsychological as examinationinput_Neuropsychological
		, ei.MentalDisorder as examinationinput_MentalDisorder
		, ei.LMP as examinationinput_LMP
		, ei.SocialHistory as examinationinput_SocialHistory
		, ei.Tobacco as examinationinput_Tobacco
		, ei.EtOH as examinationinput_EtOH
		, ei.IVDrug as examinationinput_IVDrug
		, ei.WorkStatus as examinationinput_WorkStatus
		, ei.Ambulation as examinationinput_Ambulation
		, ei.HomeManagement as examinationinput_HomeManagement
		, ei.Recreation as examinationinput_Recreation
		, ei.GeneralAppearance as examinationinput_GeneralAppearance
		, ei.HEENT as examinationinput_HEENT
		, ei.NECT as examinationinput_NECT
		, ei.Pulse as examinationinput_Pulse
		, ei.CV as examinationinput_CV
		, ei.ABD as examinationinput_ABD
		, ei.NeurologicalCranialNerve as examinationinput_NeurologicalCranialNerve
		, ei.SensoryUpperExtremities as examinationinput_SensoryUpperExtremities
		, ei.SensoryLowerExtremities as examinationinput_SensoryLowerExtremities
		, ei.MotorUpperExtremities as examinationinput_MotorUpperExtremities
		, ei.MotorLowerExtremities as examinationinput_MotorLowerExtremities
		, ei.HeelWalk as examinationinput_HeelWalk
		, ei.ToeWalk as examinationinput_ToeWalk
		, ei.ReflexBicepLeft as examinationinput_ReflexBicepLeft
		, ei.ReflexBrachioradialisLeft as examinationinput_ReflexBrachioradialisLeft
		, ei.ReflexTricepLeft as examinationinput_ReflexTricepLeft
		, ei.ReflexPatellarLeft as examinationinput_ReflexPatellarLeft
		, ei.ReflexAchillesLeft as examinationinput_ReflexAchillesLeft
		, ei.ReflexBicepLeftLevel as examinationinput_ReflexBicepLeftLevel
		, ei.ReflexBrachioradialisLeftLevel as examinationinput_ReflexBrachioradialisLeftLevel
		, ei.ReflexTricepLeftLevel as examinationinput_ReflexTricepLeftLevel
		, ei.ReflexPatellarLeftLevel as examinationinput_ReflexPatellarLeftLevel
		, ei.ReflexAchillesLeftLevel as examinationinput_ReflexAchillesLeftLevel
		, ei.ReflexBicepRight as examinationinput_ReflexBicepRight
		, ei.ReflexBrachioradialisRight as examinationinput_ReflexBrachioradialisRight
		, ei.ReflexTricepRight as examinationinput_ReflexTricepRight
		, ei.ReflexPatellarRight as examinationinput_ReflexPatellarRight
		, ei.ReflexAchillesRight as examinationinput_ReflexAchillesRight
		, ei.ReflexBicepRightLevel as examinationinput_ReflexBicepRightLevel
		, ei.ReflexBrachioradialisRightLevel as examinationinput_ReflexBrachioradialisRightLevel
		, ei.ReflexTricepRightLevel as examinationinput_ReflexTricepRightLevel
		, ei.ReflexPatellarRightLevel as examinationinput_ReflexPatellarRightLevel
		, ei.ReflexAchillesRightLevel as examinationinput_ReflexAchillesRightLevel
		, ei.SpecialBabinski as examinationinput_SpecialBabinski
		, ei.SpecialClonus as examinationinput_SpecialClonus
		, ei.SpecialRhomberg as examinationinput_SpecialRhomberg
		, ei.SpecialHeel as examinationinput_SpecialHeel
		, ei.SpecialShin as examinationinput_SpecialShin
		, ei.SpecialFinger as examinationinput_SpecialFinger
		, ei.SpecialNose as examinationinput_SpecialNose
		, ei.NerveTensionSLRSupine as examinationinput_NerveTensionSLRSupine
		, ei.NerveTensionSLRSitting as examinationinput_NerveTensionSLRSitting
		, ei.AutonomicTemperature as examinationinput_AutonomicTemperature
		, ei.AutonomicHair as examinationinput_AutonomicHair
		, ei.AutonomicNail as examinationinput_AutonomicNail
		, ei.AutonomicMottling as examinationinput_AutonomicMottling
		, ei.MusculoskeletalCervical as examinationinput_MusculoskeletalCervical
		, ei.MusculoskeletalThoracic as examinationinput_MusculoskeletalThoracic
		, ei.MusculoskeletalLumbar as examinationinput_MusculoskeletalLumbar
		, ei.MusculoskeletalExtremities as examinationinput_MusculoskeletalExtremities
		, ei.MusculoskeletalSacroiliac as examinationinput_MusculoskeletalSacroiliac
		, ei.OrthopedicCervical as examinationinput_OrthopedicCervical
		, ei.OrthopedicThoracis as examinationinput_OrthopedicThoracis
		, ei.OrthopedicLumbar as examinationinput_OrthopedicLumbar
		, ei.OrthopedicUpperExtremities as examinationinput_OrthopedicUpperExtremities
		, ei.OrthopedicLowerExtremities as examinationinput_OrthopedicLowerExtremities
		, ei.Recommendation as examinationinput_Recommendation
		, ei.ProgressVAS as examinationinput_ProgressVAS
		, ei.ProgressRadiation as examinationinput_ProgressRadiation
		, ei.ProgressPainFreq as examinationinput_ProgressPainFreq
		, ei.ProgressROM as examinationinput_ProgressROM
		, ei.ProgressTreatment as examinationinput_ProgressTreatment
	FROM  examinationinput as ei
	WHERE ei.appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetExaminationInputCompleteByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, DATE_FORMAT(at.dateOfInjury, ''%m/%d/%Y'') as appointment_time_dateOfInjury
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		#		, d.password as doctors_password
#		, d.doctor_ssn as doctors_doctor_ssn
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, me.otherNotes as medical_encounter_other_notes
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.height as vitals_height
		, v.temperature as vitals_temperature
		, v.bmi as vitals_bmi
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
		, ei.ExaminationInputId as examinationinput_ExaminationInputId
		, ei.ChiefComplaint as examinationinput_ChiefComplaint
		, ei.Date as examinationinput_Date
		, ei.HistoryOfPresentInjury as examinationinput_HistoryOfPresentInjury
		, ei.Chiro as examinationinput_Chiro
		, ei.Injection as examinationinput_Injection
		, ei.PainProgram as examinationinput_PainProgram
		, ei.Diagnostic as examinationinput_Diagnostic
		, ei.PainFreq as examinationinput_PainFreq
		, ei.PainLocation as examinationinput_PainLocation
		, ei.PainRadiation as examinationinput_PainRadiation
		, ei.PainRadiationDuration as examinationinput_PainRadiationDuration
		, ei.PainVAS as examinationinput_PainVAS
		, ei.CurrentMedication as examinationinput_CurrentMedication
		, ei.PastMedication as examinationinput_PastMedication
		, ei.Allergy as examinationinput_Allergy
		, ei.PertinentMedicalHistory as examinationinput_PertinentMedicalHistory
		, ei.SubstanceAbuse as examinationinput_SubstanceAbuse
		, ei.Neuropsychological as examinationinput_Neuropsychological
		, ei.MentalDisorder as examinationinput_MentalDisorder
		, ei.LMP as examinationinput_LMP
		, ei.SocialHistory as examinationinput_SocialHistory
		, ei.Tobacco as examinationinput_Tobacco
		, ei.EtOH as examinationinput_EtOH
		, ei.IVDrug as examinationinput_IVDrug
		, ei.WorkStatus as examinationinput_WorkStatus
		, ei.Ambulation as examinationinput_Ambulation
		, ei.HomeManagement as examinationinput_HomeManagement
		, ei.Recreation as examinationinput_Recreation
		, ei.GeneralAppearance as examinationinput_GeneralAppearance
		, ei.HEENT as examinationinput_HEENT
		, ei.Cardiovascular as examinationinput_Cardiovascular
		, ei.NECT as examinationinput_NECT
		, ei.Pulse as examinationinput_Pulse
		, ei.CV as examinationinput_CV
		, ei.ABD as examinationinput_ABD
		, ei.NeurologicalCranialNerve as examinationinput_NeurologicalCranialNerve
		, ei.SensoryUpperExtremities as examinationinput_SensoryUpperExtremities
		, ei.SensoryLowerExtremities as examinationinput_SensoryLowerExtremities
		, ei.MotorUpperExtremities as examinationinput_MotorUpperExtremities
		, ei.MotorLowerExtremities as examinationinput_MotorLowerExtremities
		, ei.HeelWalk as examinationinput_HeelWalk
		, ei.ToeWalk as examinationinput_ToeWalk
		, ei.ReflexBicepLeft as examinationinput_ReflexBicepLeft
		, ei.ReflexBrachioradialisLeft as examinationinput_ReflexBrachioradialisLeft
		, ei.ReflexTricepLeft as examinationinput_ReflexTricepLeft
		, ei.ReflexPatellarLeft as examinationinput_ReflexPatellarLeft
		, ei.ReflexAchillesLeft as examinationinput_ReflexAchillesLeft
		, ei.ReflexBicepLeftLevel as examinationinput_ReflexBicepLeftLevel
		, ei.ReflexBrachioradialisLeftLevel as examinationinput_ReflexBrachioradialisLeftLevel
		, ei.ReflexTricepLeftLevel as examinationinput_ReflexTricepLeftLevel
		, ei.ReflexPatellarLeftLevel as examinationinput_ReflexPatellarLeftLevel
		, ei.ReflexAchillesLeftLevel as examinationinput_ReflexAchillesLeftLevel
		, ei.ReflexBicepRight as examinationinput_ReflexBicepRight
		, ei.ReflexBrachioradialisRight as examinationinput_ReflexBrachioradialisRight
		, ei.ReflexTricepRight as examinationinput_ReflexTricepRight
		, ei.ReflexPatellarRight as examinationinput_ReflexPatellarRight
		, ei.ReflexAchillesRight as examinationinput_ReflexAchillesRight
		, ei.ReflexBicepRightLevel as examinationinput_ReflexBicepRightLevel
		, ei.ReflexBrachioradialisRightLevel as examinationinput_ReflexBrachioradialisRightLevel
		, ei.ReflexTricepRightLevel as examinationinput_ReflexTricepRightLevel
		, ei.ReflexPatellarRightLevel as examinationinput_ReflexPatellarRightLevel
		, ei.ReflexAchillesRightLevel as examinationinput_ReflexAchillesRightLevel
		, ei.SpecialBabinski as examinationinput_SpecialBabinski
		, ei.SpecialClonus as examinationinput_SpecialClonus
		, ei.SpecialRhomberg as examinationinput_SpecialRhomberg
		, ei.SpecialHeel as examinationinput_SpecialHeel
		, ei.SpecialShin as examinationinput_SpecialShin
		, ei.SpecialFinger as examinationinput_SpecialFinger
		, ei.SpecialNose as examinationinput_SpecialNose
		, ei.NerveTensionSLRSupine as examinationinput_NerveTensionSLRSupine
		, ei.NerveTensionSLRSitting as examinationinput_NerveTensionSLRSitting
		, ei.AutonomicTemperature as examinationinput_AutonomicTemperature
		, ei.AutonomicHair as examinationinput_AutonomicHair
		, ei.AutonomicNail as examinationinput_AutonomicNail
		, ei.AutonomicMottling as examinationinput_AutonomicMottling
		, ei.MusculoskeletalCervical as examinationinput_MusculoskeletalCervical
		, ei.MusculoskeletalThoracic as examinationinput_MusculoskeletalThoracic
		, ei.MusculoskeletalLumbar as examinationinput_MusculoskeletalLumbar
		, ei.MusculoskeletalExtremities as examinationinput_MusculoskeletalExtremities
		, ei.MusculoskeletalSacroiliac as examinationinput_MusculoskeletalSacroiliac
		, ei.OrthopedicCervical as examinationinput_OrthopedicCervical
		, ei.OrthopedicThoracis as examinationinput_OrthopedicThoracis
		, ei.OrthopedicLumbar as examinationinput_OrthopedicLumbar
		, ei.OrthopedicUpperExtremities as examinationinput_OrthopedicUpperExtremities
		, ei.OrthopedicLowerExtremities as examinationinput_OrthopedicLowerExtremities
		, ei.Recommendation as examinationinput_Recommendation
		, ei.ProgressVAS as examinationinput_ProgressVAS
		, ei.ProgressRadiation as examinationinput_ProgressRadiation
		, ei.ProgressPainFreq as examinationinput_ProgressPainFreq
		, ei.ProgressROM as examinationinput_ProgressROM
		, ei.ProgressTreatment as examinationinput_ProgressTreatment
		, ei.painAssesmentText as examinationinput_painAssesmentText
		, ei.effectsOfInjuryOnLifestyle as examinationinput_effectsOfInjuryOnLifestyle
		, ei.DermatomeText as examinationinput_DermatomeText
		, ei.MusculoskeletalText as examinationinput_MusculoskeletalText
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM medical_encounter
				WHERE appointment_id = _appointmentTimeId
				ORDER BY date DESC
				LIMIT 1) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				WHERE appointment_id = _appointmentTimeId
				ORDER BY auto DESC
				LIMIT 1) as v ON at.auto = v.appointment_id
	LEFT JOIN examinationinput as ei ON at.auto = ei.appointmentID
	WHERE at.auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFamilyHistoryByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM family_history
	WHERE id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavCPTByCPTCode
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM favouritecptcodes
	WHERE `code` = _cptCode;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavIDCByIDCCode
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM favouriteIDCtcodes
	WHERE idc = _idcCode;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavouriteCPTCodeByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM `favouritecptcodes`
	WHERE `doctor_id` = _doctorId
	ORDER BY `grouping` ASC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavouriteCPTCodeWithValueByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT fc.auto as favouritecptcodes_auto
		, fc.doctor_id as favouritecptcodes_doctor_id
		, fc.code as favouritecptcodes_code
		, fc.description as favouritecptcodes_description
		, fc.grouping  as favouritecptcodes_grouping
		, cba.auto as cpt_by_aapointment_auto
		, cba.appointmentID as cpt_by_aapointment_appointmentID
		, cba.dateOfService as cpt_by_aapointment_dateOfService
		, cba.code as cpt_by_aapointment_code
		, cba.rationale as cpt_by_aapointment_rationale
		, cba.area_treated as cpt_by_aapointment_area_treated
		, cba.time as cpt_by_aapointment_time
		, cba.unit as cpt_by_aapointment_unit
	FROM favouritecptcodes as fc
	LEFT JOIN (SELECT * FROM cpt_by_aapointment WHERE appointmentID = _appointmentTimeId) as cba ON fc.code = cba.code
	WHERE fc.doctor_id = _doctorId
	ORDER BY fc.grouping, fc.auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavouriteIDCCodeByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM `favouriteIDCtcodes`
	WHERE `doctor_id` = _doctorId
	ORDER BY `auto` ASC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFavouriteIDCCodeWithValueByDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT f.auto as favouriteidctcodes_auto
		, f.doctor_id as favouriteidctcodes_doctor_id
		, f.idc as favouriteidctcodes_idc
		, f.description as favouriteidctcodes_description
		, i.auto as idc_by_aapointment_auto
		, i.appointment_id as idc_by_aapointment_appointment_id
		, i.idc_code as idc_by_aapointment_idc_code
	FROM favouriteIDCtcodes as f
	LEFT JOIN (SELECT * FROM idc_by_aapointment WHERE appointment_id = _appointmentTimeId) as i ON f.idc = i.idc_code
	WHERE f.doctor_id = _doctorId
	ORDER BY f.auto ASC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFinancialResponsibilityByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM financial_responsability
	WHERE userID = _patientId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFormExistenceByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT iv.auto AS insuranceVerification_auto
		, sf.auto AS soap_auto
		, wc.auto AS workersComp_auto
		, sb.auto AS superBill_auto
		, ar.auto AS activeRehabSheet_auto
		, uf.auto AS utilizationReview_auto
		, pru.PhysicalRehabUtilizationId AS physicalRehabUtilization_PhysicalRehabUtilizationId
	FROM appointment_time AS at
	LEFT JOIN insuranceverificationform AS iv ON at.auto = iv.appointmentID
	LEFT JOIN soapform AS sf ON at.auto = sf.appointmentID
	LEFT JOIN workerscompinfosheet AS wc ON at.auto = wc.appointmentID
	LEFT JOIN superbill AS sb ON at.auto = sb.appointmentID
	LEFT JOIN active_rehab_sheet_info AS ar ON at.auto = ar.appointmentID
	LEFT JOIN utilizationform AS uf ON at.auto = uf.appointmentID
	LEFT JOIN physicalrehabutilization as pru ON at.auto = pru.AppointmentId
	WHERE at.auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFormSignatureByAppointmentIdFormName
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM form_signature
	WHERE appointmentId = _appointmentId
		AND formName = _formName
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetFullPatients
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, DATE_FORMAT(p.date_of_birth, ''%m/%d/%Y'') as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, p.profilePicture as users_profilePicture
		, (SELECT file_name
			FROM patient_gallery as pg
			WHERE p.auto = pg.patient_id
			AND profile = 1
			ORDER BY auto DESC
			LIMIT 1) as patient_gallery_file_name
		, (SELECT insurance_Company
			FROM insurance_info as ii
			WHERE p.auto = ii.id
			ORDER BY auto DESC
			LIMIT 1) as insurance_info_insurance_Company
	FROM users as p
	ORDER BY p.first_name ASC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetIDCByAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM idc_by_aapointment
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetIDCCodeByAppointmentTimeIdOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT idc9_code FROM diagnosis_codes
	WHERE appointment_id = _appointmentTimeId
		AND office_id = _officeId;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetIDCCodeByCode
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM idc9
	WHERE code = _idcCode;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetIDCCodeBySearchTerm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM idc9
	WHERE ((`code` RLIKE _searchTerm)	OR (`desc` RLIKE _searchTerm))
	LIMIT 10;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetImmunizationByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM immunization
	WHERE id = _patientId
	ORDER BY date DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetInsuranceClaimByInsuranceClaimIdOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM insurance_claim
	WHERE auto = _insuranceClaimId
		AND office_id = _officeId;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetInsuranceClaimByOfficeIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM insurance_claim
	WHERE office_id = _officeId
		AND (`date_of_service_from_clear_1` >= _fromDate
		AND `date_of_service_from_clear_1` <= _toDate)
	ORDER BY auto DESC LIMIT _limitStartRow, _limitMaxRow;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetInsuranceInfoByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM insurance_info
	WHERE id = _patientId
	ORDER BY auto DESC LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetInsuranceVerificationFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`contact_info`.`auto` AS `contact_info_auto`,
		`contact_info`.`id` AS `contact_info_id`,
		`contact_info`.`street_address` AS `contact_info_street_address`,
		`contact_info`.`city` AS `contact_info_city`,
		`contact_info`.`state` AS `contact_info_state`,
		`contact_info`.`zip` AS `contact_info_zip`,
		`contact_info`.`county` AS `contact_info_county`,
		`contact_info`.`country` AS `contact_info_country`,
		`contact_info`.`home_phone` AS `contact_info_home_phone`,
		`contact_info`.`mobile_phone` AS `contact_info_mobile_phone`,
		`contact_info`.`work_phone` AS `contact_info_work_phone`,
		`contact_info`.`email` AS `contact_info_email`,
		`insurance_info`.`auto` AS `insurance_info_auto`,
		`insurance_info`.`id` AS `insurance_info_id`,
		`insurance_info`.`member_id` AS `insurance_info_member_id`,
		`insurance_info`.`no_insurance` AS `insurance_info_no_insurance`,
		`insurance_info`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`insurance_info`.`policy_group` AS `insurance_info_policy_group`,
		`insurance_info`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`insurance_info`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`insurance_info`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`insurance_info`.`relationship` AS `insurance_info_relationship`,
		`insurance_info`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`insurance_info`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`insurance_info`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`insurance_info`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`insurance_info`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`insurance_info`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`insurance_info`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`insurance_info`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`insurance_info`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`insurance_info`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`insurance_info`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`insurance_info`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`insurance_info`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`insurance_info`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`insurance_info`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`insurance_info`.`plan_name` AS `insurance_info_plan_name`,
		`insurance_info`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`medical_encounter`.`auto` AS `medical_encounter_auto`,
		`medical_encounter`.`id` AS `medical_encounter_id`,
		`medical_encounter`.`date` AS `medical_encounter_date`,
		`medical_encounter`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`medical_encounter`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`medical_encounter`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`medical_encounter`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`medical_encounter`.`assesment` AS `medical_encounter_assesment`,
		`medical_encounter`.`plan` AS `medical_encounter_plan`,
		`medical_encounter`.`progress_notes` AS `medical_encounter_progress_notes`,
		`medical_encounter`.`doctor` AS `medical_encounter_doctor`,
		`medical_encounter`.`appointment_id` AS `medical_encounter_appointment_id`,
		`medical_encounter`.`referral_number` AS `medical_encounter_referral_number`,
		`medical_encounter`.`office_id` AS `medical_encounter_office_id`,
		`medical_encounter`.`checked_in` AS `medical_encounter_checked_in`,
		`medical_encounter`.`vitals` AS `medical_encounter_vitals`,
		`medical_encounter`.`visit_status` AS `medical_encounter_visit_status`,
		`medical_encounter`.`no_show` AS `medical_encounter_no_show`,
		`insuranceverificationform`.`auto` AS `insuranceverificationform_auto`,
		`insuranceverificationform`.`appointmentID` AS `insuranceverificationform_appointmentID`,
		`insuranceverificationform`.`insuranceEffectiveDate` AS `insuranceverificationform_insuranceEffectiveDate`,
		`insuranceverificationform`.`calendarYearYes` AS `insuranceverificationform_calendarYearYes`,
		`insuranceverificationform`.`calendarYearNo` AS `insuranceverificationform_calendarYearNo`,
		`insuranceverificationform`.`planYearFrom` AS `insuranceverificationform_planYearFrom`,
		`insuranceverificationform`.`planYearTo` AS `insuranceverificationform_planYearTo`,
		`insuranceverificationform`.`planRequiresReferralNo` AS `insuranceverificationform_planRequiresReferralNo`,
		`insuranceverificationform`.`planRequiresReferralYes` AS `insuranceverificationform_planRequiresReferralYes`,
		`insuranceverificationform`.`planRequiresDesuctibleNo` AS `insuranceverificationform_planRequiresDesuctibleNo`,
		`insuranceverificationform`.`planRequiresDesuctibleYes` AS `insuranceverificationform_planRequiresDesuctibleYes`,
		`insuranceverificationform`.`familyDeductibleAmount` AS `insuranceverificationform_familyDeductibleAmount`,
		`insuranceverificationform`.`deductibleSatisfiedNo` AS `insuranceverificationform_deductibleSatisfiedNo`,
		`insuranceverificationform`.`deductibleSatisfiedYes` AS `insuranceverificationform_deductibleSatisfiedYes`,
		`insuranceverificationform`.`deductibleRemindingAmount` AS `insuranceverificationform_deductibleRemindingAmount`,
		`insuranceverificationform`.`CoverageAfterDeductibleAmount` AS `insuranceverificationform_CoverageAfterDeductibleAmount`,
		`insuranceverificationform`.`CoverageAfterDeductiblePercent` AS `insuranceverificationform_CoverageAfterDeductiblePercent`,
		`insuranceverificationform`.`maximumAmountPerYearNo` AS `insuranceverificationform_maximumAmountPerYearNo`,
		`insuranceverificationform`.`maximumAmountPerYearYes` AS `insuranceverificationform_maximumAmountPerYearYes`,
		`insuranceverificationform`.`maximumAmountPerYearAmount` AS `insuranceverificationform_maximumAmountPerYearAmount`,
		`insuranceverificationform`.`hasAnyOfThisBeenUsedNo` AS `insuranceverificationform_hasAnyOfThisBeenUsedNo`,
		`insuranceverificationform`.`hasAnyOfThisBeenUsedYes` AS `insuranceverificationform_hasAnyOfThisBeenUsedYes`,
		`insuranceverificationform`.`hasAnyOfThisBeenUsedAmount` AS `insuranceverificationform_hasAnyOfThisBeenUsedAmount`,
		`insuranceverificationform`.`isThereAMaximumAmountPervisitYes` AS `insuranceverificationform_isThereAMaximumAmountPervisitYes`,
		`insuranceverificationform`.`isThereAMaximumAmountPervisitNo` AS `insuranceverificationform_isThereAMaximumAmountPervisitNo`,
		`insuranceverificationform`.`isThereAMaximumAmountPervisitAmount` AS `insuranceverificationform_isThereAMaximumAmountPervisitAmount`,
		`insuranceverificationform`.`maximumVisitLimitPerYear` AS `insuranceverificationform_maximumVisitLimitPerYear`,
		`insuranceverificationform`.`evaluationAndManagementExamsCodesCoveredNo` AS `insuranceverificationform_evaluationAndManagementExamsCodesCoveredNo`,
		`insuranceverificationform`.`evaluationAndManagementExamsCodesCoveredYes` AS `insuranceverificationform_evaluationAndManagementExamsCodesCoveredYes`,
		`insuranceverificationform`.`managementExamsCodesSeparateCopayNo` AS `insuranceverificationform_managementExamsCodesSeparateCopayNo`,
		`insuranceverificationform`.`managementExamsCodesSeparateCopayYes` AS `insuranceverificationform_managementExamsCodesSeparateCopayYes`,
		`insuranceverificationform`.`managementExamsCodesSeparateCopayAmount` AS `insuranceverificationform_managementExamsCodesSeparateCopayAmount`,
		`insuranceverificationform`.`listOneModalitiesCoveredNo` AS `insuranceverificationform_listOneModalitiesCoveredNo`,
		`insuranceverificationform`.`listOneModalitiesCoveredYes` AS `insuranceverificationform_listOneModalitiesCoveredYes`,
		`insuranceverificationform`.`listOneModalitiesCoveredAmount` AS `insuranceverificationform_listOneModalitiesCoveredAmount`,
		`insuranceverificationform`.`IDC97010` AS `insuranceverificationform_IDC97010`,
		`insuranceverificationform`.`IDC97035` AS `insuranceverificationform_IDC97035`,
		`insuranceverificationform`.`IDC97012` AS `insuranceverificationform_IDC97012`,
		`insuranceverificationform`.`IDC97014` AS `insuranceverificationform_IDC97014`,
		`insuranceverificationform`.`maximumModalitiesVisit` AS `insuranceverificationform_maximumModalitiesVisit`,
		`insuranceverificationform`.`physicalMedicineRehabCoveredYes` AS `insuranceverificationform_physicalMedicineRehabCoveredYes`,
		`insuranceverificationform`.`physicalMedicineRehabSeparateCopayYes` AS `insuranceverificationform_physicalMedicineRehabSeparateCopayYes`,
		`insuranceverificationform`.`physicalMedicineRehabSeparateCopayAmount` AS `insuranceverificationform_physicalMedicineRehabSeparateCopayAmount`,
		`insuranceverificationform`.`IDC97112` AS `insuranceverificationform_IDC97112`,
		`insuranceverificationform`.`IDC97530` AS `insuranceverificationform_IDC97530`,
		`insuranceverificationform`.`IDC97110` AS `insuranceverificationform_IDC97110`,
		`insuranceverificationform`.`IDC97140` AS `insuranceverificationform_IDC97140`,
		`insuranceverificationform`.`maximumPMRperVisit` AS `insuranceverificationform_maximumPMRperVisit`,
		`insuranceverificationform`.`IDC_98940_98941` AS `insuranceverificationform_IDC_98940_98941`,
		`insuranceverificationform`.`IDC_98940_98941SeparateCopay` AS `insuranceverificationform_IDC_98940_98941SeparateCopay`,
		`insuranceverificationform`.`IDC_98940_98941SeparateCopayAmount` AS `insuranceverificationform_IDC_98940_98941SeparateCopayAmount`,
		`insuranceverificationform`.`insuranceCompanyStreetAddress` AS `insuranceverificationform_insuranceCompanyStreetAddress`,
		`insuranceverificationform`.`insuranceCompanyCity` AS `insuranceverificationform_insuranceCompanyCity`,
		`insuranceverificationform`.`insuranceCompanyState` AS `insuranceverificationform_insuranceCompanyState`,
		`insuranceverificationform`.`insuranceCompanyZIP` AS `insuranceverificationform_insuranceCompanyZIP`,
		`insuranceverificationform`.`electronicClaimNumber` AS `insuranceverificationform_electronicClaimNumber`,
		`insuranceverificationform`.`claimCallDate` AS `insuranceverificationform_claimCallDate`,
		`insuranceverificationform`.`claimCallTime` AS `insuranceverificationform_claimCallTime`,
		`insuranceverificationform`.`claimCallSpekenTo` AS `insuranceverificationform_claimCallSpekenTo`,
		`insuranceverificationform`.`claimCallLogNumber` AS `insuranceverificationform_claimCallLogNumber`,
		`insuranceverificationform`.`saveVerificationForm` AS `insuranceverificationform_saveVerificationForm`,
		`insuranceverificationform`.`individualDeductibleAmount` AS `insuranceverificationform_individualDeductibleAmount`,
		`insuranceverificationform`.`authorizedNumberOfVisits` AS `insuranceverificationform_authorizedNumberOfVisits`
	FROM `appointment_time`
	LEFT JOIN `users` ON `appointment_time`.`patient_id` = `users`.`auto`
	INNER JOIN `doctors` ON `appointment_time`.`doctor_id` = `doctors`.`auto`
	INNER JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	INNER JOIN `contact_info` ON `appointment_time`.`patient_id` = `contact_info`.`id`
	INNER JOIN `insurance_info` ON `appointment_time`.`patient_id` = `insurance_info`.`id`
	INNER JOIN `medical_encounter` ON `appointment_time`.`auto` = `medical_encounter`.`appointment_id`
	LEFT JOIN `insuranceVerificationForm` ON `appointment_time`.`auto` = `insuranceVerificationForm`.`appointmentID`
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetLabOrderByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT auto
		, patient_id
		, test_name
		, date_ordered
		, date_performed
		, lab_id
		, labName
		, appointment_id
		, ordered_by
		, comments
	FROM lab_orders
	WHERE appointment_id = _appointmentTimeID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetLastAppointmentByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# declare variables for subquery in join statement in main query
	DECLARE var_doctor_id, var_appointment_id INT;

	# populate variables
	SELECT at.doctor_id
		, at.auto
	INTO var_doctor_id
		, var_appointment_id
	FROM appointment_time as at
	WHERE at.patient_id = _patientId
	ORDER BY at.`date` DESC
	LIMIT 1;

	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, CONCAT(''patientThumbnails/'', p.profilePicture) as patient_profilePicture
		, pg.auto as patient_gallery_auto
		, pg.patient_id as patient_gallery_patient_id
		#		, pg.appointment_in as patient_gallery_appointment_in
#		, pg.office_id as patient_gallery_office_id
		, pg.date as patient_gallery_date
		, pg.path as patient_gallery_path
		, CONCAT(''patientPicture/'', pg.file_name) as patient_gallery_file_name
		, pg.notes as patient_gallery_notes
		, pg.profile as patient_gallery_profile
		, pg.profile_date as patient_gallery_profile_date
		, ci.auto as contact_info_auto
		, ci.id as contact_info_id
		, ci.street_address as contact_info_street_address
		, ci.city as contact_info_city
		, ci.state as contact_info_state
		, ci.zip as contact_info_zip
		, ci.county as contact_info_county
		, ci.country as contact_info_country
		, ci.home_phone as contact_info_home_phone
		, ci.mobile_phone as contact_info_mobile_phone
		, ci.work_phone as contact_info_work_phone
		, ci.email as contact_info_email
		, ec.auto as emergency_contact_auto
		, ec.userID as emergency_contact_userID
		, ec.first_name as emergency_contact_first_name
		, ec.middlename as emergency_contact_middlename
		, ec.last_name as emergency_contact_last_name
		, ec.street_address as emergency_contact_street_address
		, ec.city as emergency_contact_city
		, ec.state as emergency_contact_state
		, ec.zip as emergency_contact_zip
		, ec.relationship as emergency_contact_relationship
		, ec.home_number as emergency_contact_home_number
		, ec.cell_number as emergency_contact_cell_number
		, e.auto as employment_auto
		, e.userID as employment_userID
		, e.ocupation as employment_ocupation
		, e.employer as employment_employer
		, e.street_address as employment_street_address
		, e.city as employment_city
		, e.state as employment_state
		, e.zip as employment_zip
		, e.student_fulltime as employment_student_fulltime
		, e.student_part_time as employment_student_part_time
		, e.school_name as employment_school_name
		, e.date as employment_date
		, e.telephone as employment_telephone
		, e.fax as employment_fax
		, ii.auto as insurance_info_auto
		, ii.id as insurance_info_id
		, ii.member_id as insurance_info_member_id
		, ii.no_insurance as insurance_info_no_insurance
		, ii.insurance_Company as insurance_info_insurance_Company
		, ii.policy_group as insurance_info_policy_group
		, ii.primary_beneficiary_first_name as insurance_info_primary_beneficiary_first_name
		, ii.primary_beneficiary_middle_name as insurance_info_primary_beneficiary_middle_name
		, ii.primary_beneficiary_last_name as insurance_info_primary_beneficiary_last_name
		, ii.relationship as insurance_info_relationship
		, ii.beneficiary_id as insurance_info_beneficiary_id
		, ii.beneficiary_ssn as insurance_info_beneficiary_ssn
		, ii.beneficiary_DOB as insurance_info_beneficiary_DOB
		, ii.beneficiary_sex as insurance_info_beneficiary_sex
		, ii.beneficiary_employment as insurance_info_beneficiary_employment
		, ii.beneficiary_address as insurance_info_beneficiary_address
		, ii.beneficiary_city as insurance_info_beneficiary_city
		, ii.beneficiary_state as insurance_info_beneficiary_state
		, ii.beneficiary_zip as insurance_info_beneficiary_zip
		, ii.beneficiary_phone as insurance_info_beneficiary_phone
		, ii.beneficiary_insurance_copmany as insurance_info_beneficiary_insurance_copmany
		, ii.beneficiary_plan_name as insurance_info_beneficiary_plan_name
		, ii.beneficiary_policy_group as insurance_info_beneficiary_policy_group
		, fr.auto as financial_responsability_auto
		, fr.userID as financial_responsability_userID
		, fr.self_responsable as financial_responsability_self_responsable
		, fr.first_name as financial_responsability_first_name
		, fr.middlename as financial_responsability_middlename
		, fr.last_name as financial_responsability_last_name
		, fr.street_address as financial_responsability_street_address
		, fr.city as financial_responsability_city
		, fr.state as financial_responsability_state
		, fr.zip as financial_responsability_zip
		, fr.home_phone as financial_responsability_home_phone
		, fr.mobile_number as financial_responsability_mobile_number
		, fr.relationship financial_responsability_relationship
		, fr.sex as financial_responsability_sex
		, fr.ss_number as financial_responsability_ss_number
		, fr.driver_lisence as financial_responsability_driver_lisence
		, fr.birth_date as financial_responsability_birth_date
		, fr.employer as financial_responsability_employer
		, fr.employer_address as financial_responsability_employer_address
		, fr.employer_city as financial_responsability_employer_city
		, fr.employer_state as financial_responsability_employer_state
		, fr.employer_zip as financial_responsability_employer_zip
		, fr.employer_phone as financial_responsability_employer_phone
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		#		, d.password as doctors_password
#		, d.doctor_ssn as doctors_doctor_ssn
		, dg.auto as doctor_gallery_auto
		, dg.doctor_id as doctor_gallery_doctor_id
		#		, dg.office_id as doctor_gallery_office_id
		, dg.date as doctor_gallery_date
		, dg.path as doctor_gallery_path
		, dg.file_name as doctor_gallery_file_name
		, dg.notes as doctor_gallery_notes
		, dg.extra as doctor_gallery_extra
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		, me.otherNotes as medical_encounter_other_notes
		, vs.auto as visit_status_auto
		#		, vs.office_id as visit_status_office_id
		, vs.appointment_id as visit_status_appointment_id
		#		, vs.patient_id as visit_status_patient_id
		, vs.in_waiting_room as visit_status_in_waiting_room
		, vs.check_in as visit_status_check_in
		, vs.vitals_start as visit_status_vitals_start
		, vs.vitals_end as visit_status_vitals_end
		, vs.encounter_start as visit_status_encounter_start
		, vs.encounter_room as visit_status_encounter_room
		, vs.encounter_end as visit_status_encounter_end
		, vs.checkout as visit_status_checkout
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.height as vitals_height
		, v.temperature as vitals_temperature
		, v.bmi as vitals_bmi
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN (SELECT *
				FROM patient_gallery
				WHERE patient_id = _patientId
				AND profile = 1
				ORDER BY auto DESC
				LIMIT 1) as pg ON p.auto = pg.patient_id
	LEFT JOIN (SELECT *
				FROM contact_info
				WHERE id = _patientId
				ORDER BY auto DESC
				LIMIT 1) as ci ON p.auto = ci.id
	LEFT JOIN (SELECT *
				FROM emergency_contact
				WHERE userID = _patientId
				ORDER BY auto DESC
				LIMIT 1) as ec ON p.auto = ec.userID
	LEFT JOIN (SELECT *
				FROM employment
				WHERE userID = _patientId
				ORDER BY auto DESC
				LIMIT 1) as e ON p.auto = e.userID
	LEFT JOIN (SELECT *
				FROM insurance_info
				WHERE id = _patientId
				ORDER BY auto DESC
				LIMIT 1) as ii ON p.auto = ii.id
	LEFT JOIN (SELECT *
				FROM financial_responsability
				WHERE userID = _patientId
				ORDER BY auto DESC
				LIMIT 1) as fr ON p.auto = fr.userID
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM doctor_gallery
				WHERE doctor_id = var_doctor_id
				ORDER BY auto DESC
				LIMIT 1) as dg ON d.auto = dg.doctor_id
	LEFT JOIN (SELECT *
				FROM medical_encounter
				WHERE appointment_id = var_appointment_id
				ORDER BY date DESC
				LIMIT 1) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM visit_status
				WHERE appointment_id = var_appointment_id
				ORDER BY auto DESC
				LIMIT 1) as vs ON at.auto = vs.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				WHERE appointment_id = var_appointment_id
				ORDER BY auto DESC
				LIMIT 1) as v ON at.auto = v.appointment_id
	WHERE at.patient_id = _patientId
	ORDER BY at.`auto` DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetLatestAdministrationInput
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM administrationinput
	ORDER BY auto DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medical_encounter
	WHERE appointment_id = _appointmentTimeId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT me.*
	FROM appointment_time as at
	INNER JOIN medical_encounter as me ON at.auto = me.appointment_id
	WHERE at.patient_id = _patientId
	GROUP BY me.`date`
	ORDER BY me.`date` DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterByPatientIdDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT me.*
	FROM appointment_time as at
	INNER JOIN medical_encounter as me ON at.auto = me.appointment_id
	WHERE at.patient_id = _patientId
		AND me.`date` = _selectedDate
	ORDER BY me.`date` DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterCheckedIn
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medical_encounter
	WHERE office_id = _officeId
		AND doctor = _doctorId
		AND date = _date
		AND checked_in = 1;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterHandwriteByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT auto, note_handwritten
	FROM medical_encounter_handwrites
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicalEncounterNoteByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT note_text
	FROM medical_encounter_notes
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicationByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT auto
		, id
		, prescription
		, dosage
		, instructions
		, sig
		, refill
		, start_date
		, end_date
		, prescrived_by
		, appointment_id
		, office_id
		, notes
	FROM medications
	WHERE appointment_id = _appointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicationByMedication
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medications
	WHERE id = _patientId AND prescription = _medication;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicationByMedicationId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medications
	WHERE auto = _medicationId
	AND id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMedicationByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM medications
	WHERE id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMessageByReceiverIsRead
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	IF (_isRead = true) THEN
		SELECT *
		FROM messages
		WHERE `to` = _to
			AND `read` = 0;
	ELSE
		SELECT *
		FROM messages
		WHERE `to` = _to
			AND `read` = 1;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMessageFromPatientToDoctor
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT messages.auto as message_auto
		, messages.subject as message_subject
		, messages.message as message_message
		, messages.date as message_date
		, users.auto as user_auto
		, users.first_name as user_first_name
		, users.middle_name as user_middle_name
		, users.Last_name as user_Last_name
		, doctors.auto as doctor_auto
		, doctors.first_name as doctor_first_name
		, doctors.last_name as doctor_lasName
	FROM messages
	RIGHT JOIN users ON users.auto = messages.from
	INNER JOIN doctors ON doctors.auto = messages.to
	WHERE messages.auto = _messageId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMessageFromPatientToDoctorWithDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT messages.auto as message_auto
	, messages.subject as message_subject
	, messages.message as message_message
	, messages.date as message_date
	, users.auto as user_auto
	, users.first_name as user_first_name
	, users.middle_name as user_middle_name
	, users.Last_name as user_Last_name
	, doctors.auto as doctor_auto
	, doctors.first_name as doctor_first_name
	, doctors.last_name as doctor_lasName
	from messages
	RIGHT JOIN users ON users.auto = messages.from
	INNER JOIN doctors ON doctors.auto = messages.to
	WHERE messages.to = _doctorId
		AND messages.date >= _fromDate
		AND messages.date < _toDate;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetmethodOfPaymentAll
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM method_of_payments;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetMuscularSystemAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM muscular_system_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetnumberOfApprovedVisits
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM authorizedVisits
	WHERE patient_id = _patient_id AND office_id = _office_id;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetOfficeByOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM offices
	WHERE auto = _officeId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetOpenTransactionByDistinctOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SET @query = CONCAT(''
		SELECT DISTINCT ('', _distinctBy ,'')
		FROM transaction
		INNER JOIN charge ON transaction.ChargeId = charge.ChargeId
		WHERE transaction.OfficeId = '', _officeId, ''
			AND transaction.Status = ''0''
			AND transaction.ChargeId <> ''0'';
	'');

	PREPARE Q FROM @query;
	EXECUTE Q;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetOpenTransactionByDistinctOfficeIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SET @query = CONCAT(''
		SELECT DISTINCT ('', _distinctBy, '')
		FROM transaction
		WHERE OfficeId = '', _officeId, ''
			AND DueDate >= '''', _fromDate, ''''
			AND DueDate <= '''', _toDate, ''''
			AND Status = ''0'';
	'');

	PREPARE Q FROM @query;
	EXECUTE Q;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetOpenTransactionByDistinctOfficeIdDoctorId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SET @query = CONCAT(''
		SELECT DISTINCT ('', _distinctBy, '')
		FROM transaction
		INNER JOIN charge ON transaction.ChargeId = charge.ChargeId
		WHERE transaction.OfficeId = '', _officeId, ''
			AND transaction.ProviderId = '', _doctorId, ''
			AND transaction.Status = ''0''
			AND transaction.ChargeId <> ''0'';
	'');

	PREPARE Q FROM @query;
	EXECUTE Q;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetOpenTransactionByOfficeIdPatientIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM transaction
	WHERE OfficeId = _officeId
		AND PatientId = _patientId
		AND DueDate >= _fromDate
		AND DueDate <= _toDate
		AND Status = ''0''
	ORDER BY DueDate DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainAggravatingFactorAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM pain_aggravating_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainAggravatingFactorAppointmentWithValueByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT	paf.PainAggravatingFactorId as `painaggravatingfactor_PainAggravatingFactorId`
		, paf.Name as `painaggravatingfactor_Name`
		, paf.DoctorId as `painaggravatingfactor_DoctorId`
		, pafa.auto as `pain_aggravating_factor_by_appointment_auto`
		, pafa.appointmentID as `pain_aggravating_factor_by_appointment_appointmentID`
		, pafa.PainAggravatingFactorId as `pain_aggravating_factor_by_appointment_PainAggravatingFactorId`
	FROM painaggravatingfactor as paf
	LEFT JOIN (SELECT * FROM pain_aggravating_factor_by_appointment WHERE appointmentID = _appointmentTimeId) as pafa ON paf.PainAggravatingFactorId = pafa.PainAggravatingFactorId
	WHERE paf.DoctorId = _doctorId
	ORDER BY paf.PainAggravatingFactorId DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainAlleviatingFactorAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM pain_alleviating_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainAlleviatingFactorAppointmentWithValueByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT	paf.PainAlleviatingFactorId as `painalleviatingfactor_PainAlleviatingFactorId`
		, paf.Name as `painalleviatingfactor_Name`
		, paf.DoctorId as `painalleviatingfactor_DoctorId`
		, pafa.auto as `pain_alleviating_factor_by_appointment_auto`
		, pafa.appointmentID as `pain_alleviating_factor_by_appointment_appointmentID`
		, pafa.PainAlleviatingFactorId as `pain_alleviating_factor_by_appointment_PainAlleviatingFactorId`
	FROM painalleviatingfactor as paf
	LEFT JOIN (SELECT * FROM pain_alleviating_factor_by_appointment WHERE appointmentID = _appointmentTimeId) as pafa ON paf.PainAlleviatingFactorId = pafa.PainAlleviatingFactorId
	WHERE paf.DoctorId = _doctorId
	ORDER BY paf.PainAlleviatingFactorId DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainFactorAppointmentByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM pain_factor_by_appointment
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPainFactorAppointmentWithValueByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT	pf.PainFactorId as `painfactor_PainFactorId`
		, pf.Name as `painfactor_Name`
		, pf.DoctorId as `painfactor_DoctorId`
		, pfa.auto as `pain_factor_by_appointment_auto`
		, pfa.appointmentID as `pain_factor_by_appointment_appointmentID`
		, pfa.PainFactorId as `pain_factor_by_appointment_PainFactorId`
	FROM painfactor as pf
	LEFT JOIN (SELECT * FROM pain_factor_by_appointment WHERE appointmentID = _appointmentTimeId) as pfa ON pf.PainFactorId = pfa.PainFactorId
	WHERE pf.DoctorId = _doctorId
	ORDER BY pf.PainFactorId DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientByAccountNumber
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM users
	WHERE account = _account;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientByEmail
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM users
	WHERE email = _email;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *,
	if(profilePicture is null, "patientPicture/noPicture.png", CONCAT(''patientThumbnails/'',profilePicture)) as profilePicture
	FROM users
	WHERE auto = _patientId
	ORDER BY auto
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientDetailByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.salt as users_salt
#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, DATE_FORMAT(p.date_of_birth, ''%m/%d/%Y'') as users_date_of_birth
		, if(p.gender = 0, "Male", "Female") as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, p.profilePicture as users_profilePicture
		, ci.auto as contact_info_auto
		, ci.id as contact_info_id
		, ci.street_address as contact_info_street_address
		, ci.city as contact_info_city
		, ci.state as contact_info_state
		, ci.zip as contact_info_zip
		, ci.county as contact_info_county
		, ci.country as contact_info_country
		, ci.home_phone as contact_info_home_phone
		, ci.mobile_phone as contact_info_mobile_phone
		, ci.work_phone as contact_info_work_phone
		, ci.email as contact_info_email
		, ec.auto as emergency_contact_auto
		, ec.userID as emergency_contact_userID
		, ec.first_name as emergency_contact_first_name
		, ec.middlename as emergency_contact_middlename
		, ec.last_name as emergency_contact_last_name
		, ec.street_address as emergency_contact_street_address
		, ec.city as emergency_contact_city
		, ec.state as emergency_contact_state
		, ec.zip as emergency_contact_zip
		, ec.relationship as emergency_contact_relationship
		, ec.home_number as emergency_contact_home_number
		, ec.cell_number as emergency_contact_cell_number
		, ec.work_number as emergency_contact_work_number
		, e.auto as employment_auto
		, e.userID as employment_userID
		, e.ocupation as employment_ocupation
		, e.employer as employment_employer
		, e.street_address as employment_street_address
		, e.city as employment_city
		, e.state as employment_state
		, e.zip as employment_zip
		, e.student_fulltime as employment_student_fulltime
		, e.student_part_time as employment_student_part_time
		, e.school_name as employment_school_name
		, e.school_address as employment_school_address
		, e.school_city as employment_school_city
		, e.school_state as employment_school_state
		, e.school_zip as employment_school_zip
		, e.school_telephone as employment_school_telephone
		, e.date as employment_date
		, e.telephone as employment_telephone
		, e.fax as employment_fax
	FROM users as p
	LEFT JOIN contact_info as ci ON p.auto = ci.id
	LEFT JOIN emergency_contact as ec ON p.auto = ec.userID
	LEFT JOIN employment as e ON p.auto = e.userID
	LEFT JOIN insurance_info as ii ON p.auto = ii.id
	LEFT JOIN financial_responsability fr ON p.auto = fr.userID
	WHERE p.auto = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientFileByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM patient_files
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientGalleriesByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	IF (_limitMaxRow != 0) THEN
		SELECT auto
			, patient_id
			, appointment_in
			, office_id
			, DATE_FORMAT(date, ''%m/%d/%Y'') as date
			, path
			, file_name
			, notes
			, profile
			, profile_date
		FROM patient_gallery
		WHERE patient_id = _patientId
		ORDER BY auto DESC
		LIMIT _limitStartRow, _limitMaxRow;
	ELSE
		SELECT auto
			, patient_id
			, appointment_in
			, office_id
			, DATE_FORMAT(date, ''%m/%d/%Y'') as date
			, path
			, file_name
			, notes
			, profile
			, profile_date
		FROM patient_gallery
		WHERE patient_id = _patientId
		ORDER BY auto DESC;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientGalleryByDistinctDatePatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT DISTINCT date
	FROM patient_gallery
	WHERE patient_id = _patientId
	ORDER BY date DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientGalleryByPatientGalleryId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM patient_gallery
	WHERE auto = _patientGalleryId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientGalleryByPatientIdDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM patient_gallery
	WHERE patient_id = _patientId
		AND date = _date
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatientGalleryProfileByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
		, CONCAT(''patientPicture/'', file_name) as file_name_full
	FROM patient_gallery
	WHERE patient_id = _patientId
	AND profile = 1
	ORDER BY auto DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPatients
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		#		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, DATE_FORMAT(p.date_of_birth, ''%m/%d/%Y'') as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		, p.profilePicture as users_profilePicture
		, (SELECT file_name
			FROM patient_gallery as pg
			WHERE p.auto = pg.patient_id
			AND profile = 1
			ORDER BY auto DESC
			LIMIT 1) as patient_gallery_file_name
		, (SELECT insurance_Company
			FROM insurance_info as ii
			WHERE p.auto = ii.id
			ORDER BY auto DESC
			LIMIT 1) as insurance_info_insurance_Company
	FROM users as p
	ORDER BY p.first_name ASC
	LIMIT _startRow, _limitMaxRow;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPhysicalRehabCountByAdministrationInputId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM physicalrehabcount
	WHERE administrationInputId = _administrationInputId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPhysicalRehabUtilizationByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM physicalrehabutilization
	WHERE AppointmentId = _appointmentTimeId
	ORDER BY PhysicalRehabUtilizationId DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPhysicalRehabUtilizationCountByPhysicalRehabUtilizationId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM physicalrehabutilizationcount
	WHERE PhysicalRehabUtilizationId = _physicalRehabUtilizationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPositionSettingByOfficeIdDoctorIdReportId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM income_report_position_setting
	WHERE office_id = _officeId
		AND doctor_id = _doctorId
		AND reportId = _reportId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPositionSettingDefault
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM income_report_position_setting
	WHERE office_id = ''0''
		AND doctor_id = ''0''
		AND reportId = _reportId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPreviousAppointmentByPatientIdAppointmentTimeIdComparison
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# main query
	IF _isGreater = TRUE THEN
		SELECT *
		FROM appointment_time
		WHERE patient_id = _patientId
			AND auto > _appointmentTimeId
		ORDER BY auto ASC LIMIT 1;
	ELSE
		SELECT *
		FROM appointment_time
		WHERE patient_id = _patientId
			AND auto < _appointmentTimeId
		ORDER BY auto DESC LIMIT 1;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetPreviousAppointmentByPatientIdDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# variable
	SET @dt1 = DATE(NOW());

	# main query
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		, DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, FLOOR(DATEDIFF(@dt1, at.date) / 30) as appointment_time_month_count
		, DATEDIFF(@dt1, at.date) % 30 as appointment_time_day_count
		, o.auto as offices_auto
		, o.practice_name as offices_practice_name
		, o.street_address as offices_street_address
		, o.city as offices_city
		, o.state as offices_state
		, o.zip as offices_zip
		, o.telephone as offices_telephone
		, o.fax_number as offices_fax_number
		, o.type as offices_type
		, o.tax_id_number as offices_tax_id_number
		, o.billing_provider_name as offices_billing_provider_name
		, o.billing_provider_street_address as offices_billing_provider_street_address
		, o.billing_provider_city as offices_billing_provider_city
		, o.billing_provider_state as offices_billing_provider_state
		, o.billing_provider_zip as offices_billing_provider_zip
		, o.billing_provider_phone as offices_billing_provider_phone
		, o.nip_location_id as offices_nip_location_id
		, p.auto as users_auto
		, p.account as users_account
		, p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
		#		, pg.auto as patient_gallery_auto
#		, pg.patient_id as patient_gallery_patient_id
#		, pg.appointment_in as patient_gallery_appointment_in
#		, pg.office_id as patient_gallery_office_id
#		, pg.date as patient_gallery_date
#		, pg.path as patient_gallery_path
#		, pg.file_name as patient_gallery_file_name
#		, pg.notes as patient_gallery_notes
#		, pg.profile as patient_gallery_profile
#		, pg.profile_date as patient_gallery_profile_date
#		, ci.auto as contact_info_auto
#		, ci.id as contact_info_id
#		, ci.street_address as contact_info_street_address
#		, ci.city as contact_info_city
#		, ci.state as contact_info_state
#		, ci.zip as contact_info_zip
#		, ci.county as contact_info_county
#		, ci.country as contact_info_country
#		, ci.home_phone as contact_info_home_phone
#		, ci.mobile_phone as contact_info_mobile_phone
#		, ci.work_phone as contact_info_work_phone
#		, ci.email as contact_info_email
#		, ec.auto as emergency_contact_auto
#		, ec.userID as emergency_contact_userID
#		, ec.first_name as emergency_contact_first_name
#		, ec.middlename as emergency_contact_middlename
#		, ec.last_name as emergency_contact_last_name
#		, ec.street_address as emergency_contact_street_address
#		, ec.city as emergency_contact_city
#		, ec.state as emergency_contact_state
#		, ec.zip as emergency_contact_zip
#		, ec.relationship as emergency_contact_relationship
#		, ec.home_number as emergency_contact_home_number
#		, ec.cell_number as emergency_contact_cell_number
#		, e.auto as employment_auto
#		, e.userID as employment_userID
#		, e.ocupation as employment_ocupation
#		, e.employer as employment_employer
#		, e.street_address as employment_street_address
#		, e.city as employment_city
#		, e.state as employment_state
#		, e.zip as employment_zip
#		, e.student_fulltime as employment_student_fulltime
#		, e.student_part_time as employment_student_part_time
#		, e.school_name as employment_school_name
#		, e.date as employment_date
#		, e.telephone as employment_telephone
#		, e.fax as employment_fax
#		, ii.auto as insurance_info_auto
#		, ii.id as insurance_info_id
#		, ii.member_id as insurance_info_member_id
#		, ii.no_insurance as insurance_info_no_insurance
#		, ii.insurance_Company as insurance_info_insurance_Company
#		, ii.policy_group as insurance_info_policy_group
#		, ii.primary_beneficiary_first_name as insurance_info_primary_beneficiary_first_name
#		, ii.primary_beneficiary_middle_name as insurance_info_primary_beneficiary_middle_name
#		, ii.primary_beneficiary_last_name as insurance_info_primary_beneficiary_last_name
#		, ii.relationship as insurance_info_relationship
#		, ii.beneficiary_id as insurance_info_beneficiary_id
#		, ii.beneficiary_ssn as insurance_info_beneficiary_ssn
#		, ii.beneficiary_DOB as insurance_info_beneficiary_DOB
#		, ii.beneficiary_sex as insurance_info_beneficiary_sex
#		, ii.beneficiary_employment as insurance_info_beneficiary_employment
#		, ii.beneficiary_address as insurance_info_beneficiary_address
#		, ii.beneficiary_city as insurance_info_beneficiary_city
#		, ii.beneficiary_state as insurance_info_beneficiary_state
#		, ii.beneficiary_zip as insurance_info_beneficiary_zip
#		, ii.beneficiary_phone as insurance_info_beneficiary_phone
#		, ii.beneficiary_insurance_copmany as insurance_info_beneficiary_insurance_copmany
#		, ii.beneficiary_plan_name as insurance_info_beneficiary_plan_name
#		, ii.beneficiary_policy_group as insurance_info_beneficiary_policy_group
#		, fr.auto as financial_responsability_auto
#		, fr.userID as financial_responsability_userID
#		, fr.self_responsable as financial_responsability_self_responsable
#		, fr.first_name as financial_responsability_first_name
#		, fr.middlename as financial_responsability_middlename
#		, fr.last_name as financial_responsability_last_name
#		, fr.street_address as financial_responsability_street_address
#		, fr.city as financial_responsability_city
#		, fr.state as financial_responsability_state
#		, fr.zip as financial_responsability_zip
#		, fr.home_phone as financial_responsability_home_phone
#		, fr.mobile_number as financial_responsability_mobile_number
#		, fr.relationship financial_responsability_relationship
#		, fr.sex as financial_responsability_sex
#		, fr.ss_number as financial_responsability_ss_number
#		, fr.driver_lisence as financial_responsability_driver_lisence
#		, fr.birth_date as financial_responsability_birth_date
#		, fr.employer as financial_responsability_employer
#		, fr.employer_address as financial_responsability_employer_address
#		, fr.employer_city as financial_responsability_employer_city
#		, fr.employer_state as financial_responsability_employer_state
#		, fr.employer_zip as financial_responsability_employer_zip
#		, fr.employer_phone as financial_responsability_employer_phone
		, d.auto as doctors_auto
		, d.office_id as doctors_office_id
		, d.id_badge as doctors_id_badge
		, d.first_name as doctors_first_name
		, d.middle_name as doctors_middle_name
		, d.last_name as doctors_last_name
		, d.title as doctors_title
		, d.practice as doctors_practice
		, d.street as doctors_street
		, d.city as doctors_city
		, d.zip as doctors_zip
		, d.state as doctors_state
		, d.telephone as doctors_telephone
		, d.email as doctors_email
		, d.password as doctors_password
		, d.doctor_ssn as doctors_doctor_ssn
		#		, dg.auto as doctor_gallery_auto
#		, dg.doctor_id as doctor_gallery_doctor_id
#		, dg.office_id as doctor_gallery_office_id
#		, dg.date as doctor_gallery_date
#		, dg.path as doctor_gallery_path
#		, dg.file_name as doctor_gallery_file_name
#		, dg.notes as doctor_gallery_notes
#		, dg.extra as doctor_gallery_extra
		, me.auto as medical_encounter_auto
		#		, me.id as medical_encounter_id
		, me.date as medical_encounter_date
		, me.chief_complaint as medical_encounter_chief_complaint
		, me.history_of_illness as medical_encounter_history_of_illness
		, me.assesment as medical_encounter_assesment
		, me.plan as medical_encounter_plan
		, me.progress_notes as medical_encounter_progress_notes
		#		, me.doctor as medical_encounter_doctor
		, me.appointment_id as medical_encounter_appointment_id
		, me.referral_number as medical_encounter_referral_number
		, me.office_id as medical_encounter_office_id
		, me.checked_in as medical_encounter_checked_in
		#		, me.vitals as medical_encounter_vitals
#		, me.visit_status as medical_encounter_visit_status
		, me.no_show as medical_encounter_no_show
		#		, vs.auto as visit_status_auto
#		, vs.office_id as visit_status_office_id
#		, vs.appointment_id as visit_status_appointment_id
#		, vs.patient_id as visit_status_patient_id
#		, vs.in_waiting_room as visit_status_in_waiting_room
#		, vs.check_in as visit_status_check_in
#		, vs.vitals_start as visit_status_vitals_start
#		, vs.vitals_end as visit_status_vitals_end
#		, vs.encounter_start as visit_status_encounter_start
#		, vs.encounter_room as visit_status_encounter_room
#		, vs.encounter_end as visit_status_encounter_end
#		, vs.checkout as visit_status_checkout
		, v.auto as vitals_auto
		#		, v.id as vitals_id
		, v.appointment_id as vitals_appointment_id
		, v.date as vitals_date
		, v.temperature as vitals_temperature
		, v.weight as vitals_weight
		, v.height as vitals_height
		, v.blood_pressure_low as vitals_blood_pressure_low
		, v.blood_pressure_high as vitals_blood_pressure_high
		, v.pulse as vitals_pulse
		, v.respiratory_rate as vitals_respiratory_rate
		, v.pain as vitals_pain
		, v.sixth_name as vitals_sixth_name
		, v.sixth_measure as vitals_sixth_measure
		, v.time_stamp as vitals_time_stamp
	FROM appointment_time as at
	LEFT JOIN offices as o ON at.office_id = o.auto
	LEFT JOIN users as p ON at.patient_id = p.auto
	LEFT JOIN doctors as d ON at.doctor_id = d.auto
	LEFT JOIN (SELECT *
				FROM medical_encounter
				GROUP BY appointment_id
				ORDER BY date DESC) as me ON at.auto = me.appointment_id
	LEFT JOIN (SELECT *
				FROM laboratoryorder
				GROUP BY AppointmentId
				ORDER BY AppointmentId DESC) as lo ON at.auto = lo.AppointmentId
	LEFT JOIN (SELECT *
				FROM visit_status
				GROUP BY appointment_id
				ORDER BY auto DESC) as vs ON at.auto = vs.appointment_id
	LEFT JOIN (SELECT *
				FROM vitals
				GROUP BY appointment_id
				ORDER BY auto DESC) as v ON at.auto = v.appointment_id
	WHERE at.patient_id = _patientId
		AND at.date < _date
	ORDER BY at.date DESC LIMIT _limit;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetProcedureByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedures
	WHERE id = _patientId
	ORDER BY auto DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetProcedureByProcedure
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedures
	WHERE id = _patientId AND `procedure` = _procedure;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetProcedureCodeByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedure_codes_app
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetProcedureListByCPTCode
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedures_list
	WHERE cpt_code = _cptCode;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetProcedureListBySearchTerm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM procedures_list
	WHERE ((`cpt_code` RLIKE _searchTerm)
		OR (`description` RLIKE _searchTerm))
	LIMIT 10;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetRadiologyOrderByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `radiologyorder`.`RadiologyOrderId` as `radiologyorder_RadiologyOrderId`
		, `radiologyorder`.`AppointmentId` as `radiologyorder_AppointmentId`
		, `radiologyorder`.`RadiologyId` as `radiologyorder_RadiologyId`
		, `radiologyorder`.`FacilityId` as `radiologyorder_FacilityId`
		, `radiologyorder`.`Part` as `radiologyorder_Part`
		, `radiologyorder`.`CPTCodeId` as `radiologyorder_CPTCodeId`
		, `radiologyorder`.`OrderStatusId` as `radiologyorder_OrderStatusId`
		, `radiologyorder`.`OrderDateTime` as `radiologyorder_OrderDateTime`
		, `radiology`.`RadiologyId` as `radiology_RadiologyId`
		, `radiology`.`Name` as `radiology_Name`
		, `radiology`.`Code` as `radiology_Code`
		, `orderstatus`.`OrderStatusId` as `orderstatus_OrderStatusId`
		, `orderstatus`.`Name` as `orderstatus_Name`
		, `facility`.`Name` as `facility_Name`
	FROM radiologyorder
	LEFT JOIN radiology ON radiologyorder.RadiologyId = radiology.RadiologyId
	LEFT JOIN orderstatus ON radiologyorder.OrderStatusId = orderstatus.OrderStatusId
	LEFT JOIN facility ON radiologyorder.FacilityId = facility.FacilityId
	WHERE radiologyorder.AppointmentId = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetRadiologyOrdersByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM radiologyorder
	WHERE AppointmentId = _AppointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetRadiologyResultByRadiologyOrderId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM radiologyresult
	WHERE RadiologyOrderId = _radiologyOrderId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetRadiologyTestList
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM radiology
	ORDER BY `Name`;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


getReferralsByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT auto
		, userID
		, refferral_ID
		, office_id
		, physitian
		, streetAddress
		, city
		, state
		, zip
		, phone
		, `date`
		, refered_by
		, referral_reason
		, appointment_id
		, notes
	FROM referals
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSelfAssesmentByAppointmentId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM selfassesment
	WHERE appointmentID = _appointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSignatureOnFileBySigneeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM signature_on_file
	WHERE signee_id = _signeeId
		AND whose_signature = _whoseSignature
		AND is_active = true;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSmokingHistoryByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM smoking_history
	WHERE id = _patientId
	ORDER BY auto DESC
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSoapFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `soapform`.`auto` AS `soapform_auto`,
		`soapform`.`appointmentID` AS `soapform_appointmentID`,
		`soapform`.`patientName` AS `soapform_patientName`,
		`soapform`.`formDate` AS `soapform_formDate`,
		`soapform`.`chiefComplaint` AS `soapform_chiefComplaint`,
		`soapform`.`vas_persent` AS `soapform_vas_persent`,
		`soapform`.`radiationTo` AS `soapform_radiationTo`,
		if (`soapform`.`constant` > 0, "true", "false") AS `soapform_constant`,
		if (`soapform`.`intermittent` > 0, "true", "false") AS `soapform_intermittent`,
		if (`soapform`.`aching` > 0, "true", "false") AS `soapform_aching`,
		if (`soapform`.`burning` > 0, "true", "false") AS `soapform_burning`,
		if (`soapform`.`cramping` > 0, "true", "false") AS `soapform_cramping`,
		if (`soapform`.`deep` > 0, "true", "false") AS `soapform_deep`,
		if (`soapform`.`dull` > 0, "true", "false") AS `soapform_dull`,
		if (`soapform`.`electricType` > 0, "true", "false") AS `soapform_electricType`,
		if (`soapform`.`numbness` > 0, "true", "false") AS `soapform_numbness`,
		if (`soapform`.`pulling` > 0, "true", "false") AS `soapform_pulling`,
		if (`soapform`.`sharp` > 0, "true", "false") AS `soapform_sharp`,
		if (`soapform`.`shooting` > 0, "true", "false") AS `soapform_shooting`,
		if (`soapform`.`stabbing` > 0, "true", "false") AS `soapform_stabbing`,
		if (`soapform`.`throbbing` > 0, "true", "false") AS `soapform_throbbing`,
		if (`soapform`.`tingling` > 0, "true", "false") AS `soapform_tingling`,
		`soapform`.`MusculoskeletalExam` AS `soapform_MusculoskeletalExam`,
		`soapform`.`Reflexes` AS `soapform_Reflexes`,
		`soapform`.`ROM` AS `soapform_ROM`,
		`soapform`.`LowerExtLeft` AS `soapform_LowerExtLeft`,
		`soapform`.`LowerExtRight` AS `soapform_LowerExtRight`,
		`soapform`.`UpperExtLeft` AS `soapform_UpperExtLeft`,
		`soapform`.`UpperExtRight` AS `soapform_UpperExtRight`,
		`soapform`.`Sensory` AS `soapform_Sensory`,
		`soapform`.`OrthopedicTest_SLR_rihgt` AS `soapform_OrthopedicTest_SLR_rihgt`,
		`soapform`.`OrthopedicTest_SLR_left` AS `soapform_OrthopedicTest_SLR_left`,
		`soapform`.`Other` AS `soapform_Other`,
		`soapform`.`idc9-724-5` AS `soapform_idc9-724-5`,
		`soapform`.`idc9-728-85` AS `soapform_idc9-728-85`,
		`soapform`.`idc9-723-4` AS `soapform_idc9-723-4`,
		`soapform`.`idc9-723-1` AS `soapform_idc9-723-1`,
		`soapform`.`idc9-739-1` AS `soapform_idc9-739-1`,
		`soapform`.`idc9-724-4` AS `soapform_idc9-724-4`,
		`soapform`.`idc9-724-1` AS `soapform_idc9-724-1`,
		`soapform`.`idc9-739-2` AS `soapform_idc9-739-2`,
		`soapform`.`idc9-847-0` AS `soapform_idc9-847-0`,
		`soapform`.`idc9-719-46` AS `soapform_idc9-719-46`,
		`soapform`.`idc9-739-3` AS `soapform_idc9-739-3`,
		`soapform`.`idc9-847-1` AS `soapform_idc9-847-1`,
		`soapform`.`idc9-713-41` AS `soapform_idc9-713-41`,
		`soapform`.`idc9-847-2` AS `soapform_idc9-847-2`,
		`soapform`.`idc9-722-81` AS `soapform_idc9-722-81`,
		`soapform`.`idc9-722-83` AS `soapform_idc9-722-83`,
		`soapform`.`otherIDC9` AS `soapform_otherIDC9`,
		`soapform`.`TherapeuticExercises_areaTreated` AS `soapform_TherapeuticExercises_areaTreated`,
		`soapform`.`TherapeuticExercises_time` AS `soapform_TherapeuticExercises_time`,
		`soapform`.`TherapeuticExercisesRationale` AS `soapform_TherapeuticExercisesRationale`,
		`soapform`.`NeuromuscularReEducation_areaTreated` AS `soapform_NeuromuscularReEducation_areaTreated`,
		`soapform`.`NeuromuscularReEducation_time` AS `soapform_NeuromuscularReEducation_time`,
		`soapform`.`NeuromuscularReEducationRationale` AS `soapform_NeuromuscularReEducationRationale`,
		`soapform`.`Massage_areaTreated` AS `soapform_Massage_areaTreated`,
		`soapform`.`Massage_time` AS `soapform_Massage_time`,
		`soapform`.`MassageRationale` AS `soapform_MassageRationale`,
		`soapform`.`EMS_areaTreated` AS `soapform_EMS_areaTreated`,
		`soapform`.`EMS_time` AS `soapform_EMS_time`,
		`soapform`.`EMSRationale` AS `soapform_EMSRationale`,
		`soapform`.`Ultrasound_areaTreated` AS `soapform_Ultrasound_areaTreated`,
		`soapform`.`Ultrasound_time` AS `soapform_Ultrasound_time`,
		`soapform`.`UltrasoundRationale` AS `soapform_UltrasoundRationale`,
		`soapform`.`TriggerPointMyofascialRelease_areaTreated` AS `soapform_TriggerPointMyofascialRelease_areaTreated`,
		`soapform`.`TriggerPointMyofascialRelease_time` AS `soapform_TriggerPointMyofascialRelease_time`,
		`soapform`.`TriggerPointMyofascialReleaseRationale` AS `soapform_TriggerPointMyofascialReleaseRationale`,
		`soapform`.`Traction_areaTreated` AS `soapform_Traction_areaTreated`,
		`soapform`.`Traction_time` AS `soapform_Traction_time`,
		`soapform`.`TractionRationale` AS `soapform_TractionRationale`,
		`soapform`.`Manipulation` AS `soapform_Manipulation`,
		`soapform`.`otherProcedures` AS `soapform_otherProcedures`,
		`soapform`.`ProgressAfterTXVAS` AS `soapform_ProgressAfterTXVAS`,
		`soapform`.`AfterRadiationTo` AS `soapform_AfterRadiationTo`,
		if (`soapform`.`AfterRadConstant` > 0, "true", "false") AS `soapform_AfterRadConstant`,
		if (`soapform`.`AfterRadIntermittent` > 0, "true", "false") AS `soapform_AfterRadIntermittent`,
		`soapform`.`AfterROMMuscleTone` AS `soapform_AfterROMMuscleTone`,
		`soapform`.`TreatmentToleranceCompliance` AS `soapform_TreatmentToleranceCompliance`,
		`soapform`.`Recommendations` AS `soapform_Recommendations`,
		`soapform`.`Referrals` AS `soapform_Referrals`,
		`soapform`.`Provider` AS `soapform_Provider`,
		`soapform`.`signatureDate` AS `soapform_signatureDate`,
		`soapform`.`TreatmentToleranceCompliance_poor` AS `soapform_TreatmentToleranceCompliance_poor`,
		`soapform`.`TreatmentToleranceCompliance_fair` AS `soapform_TreatmentToleranceCompliance_fair`,
		`soapform`.`TreatmentToleranceCompliance_well` AS `soapform_TreatmentToleranceCompliance_well`
	FROM `SOAPform`
	WHERE `SOAPform`.`appointmentID` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSoapFormCompleteByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# declare variables for subquery in join statement in main query
	DECLARE var_patient_id INT;

	# populate variables
	SELECT at.patient_id
	INTO var_patient_id
	FROM appointment_time as at
	WHERE at.auto = _appointmentTimeId;

	SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`ci`.`auto` AS `contact_info_auto`,
		`ci`.`id` AS `contact_info_id`,
		`ci`.`street_address` AS `contact_info_street_address`,
		`ci`.`city` AS `contact_info_city`,
		`ci`.`state` AS `contact_info_state`,
		`ci`.`zip` AS `contact_info_zip`,
		`ci`.`county` AS `contact_info_county`,
		`ci`.`country` AS `contact_info_country`,
		`ci`.`home_phone` AS `contact_info_home_phone`,
		`ci`.`mobile_phone` AS `contact_info_mobile_phone`,
		`ci`.`work_phone` AS `contact_info_work_phone`,
		`ci`.`email` AS `contact_info_email`,
		`ii`.`auto` AS `insurance_info_auto`,
		`ii`.`id` AS `insurance_info_id`,
		`ii`.`member_id` AS `insurance_info_member_id`,
		`ii`.`no_insurance` AS `insurance_info_no_insurance`,
		`ii`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`ii`.`policy_group` AS `insurance_info_policy_group`,
		`ii`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`ii`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`ii`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`ii`.`relationship` AS `insurance_info_relationship`,
		`ii`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`ii`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`ii`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`ii`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`ii`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`ii`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`ii`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`ii`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`ii`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`ii`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`ii`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`ii`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`ii`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`ii`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`ii`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`ii`.`plan_name` AS `insurance_info_plan_name`,
		`ii`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`me`.`auto` AS `medical_encounter_auto`,
		`me`.`id` AS `medical_encounter_id`,
		`me`.`date` AS `medical_encounter_date`,
		`me`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`me`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`me`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`me`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`me`.`assesment` AS `medical_encounter_assesment`,
		`me`.`plan` AS `medical_encounter_plan`,
		`me`.`progress_notes` AS `medical_encounter_progress_notes`,
		`me`.`doctor` AS `medical_encounter_doctor`,
		`me`.`appointment_id` AS `medical_encounter_appointment_id`,
		`me`.`referral_number` AS `medical_encounter_referral_number`,
		`me`.`office_id` AS `medical_encounter_office_id`,
		`me`.`checked_in` AS `medical_encounter_checked_in`,
		`me`.`vitals` AS `medical_encounter_vitals`,
		`me`.`no_show` AS `medical_encounter_no_show`,
		`soapform`.`auto` AS `soapform_auto`,
		`soapform`.`appointmentID` AS `soapform_appointmentID`,
		`soapform`.`patientName` AS `soapform_patientName`,
		`soapform`.`formDate` AS `soapform_formDate`,
		`soapform`.`chiefComplaint` AS `soapform_chiefComplaint`,
		`soapform`.`vas_persent` AS `soapform_vas_persent`,
		`soapform`.`radiationTo` AS `soapform_radiationTo`,
		if (`soapform`.`constant` > 0, "true", "false") AS `soapform_constant`,
		if (`soapform`.`intermittent` > 0, "true", "false") AS `soapform_intermittent`,
		if (`soapform`.`aching` > 0, "true", "false") AS `soapform_aching`,
		if (`soapform`.`burning` > 0, "true", "false") AS `soapform_burning`,
		if (`soapform`.`cramping` > 0, "true", "false") AS `soapform_cramping`,
		if (`soapform`.`deep` > 0, "true", "false") AS `soapform_deep`,
		if (`soapform`.`dull` > 0, "true", "false") AS `soapform_dull`,
		if (`soapform`.`electricType` > 0, "true", "false") AS `soapform_electricType`,
		if (`soapform`.`numbness` > 0, "true", "false") AS `soapform_numbness`,
		if (`soapform`.`pulling` > 0, "true", "false") AS `soapform_pulling`,
		if (`soapform`.`sharp` > 0, "true", "false") AS `soapform_sharp`,
		if (`soapform`.`shooting` > 0, "true", "false") AS `soapform_shooting`,
		if (`soapform`.`stabbing` > 0, "true", "false") AS `soapform_stabbing`,
		if (`soapform`.`throbbing` > 0, "true", "false") AS `soapform_throbbing`,
		if (`soapform`.`tingling` > 0, "true", "false") AS `soapform_tingling`,
		`soapform`.`MusculoskeletalExam` AS `soapform_MusculoskeletalExam`,
		`soapform`.`Reflexes` AS `soapform_Reflexes`,
		`soapform`.`ROM` AS `soapform_ROM`,
		`soapform`.`LowerExtLeft` AS `soapform_LowerExtLeft`,
		`soapform`.`LowerExtRight` AS `soapform_LowerExtRight`,
		`soapform`.`UpperExtLeft` AS `soapform_UpperExtLeft`,
		`soapform`.`UpperExtRight` AS `soapform_UpperExtRight`,
		`soapform`.`Sensory` AS `soapform_Sensory`,
		`soapform`.`OrthopedicTest_SLR_rihgt` AS `soapform_OrthopedicTest_SLR_rihgt`,
		`soapform`.`OrthopedicTest_SLR_left` AS `soapform_OrthopedicTest_SLR_left`,
		`soapform`.`Other` AS `soapform_Other`,
		`soapform`.`idc9-724-5` AS `soapform_idc9-724-5`,
		`soapform`.`idc9-728-85` AS `soapform_idc9-728-85`,
		`soapform`.`idc9-723-4` AS `soapform_idc9-723-4`,
		`soapform`.`idc9-723-1` AS `soapform_idc9-723-1`,
		`soapform`.`idc9-739-1` AS `soapform_idc9-739-1`,
		`soapform`.`idc9-724-4` AS `soapform_idc9-724-4`,
		`soapform`.`idc9-724-1` AS `soapform_idc9-724-1`,
		`soapform`.`idc9-739-2` AS `soapform_idc9-739-2`,
		`soapform`.`idc9-847-0` AS `soapform_idc9-847-0`,
		`soapform`.`idc9-719-46` AS `soapform_idc9-719-46`,
		`soapform`.`idc9-739-3` AS `soapform_idc9-739-3`,
		`soapform`.`idc9-847-1` AS `soapform_idc9-847-1`,
		`soapform`.`idc9-713-41` AS `soapform_idc9-713-41`,
		`soapform`.`idc9-847-2` AS `soapform_idc9-847-2`,
		`soapform`.`idc9-722-81` AS `soapform_idc9-722-81`,
		`soapform`.`idc9-722-83` AS `soapform_idc9-722-83`,
		`soapform`.`otherIDC9` AS `soapform_otherIDC9`,
		`soapform`.`TherapeuticExercises_areaTreated` AS `soapform_TherapeuticExercises_areaTreated`,
		`soapform`.`TherapeuticExercises_time` AS `soapform_TherapeuticExercises_time`,
		`soapform`.`TherapeuticExercisesRationale` AS `soapform_TherapeuticExercisesRationale`,
		`soapform`.`NeuromuscularReEducation_areaTreated` AS `soapform_NeuromuscularReEducation_areaTreated`,
		`soapform`.`NeuromuscularReEducation_time` AS `soapform_NeuromuscularReEducation_time`,
		`soapform`.`NeuromuscularReEducationRationale` AS `soapform_NeuromuscularReEducationRationale`,
		`soapform`.`Massage_areaTreated` AS `soapform_Massage_areaTreated`,
		`soapform`.`Massage_time` AS `soapform_Massage_time`,
		`soapform`.`MassageRationale` AS `soapform_MassageRationale`,
		`soapform`.`EMS_areaTreated` AS `soapform_EMS_areaTreated`,
		`soapform`.`EMS_time` AS `soapform_EMS_time`,
		`soapform`.`EMSRationale` AS `soapform_EMSRationale`,
		`soapform`.`Ultrasound_areaTreated` AS `soapform_Ultrasound_areaTreated`,
		`soapform`.`Ultrasound_time` AS `soapform_Ultrasound_time`,
		`soapform`.`UltrasoundRationale` AS `soapform_UltrasoundRationale`,
		`soapform`.`TriggerPointMyofascialRelease_areaTreated` AS `soapform_TriggerPointMyofascialRelease_areaTreated`,
		`soapform`.`TriggerPointMyofascialRelease_time` AS `soapform_TriggerPointMyofascialRelease_time`,
		`soapform`.`TriggerPointMyofascialReleaseRationale` AS `soapform_TriggerPointMyofascialReleaseRationale`,
		`soapform`.`Traction_areaTreated` AS `soapform_Traction_areaTreated`,
		`soapform`.`Traction_time` AS `soapform_Traction_time`,
		`soapform`.`TractionRationale` AS `soapform_TractionRationale`,
		`soapform`.`Manipulation` AS `soapform_Manipulation`,
		`soapform`.`otherProcedures` AS `soapform_otherProcedures`,
		`soapform`.`ProgressAfterTXVAS` AS `soapform_ProgressAfterTXVAS`,
		`soapform`.`AfterRadiationTo` AS `soapform_AfterRadiationTo`,
		if (`soapform`.`AfterRadConstant` > 0, "true", "false") AS `soapform_AfterRadConstant`,
		if (`soapform`.`AfterRadIntermittent` > 0, "true", "false") AS `soapform_AfterRadIntermittent`,
		`soapform`.`AfterROMMuscleTone` AS `soapform_AfterROMMuscleTone`,
		`soapform`.`TreatmentToleranceCompliance` AS `soapform_TreatmentToleranceCompliance`,
		`soapform`.`Recommendations` AS `soapform_Recommendations`,
		`soapform`.`Referrals` AS `soapform_Referrals`,
		`soapform`.`Provider` AS `soapform_Provider`,
		`soapform`.`signatureDate` AS `soapform_signatureDate`,
		`soapform`.`TreatmentToleranceCompliance_poor` AS `soapform_TreatmentToleranceCompliance_poor`,
		`soapform`.`TreatmentToleranceCompliance_fair` AS `soapform_TreatmentToleranceCompliance_fair`,
		`soapform`.`TreatmentToleranceCompliance_well` AS `soapform_TreatmentToleranceCompliance_well`
	FROM `appointment_time` as at
	LEFT JOIN `users` ON `at`.`patient_id` = `users`.`auto`
	LEFT JOIN `doctors` ON `at`.`doctor_id` = `doctors`.`auto`
	LEFT JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	LEFT JOIN (SELECT * FROM `contact_info` WHERE `contact_info`.`id` = var_patient_id ORDER BY auto DESC LIMIT 1) as ci ON `at`.`patient_id` = ci.`id`
	LEFT JOIN (SELECT * FROM `insurance_info` WHERE `insurance_info`.`id` = var_patient_id ORDER BY auto DESC LIMIT 1) as ii ON `at`.`patient_id` = ii.`id`
	LEFT JOIN (SELECT * FROM `medical_encounter` WHERE `medical_encounter`.`appointment_id` = _appointmentTimeId ORDER BY auto DESC LIMIT 1) as me ON `at`.`auto` = me.`appointment_id`
	LEFT JOIN `SOAPform` ON `at`.`auto` = `SOAPform`.`appointmentID`
	WHERE `at`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetSuperBillFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`contact_info`.`auto` AS `contact_info_auto`,
		`contact_info`.`id` AS `contact_info_id`,
		`contact_info`.`street_address` AS `contact_info_street_address`,
		`contact_info`.`city` AS `contact_info_city`,
		`contact_info`.`state` AS `contact_info_state`,
		`contact_info`.`zip` AS `contact_info_zip`,
		`contact_info`.`county` AS `contact_info_county`,
		`contact_info`.`country` AS `contact_info_country`,
		`contact_info`.`home_phone` AS `contact_info_home_phone`,
		`contact_info`.`mobile_phone` AS `contact_info_mobile_phone`,
		`contact_info`.`work_phone` AS `contact_info_work_phone`,
		`contact_info`.`email` AS `contact_info_email`,
		`insurance_info`.`auto` AS `insurance_info_auto`,
		`insurance_info`.`id` AS `insurance_info_id`,
		`insurance_info`.`member_id` AS `insurance_info_member_id`,
		`insurance_info`.`no_insurance` AS `insurance_info_no_insurance`,
		`insurance_info`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`insurance_info`.`policy_group` AS `insurance_info_policy_group`,
		`insurance_info`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`insurance_info`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`insurance_info`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`insurance_info`.`relationship` AS `insurance_info_relationship`,
		`insurance_info`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`insurance_info`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`insurance_info`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`insurance_info`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`insurance_info`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`insurance_info`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`insurance_info`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`insurance_info`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`insurance_info`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`insurance_info`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`insurance_info`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`insurance_info`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`insurance_info`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`insurance_info`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`insurance_info`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`insurance_info`.`plan_name` AS `insurance_info_plan_name`,
		`insurance_info`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`medical_encounter`.`auto` AS `medical_encounter_auto`,
		`medical_encounter`.`id` AS `medical_encounter_id`,
		`medical_encounter`.`date` AS `medical_encounter_date`,
		`medical_encounter`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`medical_encounter`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`medical_encounter`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`medical_encounter`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`medical_encounter`.`assesment` AS `medical_encounter_assesment`,
		`medical_encounter`.`plan` AS `medical_encounter_plan`,
		`medical_encounter`.`progress_notes` AS `medical_encounter_progress_notes`,
		`medical_encounter`.`doctor` AS `medical_encounter_doctor`,
		`medical_encounter`.`appointment_id` AS `medical_encounter_appointment_id`,
		`medical_encounter`.`referral_number` AS `medical_encounter_referral_number`,
		`medical_encounter`.`office_id` AS `medical_encounter_office_id`,
		`medical_encounter`.`checked_in` AS `medical_encounter_checked_in`,
		`medical_encounter`.`vitals` AS `medical_encounter_vitals`,
		`medical_encounter`.`visit_status` AS `medical_encounter_visit_status`,
		`medical_encounter`.`no_show` AS `medical_encounter_no_show`,
		`superbill`.`auto` AS `superbill_auto`,
		`superbill`.`appointmentID` AS `superbill_appointmentID`,
		`superbill`.`dateOfService` AS `superbill_dateOfService`,
		`superbill`.`patientsName` AS `superbill_patientsName`,
		`superbill`.`diagnosis` AS `superbill_diagnosis`,
		`superbill`.`licensedProvider` AS `superbill_licensedProvider`
	FROM `appointment_time`
	LEFT JOIN `users` ON `appointment_time`.`patient_id` = `users`.`auto`
	INNER JOIN `doctors` ON `appointment_time`.`doctor_id` = `doctors`.`auto`
	INNER JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	INNER JOIN `contact_info` ON `appointment_time`.`patient_id` = `contact_info`.`id`
	INNER JOIN `insurance_info` ON `appointment_time`.`patient_id` = `insurance_info`.`id`
	INNER JOIN `medical_encounter` ON `appointment_time`.`auto` = `medical_encounter`.`appointment_id`
	LEFT JOIN `superbill` ON `appointment_time`.`auto` = `superbill`.`appointmentID`
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTestResultByAppointemntID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM test_results
	WHERE appointmentID = _appointmentTimeID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTestResultByPatientId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM test_results
	WHERE id = _patientId
	LIMIT _limitStartRow, _limitMaxRow;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTestResultByTestName
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM test_results
	WHERE test_name = _testName
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTestResultFileByTestResultId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM test_results_file
	WHERE test_results_id = _testResultId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTodayAppointments
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT at.auto as appointment_time_auto
		, at.office_id as appointment_time_office_id
		, at.patient_id as appointment_time_patient_id
		, at.doctor_id as appointment_time_doctor_id
		-- , DATE_FORMAT(at.date, ''%m/%d/%Y'') as appointment_time_date
		, at.date as appointment_time_date
		, at.starts as appointment_time_starts
		, at.ends as appointment_time_ends
		, at.confirmation as appointment_time_confirmation
		, at.referral_number as appointment_time_referral_number
		, p.auto as users_auto
		, p.account as users_account
		-- , p.email as users_email
		, p.password as users_password
		, p.salutation as users_salutation
		, p.first_name as users_first_name
		, p.middle_name as users_middle_name
		, p.Last_name as users_Last_name
		, p.title as users_title
		, p.marital_status as users_marital_status
		, p.primary_doctor as users_primary_doctor
		, p.date_of_birth as users_date_of_birth
		, p.gender as users_gender
		, p.ss_number as users_ss_number
		, p.driver_license as users_driver_license
		, p.dl_state as users_dl_state
	FROM appointment_time as at
	JOIN users as p ON at.patient_id = p.auto
	WHERE at.date = CURDATE()
	ORDER BY at.date DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTransactionBalanceByOfficeIdPatientIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT SUM(`transaction`.`Balance`) AS balance
	FROM transaction
	INNER JOIN charge ON transaction.ChargeId = charge.ChargeId
	WHERE transaction.OfficeId = _officeId
		AND transaction.PatientId = _patientId
		AND transaction.DueDate >= _fromDate
		AND transaction.DueDate <= _toDate
		AND transaction.Status = ''0''
		AND transaction.ChargeId <> 0
	ORDER BY transaction.TransactionId DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTransactionBalanceByOfficeIdPatientIdDoctorIdDateRange
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT SUM(`transaction`.`Balance`) AS balance
	FROM transaction
	INNER JOIN charge ON transaction.ChargeId = charge.ChargeId
	WHERE transaction.OfficeId = _officeId
		AND transaction.PatientId = _patientId
		AND transaction.ProviderId = _doctorId
		AND transaction.DueDate >= _fromDate
		AND transaction.DueDate <= _toDate
		AND transaction.Status = ''0''
		AND transaction.ChargeId <> 0
	ORDER BY transaction.TransactionId DESC;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTransactionChargeByOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM transaction
	INNER JOIN charge ON transaction.ChargeId = charge.ChargeId
	WHERE transaction.OfficeId = _officeId
		AND transaction.ChargeId <> 0;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetTransactionTypeAll
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM transactiont_type;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetUtilizationFormByAppointmentId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM utilizationform
	WHERE appointmentID = _appointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetUtilizationFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`contact_info`.`auto` AS `contact_info_auto`,
		`contact_info`.`id` AS `contact_info_id`,
		`contact_info`.`street_address` AS `contact_info_street_address`,
		`contact_info`.`city` AS `contact_info_city`,
		`contact_info`.`state` AS `contact_info_state`,
		`contact_info`.`zip` AS `contact_info_zip`,
		`contact_info`.`county` AS `contact_info_county`,
		`contact_info`.`country` AS `contact_info_country`,
		`contact_info`.`home_phone` AS `contact_info_home_phone`,
		`contact_info`.`mobile_phone` AS `contact_info_mobile_phone`,
		`contact_info`.`work_phone` AS `contact_info_work_phone`,
		`contact_info`.`email` AS `contact_info_email`,
		`insurance_info`.`auto` AS `insurance_info_auto`,
		`insurance_info`.`id` AS `insurance_info_id`,
		`insurance_info`.`member_id` AS `insurance_info_member_id`,
		`insurance_info`.`no_insurance` AS `insurance_info_no_insurance`,
		`insurance_info`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`insurance_info`.`policy_group` AS `insurance_info_policy_group`,
		`insurance_info`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`insurance_info`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`insurance_info`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`insurance_info`.`relationship` AS `insurance_info_relationship`,
		`insurance_info`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`insurance_info`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`insurance_info`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`insurance_info`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`insurance_info`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`insurance_info`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`insurance_info`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`insurance_info`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`insurance_info`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`insurance_info`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`insurance_info`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`insurance_info`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`insurance_info`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`insurance_info`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`insurance_info`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`insurance_info`.`plan_name` AS `insurance_info_plan_name`,
		`insurance_info`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`medical_encounter`.`auto` AS `medical_encounter_auto`,
		`medical_encounter`.`id` AS `medical_encounter_id`,
		`medical_encounter`.`date` AS `medical_encounter_date`,
		`medical_encounter`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`medical_encounter`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`medical_encounter`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`medical_encounter`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`medical_encounter`.`assesment` AS `medical_encounter_assesment`,
		`medical_encounter`.`plan` AS `medical_encounter_plan`,
		`medical_encounter`.`progress_notes` AS `medical_encounter_progress_notes`,
		`medical_encounter`.`doctor` AS `medical_encounter_doctor`,
		`medical_encounter`.`appointment_id` AS `medical_encounter_appointment_id`,
		`medical_encounter`.`referral_number` AS `medical_encounter_referral_number`,
		`medical_encounter`.`office_id` AS `medical_encounter_office_id`,
		`medical_encounter`.`checked_in` AS `medical_encounter_checked_in`,
		`medical_encounter`.`vitals` AS `medical_encounter_vitals`,
		`medical_encounter`.`visit_status` AS `medical_encounter_visit_status`,
		`medical_encounter`.`no_show` AS `medical_encounter_no_show`,
		`utilizationform`.`auto` AS `utilizationform_auto`,
		`utilizationform`.`appointmentID` AS `utilizationform_appointmentID`,
		`utilizationform`.`reseivingName` AS `utilizationform_reseivingName`,
		`utilizationform`.`senderName` AS `utilizationform_senderName`,
		`utilizationform`.`ReseivingFax` AS `utilizationform_ReseivingFax`,
		`utilizationform`.`senderPhone` AS `utilizationform_senderPhone`,
		`utilizationform`.`numOfPages` AS `utilizationform_numOfPages`,
		`utilizationform`.`senderFax` AS `utilizationform_senderFax`,
		`utilizationform`.`diagnosis` AS `utilizationform_diagnosis`,
		`utilizationform`.`requestedServices` AS `utilizationform_requestedServices`,
		`utilizationform`.`frequency` AS `utilizationform_frequency`,
		`utilizationform`.`outpatient` AS `utilizationform_outpatient`,
		`utilizationform`.`inpatient` AS `utilizationform_inpatient`,
		`utilizationform`.`claimantName` AS `utilizationform_claimantName`,
		`utilizationform`.`claimantSSN` AS `utilizationform_claimantSSN`,
		`utilizationform`.`claimNumber` AS `utilizationform_claimNumber`,
		`utilizationform`.`dateOfInjury` AS `utilizationform_dateOfInjury`,
		`utilizationform`.`requestingProvider` AS `utilizationform_requestingProvider`,
		`utilizationform`.`taxID` AS `utilizationform_taxID`,
		`utilizationform`.`NPInumber` AS `utilizationform_NPInumber`,
		`utilizationform`.`DoctorAddress` AS `utilizationform_DoctorAddress`,
		`utilizationform`.`officePhone` AS `utilizationform_officePhone`,
		`utilizationform`.`officeFax` AS `utilizationform_officeFax`,
		`utilizationform`.`idc_97012` AS `utilizationform_idc_97012`,
		`utilizationform`.`idc_97035` AS `utilizationform_idc_97035`,
		`utilizationform`.`idc_97110` AS `utilizationform_idc_97110`,
		`utilizationform`.`idc_G0283` AS `utilizationform_idc_G0283`,
		`utilizationform`.`idc_97124` AS `utilizationform_idc_97124`,
		`utilizationform`.`idc_98940` AS `utilizationform_idc_98940`,
		`utilizationform`.`idc_97545_WC` AS `utilizationform_idc_97545_WC`,
		`utilizationform`.`idc_97546_WC` AS `utilizationform_idc_97546_WC`,
		`utilizationform`.`idc_97545_WH` AS `utilizationform_idc_97545_WH`
	FROM `appointment_time`
	LEFT JOIN `users` ON `appointment_time`.`patient_id` = `users`.`auto`
	INNER JOIN `doctors` ON `appointment_time`.`doctor_id` = `doctors`.`auto`
	INNER JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	INNER JOIN `contact_info` ON `appointment_time`.`patient_id` = `contact_info`.`id`
	INNER JOIN `insurance_info` ON `appointment_time`.`patient_id` = `insurance_info`.`id`
	INNER JOIN `medical_encounter` ON `appointment_time`.`auto` = `medical_encounter`.`appointment_id`
	LEFT JOIN `utilizationform` ON `appointment_time`.`auto` = `utilizationform`.`appointmentID`
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetVisitStatusByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `appointment_status`,
	`appointment_status`.`statusID` AS `status_id`,
	`appointment_status`.`color` AS `status_color`,
	`appointment_status`.`statusName` AS `status_name`
	FROM `appointment_time`
	LEFT JOIN `appointment_status` ON(
	`appointment_status`.`statusID` = `appointment_time`.`appointment_status`
	)
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetVisitStatusByAppointmentTimeIdOfficeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM visit_status
	WHERE appointment_id = _appointmentTimeId
		AND office_id = _officeId
	LIMIT 1;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetVitalsByAppointmentTimeID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT *
	FROM vitals
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


GetWorkerCompFormByAppointmentTimeId
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SELECT `users`.`auto` AS `users_auto`,
		`users`.`account` AS `users_account`,
		`users`.`email` AS `users_email`,
		`users`.`salt` AS `users_salt`,
		`users`.`password` AS `users_password`,
		`users`.`salutation` AS `users_salutation`,
		`users`.`first_name` AS `users_first_name`,
		`users`.`middle_name` AS `users_middle_name`,
		`users`.`Last_name` AS `users_Last_name`,
		`users`.`title` AS `users_title`,
		`users`.`marital_status` AS `users_marital_status`,
		`users`.`primary_doctor` AS `users_primary_doctor`,
		`users`.`date_of_birth` AS `users_date_of_birth`,
		`users`.`gender` AS `users_gender`,
		`users`.`ss_number` AS `users_ss_number`,
		`users`.`driver_license` AS `users_driver_license`,
		`users`.`dl_state` AS `users_dl_state`,
		`doctors`.`first_name` AS `doctors_first_name`,
		`doctors`.`last_name` AS `doctors_last_name`,
		`doctors`.`middle_name` AS `doctors_middle_name`,
		`offices`.`street_address` AS `offices_street_address`,
		`offices`.`practice_name` AS `offices_practice_name`,
		`offices`.`city` AS `offices_city`,
		`offices`.`state` AS `offices_state`,
		`offices`.`zip` AS `offices_zip`,
		`offices`.`telephone` AS `offices_telephone`,
		`offices`.`fax_number` AS `offices_fax_number`,
		`contact_info`.`auto` AS `contact_info_auto`,
		`contact_info`.`id` AS `contact_info_id`,
		`contact_info`.`street_address` AS `contact_info_street_address`,
		`contact_info`.`city` AS `contact_info_city`,
		`contact_info`.`state` AS `contact_info_state`,
		`contact_info`.`zip` AS `contact_info_zip`,
		`contact_info`.`county` AS `contact_info_county`,
		`contact_info`.`country` AS `contact_info_country`,
		`contact_info`.`home_phone` AS `contact_info_home_phone`,
		`contact_info`.`mobile_phone` AS `contact_info_mobile_phone`,
		`contact_info`.`work_phone` AS `contact_info_work_phone`,
		`contact_info`.`email` AS `contact_info_email`,
		`insurance_info`.`auto` AS `insurance_info_auto`,
		`insurance_info`.`id` AS `insurance_info_id`,
		`insurance_info`.`member_id` AS `insurance_info_member_id`,
		`insurance_info`.`no_insurance` AS `insurance_info_no_insurance`,
		`insurance_info`.`insurance_Company` AS `insurance_info_insurance_Company`,
		`insurance_info`.`policy_group` AS `insurance_info_policy_group`,
		`insurance_info`.`primary_beneficiary_first_name` AS `insurance_info_primary_beneficiary_first_name`,
		`insurance_info`.`primary_beneficiary_middle_name` AS `insurance_info_primary_beneficiary_middle_name`,
		`insurance_info`.`primary_beneficiary_last_name` AS `insurance_info_primary_beneficiary_last_name`,
		`insurance_info`.`relationship` AS `insurance_info_relationship`,
		`insurance_info`.`beneficiary_id` AS `insurance_info_beneficiary_id`,
		`insurance_info`.`beneficiary_ssn` AS `insurance_info_beneficiary_ssn`,
		`insurance_info`.`beneficiary_DOB` AS `insurance_info_beneficiary_DOB`,
		`insurance_info`.`beneficiary_sex` AS `insurance_info_beneficiary_sex`,
		`insurance_info`.`beneficiary_employment` AS `insurance_info_beneficiary_employment`,
		`insurance_info`.`beneficiary_address` AS `insurance_info_beneficiary_address`,
		`insurance_info`.`beneficiary_city` AS `insurance_info_beneficiary_city`,
		`insurance_info`.`beneficiary_state` AS `insurance_info_beneficiary_state`,
		`insurance_info`.`beneficiary_zip` AS `insurance_info_beneficiary_zip`,
		`insurance_info`.`beneficiary_phone` AS `insurance_info_beneficiary_phone`,
		`insurance_info`.`beneficiary_insurance_copmany` AS `insurance_info_beneficiary_insurance_copmany`,
		`insurance_info`.`beneficiary_plan_name` AS `insurance_info_beneficiary_plan_name`,
		`insurance_info`.`beneficiary_policy_group` AS `insurance_info_beneficiary_policy_group`,
		`insurance_info`.`insurance_efective_date` AS `insurance_info_insurance_efective_date`,
		`insurance_info`.`preauthorization_number` AS `insurance_info_preauthorization_number`,
		`insurance_info`.`plan_name` AS `insurance_info_plan_name`,
		`insurance_info`.`insurance_company_phone_number` AS `insurance_info_insurance_company_phone_number`,
		`medical_encounter`.`auto` AS `medical_encounter_auto`,
		`medical_encounter`.`id` AS `medical_encounter_id`,
		`medical_encounter`.`date` AS `medical_encounter_date`,
		`medical_encounter`.`chief_complaint` AS `medical_encounter_chief_complaint`,
		`medical_encounter`.`history_of_illness` AS `medical_encounter_history_of_illness`,
		`medical_encounter`.`painSelfAssesment` AS `medical_encounter_painSelfAssesment`,
		`medical_encounter`.`improvementSelfAssesment` AS `medical_encounter_improvementSelfAssesment`,
		`medical_encounter`.`assesment` AS `medical_encounter_assesment`,
		`medical_encounter`.`plan` AS `medical_encounter_plan`,
		`medical_encounter`.`progress_notes` AS `medical_encounter_progress_notes`,
		`medical_encounter`.`doctor` AS `medical_encounter_doctor`,
		`medical_encounter`.`appointment_id` AS `medical_encounter_appointment_id`,
		`medical_encounter`.`referral_number` AS `medical_encounter_referral_number`,
		`medical_encounter`.`office_id` AS `medical_encounter_office_id`,
		`medical_encounter`.`checked_in` AS `medical_encounter_checked_in`,
		`medical_encounter`.`vitals` AS `medical_encounter_vitals`,
		`medical_encounter`.`visit_status` AS `medical_encounter_visit_status`,
		`medical_encounter`.`no_show` AS `medical_encounter_no_show`,
		`workerscompinfosheet`.`auto` AS `workerscompinfosheet_auto`,
		`workerscompinfosheet`.`appointmentID` AS `workerscompinfosheet_appointmentID`,
		`workerscompinfosheet`.`workersCompFormDate` AS `workerscompinfosheet_workersCompFormDate`,
		`workerscompinfosheet`.`patientName` AS `workerscompinfosheet_patientName`,
		`workerscompinfosheet`.`patiet_phone` AS `workerscompinfosheet_patiet_phone`,
		`workerscompinfosheet`.`patientAddress` AS `workerscompinfosheet_patientAddress`,
		`workerscompinfosheet`.`patientSSN` AS `workerscompinfosheet_patientSSN`,
		`workerscompinfosheet`.`patientDOB` AS `workerscompinfosheet_patientDOB`,
		`workerscompinfosheet`.`claim_number` AS `workerscompinfosheet_claim_number`,
		`workerscompinfosheet`.`dateOfInjury` AS `workerscompinfosheet_dateOfInjury`,
		`workerscompinfosheet`.`in_network` AS `workerscompinfosheet_in_network`,
		`workerscompinfosheet`.`out_of_network` AS `workerscompinfosheet_out_of_network`,
		`workerscompinfosheet`.`employer` AS `workerscompinfosheet_employer`,
		`workerscompinfosheet`.`empolyerAddress` AS `workerscompinfosheet_empolyerAddress`,
		`workerscompinfosheet`.`employment_telephone` AS `workerscompinfosheet_employment_telephone`,
		`workerscompinfosheet`.`employment_fax` AS `workerscompinfosheet_employment_fax`,
		`workerscompinfosheet`.`insurance_Company` AS `workerscompinfosheet_insurance_Company`,
		`workerscompinfosheet`.`Insurance_billing_Address` AS `workerscompinfosheet_Insurance_billing_Address`,
		`workerscompinfosheet`.`insuranceCompanyAdjustor` AS `workerscompinfosheet_insuranceCompanyAdjustor`,
		`workerscompinfosheet`.`insurancePhoneNumber` AS `workerscompinfosheet_insurancePhoneNumber`,
		`workerscompinfosheet`.`InsuranceCompanyFaxNumber` AS `workerscompinfosheet_InsuranceCompanyFaxNumber`,
		`workerscompinfosheet`.`nurseCaseManager` AS `workerscompinfosheet_nurseCaseManager`,
		`workerscompinfosheet`.`nurseCaseManagerPhone` AS `workerscompinfosheet_nurseCaseManagerPhone`,
		`workerscompinfosheet`.`nurseCaseManagerFax` AS `workerscompinfosheet_nurseCaseManagerFax`,
		`workerscompinfosheet`.`compensableInjuries` AS `workerscompinfosheet_compensableInjuries`,
		`workerscompinfosheet`.`preauthorizationCode` AS `workerscompinfosheet_preauthorizationCode`,
		`workerscompinfosheet`.`referralDoctorSpecialty` AS `workerscompinfosheet_referralDoctorSpecialty`,
		`workerscompinfosheet`.`presuthorizationCodePhone` AS `workerscompinfosheet_presuthorizationCodePhone`,
		`workerscompinfosheet`.`presuthorizationCodeFax` AS `workerscompinfosheet_presuthorizationCodeFax`,
		`workerscompinfosheet`.`referralDoctorName` AS `workerscompinfosheet_referralDoctorName`,
		`workerscompinfosheet`.`referralDoctorAddress` AS `workerscompinfosheet_referralDoctorAddress`,
		`workerscompinfosheet`.`referralDoctorPhone` AS `workerscompinfosheet_referralDoctorPhone`,
		`workerscompinfosheet`.`referralDoctorFax` AS `workerscompinfosheet_referralDoctorFax`,
		`workerscompinfosheet`.`attorneyName` AS `workerscompinfosheet_attorneyName`,
		`workerscompinfosheet`.`legalAssistant` AS `workerscompinfosheet_legalAssistant`,
		`workerscompinfosheet`.`attorneysAddress` AS `workerscompinfosheet_attorneysAddress`,
		`workerscompinfosheet`.`attorneryPhone` AS `workerscompinfosheet_attorneryPhone`,
		`workerscompinfosheet`.`attorneryFax` AS `workerscompinfosheet_attorneryFax`,
		`workerscompinfosheet`.`compensableInjuriesVerifiedByName` AS `workerscompinfosheet_compensableInjuriesVerifiedByName`,
		`workerscompinfosheet`.`compensableInjuriesSpokenTo` AS `workerscompinfosheet_compensableInjuriesSpokenTo`
	FROM `appointment_time`
	LEFT JOIN `users` ON `appointment_time`.`patient_id` = `users`.`auto`
	INNER JOIN `doctors` ON `appointment_time`.`doctor_id` = `doctors`.`auto`
	INNER JOIN `offices` ON `doctors`.`office_id` = `offices`.`auto`
	INNER JOIN `contact_info` ON `appointment_time`.`patient_id` = `contact_info`.`id`
	INNER JOIN `insurance_info` ON `appointment_time`.`patient_id` = `insurance_info`.`id`
	INNER JOIN `medical_encounter` ON `appointment_time`.`auto` = `medical_encounter`.`appointment_id`
	LEFT JOIN `workersCompInfoSheet` ON `appointment_time`.`auto` = `workersCompInfoSheet`.`appointmentID`
	WHERE `appointment_time`.`auto` = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertAccidentReport
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO accident_report (patient_id
			, appointment_id
			, office_id
			, related_to_employment
			, related_to_auto_accident
			, place_of_auto_accident
			, related_to_other_accident
			, notes)
	VALUES (_patientId
			, _appointmentTimeId
			, _officeId
			, _employmentCondition
			, _autoAccidentCondition
			, _state
			, _otherAccientCondition
			, _notes);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertActiveRehabAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO active_rehab_by_appointment (appointmentID, ActiveRehabilitationId, Duration, Unit, `Set`, Rep, Weight, Goal)
	VALUES (_appointmentTimeId
		, _activeRehabilitationId
		, _duration
		, _unit
		, _set
		, _rep
		, _weight
		, _goal);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertActiveRehabilitation
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO activerehabilitation
		(`Name`
		, DoctorId
		, Category)
	VALUES
		(_name
		, _doctorId
		, _category);

	SELECT LAST_INSERT_ID() as Id;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertAdministrationInput
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO administrationinput
		(appointmentID
		, physicalRehabStartDate
		, physicalRehabEndDate
		, physicalRehabApprovedVisit
		, physicalRehabExtensionDate
		, insuranceIsRelatedToWork
		, insuranceIsMVA
		, insuranceFormOfPayment
		, insuranceCompany
		, insuranceCompanyAddress
		, insuranceCompanyCity
		, insuranceCompanyState
		, insuranceCompanyZip
		, insuranceCompanyAdjustor
		, insuranceCompanyPhone
		, insuranceCompanyFax
		, insuredName
		, relationshipToInsured
		, insurancePolicyNumber
		, insuranceGroupNumber
		, insuranceType
		, insuranceEffectiveDate
		, insuranceCalendarYear
		, insurancePlanYearFrom
		, insurancePlanYearTo
		, insuranceplanRequiresReferral
		, insurancePlanRequiresDeductible
		, insuranceIndividualDeductibleAmount
		, insuranceFamilyDeductibleAmount
		, insuranceDeductibleSatisfied
		, insuranceDeductibleRemainingAmount
		, insuranceCoverageAfterDeductibleAmount
		, insuranceCoverageAfterDeductiblePercent
		, insuranceMaximumAmountPerYear
		, insuranceMaximumAmountPerYearAmount
		, insuranceMaximumAmountBeenUsed
		, insuranceMaximumAmountBeenUsedCount
		, insuranceMaximumAmountPerVisit
		, insuranceMaximumAmountPerVisitCount
		, insuranceLimitVisitPerYear
		, insuranceLimitVisitPerYearCount
		, CPT99202
		, CPT99214
		, insuranceEvalManagementExamCodeSeparateCopay
		, insuranceEvalManagementExamCodeSeparateCopayAmount
		, IDC97010
		, IDC97035
		, IDC97012
		, IDC97014
		, insuranceModalitiesSeparateCopay
		, insuranceModalitiesSeparateCopayAmount
		, insuranceModalitiesMaxVisit
		, IDC97112
		, IDC97530
		, IDC97110
		, IDC97140
		, insurancePhysicalMedicineRehabSeparateCopay
		, insurancePhysicalMedicineRehabSeparateCopayAmount
		, insurancePhysicalMedicineRehabMaxPerVisit
		, IDC98940
		, IDC98941
		, insuranceChiropracticSeparateCopay
		, insuranceChiropracticSeparateCopayAmount
		, insuranceClaimAddress
		, insuranceClaimCity
		, insuranceClaimState
		, insuranceClaimZip
		, insuranceClaimNumber
		, insuranceClaimCallDate
		, insuranceClaimCallTime
		, insuranceClaimCallSpokenTo
		, insuranceClaimCallLogNumber
		, workerCompClaimNumber
		, dateOfInjury
		, isInNetwork
		, nurseCaseManager
		, nurseCaseManagerPhone
		, nurseCaseManagerFax
		, compensableInjuries
		, preauthorizationCode
		, preauthorizationCodePhone
		, preauthorizationCodeFax
		, referralDoctorName
		, referralDoctorSpecialty
		, referralDoctorAddress
		, referralDoctorCity
		, referralDoctorState
		, referralDoctorZip
		, referralDoctorPhone
		, referralDoctorFax
		, attorneyName
		, attorneyLegalAssistant
		, attorneyAddress
		, attorneyCity
		, attorneyState
		, attorneyZip
		, attorneyPhone
		, attorneyFax
		, compensableInjuriesVerifiedByName
		, compensableInjuriesSpokenTo)
	VALUES
		(_appointmentTimeId
		, _physicalRehabStartDate
		, _physicalRehabEndDate
		, _physicalRehabApprovedVisit
		, _physicalRehabExtensionDate
		, _insuranceIsRelatedToWork
		, _insuranceIsMVA
		, _insuranceFormOfPayment
		, _insuranceCompany
		, _insuranceCompanyAddress
		, _insuranceCompanyCity
		, _insuranceCompanyState
		, _insuranceCompanyZip
		, _insuranceCompanyAdjustor
		, _insuranceCompanyPhone
		, _insuranceCompanyFax
		, _insuredName
		, _relationshipToInsured
		, _insurancePolicyNumber
		, _insuranceGroupNumber
		, _insuranceType
		, _insuranceEffectiveDate
		, _insuranceCalendarYear
		, _insurancePlanYearFrom
		, _insurancePlanYearTo
		, _insuranceplanRequiresReferral
		, _insurancePlanRequiresDeductible
		, _insuranceIndividualDeductibleAmount
		, _insuranceFamilyDeductibleAmount
		, _insuranceDeductibleSatisfied
		, _insuranceDeductibleRemainingAmount
		, _insuranceCoverageAfterDeductibleAmount
		, _insuranceCoverageAfterDeductiblePercent
		, _insuranceMaximumAmountPerYear
		, _insuranceMaximumAmountPerYearAmount
		, _insuranceMaximumAmountBeenUsed
		, _insuranceMaximumAmountBeenUsedCount
		, _insuranceMaximumAmountPerVisit
		, _insuranceMaximumAmountPerVisitCount
		, _insuranceLimitVisitPerYear
		, _insuranceLimitVisitPerYearCount
		, _CPT99202
		, _CPT99214
		, _insuranceEvalManagementExamCodeSeparateCopay
		, _insuranceEvalManagementExamCodeSeparateCopayAmount
		, _IDC97010
		, _IDC97035
		, _IDC97012
		, _IDC97014
		, _insuranceModalitiesSeparateCopay
		, _insuranceModalitiesSeparateCopayAmount
		, _insuranceModalitiesMaxVisit
		, _IDC97112
		, _IDC97530
		, _IDC97110
		, _IDC97140
		, _insurancePhysicalMedicineRehabSeparateCopay
		, _insurancePhysicalMedicineRehabSeparateCopayAmount
		, _insurancePhysicalMedicineRehabMaxPerVisit
		, _IDC98940
		, _IDC98941
		, _insuranceChiropracticSeparateCopay
		, _insuranceChiropracticSeparateCopayAmount
		, _insuranceClaimAddress
		, _insuranceClaimCity
		, _insuranceClaimState
		, _insuranceClaimZip
		, _insuranceClaimNumber
		, _insuranceClaimCallDate
		, _insuranceClaimCallTime
		, _insuranceClaimCallSpokenTo
		, _insuranceClaimCallLogNumber
		, _workerCompClaimNumber
		, _dateOfInjury
		, _isInNetwork
		, _nurseCaseManager
		, _nurseCaseManagerPhone
		, _nurseCaseManagerFax
		, _compensableInjuries
		, _preauthorizationCode
		, _preauthorizationCodePhone
		, _preauthorizationCodeFax
		, _referralDoctorName
		, _referralDoctorSpecialty
		, _referralDoctorAddress
		, _referralDoctorCity
		, _referralDoctorState
		, _referralDoctorZip
		, _referralDoctorPhone
		, _referralDoctorFax
		, _attorneyName
		, _attorneyLegalAssistant
		, _attorneyAddress
		, _attorneyCity
		, _attorneyState
		, _attorneyZip
		, _attorneyPhone
		, _attorneyFax
		, _compensableInjuriesVerifiedByName
		, _compensableInjuriesSpokenTo);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertAllergy
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO allergies (id, allergy, reaction)
	VALUES (_patientId
			, _name
			, _reaction);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertAuthorizedVisits
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO authorizedVisits (`patient_id`
						, `office_id`
						, `date`
						, `visits_approved`
						, `visits_used`)
	VALUES (_patient_id
		, _office_id
		, _date
		, _visits_approved
		, _visits_used);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertBalanceCharge
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO balance (office_id
		, id
		, `date`
		, CPT_code
		, CPT_description
		, medical_encounter
		, transaction_type
		, transaction_amount
		, method_of_payment
		, `status`)
	VALUES(_officeId
		, _patientId
		, _date
		, _cptCode
		, _description
		, _appointmentTimeId
		, _transactionType
		, _amount
		, _methodOfPayment
		, ''charged'');
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertBalancePayment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO balance (office_id
		, id
		, `date`
		, medical_encounter
		, transaction_type
		, transaction_adjustment
		, method_of_payment
		, `status`)
	VALUES(_officeId
		, _patientId
		, _date
		, _appointmentTimeId
		, _transactionType
		, _amount
		, _methodOfPayment
		, ''Posted'');
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertCondition
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO conditions (id, `condition`, date)
	VALUES (_patientId
			, _name
			, _date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertContactInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO contact_info (id, street_address, city, state, zip, home_phone, work_phone, email)
	VALUES (_patientId
			, _contactAddress
			, _contactCity
			, _contactState
			, _contactZip
			, _contactPhone
			, _workPhone
			, _contactEmail);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertCPTAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO cpt_by_aapointment (appointmentID, dateOfService, `code`, rationale, area_treated, `time`, unit)
	VALUES (_appointmentTimeId, _dateOfService, _cptCode, _rationale, _areaTreated, _time, _unit);
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDermatome
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO dermatome_diagram (appointmentID, dermatome, `condition`, intensity)
	VALUES(_appointmentTimeId
	, _zoneName
	, _currentCondition
	, _currentIntensity);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDermatomeAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO dermatome_by_appointment (appointmentID
		, `key`
		, pain_level
		, sensitivity_level)
	VALUES (_appointmentTimeId
		, _key
		, _painLevel
		, _sensitivityLevel);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDiagnosisCode
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO diagnosis_codes (patient_id
		, appointment_id
		, office_id
		, idc9_code
		, description)
	VALUES(_patientId
		, _appointmentTimeId
		, _officeId
		, _codeNumber
		, _codeDescription);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDisplaySetting
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO income_report_display_setting(doctor_id
		, office_id
		, reportId
		, name
		, date
		, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9
		, cell10, cell11, cell12, cell13, cell14, cell15, cell16, cell17, cell18, cell19
		, cell20, cell21, cell22, cell23, cell24, cell25, cell26, cell27)
	VALUES(_doctorId
		, _officeId
		, _reportId
		, _settingName
		, _date
		, _cell1, _cell2, _cell3, _cell4
		, _cell5, _cell6, _cell7, _cell8
		, _cell9, _cell10, _cell11, _cell12
		, _cell13, _cell14, _cell15, _cell16
		, _cell17, _cell18, _cell19, _cell20
		, _cell21, _cell22, _cell23, _cell24
		, _cell25, _cell26, _cell27);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDoctorMembershipForgetPassword
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# lock account
	CALL UpdateDoctorMembership(_doctorId, null, null, 1, now(), 1);

	# delete previous request
	DELETE FROM doctors_membership_forget_password
	WHERE doctor_id = _doctorId;

	# insert new request
	INSERT INTO doctors_membership_forget_password (doctor_id
		, unique_identifier)
	VALUES (_doctorId
		,_uniqueIdentifier);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertDrinkingHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO drinking_history (id, beer, beer_amount, beer_how_often, wine, wine_amount, wine_how_often, liquor, liquor_amount, loquor_how_often)
	VALUES (_patientId
			, ''1''
			, _socialBeerQuantity
			, _socialBeerFreq
			, ''1''
			, _socialWineQuantity
			, _socialWineFreq
			, ''1''
			, _socialLiquorQuantity
			, _socialLiquorFreq);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertEmergencyContact
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	IF (_tableNumber = 1) THEN
		INSERT INTO emergency_contact (userID, first_name, middlename, last_name, relationship, street_address, city, state, zip, home_number, work_number)
		VALUES (_patientId
		, _emergencyContactFirstName
		, _emergencyContactMiddleName
		, _emergencyContactLastName
		, _emergencyContactRelationship
		, _emergencyContactAddress
		, _emergencyContactCity
		, _emergencyContactState
		, _emergencyContactZip
		, _emergencyContactPhone
		, _emergencyContactWorkPhone);
	ELSEIF (_tableNumber = 2) THEN
		INSERT INTO emergency_contact2 (userID, first_name, middlename, last_name, relationship, street_address, city, state, zip, home_number, work_number)
		VALUES (_patientId
		, _emergencyContactFirstName
		, _emergencyContactMiddleName
		, _emergencyContactLastName
		, _emergencyContactRelationship
		, _emergencyContactAddress
		, _emergencyContactCity
		, _emergencyContactState
		, _emergencyContactZip
		, _emergencyContactPhone
		, _emergencyContactWorkPhone);
	ELSEIF (_tableNumber = 3) THEN
		INSERT INTO emergency_contact3 (userID, first_name, middlename, last_name, relationship, street_address, city, state, zip, home_number, work_number)
		VALUES (_patientId
		, _emergencyContactFirstName
		, _emergencyContactMiddleName
		, _emergencyContactLastName
		, _emergencyContactRelationship
		, _emergencyContactAddress
		, _emergencyContactCity
		, _emergencyContactState
		, _emergencyContactZip
		, _emergencyContactPhone
		, _emergencyContactWorkPhone);
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertEmployment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO employment (userID, student_fulltime, ocupation, employer, street_address, city, state, zip, telephone)
	VALUES (_patientId
		, _isStudent
		, _employmentOccupation
		, _employmentName
		, _employmentAddress
		, _employmentCity
		, _employmentState
		, _employmentZip
		, _telephone);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertExaminationInput
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO examinationinput (appointmentID
		, ChiefComplaint
		, Date
		, HistoryOfPresentInjury
		, Chiro
		, Injection
		, PainProgram
		, Diagnostic
		, PainFreq
		, PainLocation
		, PainRadiation
		, PainRadiationDuration
		, PainVAS
		, CurrentMedication
		, PastMedication
		, Allergy
		, PertinentMedicalHistory
		, SubstanceAbuse
		, Neuropsychological
		, MentalDisorder
		, LMP
		, SocialHistory
		, Tobacco
		, EtOH
		, IVDrug
		, WorkStatus
		, Ambulation
		, HomeManagement
		, Recreation
		, GeneralAppearance
		, HEENT
		, Cardiovascular
		, NECT
		, Pulse
		, CV
		, ABD
		, NeurologicalCranialNerve
		, SensoryUpperExtremities
		, SensoryLowerExtremities
		, MotorUpperExtremities
		, MotorLowerExtremities
		, HeelWalk
		, ToeWalk
		, ReflexBicepLeft
		, ReflexBrachioradialisLeft
		, ReflexTricepLeft
		, ReflexPatellarLeft
		, ReflexAchillesLeft
		, ReflexBicepLeftLevel
		, ReflexBrachioradialisLeftLevel
		, ReflexTricepLeftLevel
		, ReflexPatellarLeftLevel
		, ReflexAchillesLeftLevel
		, ReflexBicepRight
		, ReflexBrachioradialisRight
		, ReflexTricepRight
		, ReflexPatellarRight
		, ReflexAchillesRight
		, ReflexBicepRightLevel
		, ReflexBrachioradialisRightLevel
		, ReflexTricepRightLevel
		, ReflexPatellarRightLevel
		, ReflexAchillesRightLevel
		, SpecialBabinski
		, SpecialClonus
		, SpecialRhomberg
		, SpecialHeel
		, SpecialShin
		, SpecialFinger
		, SpecialNose
		, NerveTensionSLRSupine
		, NerveTensionSLRSitting
		, AutonomicTemperature
		, AutonomicHair
		, AutonomicNail
		, AutonomicMottling
		, MusculoskeletalCervical
		, MusculoskeletalThoracic
		, MusculoskeletalLumbar
		, MusculoskeletalExtremities
		, MusculoskeletalSacroiliac
		, OrthopedicCervical
		, OrthopedicThoracis
		, OrthopedicLumbar
		, OrthopedicUpperExtremities
		, OrthopedicLowerExtremities
		, Recommendation
		, ProgressVAS
		, ProgressRadiation
		, ProgressPainFreq
		, ProgressROM
		, ProgressTreatment
		, painAssesmentText
		, effectsOfInjuryOnLifestyle
		, DermatomeText
		, MusculoskeletalText)
	VALUE (_appointmentTimeId
		, _chiefComplaint
		, _date
		, _historyOfPresentInjury
		, _chiro
		, _injection
		, _painProgram
		, _diagnostic
		, _painFreq
		, _painLocation
		, _painRadiation
		, _painRadiationDuration
		, _painVAS
		, _currentMedication
		, _pastMedication
		, _allergy
		, _pertinentMedicalHistory
		, _substanceAbuse
		, _neuropsychological
		, _mentalDisorder
		, _LMP
		, _socialHistory
		, _tobacco
		, _EtOH
		, _IVDrug
		, _workStatus
		, _ambulation
		, _homeManagement
		, _recreation
		, _generalAppearance
		, _HEENT
		, _cardiovascular
		, _NECT
		, _pulse
		, _CV
		, _ABD
		, _neurologicalCranialNerve
		, _sensoryUpperExtremities
		, _sensoryLowerExtremities
		, _motorUpperExtremities
		, _motorLowerExtremities
		, _heelWalk
		, _toeWalk
		, _reflexBicepLeft
		, _reflexBrachioradialisLeft
		, _reflexTricepLeft
		, _reflexPatellarLeft
		, _reflexAchillesLeft
		, _reflexBicepLeftLevel
		, _reflexBrachioradialisLeftLevel
		, _reflexTricepLeftLevel
		, _reflexPatellarLeftLevel
		, _reflexAchillesLeftLevel
		, _reflexBicepRight
		, _reflexBrachioradialisRight
		, _reflexTricepRight
		, _reflexPatellarRight
		, _reflexAchillesRight
		, _reflexBicepRightLevel
		, _reflexBrachioradialisRightLevel
		, _reflexTricepRightLevel
		, _reflexPatellarRightLevel
		, _reflexAchillesRightLevel
		, _specialBabinski
		, _specialClonus
		, _specialRhomberg
		, _specialHeel
		, _specialShin
		, _specialFinger
		, _specialNose
		, _nerveTensionSLRSupine
		, _nerveTensionSLRSitting
		, _autonomicTemperature
		, _autonomicHair
		, _autonomicNail
		, _autonomicMottling
		, _musculoskeletalCervical
		, _musculoskeletalThoracic
		, _musculoskeletalLumbar
		, _musculoskeletalExtremities
		, _musculoskeletalSacroiliac
		, _orthopedicCervical
		, _orthopedicThoracis
		, _orthopedicLumbar
		, _orthopedicUpperExtremities
		, _orthopedicLowerExtremities
		, _recommendation
		, _progressVAS
		, _progressRadiation
		, _progressPainFreq
		, _progressROM
		, _progressTreatment
		, _painAssesmentText
		, _effectsOfInjuryOnLifestyle
		, _dermatomeText
		, _musculoskeletalText);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertFamilyHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO family_history (id, family_condition, extra)
	VALUES (_patientId
			, _condition
			,''0'');
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertFavCPT
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO favouritecptcodes
		(doctor_id
		, `code`
		, description
		, grouping)
	VALUES
		(_doctor_id
		, _cpt
		, _description
		, _grouping);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertFavIDC
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO favouriteIDCtcodes (doctor_id, idc, description)
	VALUES (_doctor_id
			, _idc
			, _description);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertFinancialResponsibility
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
INSERT INTO financial_responsability (userID, first_name, middlename, last_name, sex, relationship, street_address, city, state, zip, home_phone, ss_number, driver_lisence, birth_date, employer, employer_address, employer_city, employer_state, employer_zip, employer_phone)
VALUES (_patientId
		, _firstName
		, _middleName
		, _lastName
		, _gender
		, _relationship
		, _address
		, _city
		, _state
		, _zip
		, _phone
		, _SSN
		, _driverLicense
		, _DOB
		, _employer
		, _employerAddress
		, _employerCity
		, _employerState
		, _employerZip
		, _employerPhone);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertFormSignature
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO form_signature (formName, appointmentId, whoseSignature, whoseSignatureId, signature, `date`)
	VALUES (_formName
			, _appointmentId
			, _whoseSignature
			, _whoseSignatureId
			, _signature
			, _date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertIDCAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO idc_by_aapointment (appointment_id, idc_code)
	VALUES (_appointmentTimeId, _idcCode);
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertImmunization
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO immunization (id, immunization, date)
	VALUES(_patientId
			, _name
			, _date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertInsuranceClaim
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO insurance_claim (meicare_number
		, medicaid_number
		, tricare_SSN
		, champva_id
		, group_health_plan_id
		, feca_ssn
		, other_insurance_id
		, insureds_id_number
		, member_id
		, appointment_id
		, claim_number
		, date_of_current_insident
		, office_id
		, patient_name
		, patient_birthday
		, sex
		, insureds_name
		, patient_address
		, patient_city
		, patient_state
		, patient_zip
		, patient_telephone
		, patient_relationship
		, insureds_address
		, insureds_city
		, insureds_state
		, insureds_zip
		, insureds_telephone
		, patient_status
		, patient_employment
		, other_insureds_name
		, other_insurance_policy_no
		, other_insureds_DOB
		, other_insureds_sex
		, employer_or_school_name
		, insurance_plan_name
		, insureds_policy_group
		, insureds_DOB
		, insureds_sex
		, insureds_employer_or_school_name
		, insureds_insurance_plan_name
		, in_there_another_health_benefit
		, federal_tax_id_SSN
		, federal_tax_id_EIN
		, patient_account_number
		, service_facility_info
		, service_facility_info_a
		, service_facility_info_b
		, billing_provider_phone
		, billing_provider_info
		, billing_provider_a_npi_num
		, billing_provider_b_medicaid_id)
	VALUES (_medicareNumber
		, _medicaidNumber
		, _tricareSSN
		, _champvaId
		, _groupHealthPlanId
		, _fecaSSN
		, _otherInsuranceId
		, _insuredIdNumber
		, _patientId
		, _appointmentTimeId
		, _claimNumber
		, _date
		, _officeId
		, _patientName
		, _patientDOB
		, _gender
		, _insuredName
		, _patientAddress
		, _patientCity
		, _patientState
		, _patientZip
		, _patientTelephone
		, _patientRelationship
		, _insuredAddress
		, _insuredCity
		, _insuredState
		, _insuredZip
		, _insuredTelephone
		, _patientStatus
		, _patientEmployment
		, _otherInsuredName
		, _otherInsurancePolicyNo
		, _otherInsuredDOB
		, _otherInsuredGender
		, _employerSchoolName
		, _insurancePlanName
		, _insuredPolicyGroup
		, _insuredDOB
		, _insuredGender
		, _insuredEmployerSchoolName
		, _insuredInsurancePlanName
		, _isThereAnotherHealthBenefit
		, _federalTaxIdSSN
		, _federalTaxIdEIN
		, _patientAccountNumber
		, _serviceFacilityInfo
		, _serviceFacilityInfoA
		, _serviceFacilityInfoB
		, _billingProviderPhone
		, _billingProviderInfo
		, _billingProviderNPI
		, _billingProviderMedicaidId);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertInsuranceInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO insurance_info (id
		, insurance_Company
		, member_id
		, policy_group
		, primary_beneficiary_first_name
		, primary_beneficiary_middle_name
		, primary_beneficiary_last_name
		, beneficiary_sex
		, relationship
		, beneficiary_address
		, beneficiary_city
		, beneficiary_state
		, beneficiary_zip
		, beneficiary_phone
		, beneficiary_id
		, beneficiary_ssn
		, beneficiary_DOB)
	VALUES (_patientId
		, _insuranceCompany
		, _policyNumber
		, _policyGroup
		, _beneficiaryFirstName
		, _beneficiaryMiddleName
		, _beneficiaryLastName
		, _beneficiaryGender
		, _beneficiaryRelationship
		, _beneficiaryAddress
		, _beneficiaryCity
		, _beneficiaryState
		, _beneficiaryZip
		, _beneficiaryPhone
		, _beneficiaryPolicyNumber
		, _beneficiarySSN
		, _beneficiaryDOB);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertKioskInsuranceInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO insurance_info (id
							,beneficiary_id
							,no_insurance
							,insurance_Company
							,policy_group
							,beneficiary_ssn
							,beneficiary_DOB
							,primary_beneficiary_first_name
							,primary_beneficiary_middle_name
							,primary_beneficiary_last_name
							,beneficiary_sex
							,relationship
							,beneficiary_address
							,beneficiary_city
							,beneficiary_state
							,beneficiary_zip
							,insurance_efective_date
							,beneficiary_plan_name
							,preauthorization_number
							,insurance_company_phone_number)
	VALUES (_patientId
			, _memberId
			, _noInsurance
			, _insuranceCompany
			, _policyGroup
			, _beneficiarySSN
			, _beneficiaryDOB
			, _beneficiaryFirstName
			, _beneficiaryMiddleName
			, _beneficiaryLastName
			, _beneficiaryGender
			, _beneficiaryRelationship
			, _beneficiaryAddress
			, _beneficiaryCity
			, _beneficiaryState
			, _beneficiaryZip
			, _insurance_efective_date
			, _insurance_plan_name
			, _insurance_preauthorization_number
			, _insurance_company_phone_number);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertLabOrder
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO lab_orders (patient_id, appointment_id, test_name, date_ordered, comments, labName)
	VALUES (_patientId
			, _appointmentTimeId
			, _testName
			, _testDate
			, _testNote
			, _labName);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMedicalEncounter
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO medical_encounter (id
				, `date`
				, chief_complaint
				, doctor
				, appointment_id
				, office_id)
	VALUES (_patientId
			, _date
			, _chiefComplaint
			, _doctorId
			, _appointmentTimeId
			, _officeId);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMedicalEncounterHandwrite
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO medical_encounter_handwrites (patient_id
		, appointment_id
		, office_id
		, note_handwritten)
	VALUES(_patientId
		, _appointmentTimeId
		, _officeId
		, _handwrite);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMedicalEncounterNote
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO medical_encounter_notes (patient_id
		, appointment_id
		, office_id
		, note_text)
	VALUES (_patientId
		, _appointmentTimeId
		, _officeId
		, _note);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMedication
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO medications (id
		, appointment_id
		, office_id
		, prescription
		, start_date
		, end_date
		, dosage
		, refill
		, sig
		, notes
		, instructions)
	VALUES (_patientId
		, _appointmentTimeId
		, _officeId
		, _prescription
		, _startDate
		, _endDate
		, _dosage
		, _refill
		, _sig
		, _note
		, _quantity);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMessage
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO messages (`to`, `from`, `subject`, message, old_message, `date`)
	VALUES(_to
			, _from
			, _subject
			, _message
			, _originalMessage
			, _date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertMuscularSystemAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO muscular_system_by_appointment (appointmentID
		, `key`
		, pain_level)
	VALUES (_appointmentTimeId
		, _key
		, _painLevel);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPainAggravatingFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO pain_aggravating_factor_by_appointment (appointmentID
		, PainAggravatingFactorId)
	VALUES (_appointmentTimeId
		, _painAggravatingFactorId);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPainAlleviatingFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO pain_alleviating_factor_by_appointment (appointmentID
		, PainAlleviatingFactorId)
	VALUES (_appointmentTimeId
		, _painAlleviatingFactorId);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPainFactorAppointment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO pain_factor_by_appointment
		(appointmentID
		, PainFactorId)
	VALUES
		(_appointmentTimeId
		, _painFactorId);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPatient
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO users(account, first_name, middle_name, Last_name, marital_status, date_of_birth, gender, ss_number, driver_license, dl_state)
	VALUES (_account
		, _firstName
		, _middleName
		, _lastName
		, _patientMarital
		, _patientDOB
		, _patientGender
		, _patientSSN
		, _patientDL
		, _patientDLState);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPatientEmploymentInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO employment (patientId, isStudent, employmentOccupation, employmentName, employmentAddress, employmentCity, employmentState, employmentZip, date, telephone, fax)
	VALUES (_isStudent
		, _employmentOccupation
		, _employmentName
		, _employmentAddress
		, _employmentCity
		, _employmentState
		, _employmentZip
		, _date
		, _telephone
		, _fax);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPatientFile
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO patient_files (patient_id
		, appointment_id
		, office_id
		, path
		, file_name
		, notes)
	VALUES(_patientId
		, _appointmentTimeId
		, _officeId
		, _path
		, _fileNames
		, _note);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPatientGallery
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO patient_gallery (patient_id
		, appointment_in
		, office_id
		, `date`
		, path
		, file_name
		, notes
		, `profile`)
	VALUES (_patientId
		, _appointmentTimeId
		, _officeId
		, _date
		, _path
		, _fileNames
		, _note
		, 0);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPhysicalRehabCount
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO physicalrehabcount (administrationInputId, visitDate)
	VALUE (_administrationInputId
		, _visitDate);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPhysicalRehabUtilization
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO physicalrehabutilization (`AppointmentId`, `StartDate`, `EndDate`, `ApprovedVisitCount`)
	VALUES (_appointmentTimeId
		, _startDate
		, _endDate
		, _approvedVisitCount);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPhysicalRehabUtilizationCount
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO physicalrehabutilizationcount (PhysicalRehabUtilizationId, VisitDate)
	VALUE (_physicalRehabUtilizationId
		, _visitDate);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertPositionSetting
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO income_report_position_setting (office_id, doctor_id, reportId, cell1, cell2, cell3, cell4, cell5, cell6)
	VALUES (_officeId
			, _doctorId
			, _reportId
			, _cell1
			, _cell2
			, _cell3
			, _cell4
			, _cell5
			, _cell6);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertProcedure
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO procedures (id, `procedure`, `date`)
	VALUES (_patientId
		, _name
		, _date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertRadiology
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO radiologyorder (AppointmentId
							,RadiologyId
							,FacilityId
							,Part
							,CPTCodeId
							,OrderStatusId
							,OrderDateTime)
	VALUES (_AppointmentId
			,_RadiologyId
			,_FacilityId
			,_Part
			,_CPTCodeId
			,_OrderStatusId
			,_OrderDateTime);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertReferral
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO referals (userID, appointment_id, office_id, referral_reason, physitian, phone, streetAddress, city, state, zip, notes)
	VALUES (_patientId
			, _appointmentTimeId
			, _officeId
			, _reason
			, _toName
			, _toPhone
			, _toAddress
			, _toCity
			, _toState
			, _toZip
			, _toNote);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertSchoolInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO employment (`userID`, `student_fulltime`, `student_part_time`, `school_name`, `school_address`, `school_city`, `school_state`, `school_zip`, `school_telephone`, `date`)
	VALUES (_patientId,
			_student_fulltime,
			_student_part_time,
			_school_name,
			_school_address,
			_school_city,
			_school_state,
			_school_zip,
			_school_telephone,
			_date);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertSelfAssesment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO selfassesment (causeOfProblem
							, appointmentID
							, chiefComplaint
							, frequencyOfsymptoms
							, descriptionOfPain
							, workInterferance
							, socianInterferance
							, timeOfProblem
							, begginingOfProblem
							, isProblemSevere
							, whatAgravatesProblem
							, concernsAboutProblem
							, moreInformation
							, neckPain_leftshoulder
							, neckPain_rightshoulder
							, neckPain_leftarm
							, neckPain_rightarm
							, neckPain_leftforearm
							, neckPain_rightforearm
							, neckPain_lefthand
							, neckPain_righthand
							, Headache
							, Migraine_Headache
							, Upper_back_pain
							, radiation_Buttocks
							, radiation_Left_buttock
							, radiation_Right_buttock
							, radiation_Left_thight
							, radiation_Right_thight
							, radiation_Left_knee
							, radiation_Right_knee
							, radiation_Left_foot
							, radiation_Right_foot
							, numbnes_Left_Hand
							, numbnes_Right_Hand
							, numbnes_Left_Foot
							, numbnes_Right_Foot
							, numbnes_Left_Upper_Arm
							, numbnes_Right_Upper_Ann
							, numbnes_Left_Leg
							, numbnes_Right_Leg
							, RingingInEars_Yes
							, RingingInEars_No
							, RingingInEars_Left
							, RingingInEars_Right
							, RingingInEars_Both
							, BlurryVision_Left
							, BlurryVision_Right
							, BlurryVision_Both
							, WristPain_Left
							, WristPain_Right
							, WristPain_Both
							, JawPain_Left
							, JawPain_Right
							, JawPain_Both
							, Dizziness
							, Nervousness
							, Fatigue
							, Anxiety
							, Depression
							, Excessive_irritability
							, Fear_of_driving_in_a_car
							, Loss_of_concentration
							, Jaw_clenching
							, Grinding_of_teeth_at_night
							, Nightmares
							, Difficulty_with_sleeping_at_night
							, HipPain_left
							, HipPain_right
							, HipPain_both
							, KneePain_left
							, KneePain_right
							, KneePain_both
							, FootPain_left
							, FootPain_right
							, FootPain_both
							, timeLostDueToInjuries_yes
							, timeLostDueToInjuries_no
							, timeLostDueToInjuries_date
							, typeOfEmployment
							, descriptionOfPreviousAccident
							, descriptionOfPreviousInjuries
							, howMuchBetterPriorToCurrentCondition)
	VALUES(_causeOfProblem
		, _appointmentID
		, _chiefComplaint
		, _frequencyOfsymptoms
		, _descriptionOfPain
		, _workInterferance
		, _socianInterferance
		, _timeOfProblem
		, _begginingOfProblem
		, _isProblemSevere
		, _whatAgravatesProblem
		, _concernsAboutProblem
		, _moreInformation
		, _neckPain_leftshoulder
		, _neckPain_rightshoulder
		, _neckPain_leftarm
		, _neckPain_rightarm
		, _neckPain_leftforearm
		, _neckPain_rightforearm
		, _neckPain_lefthand
		, _neckPain_righthand
		, _Headache
		, _Migraine_Headache
		, _Upper_back_pain
		, _radiation_Buttocks
		, _radiation_Left_buttock
		, _radiation_Right_buttock
		, _radiation_Left_thight
		, _radiation_Right_thight
		, _radiation_Left_knee
		, _radiation_Right_knee
		, _radiation_Left_foot
		, _radiation_Right_foot
		, _numbnes_Left_Hand
		, _numbnes_Right_Hand
		, _numbnes_Left_Foot
		, _numbnes_Right_Foot
		, _numbnes_Left_Upper_Arm
		, _numbnes_Right_Upper_Ann
		, _numbnes_Left_Leg
		, _numbnes_Right_Leg
		, _RingingInEars_Yes
		, _RingingInEars_No
		, _RingingInEars_Left
		, _RingingInEars_Right
		, _RingingInEars_Both
		, _BlurryVision_Left
		, _BlurryVision_Right
		, _BlurryVision_Both
		, _WristPain_Left
		, _WristPain_Right
		, _WristPain_Both
		, _JawPain_Left
		, _JawPain_Right
		, _JawPain_Both
		, _Dizziness
		, _Nervousness
		, _Fatigue
		, _Anxiety
		, _Depression
		, _Excessive_irritability
		, _Fear_of_driving_in_a_car
		, _Loss_of_concentration
		, _Jaw_clenching
		, _Grinding_of_teeth_at_night
		, _Nightmares
		, _Difficulty_with_sleeping_at_night
		, _HipPain_left
		, _HipPain_right
		, _HipPain_both
		, _KneePain_left
		, _KneePain_right
		, _KneePain_both
		, _FootPain_left
		, _FootPain_right
		, _FootPain_both
		, _timeLostDueToInjuries_yes
		, _timeLostDueToInjuries_no
		, _timeLostDueToInjuries_date
		, _typeOfEmployment
		, _descriptionOfPreviousAccident
		, _descriptionOfPreviousInjuries
		, _howMuchBetterPriorToCurrentCondition);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertSignatureOnFile
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	-- set all other signature in active
	UPDATE signature_on_file
	SET is_active = 0
	WHERE signee_id = _signeeId;

	-- insert new active signature
	INSERT INTO signature_on_file (`signee_id`
		, `signature`
		, `date`
		, `is_active`
		, `whose_signature`)
	VALUES (_signeeId
		, _signature
		, _date
		, _isActive
		, _whoseSignature);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertSmokingHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO smoking_history (id
								, smoker
								, packs_a_day
								, how_often_do_you_smoke
								, time_smoking
								, quit_smoking
								, smokeless_tobacco)
	VALUES (_patientId
			, _smoker
			, _packs_a_day
			, _how_often_do_you_smoke
			, _time_smoking
			, _quit_smoking
			, _smokeless_tobacco);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertSoapForm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO `soapform` (`appointmentID`
		, `patientName`
		, `chiefComplaint`
		, `formDate`
		, `vas_persent`
		, `radiationTo`
		, `constant`
		, `intermittent`
		, `aching`
		, `burning`
		, `cramping`
		, `deep`
		, `dull`
		, `electricType`
		, `numbness`
		, `pulling`
		, `sharp`
		, `shooting`
		, `stabbing`
		, `throbbing`
		, `tingling`
		, `MusculoskeletalExam`
		, `ROM`
		, `Reflexes`
		, `LowerExtLeft`
		, `LowerExtRight`
		, `UpperExtLeft`
		, `UpperExtRight`
		, `Sensory`
		, `OrthopedicTest_SLR_rihgt`
		, `OrthopedicTest_SLR_left`
		, `Other`
		, `idc9-724-5`
		, `idc9-728-85`
		, `idc9-723-4`
		, `idc9-723-1`
		, `idc9-739-1`
		, `idc9-724-4`
		, `idc9-724-1`
		, `idc9-739-2`
		, `idc9-847-0`
		, `idc9-719-46`
		, `idc9-739-3`
		, `idc9-847-1`
		, `idc9-713-41`
		, `idc9-847-2`
		, `idc9-722-81`
		, `idc9-722-83`
		, `otherIDC9`
		, `TherapeuticExercises_areaTreated`
		, `TherapeuticExercises_time`
		, `TherapeuticExercisesRationale`
		, `NeuromuscularReEducation_areaTreated`
		, `NeuromuscularReEducation_time`
		, `NeuromuscularReEducationRationale`
		, `Massage_areaTreated`
		, `Massage_time`
		, `MassageRationale`
		, `EMS_areaTreated`
		, `EMS_time`
		, `EMSRationale`
		, `Ultrasound_areaTreated`
		, `Ultrasound_time`
		, `UltrasoundRationale`
		, `TriggerPointMyofascialRelease_areaTreated`
		, `TriggerPointMyofascialRelease_time`
		, `TriggerPointMyofascialReleaseRationale`
		, `Traction_areaTreated`
		, `Traction_time`
		, `TractionRationale`
		, `Manipulation`
		, `otherProcedures`
		, `ProgressAfterTXVAS`
		, `AfterRadiationTo`
		, `AfterRadConstant`
		, `AfterRadIntermittent`
		, `AfterROMMuscleTone`
		, `TreatmentToleranceCompliance_well`
		, `TreatmentToleranceCompliance_fair`
		, `TreatmentToleranceCompliance_poor`
		, `Recommendations`
		, `Referrals`
		, `Provider`)
	VALUES (_appointmentTimeId
		, _patientName
		, _chiefComplaint
		, _formDate
		, _vas_persent
		, _radiationTo
		, _constant
		, _intermittent
		, _aching
		, _burning
		, _cramping
		, _deep
		, _dull
		, _electricType
		, _numbness
		, _pulling
		, _sharp
		, _shooting
		, _stabbing
		, _throbbing
		, _tingling
		, _MusculoskeletalExam
		, _ROM
		, _Reflexes
		, _LowerExtLeft
		, _LowerExtRight
		, _UpperExtLeft
		, _UpperExtRight
		, _Sensory
		, _OrthopedicTest_SLR_rihgt
		, _OrthopedicTest_SLR_left
		, _Other
		, _idc9_724_5
		, _idc9_728_85
		, _idc9_723_4
		, _idc9_723_1
		, _idc9_739_1
		, _idc9_724_4
		, _idc9_724_1
		, _idc9_739_2
		, _idc9_847_0
		, _idc9_719_46
		, _idc9_739_3
		, _idc9_847_1
		, _idc9_713_41
		, _idc9_847_2
		, _idc9_722_81
		, _idc9_722_83
		, _otherIDC9
		, _TherapeuticExercises_areaTreated
		, _TherapeuticExercises_time
		, _TherapeuticExercisesRationale
		, _NeuromuscularReEducation_areaTreated
		, _NeuromuscularReEducation_time
		, _NeuromuscularReEducationRationale
		, _Massage_areaTreated
		, _Massage_time
		, _MassageRationale
		, _EMS_areaTreated
		, _EMS_time
		, _EMSRationale
		, _Ultrasound_areaTreated
		, _Ultrasound_time
		, _UltrasoundRationale
		, _TriggerPointMyofascialRelease_areaTreated
		, _TriggerPointMyofascialRelease_time
		, _TriggerPointMyofascialReleaseRationale
		, _Traction_areaTreated
		, _Traction_time
		, _TractionRationale
		, _Manipulation
		, _otherProcedures
		, _ProgressAfterTXVAS
		, _AfterRadiationTo
		, _AfterRadConstant
		, _AfterRadIntermittent
		, _AfterROMMuscleTone
		, _TreatmentToleranceCompliance_well
		, _TreatmentToleranceCompliance_fair
		, _TreatmentToleranceCompliance_poor
		, _Recommendations
		, _Referrals
		, _Provider);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertTestResult
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO test_results (id
				, `date`
				, test_name
				, upper_range
				, lower_range
				, reading
				, comments
				, IsFile)
	VALUES(_patientId
				, _date
				, _testName
				, _upperRange
				, _lowerRange
				, _reading
				, _comment
				, _isFile);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertTestResultsFile
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO test_results_file (test_results_id
		, `date`
		, path
		, file_name
		, notes)
	VALUES (_testResultId
		, _date
		, _path
		, _fileNames
		, _note);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertTransaction
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO `transaction` (PatientId, ProviderId, OfficeId, ChargeId, `Date`, DueDate, `Status`, Balance)
	VALUES(_patientId
			, _providerId
			, _officeId
			, _chargeId
			, _date
			, _dueDate
			, _status
			, _balance);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertUserWithPasswordAndEmail
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO users (email
				, `password`)
	VALUES (_email
			, _password);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertUtilizationForm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO utilizationform (`appointmentID`
		, `reseivingName`
		, `senderName`
		, `ReseivingFax`
		, `senderPhone`
		, `numOfPages`
		, `senderFax`
		, `diagnosis`
		, `requestedServices`
		, `frequency`
		, `outpatient`
		, `inpatient`
		, `claimantName`
		, `claimantSSN`
		, `claimNumber`
		, `dateOfInjury`
		, `requestingProvider`
		, `taxID`
		, `NPInumber`
		, `DoctorAddress`
		, `officePhone`
		, `officeFax`
		, `idc_97012`
		, `idc_97035`
		, `idc_97110`
		, `idc_G0283`
		, `idc_97124`
		, `idc_98940`
		, `idc_97545_WC`
		, `idc_97546_WC`
		, `idc_97545_WH`)
	VALUES (_appointmentID
		, _reseivingName
		, _senderName
		, _ReseivingFax
		, _senderPhone
		, _numOfPages
		, _senderFax
		, _diagnosis
		, _requestedServices
		, _frequency
		, _outpatient
		, _inpatient
		, _claimantName
		, _claimantSSN
		, _claimNumber
		, _dateOfInjury
		, _requestingProvider
		, _taxID
		, _NPInumber
		, _DoctorAddress
		, _officePhone
		, _officeFax
		, _idc_97012
		, _idc_97035
		, _idc_97110
		, _idc_G0283
		, _idc_97124
		, _idc_98940
		, _idc_97545_WC
		, _idc_97546_WC
		, _idc_97545_WH);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertVisitStatus
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO visit_status (office_id
							, appointment_id
							, patient_id
							, check_in
							, checkout
							, encounter_end
							, vitals_end)
	VALUES(_officeId
			, _appointmentTimeId
			, _patientId
			, _checkInTime
			, _checkOutTime
			, _date
			, _vitalEnd);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


InsertVital
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	INSERT INTO vitals (appointment_id, temperature, blood_pressure_low, blood_pressure_high, pulse, respiratory_rate, pain, sixth_name, sixth_measure, weight, height, bmi, time_stamp)
	VALUES (_appointmentTimeId
		, _temperature
		, _bloodPressureLow
		, _bloodPressureHigh
		, _pulse
		, _respiratoryRate
		, _pain
		, _sixthName
		, _sixthValue
		, _weight
		, _height
		, _bmi
		, _timeStamp);
END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAccidentReport
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE accident_report
	SET office_id = _officeId
		, related_to_employment = _employmentCondition
		, related_to_auto_accident = _autoAccidentCondition
		, place_of_auto_accident = _state
		, related_to_other_accident = _otherAccidentCondition
		, notes = _note
	WHERE auto = _accidentReportId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateActiveRehabilitation
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE activerehabilitation
	SET `Name` = _name
		, DoctorId = _doctorId
		, Category = _category
	WHERE ActiveRehabilitationId = _activeRehabilitationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAdministrationInput
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE administrationinput
	SET physicalRehabStartDate = _physicalRehabStartDate
		, physicalRehabEndDate = _physicalRehabEndDate
		, physicalRehabApprovedVisit = _physicalRehabApprovedVisit
		, physicalRehabExtensionDate = _physicalRehabExtensionDate
		, insuranceIsRelatedToWork = _insuranceIsRelatedToWork
		, insuranceIsMVA = _insuranceIsMVA
		, insuranceFormOfPayment = _insuranceFormOfPayment
		, insuranceCompany = _insuranceCompany
		, insuranceCompanyAddress = _insuranceCompanyAddress
		, insuranceCompanyCity = _insuranceCompanyCity
		, insuranceCompanyState = _insuranceCompanyState
		, insuranceCompanyZip = _insuranceCompanyZip
		, insuranceCompanyAdjustor = _insuranceCompanyAdjustor
		, insuranceCompanyPhone = _insuranceCompanyPhone
		, insuranceCompanyFax = _insuranceCompanyFax
		, insuredName = _insuredName
		, relationshipToInsured = _relationshipToInsured
		, insurancePolicyNumber = _insurancePolicyNumber
		, insuranceGroupNumber = _insuranceGroupNumber
		, insuranceType = _insuranceType
		, insuranceEffectiveDate = _insuranceEffectiveDate
		, insuranceCalendarYear = _insuranceCalendarYear
		, insurancePlanYearFrom = _insurancePlanYearFrom
		, insurancePlanYearTo = _insurancePlanYearTo
		, insuranceplanRequiresReferral = _insuranceplanRequiresReferral
		, insurancePlanRequiresDeductible = _insurancePlanRequiresDeductible
		, insuranceIndividualDeductibleAmount = _insuranceIndividualDeductibleAmount
		, insuranceFamilyDeductibleAmount = _insuranceFamilyDeductibleAmount
		, insuranceDeductibleSatisfied = _insuranceDeductibleSatisfied
		, insuranceDeductibleRemainingAmount = _insuranceDeductibleRemainingAmount
		, insuranceCoverageAfterDeductibleAmount = _insuranceCoverageAfterDeductibleAmount
		, insuranceCoverageAfterDeductiblePercent = _insuranceCoverageAfterDeductiblePercent
		, insuranceMaximumAmountPerYear = _insuranceMaximumAmountPerYear
		, insuranceMaximumAmountPerYearAmount = _insuranceMaximumAmountPerYearAmount
		, insuranceMaximumAmountBeenUsed = _insuranceMaximumAmountBeenUsed
		, insuranceMaximumAmountBeenUsedCount = _insuranceMaximumAmountBeenUsedCount
		, insuranceMaximumAmountPerVisit = _insuranceMaximumAmountPerVisit
		, insuranceMaximumAmountPerVisitCount = _insuranceMaximumAmountPerVisitCount
		, insuranceLimitVisitPerYear = _insuranceLimitVisitPerYear
		, insuranceLimitVisitPerYearCount = _insuranceLimitVisitPerYearCount
		, CPT99202 = _CPT99202
		, CPT99214 = _CPT99214
		, insuranceEvalManagementExamCodeSeparateCopay = _insuranceEvalManagementExamCodeSeparateCopay
		, insuranceEvalManagementExamCodeSeparateCopayAmount = _insuranceEvalManagementExamCodeSeparateCopayAmount
		, IDC97010 = _IDC97010
		, IDC97035 = _IDC97035
		, IDC97012 = _IDC97012
		, IDC97014 = _IDC97014
		, insuranceModalitiesSeparateCopay = _insuranceModalitiesSeparateCopay
		, insuranceModalitiesSeparateCopayAmount = _insuranceModalitiesSeparateCopayAmount
		, insuranceModalitiesMaxVisit = _insuranceModalitiesMaxVisit
		, IDC97112 = _IDC97112
		, IDC97530 = _IDC97530
		, IDC97110 = _IDC97110
		, IDC97140 = _IDC97140
		, insurancePhysicalMedicineRehabSeparateCopay = _insurancePhysicalMedicineRehabSeparateCopay
		, insurancePhysicalMedicineRehabSeparateCopayAmount = _insurancePhysicalMedicineRehabSeparateCopayAmount
		, insurancePhysicalMedicineRehabMaxPerVisit = _insurancePhysicalMedicineRehabMaxPerVisit
		, IDC98940 = _IDC98940
		, IDC98941 = _IDC98941
		, insuranceChiropracticSeparateCopay = _insuranceChiropracticSeparateCopay
		, insuranceChiropracticSeparateCopayAmount = _insuranceChiropracticSeparateCopayAmount
		, insuranceClaimAddress = _insuranceClaimAddress
		, insuranceClaimCity = _insuranceClaimCity
		, insuranceClaimState = _insuranceClaimState
		, insuranceClaimZip = _insuranceClaimZip
		, insuranceClaimNumber = _insuranceClaimNumber
		, insuranceClaimCallDate = _insuranceClaimCallDate
		, insuranceClaimCallTime = _insuranceClaimCallTime
		, insuranceClaimCallSpokenTo = _insuranceClaimCallSpokenTo
		, insuranceClaimCallLogNumber = _insuranceClaimCallLogNumber
		, workerCompClaimNumber = _workerCompClaimNumber
		, dateOfInjury = _dateOfInjury
		, isInNetwork = _isInNetwork
		, nurseCaseManager = _nurseCaseManager
		, nurseCaseManagerPhone = _nurseCaseManagerPhone
		, nurseCaseManagerFax = _nurseCaseManagerFax
		, compensableInjuries = _compensableInjuries
		, preauthorizationCode = _preauthorizationCode
		, preauthorizationCodePhone = _preauthorizationCodePhone
		, preauthorizationCodeFax = _preauthorizationCodeFax
		, referralDoctorName = _referralDoctorName
		, referralDoctorSpecialty = _referralDoctorSpecialty
		, referralDoctorAddress = _referralDoctorAddress
		, referralDoctorCity = _referralDoctorCity
		, referralDoctorState = _referralDoctorState
		, referralDoctorZip = _referralDoctorZip
		, referralDoctorPhone = _referralDoctorPhone
		, referralDoctorFax = _referralDoctorFax
		, attorneyName = _attorneyName
		, attorneyLegalAssistant = _attorneyLegalAssistant
		, attorneyAddress = _attorneyAddress
		, attorneyCity = _attorneyCity
		, attorneyState = _attorneyState
		, attorneyZip = _attorneyZip
		, attorneyPhone = _attorneyPhone
		, attorneyFax = _attorneyFax
		, compensableInjuriesVerifiedByName = _compensableInjuriesVerifiedByName
		, compensableInjuriesSpokenTo = _compensableInjuriesSpokenTo
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAllergy
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE allergies
	SET	`allergy` = _allergy
		, `reaction` = _reaction
	WHERE auto = _allergyId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAppointmentRequest
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE appointment_request
	SET comfirmed = 1
		, office_id = _officeId
	WHERE appointment_request.auto = _appointmentRequestId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAppointmentTime
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE appointment_time
	SET doctor_id = _doctorId
		, date = _date
		, starts = _startTime
		, ends = _endTime
	WHERE appointment_time.auto = _appiontmentID;

	UPDATE medical_encounter
	SET chief_complaint = _chiefComplaint
		, doctor = _doctorId
	WHERE medical_encounter.appointment_id = _appiontmentID;

	UPDATE vitals
	SET date = _date
	WHERE vitals.appointment_id = _appiontmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAppointmentTimeDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE appointment_time
	SET date = _date
		, starts = _startTime
		, ends = _endTime
	WHERE appointment_time.auto = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAuthorizedVisits
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE authorizedVisits
	SET visits_approved = _visits_approved
		, date = _date
	WHERE patient_id = _patient_id
	AND office_id = _office_id;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateAuthorizedVisitsUsed
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE authorizedVisits
	SET visits_used = _visits_used
	WHERE patient_id = _patient_id
	AND office_id = _office_id;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateChiefComplaint
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET chief_complaint = _chiefComplaint
	WHERE medical_encounter.auto = _medicalEncounterId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateChiefComplaintByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET chief_complaint = _chiefComplaint
	WHERE medical_encounter.appointment_id = _appointmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateCondition
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE `clinicdev`.`conditions`
	SET `condition` = _condition
	WHERE auto = _conditionId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateContactInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE contact_info
	SET street_address = _contactAddress
		, city = _contactCity
		, state = _contactState
		, zip = _contactZip
		, home_phone = _contactPhone
		, work_phone = _workPhone
		, email = _contactEmail
	WHERE id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateDisplaySetting
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE income_report_display_setting
	SET cell1 = _cell1
		, cell2 = _cell2
		, cell3 = _cell3
		, cell4 = _cell4
		, cell5 = _cell5
		, cell6 = _cell6
		, cell7 = _cell7
		, cell8 = _cell8
		, cell9 = _cell9
		, cell10 = _cell10
		, cell11 = _cell11
		, cell12 = _cell12
		, cell13 = _cell13
		, cell14 = _cell14
		, cell15 = _cell15
		, cell16 = _cell16
		, cell17 = _cell17
		, cell18 = _cell18
		, cell19 = _cell19
		, cell20 = _cell20
		, cell21 = _cell21
		, cell22 = _cell22
		, cell23 = _cell23
		, cell24 = _cell24
		, cell25 = _cell25
		, cell26 = _cell26
		, cell27 = _cell27
		, `date` = _date
	WHERE income_report_display_setting.name = _settingName
		AND income_report_display_setting.doctor_id = _doctorId
		AND reportId = _reportId;
		END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateDoctorMembership
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# variable
	DECLARE var_failedLoginAttempt, var_forgetPasswordRequest, var_doctor_count INT;
	DECLARE var_lastLoginAttempt, var_lastForgetPassword DATETIME;
	SET var_failedLoginAttempt = 0;
	SET var_forgetPasswordRequest = 0;

	# check if membership exist
	SELECT COUNT(doctors_id)
	INTO var_doctor_count
	FROM doctors_membership
	WHERE doctors_id = _doctorId;

	# update if membership exist, insert otherwise
	IF (var_doctor_count > 0) THEN
		# get existing membership
		SELECT failed_login_attempt
				, forget_password_request
				, last_login_attempt
				, last_forget_password
		INTO var_failedLoginAttempt
			, var_forgetPasswordRequest
			, var_lastLoginAttempt
			, var_lastForgetPassword
		FROM doctors_membership
		WHERE doctors_id = _doctorId;

		# set failed login and password request
		SET var_failedLoginAttempt = var_failedLoginAttempt + IFNULL(_failedLoginAttempt, 0);
		SET var_forgetPasswordRequest = var_forgetPasswordRequest + IFNULL(_forgetPasswordRequest, 0);

		# check _lastLoginAttempt and _lastForgetPassword value
		IF (_lastLoginAttempt IS NULL OR _lastLoginAttempt = ''0000-00-00 00:00:00'') THEN
			SET _lastLoginAttempt = var_lastLoginAttempt;
		END IF;
		IF (_lastForgetPassword IS NULL OR _lastForgetPassword = ''0000-00-00 00:00:00'') THEN
			SET _lastForgetPassword = var_lastForgetPassword;
		END IF;

		# update doctor membership
		UPDATE doctors_membership
		SET `failed_login_attempt` = var_failedLoginAttempt
			, `last_login_attempt`= _lastLoginAttempt
			, `forget_password_request` = var_forgetPasswordRequest
			, `last_forget_password` = _lastForgetPassword
			, `is_locked` = _isLocked
		WHERE `doctors_id` = _doctorId;

		# reset failed login attempt if last login attempt is more than a day, 1000000 is 1 day
		IF (_lastLoginAttempt - var_lastLoginAttempt >= 1000000) THEN
			UPDATE doctors_membership
			SET `failed_login_attempt` = 0
			WHERE `doctors_id` = _doctorId;
		END IF;

		# update is locked if failed attempt 10 times or more
		IF (var_failedLoginAttempt >= 20) THEN
			UPDATE doctors_membership
			SET `is_locked` = true
			WHERE `doctors_id` = _doctorId;
		END IF;
	ELSE
		# set failed login and password request
		SET var_failedLoginAttempt = var_failedLoginAttempt + IFNULL(_failedLoginAttempt, 0);
		SET var_forgetPasswordRequest = var_forgetPasswordRequest + IFNULL(_forgetPasswordRequest, 0);

		INSERT INTO doctors_membership (`doctors_id`
			, `failed_login_attempt`
			, `last_login_attempt`
			, `forget_password_request`
			, `last_forget_password`
			, `is_locked`)
		VALUES 	(_doctorId
			, var_failedLoginAttempt
			, _lastLoginAttempt
			, var_forgetPasswordRequest
			, _lastForgetPassword
			, _isLocked);
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateDoctorMembershipForgetPassword
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	# variable
	DECLARE var_doctor_id INT;
	SET var_doctor_id = 0;

	# get doctor id
	SELECT doctor_id
	INTO var_doctor_id
	FROM doctors_membership_forget_password
	WHERE unique_identifier = _uniqueIdentifier;

	IF (var_doctor_id > 0) THEN
		# unlock account
		CALL UpdateDoctorMembership(var_doctor_id, null, null, null, null, 0);

		# delete forget password identifier
		DELETE FROM doctors_membership_forget_password
		WHERE doctor_id = var_doctor_id;

		# reset password
		UPDATE doctors
		SET `password` = _password
			, `salt` = _salt
		WHERE auto = var_doctor_id;

		SELECT TRUE AS result;
	ELSE
		SELECT FALSE AS result;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateDrinkingHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE drinking_history
	SET beer_amount = _beer_amount
		, beer_how_often = _beer_how_often
		, wine_amount = _wine_amount
		, wine_how_often = _wine_how_often
		, liquor_amount = _liquor_amount
		, loquor_how_often = _loquor_how_often
	WHERE id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateEmergencyContact
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	IF (_tableNumber = 1) THEN
		UPDATE emergency_contact
		SET first_name = _firstName
			, middlename = _middleName
			, last_name = _lastName
			, relationship = _relationship
			, street_address = _address
			, city = _city
			, state = _state
			, zip = _zip
			, home_number = _phone
			, work_number = _workPhone
		WHERE userID = _patientId;
	ELSEIF (_tableNumber = 2) THEN
		UPDATE emergency_contact2
		SET first_name = _firstName
			, middlename = _middleName
			, last_name = _lastName
			, relationship = _relationship
			, street_address = _address
			, city = _city
			, state = _state
			, zip = _zip
			, home_number = _phone
			, work_number = _workPhone
		WHERE userID = _patientId;
	ELSEIF (_tableNumber = 3) THEN
		UPDATE emergency_contact3
		SET first_name = _firstName
			, middlename = _middleName
			, last_name = _lastName
			, relationship = _relationship
			, street_address = _address
			, city = _city
			, state = _state
			, zip = _zip
			, home_number = _phone
			, work_number = _workPhone
		WHERE userID = _patientId;
	END IF;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateEmployment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE employment
	SET student_fulltime = _isStudent
		, ocupation = _employmentOccupation
		, employer = _employmentName
		, street_address = _employmentAddress
		, city = _employmentCity
		, state = _employmentState
		, zip = _employmentZip
		, telephone = _telephone
	WHERE userID = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateExaminationInput
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE examinationinput
	SET ChiefComplaint = _chiefComplaint
		, Date = _date
		, HistoryOfPresentInjury = _historyOfPresentInjury
		, Chiro = _chiro
		, Injection = _injection
		, PainProgram = _painProgram
		, Diagnostic = _diagnostic
		, PainFreq = _painFreq
		, PainLocation = _painLocation
		, PainRadiation = _painRadiation
		, PainRadiationDuration = _painRadiationDuration
		, PainVAS = _painVAS
		, CurrentMedication = _currentMedication
		, PastMedication = _pastMedication
		, Allergy = _allergy
		, PertinentMedicalHistory = _pertinentMedicalHistory
		, SubstanceAbuse = _substanceAbuse
		, Neuropsychological = _neuropsychological
		, MentalDisorder = _mentalDisorder
		, LMP = _LMP
		, SocialHistory = _socialHistory
		, Tobacco = _tobacco
		, EtOH = _EtOH
		, IVDrug = _IVDrug
		, WorkStatus = _workStatus
		, Ambulation = _ambulation
		, HomeManagement = _homeManagement
		, Recreation = _recreation
		, GeneralAppearance = _generalAppearance
		, HEENT = _HEENT
		, Cardiovascular = _cardiovascular
		, NECT = _NECT
		, Pulse = _pulse
		, CV = _CV
		, ABD = _ABD
		, NeurologicalCranialNerve = _neurologicalCranialNerve
		, SensoryUpperExtremities = _sensoryUpperExtremities
		, SensoryLowerExtremities = _sensoryLowerExtremities
		, MotorUpperExtremities = _motorUpperExtremities
		, MotorLowerExtremities = _motorLowerExtremities
		, HeelWalk = _heelWalk
		, ToeWalk = _toeWalk
		, ReflexBicepLeft = _reflexBicepLeft
		, ReflexBrachioradialisLeft = _reflexBrachioradialisLeft
		, ReflexTricepLeft = _reflexTricepLeft
		, ReflexPatellarLeft = _reflexPatellarLeft
		, ReflexAchillesLeft = _reflexAchillesLeft
		, ReflexBicepLeftLevel = _reflexBicepLeftLevel
		, ReflexBrachioradialisLeftLevel = _reflexBrachioradialisLeftLevel
		, ReflexTricepLeftLevel = _reflexTricepLeftLevel
		, ReflexPatellarLeftLevel = _reflexPatellarLeftLevel
		, ReflexAchillesLeftLevel = _reflexAchillesLeftLevel
		, ReflexBicepRight = _reflexBicepRight
		, ReflexBrachioradialisRight = _reflexBrachioradialisRight
		, ReflexTricepRight = _reflexTricepRight
		, ReflexPatellarRight = _reflexPatellarRight
		, ReflexAchillesRight = _reflexAchillesRight
		, ReflexBicepRightLevel = _reflexBicepRightLevel
		, ReflexBrachioradialisRightLevel = _reflexBrachioradialisRightLevel
		, ReflexTricepRightLevel = _reflexTricepRightLevel
		, ReflexPatellarRightLevel = _reflexPatellarRightLevel
		, ReflexAchillesRightLevel = _reflexAchillesRightLevel
		, SpecialBabinski = _specialBabinski
		, SpecialClonus = _specialClonus
		, SpecialRhomberg = _specialRhomberg
		, SpecialHeel = _specialHeel
		, SpecialShin = _specialShin
		, SpecialFinger = _specialFinger
		, SpecialNose = _specialNose
		, NerveTensionSLRSupine = _nerveTensionSLRSupine
		, NerveTensionSLRSitting = _nerveTensionSLRSitting
		, AutonomicTemperature = _autonomicTemperature
		, AutonomicHair = _autonomicHair
		, AutonomicNail = _autonomicNail
		, AutonomicMottling = _autonomicMottling
		, MusculoskeletalCervical = _musculoskeletalCervical
		, MusculoskeletalThoracic = _musculoskeletalThoracic
		, MusculoskeletalLumbar = _musculoskeletalLumbar
		, MusculoskeletalExtremities = _musculoskeletalExtremities
		, MusculoskeletalSacroiliac = _musculoskeletalSacroiliac
		, OrthopedicCervical = _orthopedicCervical
		, OrthopedicThoracis = _orthopedicThoracis
		, OrthopedicLumbar = _orthopedicLumbar
		, OrthopedicUpperExtremities = _orthopedicUpperExtremities
		, OrthopedicLowerExtremities = _orthopedicLowerExtremities
		, Recommendation = _recommendation
		, ProgressVAS = _progressVAS
		, ProgressRadiation = _progressRadiation
		, ProgressPainFreq = _progressPainFreq
		, ProgressROM = _progressROM
		, ProgressTreatment = _progressTreatment
		, painAssesmentText = _painAssesmentText
		, effectsOfInjuryOnLifestyle = _effectsOfInjuryOnLifestyle
		, DermatomeText = _dermatomeText
		, MusculoskeletalText = _musculoskeletalText
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateExaminationInputDermatomeText
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE examinationinput
	SET DermatomeText = _dermatomeText
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateExaminationInputMusculoskeletalText
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE examinationinput
	SET MusculoskeletalText = _musculoskeletalText
	WHERE appointmentID = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateFamilyHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE `clinicdev`.`family_history`
	SET `family_condition` = _familyHistory
	WHERE auto = _familyHistoryId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateFavCPT
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE favouritecptcodes
	SET	doctor_id = _doctor_id
		, `code` = _cpt
		, description = _description
		, grouping = _grouping
	WHERE auto = _favCPTId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateFavIDC
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE favouriteIDCtcodes
	SET `doctor_id` = _doctor_id
		, `idc` = _idc
		, `description` = _description
	WHERE `auto` = _favIDCId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateFinancialResponsibility
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE financial_responsability
	SET first_name = _firstName
		, middlename = _middleName
		, last_name = _lastName
		, sex = _gender
		, relationship = _relationship
		, street_address = _address
		, city = _city
		, state = _state
		, zip = _zip
		, home_phone = _phone
		, ss_number = _SSN
		, driver_lisence = _driverLicense
		, birth_date = _DOB
		, employer = _employer
		, employer_address = _employerAddress
		, employer_city = _employerCity
		, employer_state = _employerState
		, employer_zip = _employerZip
		, employer_phone = _employerPhone
	WHERE userID = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateHistoryOfIllness
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET history_of_illness = _history
	WHERE medical_encounter.auto = _medicalEncounterId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateHistoryOfIllnessByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET history_of_illness = _history
	WHERE medical_encounter.appointment_id = _appointmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceClaimBalanceDue
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE insurance_claim
	SET balance_due = _totalCharge
	WHERE insurance_claim.auto = _insuranceClaimId
	AND insurance_claim.office_id = _officeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceClaimDateReviewed
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE insurance_claim
	SET date_reviewd = _date
		, date_submited = ''0000-00-00 00:00:00''
		, date_approved = ''0000-00-00 00:00:00''
	WHERE auto = _insuranceClaimId
	AND member_id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceClaimDateSubmitted
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE insurance_claim
	SET date_submited = _date
		, date_reviewd = ''0000-00-00 00:00:00''
		, date_approved = ''0000-00-00 00:00:00''
	WHERE insurance_claim.auto = _insuranceClaimId
	AND insurance_claim.member_id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceClaimDetail
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SET @query = CONCAT(''
		UPDATE insurance_claim
		SET '', _field, '' = '''', _value, ''''
		WHERE insurance_claim.auto = '', _insuranceClaimId, ''
		AND insurance_claim.office_id = '', _officeId, '';
	'');

	PREPARE Q FROM @query;
	EXECUTE Q;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceClaimTotalCharge
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE insurance_claim
	SET total_charge = _totalCharge
	WHERE insurance_claim.auto = _insuranceClaimId
	AND insurance_claim.office_id = _officeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateInsuranceInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE insurance_info
	SET insurance_Company = _insuranceCompany
		, member_id = _policyNumber
		, policy_group = _policyGroup
		, primary_beneficiary_first_name = _beneficiaryFirstName
		, primary_beneficiary_middle_name = _beneficiaryMiddleName
		, primary_beneficiary_last_name = _beneficiaryLastName
		, beneficiary_sex = _beneficiaryGender
		, relationship = _beneficiaryRelationship
		, beneficiary_address = _beneficiaryAddress
		, beneficiary_city = _beneficiaryCity
		, beneficiary_state = _beneficiaryState
		, beneficiary_zip = _beneficiaryZip
		, beneficiary_phone = _beneficiaryPhone
		, beneficiary_id = _beneficiaryPolicyNumber
		, beneficiary_ssn = _beneficiarySSN
		, beneficiary_DOB = _beneficiaryDOB
	WHERE id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateLabOrder
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE lab_orders
	SET test_name = _testName
	, date_ordered = _testDate
	, labName = _labName
	, comments = _testNote
	WHERE lab_orders.auto = _orderID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterCheckIn
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET checked_in = _checkedIn
	WHERE medical_encounter.appointment_id = _appointmentTimeId
	AND medical_encounter.id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET date = _date
	WHERE medical_encounter.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterImprovementSelfAssesmentByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET improvementSelfAssesment = _improvementSelfAssesment
	WHERE medical_encounter.appointment_id = _appointmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterInfo
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET chief_complaint = _chiefComplaint
		, history_of_illness = _history
		, assesment = _assesment
		, plan = _plan
		, progress_notes = _progressNote
	WHERE medical_encounter.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterNote
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter_notes
	SET note_text = _noteText
	WHERE appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterPainSelfAssesmentByAppointmentID
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET painSelfAssesment = _painSelfAssesment
	WHERE medical_encounter.appointment_id = _appointmentID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedicalEncounterVital
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medical_encounter
	SET vitals = 1
	WHERE medical_encounter.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMedication
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE medications
	SET prescription = _prescription
	, start_date = _startDate
	, end_date = _endDate
	, dosage = _dosage
	, refill = _refill
	, sig = _sig
	, notes = _note
	WHERE medications.auto = _auto;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateMessageRead
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE messages
	SET `read` = 1
	WHERE auto = _messageId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdatePatient
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE users
	SET first_name = _firstName
		, middle_name = _middleName
		, Last_name = _lastName
		, date_of_birth = _patientDOB
		, marital_status = _patientMarital
		, gender = _patientGender
		, ss_number = _patientSSN
		, driver_license = _patientDL
		, dl_state = _patientDLState
	WHERE auto = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdatePatientPersonalInformation
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE `users`
	SET  `account` =  _patientAccount
		, `salutation` =  _patientSalutation
		, `first_name` =  _patientFirstName
		, `middle_name` =  _patientMiddleName
		, `Last_name` =  _patientLastName
		, `marital_status` =  _patientMarital
		, `date_of_birth` =  _patientDOB
		, `gender` = _patientGender
		, `ss_number` =  _patientSSN
		, `driver_license` =  _patientDL
		, `dl_state` =  _patientDLState
	WHERE  `auto` = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdatePhysicalRehabUtilization
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE physicalrehabutilization
	SET `StartDate` = _startDate
		, `EndDate` = _endDate
		, `ApprovedVisitCount` = _approvedVisitCount
	WHERE PhysicalRehabUtilizationId = _physicalRehabUtilizationId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdatePositionSetting
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	SET @query = CONCAT(''
		UPDATE income_report_position_setting
		SET	'', _currentColumn, ''= '''', _nextRowToTheRight, ''''
			, '', _nextColumnNumber, '' = '''', _currentName, ''''
		WHERE doctor_id = '', _doctorId, ''
		AND reportId = '', _reportId, '';
	'');

	PREPARE Q FROM @query;
	EXECUTE Q;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateProcedure
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE procedures
	SET	`procedure` = _procedure
	WHERE auto = _procedureId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateReferral
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE referals
	SET referral_reason = _ReferralReason
		,physitian = _ReferralToName
		,phone = _ReferralToPhone
		,streetAddress = _ReferralToAddress
		,city = _ReferralToCity
		,state = _ReferralToState
		,zip = _ReferralToZip
		,notes = _ReferralToNotes
	WHERE auto = _ReferralID;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateSelfAssesment
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE selfassesment
	SET chiefComplaint = _chiefComplaint
		, causeOfProblem = _causeOfProblem
		, frequencyOfsymptoms = _frequencyOfsymptoms
		, descriptionOfPain = _descriptionOfPain
		, workInterferance = _workInterferance
		, socianInterferance = _socianInterferance
		, timeOfProblem = _timeOfProblem
		, begginingOfProblem = _begginingOfProblem
		, isProblemSevere = _isProblemSevere
		, whatAgravatesProblem = _whatAgravatesProblem
		, whatMakesTheProblemFeelBetter = _whatMakesTheProblemFeelBetter
		, concernsAboutProblem = _concernsAboutProblem
		, moreInformation = _moreInformation
		, painScale = _painScale
		, relativePain = _relativePain
		, neckPain_leftshoulder = _neckPain_leftshoulder
		, neckPain_rightshoulder = _neckPain_rightshoulder
		, neckPain_leftarm = _neckPain_leftarm
		, neckPain_rightarm = _neckPain_rightarm
		, neckPain_leftforearm = _neckPain_leftforearm
		, neckPain_rightforearm = _neckPain_rightforearm
		, neckPain_lefthand = _neckPain_lefthand
		, neckPain_righthand = _neckPain_righthand
		, Headache = _Headache
		, Migraine_Headache = _Migraine_Headache
		, Upper_back_pain = _Upper_back_pain
		, radiation_Buttocks = _radiation_Buttocks
		, radiation_Left_buttock = _radiation_Left_buttock
		, radiation_Right_buttock = _radiation_Right_buttock
		, radiation_Left_thight = _radiation_Left_thight
		, radiation_Right_thight = _radiation_Right_thight
		, radiation_Left_knee = _radiation_Left_knee
		, radiation_Right_knee = _radiation_Right_knee
		, radiation_Left_foot = _radiation_Left_foot
		, radiation_Right_foot = _radiation_Right_foot
		, numbnes_Left_Hand = _numbnes_Left_Hand
		, numbnes_Right_Hand = _numbnes_Right_Hand
		, numbnes_Left_Foot = _numbnes_Left_Foot
		, numbnes_Right_Foot = _numbnes_Right_Foot
		, numbnes_Left_Upper_Arm = _numbnes_Left_Upper_Arm
		, numbnes_Right_Upper_Ann = _numbnes_Right_Upper_Ann
		, numbnes_Left_Leg = _numbnes_Left_Leg
		, numbnes_Right_Leg = _numbnes_Right_Leg
		, RingingInEars_Yes = _RingingInEars_Yes
		, RingingInEars_No = _RingingInEars_No
		, RingingInEars_Left = _RingingInEars_Left
		, RingingInEars_Right = _RingingInEars_Right
		, RingingInEars_Both = _RingingInEars_Both
		, BlurryVision_Left = _BlurryVision_Left
		, BlurryVision_Right = _BlurryVision_Right
		, BlurryVision_Both = _BlurryVision_Both
		, WristPain_Left = _WristPain_Left
		, WristPain_Right = _WristPain_Right
		, WristPain_Both = _WristPain_Both
		, JawPain_Left = _JawPain_Left
		, JawPain_Right = _JawPain_Right
		, JawPain_Both = _JawPain_Both
		, Dizziness = _Dizziness
		, Nervousness = _Nervousness
		, Fatigue = _Fatigue
		, Anxiety = _Anxiety
		, Depression = _Depression
		, Excessive_irritability = _Excessive_irritability
		, Fear_of_driving_in_a_car = _Fear_of_driving_in_a_car
		, Loss_of_concentration = _Loss_of_concentration
		, Jaw_clenching = _Jaw_clenching
		, Grinding_of_teeth_at_night = _Grinding_of_teeth_at_night
		, Nightmares = _Nightmares
		, Difficulty_with_sleeping_at_night = _Difficulty_with_sleeping_at_night
		, HipPain_left = _HipPain_left
		, HipPain_right = _HipPain_right
		, HipPain_both = _HipPain_both
		, KneePain_left = _KneePain_left
		, KneePain_right = _KneePain_right
		, KneePain_both = _KneePain_both
		, FootPain_left = _FootPain_left
		, FootPain_right = _FootPain_right
		, FootPain_both = _FootPain_both
		, timeLostDueToInjuries_yes = _timeLostDueToInjuries_yes
		, timeLostDueToInjuries_date = _timeLostDueToInjuries_date
		, typeOfEmployment = _typeOfEmployment
		, descriptionOfPreviousAccident = _descriptionOfPreviousAccident
		, descriptionOfPreviousInjuries = _descriptionOfPreviousInjuries
		, howMuchBetterPriorToCurrentCondition = _howMuchBetterPriorToCurrentCondition
	WHERE appointmentID = _appointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateSmokingHistory
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE smoking_history
	SET smokeless_tobacco = _is_smokeless
		, packs_a_day = _packs_a_day
		, how_often_do_you_smoke = _how_often_do_you_smoke
	WHERE id = _patientId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateSoapForm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE `soapform`
	SET `patientName` = _patientName
		, `chiefComplaint` = _chiefComplaint
		, `formDate` = _formDate
		, `vas_persent` = _vas_persent
		, `radiationTo` = _radiationTo
		, `constant` = _constant
		, `intermittent` = _intermittent
		, `aching` = _aching
		, `burning` = _burning
		, `cramping` = _cramping
		, `deep` = _deep
		, `dull` = _dull
		, `electricType` = _electricType
		, `numbness` = _numbness
		, `pulling` = _pulling
		, `sharp` = _sharp
		, `shooting` = _shooting
		, `stabbing` = _stabbing
		, `throbbing` = _throbbing
		, `tingling` = _tingling
		, `MusculoskeletalExam` = _MusculoskeletalExam
		, `ROM` = _ROM
		, `Reflexes` = _Reflexes
		, `LowerExtLeft` = _LowerExtLeft
		, `LowerExtRight` = _LowerExtRight
		, `UpperExtLeft` = _UpperExtLeft
		, `UpperExtRight` = _UpperExtRight
		, `Sensory` = _Sensory
		, `OrthopedicTest_SLR_rihgt` = _OrthopedicTest_SLR_rihgt
		, `OrthopedicTest_SLR_left` = _OrthopedicTest_SLR_left
		, `Other` = _Other
		, `idc9-724-5` = _idc9_724_5
		, `idc9-728-85` = _idc9_728_85
		, `idc9-723-4` = _idc9_723_4
		, `idc9-723-1` = _idc9_723_1
		, `idc9-739-1` = _idc9_739_1
		, `idc9-724-4` = _idc9_724_4
		, `idc9-724-1` = _idc9_724_1
		, `idc9-739-2` = _idc9_739_2
		, `idc9-847-0` = _idc9_847_0
		, `idc9-719-46` = _idc9_719_46
		, `idc9-739-3` = _idc9_739_3
		, `idc9-847-1` = _idc9_847_1
		, `idc9-713-41` = _idc9_713_41
		, `idc9-847-2` = _idc9_847_2
		, `idc9-722-81` = _idc9_722_81
		, `idc9-722-83` = _idc9_722_83
		, `otherIDC9` = _otherIDC9
		, `TherapeuticExercises_areaTreated` = _TherapeuticExercises_areaTreated
		, `TherapeuticExercises_time` = _TherapeuticExercises_time
		, `TherapeuticExercisesRationale` = _TherapeuticExercisesRationale
		, `NeuromuscularReEducation_areaTreated` = _NeuromuscularReEducation_areaTreated
		, `NeuromuscularReEducation_time` = _NeuromuscularReEducation_time
		, `NeuromuscularReEducationRationale` = _NeuromuscularReEducationRationale
		, `Massage_areaTreated` = _Massage_areaTreated
		, `Massage_time` = _Massage_time
		, `MassageRationale` = _MassageRationale
		, `EMS_areaTreated` = _EMS_areaTreated
		, `EMS_time` = _EMS_time
		, `EMSRationale` = _EMSRationale
		, `Ultrasound_areaTreated` = _Ultrasound_areaTreated
		, `Ultrasound_time` = _Ultrasound_time
		, `UltrasoundRationale` = _UltrasoundRationale
		, `TriggerPointMyofascialRelease_areaTreated` = _TriggerPointMyofascialRelease_areaTreated
		, `TriggerPointMyofascialRelease_time` = _TriggerPointMyofascialRelease_time
		, `TriggerPointMyofascialReleaseRationale` = _TriggerPointMyofascialReleaseRationale
		, `Traction_areaTreated` = _Traction_areaTreated
		, `Traction_time` = _Traction_time
		, `TractionRationale` = _TractionRationale
		, `Manipulation` = _Manipulation
		, `otherProcedures` = _otherProcedures
		, `ProgressAfterTXVAS` = _ProgressAfterTXVAS
		, `AfterRadiationTo` = _AfterRadiationTo
		, `AfterRadConstant` = _AfterRadConstant
		, `AfterRadIntermittent` = _AfterRadIntermittent
		, `AfterROMMuscleTone` = _AfterROMMuscleTone
		, `TreatmentToleranceCompliance_well` = _TreatmentToleranceCompliance_well
		, `TreatmentToleranceCompliance_fair` = _TreatmentToleranceCompliance_fair
		, `TreatmentToleranceCompliance_poor` = _TreatmentToleranceCompliance_poor
		, `Recommendations` = _Recommendations
		, `Referrals` = _Referrals
		, `Provider` = _Provider
	WHERE `appointmentID`= _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateUtilizationForm
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE utilizationform
	SET reseivingName = _reseivingName
		, senderName = _senderName
		, ReseivingFax = _ReseivingFax
		, senderPhone = _senderPhone
		, numOfPages = _numOfPages
		, senderFax = _senderFax
		, diagnosis = _diagnosis
		, requestedServices = _requestedServices
		, frequency = _frequency
		, outpatient = _outpatient
		, inpatient = _inpatient
		, claimantName = _claimantName
		, claimantSSN = _claimantSSN
		, claimNumber = _claimNumber
		, dateOfInjury = _dateOfInjury
		, requestingProvider = _requestingProvider
		, taxID = _taxID
		, NPInumber = _NPInumber
		, DoctorAddress = _DoctorAddress
		, officePhone = _officePhone
		, officeFax = _officeFax
		, idc_97012 = _idc_97012
		, idc_97035 = _idc_97035
		, idc_97110 = _idc_97110
		, idc_G0283 = _idc_G0283
		, idc_97124 = _idc_97124
		, idc_98940 = _idc_98940
		, idc_97545_WC = _idc_97545_WC
		, idc_97546_WC = _idc_97546_WC
		, idc_97545_WH = _idc_97545_WH
		, idc_97546_WH = _idc_97546_WH
	WHERE appointmentID = _appointmentId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVisitStatusCheckIn
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE visit_status
	SET check_in = _checkTime
	WHERE visit_status.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVisitStatusCheckInOut
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE visit_status
	SET checkout = _checkTime
	WHERE visit_status.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVisitStatusEncounterEnd
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE visit_status
	SET encounter_end = _encounterEnd
	WHERE visit_status.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVisitStatusVitalEnd
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE visit_status
	SET vitals_end = _vitalEnd
	WHERE visit_status.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVital
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE vitals
	SET temperature = _temperature
		, blood_pressure_low = _bloodPressureLow
		, blood_pressure_high = _bloodPressureHigh
		, pulse = _pulse
		, respiratory_rate = _respiratoryRate
		, pain = _pain
		, sixth_name = _sixthName
		, sixth_measure = _sixthValue
		, weight = _weight
		, height = _height
		, bmi = _bmi
		, time_stamp = _timeStamp
	WHERE vitals.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:39', '2013-08-27 15:06:39', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';


UpdateVitalDate
, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SQL', 'BEGIN
	UPDATE vitals
	SET date = _date
	WHERE vitals.appointment_id = _appointmentTimeId;
	END', NULL, NULL, 'SQL', 'NO', 'CONTAINS SQL', NULL, 'DEFINER', '2013-08-27 15:06:40', '2013-08-27 15:06:40', 'NO_AUTO_VALUE_ON_ZERO', '', 'spectrumgeorge@%', 'utf8', 'utf8_general_ci', 'latin1_swedish_ci';
