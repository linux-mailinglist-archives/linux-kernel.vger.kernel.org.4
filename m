Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285AF643BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiLFDQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiLFDQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:16:24 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7A22B2B;
        Mon,  5 Dec 2022 19:16:18 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NR5D04l4Jz4y0v9;
        Tue,  6 Dec 2022 11:16:16 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B63G7iu068075;
        Tue, 6 Dec 2022 11:16:07 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 11:16:08 +0800 (CST)
Date:   Tue, 6 Dec 2022 11:16:08 +0800 (CST)
X-Zmail-TransId: 2af9638eb3f85e275bd0
X-Mailer: Zmail v1.0
Message-ID: <202212061116089380072@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sre@kernel.org>
Cc:     <linus.walleij@linaro.org>, <pali@kernel.org>,
        <bleung@chromium.org>, <groeck@chromium.org>,
        <sravanhome@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <patches@opensource.cirrus.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VyOiBzdXBwbHk6IGNvbnZlcnQgc3ByaW50ZiB3aXRoIHN5c2ZzX2VtaXQoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B63G7iu068075
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638EB400.000 by FangMail milter!
X-FangMail-Envelope: 1670296576/4NR5D04l4Jz4y0v9/638EB400.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638EB400.000/4NR5D04l4Jz4y0v9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/power/supply/ab8500_fg.c          |  4 +--
 drivers/power/supply/bq2415x_charger.c    | 44 +++++++++++------------
 drivers/power/supply/charger-manager.c    |  6 ++--
 drivers/power/supply/cros_usbpd-charger.c |  4 +--
 drivers/power/supply/ds2780_battery.c     |  8 ++---
 drivers/power/supply/ds2781_battery.c     |  8 ++---
 drivers/power/supply/isp1704_charger.c    |  2 +-
 drivers/power/supply/ltc4162-l-charger.c  | 12 +++----
 drivers/power/supply/mp2629_charger.c     |  2 +-
 drivers/power/supply/olpc_battery.c       |  4 +--
 drivers/power/supply/pcf50633-charger.c   |  6 ++--
 drivers/power/supply/pmu_battery.c        |  2 +-
 drivers/power/supply/power_supply_sysfs.c | 12 +++----
 drivers/power/supply/sbs-battery.c        |  2 +-
 drivers/power/supply/test_power.c         | 12 +++----
 drivers/power/supply/wm8350_power.c       |  2 +-
 16 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index d989eadaa933..41a7bff9ac37 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2453,7 +2453,7 @@ struct ab8500_fg_sysfs_entry {

 static ssize_t charge_full_show(struct ab8500_fg *di, char *buf)
 {
-	return sprintf(buf, "%d\n", di->bat_cap.max_mah);
+	return sysfs_emit(buf, "%d\n", di->bat_cap.max_mah);
 }

 static ssize_t charge_full_store(struct ab8500_fg *di, const char *buf,
@@ -2472,7 +2472,7 @@ static ssize_t charge_full_store(struct ab8500_fg *di, const char *buf,

 static ssize_t charge_now_show(struct ab8500_fg *di, char *buf)
 {
-	return sprintf(buf, "%d\n", di->bat_cap.prev_mah);
+	return sysfs_emit(buf, "%d\n", di->bat_cap.prev_mah);
 }

 static ssize_t charge_now_store(struct ab8500_fg *di, const char *buf,
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index d2cb7431dced..0e8bbc2e3e07 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1059,7 +1059,7 @@ static ssize_t bq2415x_sysfs_show_status(struct device *dev,
 	ret = bq2415x_exec_command(bq, command);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }

 /*
@@ -1098,11 +1098,11 @@ static ssize_t bq2415x_sysfs_show_timer(struct device *dev,
 	struct bq2415x_device *bq = power_supply_get_drvdata(psy);

 	if (bq->timer_error)
-		return sprintf(buf, "%s\n", bq->timer_error);
+		return sysfs_emit(buf, "%s\n", bq->timer_error);

 	if (bq->autotimer)
-		return sprintf(buf, "auto\n");
-	return sprintf(buf, "off\n");
+		return sysfs_emit(buf, "auto\n");
+	return sysfs_emit(buf, "off\n");
 }

 /*
@@ -1175,30 +1175,30 @@ static ssize_t bq2415x_sysfs_show_mode(struct device *dev,
 	ssize_t ret = 0;

 	if (bq->automode > 0)
-		ret += sprintf(buf+ret, "auto (");
+		ret += sysfs_emit_at(buf, ret, "auto (");

 	switch (bq->mode) {
 	case BQ2415X_MODE_OFF:
-		ret += sprintf(buf+ret, "off");
+		ret += sysfs_emit_at(buf, ret, "off");
 		break;
 	case BQ2415X_MODE_NONE:
-		ret += sprintf(buf+ret, "none");
+		ret += sysfs_emit_at(buf, ret, "none");
 		break;
 	case BQ2415X_MODE_HOST_CHARGER:
-		ret += sprintf(buf+ret, "host");
+		ret += sysfs_emit_at(buf, ret, "host");
 		break;
 	case BQ2415X_MODE_DEDICATED_CHARGER:
-		ret += sprintf(buf+ret, "dedicated");
+		ret += sysfs_emit_at(buf, ret, "dedicated");
 		break;
 	case BQ2415X_MODE_BOOST:
-		ret += sprintf(buf+ret, "boost");
+		ret += sysfs_emit_at(buf, ret, "boost");
 		break;
 	}

 	if (bq->automode > 0)
-		ret += sprintf(buf+ret, ")");
+		ret += sysfs_emit_at(buf, ret, ")");

-	ret += sprintf(buf+ret, "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }

@@ -1215,15 +1215,15 @@ static ssize_t bq2415x_sysfs_show_reported_mode(struct device *dev,

 	switch (bq->reported_mode) {
 	case BQ2415X_MODE_OFF:
-		return sprintf(buf, "off\n");
+		return sysfs_emit(buf, "off\n");
 	case BQ2415X_MODE_NONE:
-		return sprintf(buf, "none\n");
+		return sysfs_emit(buf, "none\n");
 	case BQ2415X_MODE_HOST_CHARGER:
-		return sprintf(buf, "host\n");
+		return sysfs_emit(buf, "host\n");
 	case BQ2415X_MODE_DEDICATED_CHARGER:
-		return sprintf(buf, "dedicated\n");
+		return sysfs_emit(buf, "dedicated\n");
 	case BQ2415X_MODE_BOOST:
-		return sprintf(buf, "boost\n");
+		return sysfs_emit(buf, "boost\n");
 	}

 	return -EINVAL;
@@ -1261,8 +1261,8 @@ static ssize_t bq2415x_sysfs_print_reg(struct bq2415x_device *bq,
 	int ret = bq2415x_i2c_read(bq, reg);

 	if (ret < 0)
-		return sprintf(buf, "%#.2x=error %d\n", reg, ret);
-	return sprintf(buf, "%#.2x=%#.2x\n", reg, ret);
+		return sysfs_emit(buf, "%#.2x=error %d\n", reg, ret);
+	return sysfs_emit(buf, "%#.2x=%#.2x\n", reg, ret);
 }

 /* show all raw values of chip register, format per line: 'register=value' */
@@ -1338,7 +1338,7 @@ static ssize_t bq2415x_sysfs_show_limit(struct device *dev,

 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }

 /* set *_enable entries */
@@ -1401,7 +1401,7 @@ static ssize_t bq2415x_sysfs_show_enable(struct device *dev,
 	ret = bq2415x_exec_command(bq, command);
 	if (ret < 0)
 		return ret;
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }

 static DEVICE_ATTR(current_limit, S_IWUSR | S_IRUGO,
@@ -1498,7 +1498,7 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 	if (ret < 0)
 		strcpy(revstr, "unknown");
 	else
-		sprintf(revstr, "1.%d", ret);
+		sysfs_emit(revstr, "1.%d", ret);

 	bq->model = kasprintf(GFP_KERNEL,
 				"chip %s, revision %s, vender code %.3d",
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 92db79400a6a..c9e8450c646f 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1075,7 +1075,7 @@ static ssize_t charger_name_show(struct device *dev,
 	struct charger_regulator *charger
 		= container_of(attr, struct charger_regulator, attr_name);

-	return sprintf(buf, "%s\n", charger->regulator_name);
+	return sysfs_emit(buf, "%s\n", charger->regulator_name);
 }

 static ssize_t charger_state_show(struct device *dev,
@@ -1088,7 +1088,7 @@ static ssize_t charger_state_show(struct device *dev,
 	if (!charger->externally_control)
 		state = regulator_is_enabled(charger->consumer);

-	return sprintf(buf, "%s\n", state ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
 }

 static ssize_t charger_externally_control_show(struct device *dev,
@@ -1097,7 +1097,7 @@ static ssize_t charger_externally_control_show(struct device *dev,
 	struct charger_regulator *charger = container_of(attr,
 			struct charger_regulator, attr_externally_control);

-	return sprintf(buf, "%d\n", charger->externally_control);
+	return sysfs_emit(buf, "%d\n", charger->externally_control);
 }

 static ssize_t charger_externally_control_store(struct device *dev,
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index cadb6a0c2cc7..effd5dc4eb79 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -630,14 +630,14 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 		psy_cfg.drv_data = port;

 		if (cros_usbpd_charger_port_is_dedicated(port)) {
-			sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
+			sysfs_emit(port->name, CHARGER_DEDICATED_DIR_NAME);
 			psy_desc->type = POWER_SUPPLY_TYPE_MAINS;
 			psy_desc->properties =
 				cros_usbpd_dedicated_charger_props;
 			psy_desc->num_properties =
 				ARRAY_SIZE(cros_usbpd_dedicated_charger_props);
 		} else {
-			sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
+			sysfs_emit(port->name, CHARGER_USBPD_DIR_NAME, i);
 			psy_desc->type = POWER_SUPPLY_TYPE_USB;
 			psy_desc->properties = cros_usbpd_charger_props;
 			psy_desc->num_properties =
diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 2b8c90d84325..1e7f297f6cb1 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -454,7 +454,7 @@ static ssize_t ds2780_get_pmod_enabled(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		 !!(control_reg & DS2780_CONTROL_REG_PMOD));
 }

@@ -507,7 +507,7 @@ static ssize_t ds2780_get_sense_resistor_value(struct device *dev,
 	if (ret < 0)
 		return ret;

-	ret = sprintf(buf, "%d\n", sense_resistor);
+	ret = sysfs_emit(buf, "%d\n", sense_resistor);
 	return ret;
 }

@@ -545,7 +545,7 @@ static ssize_t ds2780_get_rsgain_setting(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return sprintf(buf, "%d\n", rsgain);
+	return sysfs_emit(buf, "%d\n", rsgain);
 }

 static ssize_t ds2780_set_rsgain_setting(struct device *dev,
@@ -588,7 +588,7 @@ static ssize_t ds2780_get_pio_pin(struct device *dev,
 	if (ret < 0)
 		return ret;

-	ret = sprintf(buf, "%d\n", sfr & DS2780_SFR_REG_PIOSC);
+	ret = sysfs_emit(buf, "%d\n", sfr & DS2780_SFR_REG_PIOSC);
 	return ret;
 }

diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 05b859bf2dc0..c4f8ccc687f9 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -456,7 +456,7 @@ static ssize_t ds2781_get_pmod_enabled(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return sprintf(buf, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 		 !!(control_reg & DS2781_CONTROL_PMOD));
 }

@@ -509,7 +509,7 @@ static ssize_t ds2781_get_sense_resistor_value(struct device *dev,
 	if (ret < 0)
 		return ret;

-	ret = sprintf(buf, "%d\n", sense_resistor);
+	ret = sysfs_emit(buf, "%d\n", sense_resistor);
 	return ret;
 }

@@ -547,7 +547,7 @@ static ssize_t ds2781_get_rsgain_setting(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return sprintf(buf, "%d\n", rsgain);
+	return sysfs_emit(buf, "%d\n", rsgain);
 }

 static ssize_t ds2781_set_rsgain_setting(struct device *dev,
@@ -590,7 +590,7 @@ static ssize_t ds2781_get_pio_pin(struct device *dev,
 	if (ret < 0)
 		return ret;

-	ret = sprintf(buf, "%d\n", sfr & DS2781_SFR_PIOSC);
+	ret = sysfs_emit(buf, "%d\n", sfr & DS2781_SFR_PIOSC);
 	return ret;
 }

diff --git a/drivers/power/supply/isp1704_charger.c b/drivers/power/supply/isp1704_charger.c
index b6efc454e4f0..7e82b0c17672 100644
--- a/drivers/power/supply/isp1704_charger.c
+++ b/drivers/power/supply/isp1704_charger.c
@@ -367,7 +367,7 @@ static inline int isp1704_test_ulpi(struct isp1704_charger *isp)

 	for (i = 0; i < ARRAY_SIZE(isp170x_id); i++) {
 		if (product == isp170x_id[i]) {
-			sprintf(isp->model, "isp%x", product);
+			sysfs_emit(isp->model, "isp%x", product);
 			return product;
 		}
 	}
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index db2bb5233570..0e95c65369b8 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -525,7 +525,7 @@ static ssize_t charge_status_show(struct device *dev,
 		}
 	}

-	return sprintf(buf, "%s\n", result);
+	return sysfs_emit(buf, "%s\n", result);
 }
 static DEVICE_ATTR_RO(charge_status);

@@ -541,7 +541,7 @@ static ssize_t vbat_show(struct device *dev,
 	if (ret)
 		return ret;

-	return sprintf(buf, "%d\n", val.intval);
+	return sysfs_emit(buf, "%d\n", val.intval);
 }
 static DEVICE_ATTR_RO(vbat);

@@ -557,7 +557,7 @@ static ssize_t vbat_avg_show(struct device *dev,
 	if (ret)
 		return ret;

-	return sprintf(buf, "%d\n", val.intval);
+	return sysfs_emit(buf, "%d\n", val.intval);
 }
 static DEVICE_ATTR_RO(vbat_avg);

@@ -573,7 +573,7 @@ static ssize_t ibat_show(struct device *dev,
 	if (ret)
 		return ret;

-	return sprintf(buf, "%d\n", val.intval);
+	return sysfs_emit(buf, "%d\n", val.intval);
 }
 static DEVICE_ATTR_RO(ibat);

@@ -589,7 +589,7 @@ static ssize_t force_telemetry_show(struct device *dev,
 	if (ret)
 		return ret;

-	return sprintf(buf, "%u\n", regval & BIT(2) ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", regval & BIT(2) ? 1 : 0);
 }

 static ssize_t force_telemetry_store(struct device *dev,
@@ -628,7 +628,7 @@ static ssize_t arm_ship_mode_show(struct device *dev,
 	if (ret)
 		return ret;

-	return sprintf(buf, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 		regval == LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
 }

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index bf9c27b463a8..3a2a28fbba73 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -519,7 +519,7 @@ static ssize_t batt_impedance_compensation_show(struct device *dev,
 		return ret;

 	rval = (rval >> 4) * 10;
-	return sprintf(buf, "%d mohm\n", rval);
+	return sysfs_emit(buf, "%d mohm\n", rval);
 }

 static ssize_t batt_impedance_compensation_store(struct device *dev,
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index a5da20ffd685..4751e5e6b3b2 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -460,7 +460,7 @@ static int olpc_bat_get_property(struct power_supply *psy,
 		if (ret)
 			return ret;

-		sprintf(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
+		sysfs_emit(data->bat_serial, "%016llx", (long long)be64_to_cpu(ser_buf));
 		val->strval = data->bat_serial;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
@@ -568,7 +568,7 @@ static ssize_t olpc_bat_error_read(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return sprintf(buf, "%d\n", ec_byte);
+	return sysfs_emit(buf, "%d\n", ec_byte);
 }

 static struct device_attribute olpc_bat_error = {
diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index 8c5d892f6350..fd44cb8ac0e2 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -153,7 +153,7 @@ show_chgmode(struct device *dev, struct device_attribute *attr, char *buf)
 	u8 mbcs2 = pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCS2);
 	u8 chgmod = (mbcs2 & PCF50633_MBCS2_MBC_MASK);

-	return sprintf(buf, "%d\n", chgmod);
+	return sysfs_emit(buf, "%d\n", chgmod);
 }
 static DEVICE_ATTR(chgmode, S_IRUGO, show_chgmode, NULL);

@@ -174,7 +174,7 @@ show_usblim(struct device *dev, struct device_attribute *attr, char *buf)
 	else
 		ma = 0;

-	return sprintf(buf, "%u\n", ma);
+	return sysfs_emit(buf, "%u\n", ma);
 }

 static ssize_t set_usblim(struct device *dev,
@@ -207,7 +207,7 @@ show_chglim(struct device *dev, struct device_attribute *attr, char *buf)

 	ma = (mbc->pcf->pdata->charger_reference_current_ma *  mbcc5) >> 8;

-	return sprintf(buf, "%u\n", ma);
+	return sysfs_emit(buf, "%u\n", ma);
 }

 static ssize_t set_chglim(struct device *dev,
diff --git a/drivers/power/supply/pmu_battery.c b/drivers/power/supply/pmu_battery.c
index eaab7500d99b..623a4e80a21f 100644
--- a/drivers/power/supply/pmu_battery.c
+++ b/drivers/power/supply/pmu_battery.c
@@ -165,7 +165,7 @@ static int __init pmu_bat_init(void)
 		if (!pbat)
 			break;

-		sprintf(pbat->name, "PMU_battery_%d", i);
+		sysfs_emit(pbat->name, "PMU_battery_%d", i);
 		pbat->bat_desc.name = pbat->name;
 		pbat->bat_desc.properties = pmu_bat_props;
 		pbat->bat_desc.num_properties = ARRAY_SIZE(pmu_bat_props);
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 6ca7d3985a40..9915b701c894 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -249,11 +249,11 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 		usb_type = desc->usb_types[i];

 		if (value->intval == usb_type) {
-			count += sprintf(buf + count, "[%s] ",
+			count += sysfs_emit_at(buf, count, "[%s] ",
 					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
 			match = true;
 		} else {
-			count += sprintf(buf + count, "%s ",
+			count += sysfs_emit_at(buf, count, "%s ",
 					 POWER_SUPPLY_USB_TYPE_TEXT[usb_type]);
 		}
 	}
@@ -297,7 +297,7 @@ static ssize_t power_supply_show_property(struct device *dev,

 	if (ps_attr->text_values_len > 0 &&
 	    value.intval < ps_attr->text_values_len && value.intval >= 0) {
-		return sprintf(buf, "%s\n", ps_attr->text_values[value.intval]);
+		return sysfs_emit(buf, "%s\n", ps_attr->text_values[value.intval]);
 	}

 	switch (psp) {
@@ -306,10 +306,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 						&value, buf);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
-		ret = sprintf(buf, "%s\n", value.strval);
+		ret = sysfs_emit(buf, "%s\n", value.strval);
 		break;
 	default:
-		ret = sprintf(buf, "%d\n", value.intval);
+		ret = sysfs_emit(buf, "%d\n", value.intval);
 	}

 	return ret;
@@ -413,7 +413,7 @@ void power_supply_init_attrs(struct device_type *dev_type)
 		if (!power_supply_attrs[i].prop_name) {
 			pr_warn("%s: Property %d skipped because it is missing from power_supply_attrs\n",
 				__func__, i);
-			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
+			sysfs_emit(power_supply_attrs[i].attr_name, "_err_%d", i);
 		} else {
 			str_to_lower(power_supply_attrs[i].attr_name);
 		}
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index c4a95b01463a..2a9fa843707e 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -830,7 +830,7 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
 	if (ret < 0)
 		return ret;

-	sprintf(sbs_serial, "%04x", ret);
+	sysfs_emit(sbs_serial, "%04x", ret);
 	val->strval = sbs_serial;

 	return 0;
diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 5f510ddc946d..751c9b0f4adf 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -352,7 +352,7 @@ static int param_set_ac_online(const char *key, const struct kernel_param *kp)

 static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, ac_online, "unknown"));
 }

@@ -365,7 +365,7 @@ static int param_set_usb_online(const char *key, const struct kernel_param *kp)

 static int param_get_usb_online(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, usb_online, "unknown"));
 }

@@ -379,7 +379,7 @@ static int param_set_battery_status(const char *key,

 static int param_get_battery_status(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, battery_status, "unknown"));
 }

@@ -393,7 +393,7 @@ static int param_set_battery_health(const char *key,

 static int param_get_battery_health(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, battery_health, "unknown"));
 }

@@ -408,7 +408,7 @@ static int param_set_battery_present(const char *key,
 static int param_get_battery_present(char *buffer,
 					const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, battery_present, "unknown"));
 }

@@ -424,7 +424,7 @@ static int param_set_battery_technology(const char *key,
 static int param_get_battery_technology(char *buffer,
 					const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n",
+	return sysfs_emit(buffer, "%s\n",
 			map_get_key(map_ac_online, battery_technology,
 					"unknown"));
 }
diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index 908cfd45d262..f2786761299c 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -176,7 +176,7 @@ static ssize_t charger_state_show(struct device *dev,
 		return 0;
 	}

-	return sprintf(buf, "%s\n", charge);
+	return sysfs_emit(buf, "%s\n", charge);
 }

 static DEVICE_ATTR_RO(charger_state);
-- 
2.25.1
