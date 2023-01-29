Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC556802BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjA2XLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 18:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 18:11:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09D1ADC2;
        Sun, 29 Jan 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hSVWChRDN+7R1q+eUNK+va/B9M97WY52yd2h5OskBp0=; b=yUv0VVi7AzeHRNOF30ohLHw5zu
        /EpIh2+vV2zjgdq1rrJGU4FU7Sqo3t43U7K9gOpKF2ubTcAqhQMdBAKf9YG61i3DRGLxb36dWzOn4
        TXERwYxHRQiAAy1QS4TbBkPJjGjssSK0oXUUkhaBVLbi5lWSYk/zdo8NTqj2ZWLFRTJGDjfc9SXCo
        hEyl0nMWxtlsPZdxJLXFFxiBry9YP3GQ2ymXTqnEEmFkjSyqg7W/xed6YUo1nzs/vQ3P3iMno43XC
        fR+uzw5JFLfCHWvOnYuSJPKJh1y/QGWAtpfsfWLJYQRzO6RHZG7xApoodt05CnWQeQCNvBJpPuS5d
        KUkWt7MA==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMGp7-0020M2-IK; Sun, 29 Jan 2023 23:10:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 3/9] Documentation: hwmon: correct spelling
Date:   Sun, 29 Jan 2023 15:10:47 -0800
Message-Id: <20230129231053.20863-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129231053.20863-1-rdunlap@infradead.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/hwmon/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/aht10.rst            |    2 +-
 Documentation/hwmon/aspeed-pwm-tacho.rst |    2 +-
 Documentation/hwmon/corsair-psu.rst      |    2 +-
 Documentation/hwmon/gsc-hwmon.rst        |    6 +++---
 Documentation/hwmon/hwmon-kernel-api.rst |    4 ++--
 Documentation/hwmon/ltc2978.rst          |    2 +-
 Documentation/hwmon/max6697.rst          |    2 +-
 Documentation/hwmon/menf21bmc.rst        |    2 +-
 Documentation/hwmon/pmbus-core.rst       |    2 +-
 Documentation/hwmon/sht4x.rst            |    2 +-
 Documentation/hwmon/smm665.rst           |    2 +-
 Documentation/hwmon/stpddc60.rst         |    2 +-
 Documentation/hwmon/vexpress.rst         |    2 +-
 Documentation/hwmon/via686a.rst          |    2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff -- a/Documentation/hwmon/aspeed-pwm-tacho.rst b/Documentation/hwmon/aspeed-pwm-tacho.rst
--- a/Documentation/hwmon/aspeed-pwm-tacho.rst
+++ b/Documentation/hwmon/aspeed-pwm-tacho.rst
@@ -10,7 +10,7 @@ Authors:
 Description:
 ------------
 This driver implements support for ASPEED AST2400/2500 PWM and Fan Tacho
-controller. The PWM controller supports upto 8 PWM outputs. The Fan tacho
+controller. The PWM controller supports up to 8 PWM outputs. The Fan tacho
 controller supports up to 16 tachometer inputs.
 
 The driver provides the following sensor accesses in sysfs:
diff -- a/Documentation/hwmon/gsc-hwmon.rst b/Documentation/hwmon/gsc-hwmon.rst
--- a/Documentation/hwmon/gsc-hwmon.rst
+++ b/Documentation/hwmon/gsc-hwmon.rst
@@ -31,7 +31,7 @@ Temperature Monitoring
 
 Temperatures are measured with 12-bit or 10-bit resolution and are scaled
 either internally or by the driver depending on the GSC version and firmware.
-The values returned by the driver reflect millidegree Celcius:
+The values returned by the driver reflect millidegree Celsius:
 
 tempX_input                Measured temperature.
 tempX_label                Name of temperature input.
@@ -41,8 +41,8 @@ PWM Output Control
 ------------------
 
 The GSC features 1 PWM output that operates in automatic mode where the
-PWM value will be scalled depending on 6 temperature boundaries.
-The tempeature boundaries are read-write and in millidegree Celcius and the
+PWM value will be scaled depending on 6 temperature boundaries.
+The tempeature boundaries are read-write and in millidegree Celsius and the
 read-only PWM values range from 0 (off) to 255 (full speed).
 Fan speed will be set to minimum (off) when the temperature sensor reads
 less than pwm1_auto_point1_temp and maximum when the temperature sensor
diff -- a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
--- a/Documentation/hwmon/sht4x.rst
+++ b/Documentation/hwmon/sht4x.rst
@@ -37,7 +37,7 @@ Sysfs entries
 -------------
 
 =============== ============================================
-temp1_input     Measured temperature in millidegrees Celcius
+temp1_input     Measured temperature in millidegrees Celsius
 humidity1_input Measured humidity in %H
 update_interval The minimum interval for polling the sensor,
                 in milliseconds. Writable. Must be at least
diff -- a/Documentation/hwmon/stpddc60.rst b/Documentation/hwmon/stpddc60.rst
--- a/Documentation/hwmon/stpddc60.rst
+++ b/Documentation/hwmon/stpddc60.rst
@@ -39,7 +39,7 @@ output voltage as a positive or negative
 in 50mV steps. This means that the absolute values of the limits will change
 when the commanded output voltage changes. Also, care should be taken when
 writing to those limits since in the worst case the commanded output voltage
-could change at the same time as the limit is written to, wich will lead to
+could change at the same time as the limit is written to, which will lead to
 unpredictable results.
 
 
diff -- a/Documentation/hwmon/smm665.rst b/Documentation/hwmon/smm665.rst
--- a/Documentation/hwmon/smm665.rst
+++ b/Documentation/hwmon/smm665.rst
@@ -180,7 +180,7 @@ in9_crit_alarm		AIN1 critical alarm
 in10_crit_alarm		AIN2 critical alarm
 
 temp1_input		Chip temperature
-temp1_min		Mimimum chip temperature
+temp1_min		Minimum chip temperature
 temp1_max		Maximum chip temperature
 temp1_crit		Critical chip temperature
 temp1_crit_alarm	Temperature critical alarm
diff -- a/Documentation/hwmon/via686a.rst b/Documentation/hwmon/via686a.rst
--- a/Documentation/hwmon/via686a.rst
+++ b/Documentation/hwmon/via686a.rst
@@ -58,7 +58,7 @@ representable value is around 2600 RPM.
 
 Voltage sensors (also known as IN sensors) report their values in volts.
 An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit. Voltages are internally scalled, so each voltage channel
+or maximum limit. Voltages are internally scaled, so each voltage channel
 has a different resolution and range.
 
 If an alarm triggers, it will remain triggered until the hardware register
diff -- a/Documentation/hwmon/aht10.rst b/Documentation/hwmon/aht10.rst
--- a/Documentation/hwmon/aht10.rst
+++ b/Documentation/hwmon/aht10.rst
@@ -38,7 +38,7 @@ Sysfs entries
 -------------
 
 =============== ============================================
-temp1_input     Measured temperature in millidegrees Celcius
+temp1_input     Measured temperature in millidegrees Celsius
 humidity1_input Measured humidity in %H
 update_interval The minimum interval for polling the sensor,
                 in milliseconds. Writable. Must be at
diff -- a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -40,7 +40,7 @@ This driver implements the sysfs interfa
 interface of the HXi and RMi series.
 These power supplies provide access to a micro-controller with 2 attached
 temperature sensors, 1 fan rpm sensor, 4 sensors for volt levels, 4 sensors for
-power usage and 4 sensors for current levels and addtional non-sensor information
+power usage and 4 sensors for current levels and additional non-sensor information
 like uptimes.
 
 Sysfs entries
diff -- a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -57,7 +57,7 @@ register/unregister functions::
 hwmon_device_register_with_groups registers a hardware monitoring device.
 The first parameter of this function is a pointer to the parent device.
 The name parameter is a pointer to the hwmon device name. The registration
-function wil create a name sysfs attribute pointing to this name.
+function will create a name sysfs attribute pointing to this name.
 The drvdata parameter is the pointer to the local driver data.
 hwmon_device_register_with_groups will attach this pointer to the newly
 allocated hwmon device. The pointer can be retrieved by the driver using
@@ -360,7 +360,7 @@ functions is used.
 The header file linux/hwmon-sysfs.h provides a number of useful macros to
 declare and use hardware monitoring sysfs attributes.
 
-In many cases, you can use the exsting define DEVICE_ATTR or its variants
+In many cases, you can use the existing define DEVICE_ATTR or its variants
 DEVICE_ATTR_{RW,RO,WO} to declare such attributes. This is feasible if an
 attribute has no additional context. However, in many cases there will be
 additional information such as a sensor index which will need to be passed
diff -- a/Documentation/hwmon/ltc2978.rst b/Documentation/hwmon/ltc2978.rst
--- a/Documentation/hwmon/ltc2978.rst
+++ b/Documentation/hwmon/ltc2978.rst
@@ -333,7 +333,7 @@ temp[N]_input		Measured temperature.
 			- On LTC3883, temp1 reports an external temperature,
 			  and temp2 reports the chip temperature.
 
-temp[N]_min		Mimimum temperature.
+temp[N]_min		Minimum temperature.
 
 			LTC2972, LTC2974, LCT2977, LTM2980, LTC2978,
 			LTC2979, and LTM2987 only.
diff -- a/Documentation/hwmon/max6697.rst b/Documentation/hwmon/max6697.rst
--- a/Documentation/hwmon/max6697.rst
+++ b/Documentation/hwmon/max6697.rst
@@ -73,7 +73,7 @@ Description
 This driver implements support for several MAX6697 compatible temperature sensor
 chips. The chips support one local temperature sensor plus four, six, or seven
 remote temperature sensors. Remote temperature sensors are diode-connected
-thermal transitors, except for MAX6698 which supports three diode-connected
+thermal transistors, except for MAX6698 which supports three diode-connected
 thermal transistors plus three thermistors in addition to the local temperature
 sensor.
 
diff -- a/Documentation/hwmon/menf21bmc.rst b/Documentation/hwmon/menf21bmc.rst
--- a/Documentation/hwmon/menf21bmc.rst
+++ b/Documentation/hwmon/menf21bmc.rst
@@ -7,7 +7,7 @@ Supported chips:
 
 	  Prefix: 'menf21bmc_hwmon'
 
-	  Adresses scanned: -
+	  Addresses scanned: -
 
 Author: Andreas Werner <andreas.werner@men.de>
 
diff -- a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
--- a/Documentation/hwmon/pmbus-core.rst
+++ b/Documentation/hwmon/pmbus-core.rst
@@ -174,7 +174,7 @@ Read byte from page <page>, register <re
   int (*read_word_data)(struct i2c_client *client, int page, int phase,
                         int reg);
 
-Read word from page <page>, phase <pase>, register <reg>. If the chip does not
+Read word from page <page>, phase <phase>, register <reg>. If the chip does not
 support multiple phases, the phase parameter can be ignored. If the chip
 supports multiple phases, a phase value of 0xff indicates all phases.
 
diff -- a/Documentation/hwmon/vexpress.rst b/Documentation/hwmon/vexpress.rst
--- a/Documentation/hwmon/vexpress.rst
+++ b/Documentation/hwmon/vexpress.rst
@@ -27,7 +27,7 @@ Versatile Express platform (http://www.a
 reference & prototyping system for ARM Ltd. processors. It can be set up
 from a wide range of boards, each of them containing (apart of the main
 chip/FPGA) a number of microcontrollers responsible for platform
-configuration and control. Theses microcontrollers can also monitor the
+configuration and control. These microcontrollers can also monitor the
 board and its environment by a number of internal and external sensors,
 providing information about power lines voltages and currents, board
 temperature and power usage. Some of them also calculate consumed energy
