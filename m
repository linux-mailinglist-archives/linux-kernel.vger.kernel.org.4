Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EC682A76
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAaK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAaK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:26:40 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643A17CD4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:26:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:fd54:3eff:f16a:8c82])
        by baptiste.telenet-ops.be with bizsmtp
        id FNSa2900B3oGUMV01NSaDd; Tue, 31 Jan 2023 11:26:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pMnqG-007vjW-8v;
        Tue, 31 Jan 2023 11:26:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pMnqU-000NPv-6X;
        Tue, 31 Jan 2023 11:26:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] thermal: Drop spaces before TABs
Date:   Tue, 31 Jan 2023 11:26:32 +0100
Message-Id: <cda2b9ee52a49fa3904d209097754cd757728a4f.1675160668.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is never a need to have a space before a TAB, but they hurt the
eyes of vim users.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/thermal/Makefile               |  2 +-
 drivers/thermal/st/st_thermal.h        | 18 +++++++++---------
 drivers/thermal/st/st_thermal_memmap.c |  2 +-
 drivers/thermal/st/st_thermal_syscfg.c |  2 +-
 drivers/thermal/thermal_of.c           |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 60f0dfa9aae241df..d8f1ab250cb1a1f8 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
-obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
+obj-$(CONFIG_DOVE_THERMAL)	+= dove_thermal.o
 obj-$(CONFIG_DB8500_THERMAL)	+= db8500_thermal.o
 obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
diff --git a/drivers/thermal/st/st_thermal.h b/drivers/thermal/st/st_thermal.h
index d661b2f2ef29f2c5..0e819ee93bbd54b0 100644
--- a/drivers/thermal/st/st_thermal.h
+++ b/drivers/thermal/st/st_thermal.h
@@ -38,10 +38,10 @@ struct st_thermal_sensor;
  *
  * @power_ctrl:		Function for powering on/off a sensor. Clock to the
  *			sensor is also controlled from this function.
- * @alloc_regfields: 	Allocate regmap register fields, specific to a sensor.
- * @do_memmap_regmap: 	Memory map the thermal register space and init regmap
+ * @alloc_regfields:	Allocate regmap register fields, specific to a sensor.
+ * @do_memmap_regmap:	Memory map the thermal register space and init regmap
  *			instance or find regmap instance.
- * @register_irq: 	Register an interrupt handler for a sensor.
+ * @register_irq:	Register an interrupt handler for a sensor.
  */
 struct st_thermal_sensor_ops {
 	int (*power_ctrl)(struct st_thermal_sensor *, enum st_thermal_power_state);
@@ -56,15 +56,15 @@ struct st_thermal_sensor_ops {
  *
  * @reg_fields:		Pointer to the regfields array for a sensor.
  * @sys_compat:		Pointer to the syscon node compatible string.
- * @ops: 		Pointer to private thermal ops for a sensor.
- * @calibration_val: 	Default calibration value to be written to the DCORRECT
+ * @ops:		Pointer to private thermal ops for a sensor.
+ * @calibration_val:	Default calibration value to be written to the DCORRECT
  *			register field for a sensor.
- * @temp_adjust_val: 	Value to be added/subtracted from the data read from
+ * @temp_adjust_val:	Value to be added/subtracted from the data read from
  *			the sensor. If value needs to be added please provide a
  *			positive value and if it is to be subtracted please
- * 			provide a negative value.
- * @crit_temp: 		The temperature beyond which the SoC should be shutdown
- * 			to prevent damage.
+ *			provide a negative value.
+ * @crit_temp:		The temperature beyond which the SoC should be shutdown
+ *			to prevent damage.
  */
 struct st_thermal_compat_data {
 	char *sys_compat;
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index d68596c40be99009..7266d0d74fd8d3cf 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -27,7 +27,7 @@ static const struct reg_field st_mmap_thermal_regfields[MAX_REGFIELDS] = {
 	 * written simultaneously for powering on and off the temperature
 	 * sensor. regmap_update_bits() will be used to update the register.
 	 */
-	[INT_THRESH_HI]	= REG_FIELD(STIH416_MPE_INT_THRESH, 	0,  7),
+	[INT_THRESH_HI]	= REG_FIELD(STIH416_MPE_INT_THRESH,	0,  7),
 	[DCORRECT]	= REG_FIELD(STIH416_MPE_CONF,		5,  9),
 	[OVERFLOW]	= REG_FIELD(STIH416_MPE_STATUS,		9,  9),
 	[DATA]		= REG_FIELD(STIH416_MPE_STATUS,		11, 18),
diff --git a/drivers/thermal/st/st_thermal_syscfg.c b/drivers/thermal/st/st_thermal_syscfg.c
index 94efecf35cf83c2d..1106be5a1eded52e 100644
--- a/drivers/thermal/st/st_thermal_syscfg.c
+++ b/drivers/thermal/st/st_thermal_syscfg.c
@@ -35,7 +35,7 @@ static const struct reg_field st_415sas_regfields[MAX_REGFIELDS] = {
 	[TEMP_PWR] = REG_FIELD(STIH415_SAS_THSENS_CONF,   9,  9),
 	[DCORRECT] = REG_FIELD(STIH415_SAS_THSENS_CONF,   4,  8),
 	[OVERFLOW] = REG_FIELD(STIH415_SAS_THSENS_STATUS, 8,  8),
-	[DATA] 	   = REG_FIELD(STIH415_SAS_THSENS_STATUS, 10, 16),
+	[DATA]	   = REG_FIELD(STIH415_SAS_THSENS_STATUS, 10, 16),
 };
 
 static const struct reg_field st_415mpe_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index ff4d12ef51bcb6ed..8f4d5d671def1258 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -469,7 +469,7 @@ EXPORT_SYMBOL_GPL(thermal_of_zone_unregister);
  * @ops: A set of thermal sensor ops
  *
  * Return: a valid thermal zone structure pointer on success.
- * 	- EINVAL: if the device tree thermal description is malformed
+ *	- EINVAL: if the device tree thermal description is malformed
  *	- ENOMEM: if one structure can not be allocated
  *	- Other negative errors are returned by the underlying called functions
  */
-- 
2.34.1

