Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2C6F6704
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjEDIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:12:40 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2F4EDF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:10:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683187812; x=1683195012; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Subject: Cc: To: To:
 From: From: Sender: Sender; bh=QuJJoGR9fWJNzZVaBdukBO0Jy/gNIFPAmlLCVtt3XUY=;
 b=MMnnF7M+Jcv4hQx+sT22iGXv9UHv0BRjOr4Dbll9+4zA02Gvl5vvztv8ilx0swEz3P9hhAGi3nVUplHwmVi7TAn5Y9+Uq9PpQ0jKqKfQlqElWpywriBlJdMDYbtJhrgzGzJSjgea7G3e6Nuz1HEiQIVTl6EQrV2LOJ8pMhJKP53J+A6NQQKmdqdDlapF/5RfbHbfgAVNMnyhWzMdWuEu/pzUGWmQr+2GqzSZJYXGkz5fC4iO4Nf/E8tsw642UJhI1dvmNVlR8kihmxFBjtarHe/GaTFkjb2f6lf4NDQc6J6XVq4xbX9IAYsYwX7Vx6Bll4soVlGa6o1KEr6WFKTCtQ==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 57d6487547fc with SMTP id
 645365eef77227a830390e79 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 May 2023 07:59:42 GMT
Sender: james@equiv.tech
From:   James Seo <james@equiv.tech>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     James Seo <james@equiv.tech>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 09/11] ABI: sysfs-class-hwmon: Revise hwmon ABI documentation
Date:   Thu,  4 May 2023 00:57:50 -0700
Message-Id: <20230504075752.1320967-10-james@equiv.tech>
In-Reply-To: <20230504075752.1320967-1-james@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat attribute descriptions to impose a consistent style
and improve rendering in the generated docs. For example,
some multi-line descriptions were being rendered as a single
line/paragraph due to missing blank line separators.

Harmonize short descriptions with those in the sysfs
interface spec and move in the longer explanations that were
shortened there.

Add cross-references (just file paths) in descriptions of
temperature attributes back to the sysfs interface spec
whence they were moved to explain why some sensor chips
report temperature as a voltage. Previously there was only a
note in the existing description of tempY_max directing the
reader to "see below" as though the move had never occurred.

Fix minor issues (typos, grammar, etc.) and add just a touch
of markup (inline literals only).

Link: https://lore.kernel.org/all/5f47619ed882b0b8d1c84b56f7ea17bac0854b77.1632994837.git.mchehab+huawei@kernel.org/
Signed-off-by: James Seo <james@equiv.tech>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 563 +++++++++++---------
 1 file changed, 322 insertions(+), 241 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 638f4c6d4ec7..7fc914bc70e2 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -1,32 +1,38 @@
 What:		/sys/class/hwmon/hwmonX/name
 Description:
-		The chip name.
+		Chip name.
+
+		Represents the chip name. It is the only mandatory attribute.
+
 		This should be a short, lowercase string, not containing
 		whitespace, dashes, or the wildcard character '*'.
-		This attribute represents the chip name. It is the only
-		mandatory attribute.
+
 		I2C devices get this attribute created automatically.
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/label
 Description:
-		A descriptive label that allows to uniquely identify a
+		Chip label.
+
+		A descriptive freeform label that uniquely identifies a
 		device within the system.
-		The contents of the label are free-form.
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/update_interval
 Description:
-		The interval at which the chip will update readings.
-		Unit: millisecond
+		Chip reading update interval.
 
-		RW
+		The interval at which the chip will update readings.
 
 		Some devices have a variable update rate or interval.
 		This attribute can be used to change it to the desired value.
 
+		Unit: millisecond
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/inY_min
 Description:
 		Voltage min value.
@@ -39,14 +45,14 @@ What:		/sys/class/hwmon/hwmonX/inY_lcrit
 Description:
 		Voltage critical min value.
 
+		If voltage drops to or below this limit, the system may
+		take drastic action such as powering down or restarting.
+		At the very least, it should report a fault.
+
 		Unit: millivolt
 
 		RW
 
-		If voltage drops to or below this limit, the system may
-		take drastic action such as power down or reset. At the very
-		least, it should report a fault.
-
 What:		/sys/class/hwmon/hwmonX/inY_max
 Description:
 		Voltage max value.
@@ -59,39 +65,40 @@ What:		/sys/class/hwmon/hwmonX/inY_crit
 Description:
 		Voltage critical max value.
 
+		If voltage reaches or exceeds this limit, the system may
+		take drastic action such as powering down or restarting.
+		At the very least, it should report a fault.
+
 		Unit: millivolt
 
 		RW
 
-		If voltage reaches or exceeds this limit, the system may
-		take drastic action such as power down or reset. At the very
-		least, it should report a fault.
-
 What:		/sys/class/hwmon/hwmonX/inY_input
 Description:
 		Voltage input value.
 
-		Unit: millivolt
-
-		RO
+		The voltage measured on the chip pin. The actual voltage
+		depends on the scaling resistors on the motherboard, as
+		recommended in the chip datasheet.
 
-		Voltage measured on the chip pin.
+		This varies by chip and by motherboard. Because of this
+		variation, values are generally NOT scaled by the chip driver,
+		and scaling must be done by the application.
 
-		Actual voltage depends on the scaling resistors on the
-		motherboard, as recommended in the chip datasheet.
+		However, some drivers (notably ``lm87`` and ``via686a``) do
+		scale, because of internal resistors built into the chip.
+		These drivers will output the actual voltage.
 
-		This varies by chip and by motherboard.
-		Because of this variation, values are generally NOT scaled
-		by the chip driver, and must be done by the application.
-		However, some drivers (notably lm87 and via686a)
-		do scale, because of internal resistors built into a chip.
-		These drivers will output the actual voltage. Rule of
-		thumb: drivers should report the voltage values at the
+		Rule of	thumb: Drivers should report the voltage values at the
 		"pins" of the chip.
 
+		Unit: millivolt
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/inY_average
 Description:
-		Average voltage
+		Average voltage.
 
 		Unit: millivolt
 
@@ -99,7 +106,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/inY_lowest
 Description:
-		Historical minimum voltage
+		Historical minimum voltage.
 
 		Unit: millivolt
 
@@ -107,7 +114,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/inY_highest
 Description:
-		Historical maximum voltage
+		Historical maximum voltage.
 
 		Unit: millivolt
 
@@ -115,13 +122,13 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/inY_reset_history
 Description:
-		Reset inX_lowest and inX_highest
+		Reset ``inY_lowest`` and ``inY_highest``.
 
 		WO
 
 What:		/sys/class/hwmon/hwmonX/in_reset_history
 Description:
-		Reset inX_lowest and inX_highest for all sensors
+		Reset ``inY_lowest`` and ``inY_highest`` for all sensors.
 
 		WO
 
@@ -129,23 +136,22 @@ What:		/sys/class/hwmon/hwmonX/inY_label
 Description:
 		Suggested voltage channel label.
 
-		Text string
+		A text string.
 
-		Should only be created if the driver has hints about what
-		this voltage channel is being used for, and user-space
-		doesn't. In all other cases, the label is provided by
-		user-space.
+		Should only be created if the driver has hints about what this
+		voltage channel is being used for, and userspace doesn't.
+		In all other cases, the label is provided by userspace.
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/inY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return -ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
-		- 1: Enable
 		- 0: Disable
+		- 1: Enable
 
 		RW
 
@@ -153,18 +159,16 @@ What:		/sys/class/hwmon/hwmonX/cpuY_vid
 Description:
 		CPU core reference voltage.
 
+		Not always correct.
+
 		Unit: millivolt
 
 		RO
 
-		Not always correct.
-
 What:		/sys/class/hwmon/hwmonX/vrm
 Description:
 		Voltage Regulator Module version number.
 
-		RW (but changing it should no more be necessary)
-
 		Originally the VRM standard version multiplied by 10, but now
 		an arbitrary number, as not all standards have a version
 		number.
@@ -172,6 +176,8 @@ Description:
 		Affects the way the driver calculates the CPU core reference
 		voltage from the vid pins.
 
+		RW (but changing it should not be necessary)
+
 What:		/sys/class/hwmon/hwmonX/inY_rated_min
 Description:
 		Minimum rated voltage.
@@ -190,7 +196,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/fanY_min
 Description:
-		Fan minimum value
+		Fan minimum value.
 
 		Unit: revolution/min (RPM)
 
@@ -198,11 +204,12 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/fanY_max
 Description:
-		Fan maximum value
+		Fan maximum value.
+
+		Only rarely supported by the hardware.
 
 		Unit: revolution/min (RPM)
 
-		Only rarely supported by the hardware.
 		RW
 
 What:		/sys/class/hwmon/hwmonX/fanY_input
@@ -217,21 +224,19 @@ What:		/sys/class/hwmon/hwmonX/fanY_div
 Description:
 		Fan divisor.
 
-		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
-
-		RW
-
+		An integer power of two (1, 2, 4, 8, 16, 32, 64, 128).
 		Some chips only support values 1, 2, 4 and 8.
+
 		Note that this is actually an internal clock divisor, which
 		affects the measurable speed range, not the read value.
 
+		RW
+
 What:		/sys/class/hwmon/hwmonX/fanY_pulses
 Description:
 		Number of tachometer pulses per fan revolution.
 
-		Integer value, typically between 1 and 4.
-
-		RW
+		An integer value, typically between 1 and 4.
 
 		This value is a characteristic of the fan connected to the
 		device's input, so it has to be set in accordance with the fan
@@ -242,74 +247,80 @@ Description:
 		thus attribute) the value assumed by all devices is 2 pulses
 		per fan revolution.
 
+		RW
+
 What:		/sys/class/hwmon/hwmonX/fanY_target
 Description:
-		Desired fan speed
+		Desired fan speed.
+
+		Only makes sense if the chip supports closed-loop fan speed
+		control based on the measured fan speed.
 
 		Unit: revolution/min (RPM)
 
 		RW
 
-		Only makes sense if the chip supports closed-loop fan speed
-		control based on the measured fan speed.
-
 What:		/sys/class/hwmon/hwmonX/fanY_label
 Description:
 		Suggested fan channel label.
 
-		Text string
+		A text string.
 
-		Should only be created if the driver has hints about what
-		this fan channel is being used for, and user-space doesn't.
-		In all other cases, the label is provided by user-space.
+		Should only be created if the driver has hints about what this
+		fan channel is being used for, and userspace doesn't.
+		In all other cases, the label is provided by userspace.
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/fanY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return -ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
-		- 1: Enable
 		- 0: Disable
+		- 1: Enable
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/fanY_fault
 Description:
-		Reports if a fan has reported failure.
+		Fan channel fault indicator.
+
+		Indicates whether a fan has reported failure.
 
+		- 0: OK
 		- 1: Failed
-		- 0: Ok
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/pwmY
 Description:
-		Pulse width modulation fan control.
+		Pulse-width modulation fan control.
 
-		Integer value in the range 0 to 255
+		An integer value in the range 0 to 255.
 
-		RW
+		255 represents 100%.
 
-		255 is max or 100%.
+		RW
 
 What:		/sys/class/hwmon/hwmonX/pwmY_enable
 Description:
-		Fan speed control method:
-
-		- 0: no fan speed control (i.e. fan at full speed)
-		- 1: manual fan speed control enabled (using `pwmY`)
-		- 2+: automatic fan speed control enabled
+		Fan speed control method.
 
 		Check individual chip documentation files for automatic mode
 		details.
 
+		- 0: No fan speed control (i.e. fan at full speed)
+		- 1: Manual fan speed control enabled (using ``pwmY``)
+		- 2+: Automatic fan speed control enabled
+
 		RW
 
 What:		/sys/class/hwmon/hwmonX/pwmY_mode
 Description:
+		Fan speed control mode.
+
 		- 0: DC mode (direct current)
 		- 1: PWM mode (pulse-width modulation)
 
@@ -319,18 +330,24 @@ What:		/sys/class/hwmon/hwmonX/pwmY_freq
 Description:
 		Base PWM frequency in Hz.
 
-		Only possibly available when pwmN_mode is PWM, but not always
-		present even then.
+		May only be available when ``pwmY_mode`` is PWM,
+		but not always present even then.
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
 Description:
-		Select which temperature channels affect this PWM output in
-		auto mode.
+		Auto mode channel mask.
+
+		Select which temperature channels affect this PWM output
+		in auto mode.
 
-		Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
-		Which values are possible depend on the chip used.
+		A bitfield. Possible values are chip-dependent. For example:
+
+		- 1: ``temp1``
+		- 2: ``temp2``
+		- 4: ``temp3``
+		- 5: ``temp1`` and ``temp3``
 
 		RW
 
@@ -338,10 +355,13 @@ What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_pwm
 What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_temp
 What:		/sys/class/hwmon/hwmonX/pwmY_auto_pointZ_temp_hyst
 Description:
-		Define the PWM vs temperature curve.
+		PWM temperature curve definition.
+
+		Define the PWM vs. temperature curve.
+		The number of trip points is chip-dependent.
 
-		Number of trip points is chip-dependent. Use this for chips
-		which associate trip points to PWM output channels.
+		Use this for chips that associate trip points
+		with PWM output channels.
 
 		RW
 
@@ -349,10 +369,13 @@ What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_pwm
 What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_temp
 What:		/sys/class/hwmon/hwmonX/tempY_auto_pointZ_temp_hyst
 Description:
-		Define the PWM vs temperature curve.
+		PWM temperature curve definition.
 
-		Number of trip points is chip-dependent. Use this for chips
-		which associate trip points to temperature channels.
+		Define the PWM vs. temperature curve.
+		The number of trip points is chip-dependent.
+
+		Use this for chips that associate trip points
+		with temperature channels.
 
 		RW
 
@@ -360,24 +383,25 @@ What:		/sys/class/hwmon/hwmonX/tempY_type
 Description:
 		Sensor type selection.
 
-		Integers 1 to 6
-
-		RW
+		Not all types are supported by all chips.
 
 		- 1: CPU embedded diode
 		- 2: 3904 transistor
-		- 3: thermal diode
-		- 4: thermistor
+		- 3: Thermal diode
+		- 4: Thermistor
 		- 5: AMD AMDSI
 		- 6: Intel PECI
 
-		Not all types are supported by all chips
+		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_max
 Description:
 		Temperature max value.
 
-		Unit: millidegree Celsius (or millivolt, see below)
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
@@ -385,7 +409,10 @@ What:		/sys/class/hwmon/hwmonX/tempY_min
 Description:
 		Temperature min value.
 
-		Unit: millidegree Celsius
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
@@ -393,20 +420,27 @@ What:		/sys/class/hwmon/hwmonX/tempY_max_hyst
 Description:
 		Temperature hysteresis value for max limit.
 
-		Unit: millidegree Celsius
+		Must be reported as an absolute temperature,
+		NOT as a delta from the max value.
 
-		Must be reported as an absolute temperature, NOT a delta
-		from the max value.
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_min_hyst
 Description:
 		Temperature hysteresis value for min limit.
-		Unit: millidegree Celsius
 
-		Must be reported as an absolute temperature, NOT a delta
-		from the min value.
+		Must be reported as an absolute temperature,
+		NOT as a delta from the min value.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
@@ -414,51 +448,67 @@ What:		/sys/class/hwmon/hwmonX/tempY_input
 Description:
 		Temperature input value.
 
-		Unit: millidegree Celsius
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/tempY_crit
 Description:
-		Temperature critical max value, typically greater than
-		corresponding temp_max values.
+		Temperature critical max value.
+
+		Typically greater than corresponding ``tempY_max`` values.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
 
-		Unit: millidegree Celsius
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_crit_alarm
 Description:
-		Critical high temperature alarm flag.
-
-		- 0: OK
-		- 1: temperature has reached tempY_crit
-
-		RW
+		Temperature critical max alarm indicator.
 
 		Contrary to regular alarm flags which clear themselves
 		automatically when read, this one sticks until cleared by
 		the user. This is done by writing 0 to the file. Writing
 		other values is unsupported.
 
+		- 0: No alarm
+		- 1: Alarm
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/tempY_crit_hyst
 Description:
 		Temperature hysteresis value for critical limit.
 
-		Unit: millidegree Celsius
+		Must be reported as an absolute temperature,
+		NOT as a delta from the critical value.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
 
-		Must be reported as an absolute temperature, NOT a delta
-		from the critical value.
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_emergency
 Description:
-		Temperature emergency max value, for chips supporting more than
-		two upper temperature limits. Must be equal or greater than
-		corresponding temp_crit values.
+		Temperature emergency max value.
 
-		Unit: millidegree Celsius
+		For chips supporting more than two upper temperature limits.
+
+		Must be equal to or greater than corresponding ``tempY_crit``
+		values.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
@@ -466,19 +516,26 @@ What:		/sys/class/hwmon/hwmonX/tempY_emergency_hyst
 Description:
 		Temperature hysteresis value for emergency limit.
 
-		Unit: millidegree Celsius
+		Must be reported as an absolute temperature,
+		NOT as a delta from the emergency value.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
 
-		Must be reported as an absolute temperature, NOT a delta
-		from the emergency value.
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_lcrit
 Description:
-		Temperature critical min value, typically lower than
-		corresponding temp_min values.
+		Temperature critical min value.
 
-		Unit: millidegree Celsius
+		Typically lower than corresponding ``tempY_min`` values.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
@@ -486,68 +543,80 @@ What:		/sys/class/hwmon/hwmonX/tempY_lcrit_hyst
 Description:
 		Temperature hysteresis value for critical min limit.
 
-		Unit: millidegree Celsius
+		Must be reported as an absolute temperature,
+		NOT as a delta from the critical min value.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
 
-		Must be reported as an absolute temperature, NOT a delta
-		from the critical min value.
+		Unit: millidegree Celsius (or millivolt)
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_offset
 Description:
-		Temperature offset which is added to the temperature reading
-		by the chip.
+		Temperature offset.
 
-		Unit: millidegree Celsius
+		An offset added to the temperature reading by the chip.
 
-		Read/Write value.
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
+
+		RW
 
 What:		/sys/class/hwmon/hwmonX/tempY_label
 Description:
 		Suggested temperature channel label.
 
-		Text string
+		A text string.
 
-		Should only be created if the driver has hints about what
-		this temperature channel is being used for, and user-space
-		doesn't. In all other cases, the label is provided by
-		user-space.
+		Should only be created if the driver has hints about what this
+		temperature channel is being used for, and userspace doesn't.
+		In all other cases, the label is provided by userspace.
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/tempY_lowest
 Description:
-		Historical minimum temperature
+		Historical minimum temperature.
+
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
 
-		Unit: millidegree Celsius
+		Unit: millidegree Celsius (or millivolt)
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/tempY_highest
 Description:
-		Historical maximum temperature
+		Historical maximum temperature.
 
-		Unit: millidegree Celsius
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/tempY_reset_history
 Description:
-		Reset temp_lowest and temp_highest
+		Reset ``tempY_lowest`` and ``tempY_highest``.
 
 		WO
 
 What:		/sys/class/hwmon/hwmonX/temp_reset_history
 Description:
-		Reset temp_lowest and temp_highest for all sensors
+		Reset ``tempY_lowest`` and ``tempY_highest`` for all sensors.
 
 		WO
 
 What:		/sys/class/hwmon/hwmonX/tempY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return -ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
 		- 1: Enable
 		- 0: Disable
@@ -558,7 +627,10 @@ What:		/sys/class/hwmon/hwmonX/tempY_rated_min
 Description:
 		Minimum rated temperature.
 
-		Unit: millidegree Celsius
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RO
 
@@ -566,13 +638,16 @@ What:		/sys/class/hwmon/hwmonX/tempY_rated_max
 Description:
 		Maximum rated temperature.
 
-		Unit: millidegree Celsius
+		In some cases, this is a voltage. Please see
+		Documentation/hwmon/sysfs-interface.rst for more details.
+
+		Unit: millidegree Celsius (or millivolt)
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/currY_max
 Description:
-		Current max value
+		Current max value.
 
 		Unit: milliampere
 
@@ -588,7 +663,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_lcrit
 Description:
-		Current critical low value
+		Current critical min value.
 
 		Unit: milliampere
 
@@ -596,7 +671,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_crit
 Description:
-		Current critical high value.
+		Current critical max value.
 
 		Unit: milliampere
 
@@ -604,7 +679,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_input
 Description:
-		Current input value
+		Current input value.
 
 		Unit: milliampere
 
@@ -612,7 +687,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_average
 Description:
-		Average current use
+		Average current use.
 
 		Unit: milliampere
 
@@ -620,7 +695,7 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_lowest
 Description:
-		Historical minimum current
+		Historical minimum current.
 
 		Unit: milliampere
 
@@ -628,27 +703,29 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/currY_highest
 Description:
-		Historical maximum current
+		Historical maximum current.
+
 		Unit: milliampere
+
 		RO
 
 What:		/sys/class/hwmon/hwmonX/currY_reset_history
 Description:
-		Reset currX_lowest and currX_highest
+		Reset ``currY_lowest`` and ``currY_highest``.
 
 		WO
 
 What:		/sys/class/hwmon/hwmonX/curr_reset_history
 Description:
-		Reset currX_lowest and currX_highest for all sensors
+		Reset ``currY_lowest`` and ``currY_highest`` for all sensors.
 
 		WO
 
 What:		/sys/class/hwmon/hwmonX/currY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return -ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
 		- 1: Enable
 		- 0: Disable
@@ -673,102 +750,105 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/powerY_average
 Description:
-		Average power use
+		Average power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_interval
 Description:
-		Power use averaging interval.  A poll
-		notification is sent to this file if the
-		hardware changes the averaging interval.
+		Power use averaging interval.
+
+		A poll notification is sent to this file if
+		the hardware changes the averaging interval.
 
-		Unit: milliseconds
+		Unit: millisecond
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_interval_max
 Description:
-		Maximum power use averaging interval
+		Maximum power use averaging interval.
 
-		Unit: milliseconds
+		Unit: millisecond
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_interval_min
 Description:
-		Minimum power use averaging interval
+		Minimum power use averaging interval.
 
-		Unit: milliseconds
+		Unit: millisecond
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_highest
 Description:
-		Historical average maximum power use
+		Historical average maximum power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_lowest
 Description:
-		Historical average minimum power use
+		Historical average minimum power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_max
 Description:
-		A poll notification is sent to
-		`powerY_average` when power use
-		rises above this value.
+		Maximum average power notification threshold.
+
+		A poll notification is sent to `powerY_average`
+		when power use rises above this value.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_average_min
 Description:
-		A poll notification is sent to
-		`powerY_average` when power use
-		sinks below this value.
+		Minimum average power notification threshold.
 
-		Unit: microWatt
+		A poll notification is sent to `powerY_average`
+		when power use sinks below this value.
+
+		Unit: microwatt
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_input
 Description:
-		Instantaneous power use
+		Instantaneous power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_input_highest
 Description:
-		Historical maximum power use
+		Historical maximum power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_input_lowest
 Description:
-		Historical minimum power use
+		Historical minimum power use.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_reset_history
 Description:
-		Reset input_highest, input_lowest,
-		average_highest and average_lowest.
+		Reset ``powerY_input_highest``, ``powerY_input_lowest``,
+		``powerY_average_highest``, and ``powerY_average_lowest``.
 
 		WO
 
@@ -776,29 +856,34 @@ What:		/sys/class/hwmon/hwmonX/powerY_accuracy
 Description:
 		Accuracy of the power meter.
 
-		Unit: Percent
+		Unit: percent
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/powerY_cap
 Description:
-		If power use rises above this limit, the
-		system should take action to reduce power use.
-		A poll notification is sent to this file if the
-		cap is changed by the hardware.  The `*_cap`
-		files only appear if the cap is known to be
-		enforced by hardware.
+		Power reduction threshold.
+
+		If power use rises above this limit, the system should
+		take action to reduce power use.
 
-		Unit: microWatt
+		A poll notification is sent to this file if the cap is
+		changed by the hardware.
+
+		The `powerY_cap` files only appear if the cap is known
+		to be enforced by hardware.
+
+		Unit: microwatt
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_cap_hyst
 Description:
-		Margin of hysteresis built around capping and
-		notification.
+		Threshold hysteresis margin.
 
-		Unit: microWatt
+		Margin of hysteresis built around capping and notification.
+
+		Unit: microwatt
 
 		RW
 
@@ -806,7 +891,7 @@ What:		/sys/class/hwmon/hwmonX/powerY_cap_max
 Description:
 		Maximum cap that can be set.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
@@ -814,7 +899,7 @@ What:		/sys/class/hwmon/hwmonX/powerY_cap_min
 Description:
 		Minimum cap that can be set.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
@@ -822,29 +907,27 @@ What:		/sys/class/hwmon/hwmonX/powerY_max
 Description:
 		Maximum power.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_crit
 Description:
-		Critical maximum power.
+		Critical power reduction threshold.
 
-		If power rises to or above this limit, the
-		system is expected take drastic action to reduce
-		power consumption, such as a system shutdown or
-		a forced powerdown of some devices.
+		If power rises to or above this limit, the system is expected
+		to take drastic action to reduce power consumption, such as a
+		system shutdown or a forced powerdown of some devices.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/powerY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return
-		-ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
 		- 1: Enable
 		- 0: Disable
@@ -855,7 +938,7 @@ What:		/sys/class/hwmon/hwmonX/powerY_rated_min
 Description:
 		Minimum rated power.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
@@ -863,24 +946,23 @@ What:		/sys/class/hwmon/hwmonX/powerY_rated_max
 Description:
 		Maximum rated power.
 
-		Unit: microWatt
+		Unit: microwatt
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/energyY_input
 Description:
-		Cumulative energy use
+		Cumulative energy use.
 
-		Unit: microJoule
+		Unit: microjoule
 
 		RO
 
 What:		/sys/class/hwmon/hwmonX/energyY_enable
 Description:
-		Enable or disable the sensors.
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return
-		-ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
 		- 1: Enable
 		- 0: Disable
@@ -889,19 +971,17 @@ Description:
 
 What:		/sys/class/hwmon/hwmonX/humidityY_input
 Description:
-		Humidity
+		Humidity.
 
-		Unit: milli-percent (per cent mille, pcm)
+		Unit: millipercent (per cent mille, pcm)
 
 		RO
 
-
 What:		/sys/class/hwmon/hwmonX/humidityY_enable
 Description:
-		Enable or disable the sensors
+		Enable or disable the sensor.
 
-		When disabled the sensor read will return
-		-ENODATA.
+		When disabled, reading the sensor returns ``-ENODATA``.
 
 		- 1: Enable
 		- 0: Disable
@@ -912,7 +992,7 @@ What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
 Description:
 		Minimum rated humidity.
 
-		Unit: milli-percent (per cent mille, pcm)
+		Unit: millipercent (per cent mille, pcm)
 
 		RO
 
@@ -920,39 +1000,40 @@ What:		/sys/class/hwmon/hwmonX/humidityY_rated_max
 Description:
 		Maximum rated humidity.
 
-		Unit: milli-percent (per cent mille, pcm)
+		Unit: millipercent (per cent mille, pcm)
 
 		RO
 
-
 What:		/sys/class/hwmon/hwmonX/intrusionY_alarm
 Description:
-		Chassis intrusion detection
-
-		- 0: OK
-		- 1: intrusion detected
-
-		RW
+		Chassis intrusion indicator.
 
 		Contrary to regular alarm flags which clear themselves
 		automatically when read, this one sticks until cleared by
 		the user. This is done by writing 0 to the file. Writing
 		other values is unsupported.
 
+		- 0: OK
+		- 1: Intrusion detected
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/intrusionY_beep
 Description:
-		Chassis intrusion beep
+		Chassis intrusion beep.
 
-		- 0: disable
-		- 1: enable
+		- 0: Disable
+		- 1: Enable
 
 		RW
 
 What:		/sys/class/hwmon/hwmonX/device/pec
 Description:
-		PEC support on I2C devices
+		PEC support on I2C devices.
 
-		- 0, off, n: disable
-		- 1, on, y: enable
+		- 0: Off
+		- 1: On
+		- n: Disable
+		- y: Enable
 
 		RW
-- 
2.34.1

