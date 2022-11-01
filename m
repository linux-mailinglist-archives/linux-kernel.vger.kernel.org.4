Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1445614756
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKAJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKAJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:59:37 -0400
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C808A14087
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:59:35 -0700 (PDT)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <glazveze@delta.nl>)
        id 1opmgT-0006Dr-4K; Tue, 01 Nov 2022 09:31:56 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Tue,  1 Nov 2022 09:31:39 +0100 (CET)
From:   glazveze@delta.nl
To:     linux-rtc@vger.kernel.org
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rtc: ds1307: Add support for Epson RX8111
Date:   Tue,  1 Nov 2022 09:31:22 +0100
Message-Id: <20221101083123.11695-2-glazveze@delta.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101083123.11695-1-glazveze@delta.nl>
References: <20221101083123.11695-1-glazveze@delta.nl>
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (2.89810905447e-05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+ZRGfk0At9Ike/xfAhHowcPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wqSBOxlRVmV45FJ8CYZCUIt8C9mOBdONdnsxgsk1D2pwpi
 79/9lCWegUcH0YAeiESZu3hhVxUr+XbzYNuhZTyMN2jRpXv406oGDMCZBpfLj6tXYKbjfBt0vNkw
 cgcqpVi2EeDr8t3Z6zKdUQQxqR+SarWVngVq5vG8OaFuy65RvR2mlP2W9u+agdcanH6cUDPhtIdB
 kUNQyNMiiqabnglhcXCN1jpoyjx2M7Im+CZAXFY+5adZvWXoGLcQcb78Eui+mtbuPAbQ+aWD8hhQ
 CZMTEEe1sLzznCY3CGPOzCfYYPbQTl/SJIDeIbJV6Zcf430jRGDmKiHQCBmbL4/kVA5ilfR3t3lk
 efZwj1OjoVRNk0OBtfs8eND145V556pRoeWoiZFW8yMEtAB+QqbWN455cayBalMzNiQi+IaP6Ip3
 l1/Gfk/thginq2iQcOP+mMhCFzRIiEpzynty7G1sAhwpazrLOzVL2cm1v+nUTthXE4PZdr6INmo5
 IO5sXBWBIKP+Xt1YVt34tXjgAnyScrZDbgZGFmIP8t6jENaJPnk2Q0EqJ2YhaHYKPX4HHcW4fmLf
 d77XZbPqWAY81T0FayDkAbOrs4FPMK+W+hB4jPTBjMy+REZzZZBkbyPIV/jp5XA84mAL2fYZt/ag
 6cJYhE+JR1THjBWZFF00ALVWc/sntqhVr03UHlrscRrHorFm3BMamUdylUIKhf3z2GAHxH7Inwey
 uebMOAyd9KE1KnR6Q/uNUZtOoISscGZbnZWaYNZOLDTtebGvOVlNWIOgzjpYs6oM5c5v6nO6dxgr
 nLgL2IFyOv5cAKYGRAn40Vzq1+FjVbTBFy0HmZ7j54j5nbTw0F2VAitLyFstLTVGwdoo+nbOFKKz
 xACo90vCZrfvMYKWPHYo9X+hHrxPABGbYgYFQMAJdpT8SBGMx9Hio+WRxFDvx3zE1+CEGnCvOf5u
 H+WNO/AEWyHOtr9hiOqu6Gu3yB2oVjwpD0SDGnhQZ7XpT5syUIQR9jMhtWFgK0+Er7PJLlMHANA1
 bs2R4iRcH3xv9Puiud/hROIkQBFx9BA5yh8iLgxxK8ttJOgE22ySLDlnuktNvxRB2uyScQ1h73J0
 jHT9cO2eqPW6UlupkxNosx4GZ3jlszDBLqeHTFooTZCcSBYZDWQs5qlkvd6bQTUH3gkwE9mTsS/2
 b1BN8Jw1rw==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>

The rx_8111 is quite similar to the rx_8030. This adds support for this
chip to the ds1307 driver. Date/time and alarm registers are in the
usual places. The nvmem is located at 0x40. Time stamping is not
supported.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Add "_REG" in register names
Add interrupt/alarm handling (different from rx8030)

 drivers/rtc/rtc-ds1307.c | 308 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 285 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d51565bcc189..2c5dff45a246 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -46,6 +46,7 @@ enum ds_type {
 	m41t11,
 	mcp794xx,
 	rx_8025,
+	rx_8111,
 	rx_8130,
 	last_ds_type /* always last */
 	/* rs5c372 too?  different address... */
@@ -113,6 +114,24 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define RX8111_REG_EXTENSION	0x1d
+#	define RX8111_REG_EXTENSION_WADA	BIT(3)
+#define RX8111_REG_FLAG		0x1e
+#	define RX8111_REG_FLAG_VLF	BIT(1)
+#	define RX8111_REG_FLAG_EVF	BIT(2)
+#	define RX8111_REG_FLAG_AF	BIT(3)
+#	define RX8111_REG_FLAG_TF	BIT(4)
+#	define RX8111_REG_FLAG_UF	BIT(5)
+#define RX8111_REG_CONTROL	0x1e
+#	define RX8111_REG_CONTROL_EIE	BIT(2)
+#	define RX8111_REG_CONTROL_AIE	BIT(3)
+#	define RX8111_REG_CONTROL_TIE	BIT(4)
+#	define RX8111_REG_CONTROL_UIE	BIT(5)
+#define RX8111_REG_PWR_SWITCH_CTRL	0x32
+#	define RX8111_PSC_SMP_INIEN	BIT(6)
+#	define RX8111_PSC_SMP_CHGEN	BIT(7)
+#define RX8111_REG_TIME_STAMP_BUF_CTRL	0x34
+
 #define RX8130_REG_ALARM_MIN		0x17
 #define RX8130_REG_ALARM_HOUR		0x18
 #define RX8130_REG_ALARM_WEEK_OR_DAY	0x19
@@ -205,6 +224,68 @@ struct chip_desc {
 
 static const struct chip_desc chips[last_ds_type];
 
+static int ds1307_check_voltage_lost(struct ds1307 *ds1307)
+{
+	int ret;
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int regflag;
+
+	switch (ds1307->type) {
+	case rx_8111:
+		reg = RX8111_REG_FLAG;
+		mask = RX8111_REG_FLAG_VLF;
+		break;
+	case rx_8130:
+		reg = RX8130_REG_FLAG;
+		mask = RX8130_REG_FLAG_VLF;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = regmap_read(ds1307->regmap, reg, &regflag);
+	if (ret) {
+		dev_err(ds1307->dev, "%s error %d\n", "read", ret);
+		return ret;
+	}
+
+	if (regflag & mask) {
+		dev_warn_once(ds1307->dev, "oscillator failed, set time!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ds1307_clear_voltage_lost(struct ds1307 *ds1307)
+{
+	int ret;
+	unsigned int reg;
+	unsigned int mask;
+
+	switch (ds1307->type) {
+	case rx_8111:
+		reg = RX8111_REG_FLAG;
+		mask = (unsigned int)~RX8111_REG_FLAG_VLF;
+		break;
+	case rx_8130:
+		reg = RX8130_REG_FLAG;
+		mask = (unsigned int)~RX8130_REG_FLAG_VLF;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = regmap_write(ds1307->regmap, reg, mask);
+	if (ret) {
+		dev_err(ds1307->dev, "%s error %d\n", "write", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 {
 	struct ds1307	*ds1307 = dev_get_drvdata(dev);
@@ -212,19 +293,9 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 	const struct chip_desc *chip = &chips[ds1307->type];
 	u8 regs[7];
 
-	if (ds1307->type == rx_8130) {
-		unsigned int regflag;
-		ret = regmap_read(ds1307->regmap, RX8130_REG_FLAG, &regflag);
-		if (ret) {
-			dev_err(dev, "%s error %d\n", "read", ret);
-			return ret;
-		}
-
-		if (regflag & RX8130_REG_FLAG_VLF) {
-			dev_warn_once(dev, "oscillator failed, set time!\n");
-			return -EINVAL;
-		}
-	}
+	ret = ds1307_check_voltage_lost(ds1307);
+	if (ret)
+		return ret;
 
 	/* read the RTC date and time registers all at once */
 	ret = regmap_bulk_read(ds1307->regmap, chip->offset, regs,
@@ -397,15 +468,9 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		return result;
 	}
 
-	if (ds1307->type == rx_8130) {
-		/* clear Voltage Loss Flag as data is available now */
-		result = regmap_write(ds1307->regmap, RX8130_REG_FLAG,
-				      ~(u8)RX8130_REG_FLAG_VLF);
-		if (result) {
-			dev_err(dev, "%s error %d\n", "write", result);
-			return result;
-		}
-	}
+	result =  ds1307_clear_voltage_lost(ds1307);
+	if (result)
+		return result;
 
 	return 0;
 }
@@ -541,6 +606,174 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307, u32 ohms, bool diode)
 	return setup;
 }
 
+static u8 do_trickle_setup_rx8111(struct ds1307 *ds1307, u32 ohms, bool diode)
+{
+	/* make sure that the backup battery is enabled */
+	u8 setup = RX8111_PSC_SMP_INIEN;
+
+	if (diode)
+		setup |= RX8111_PSC_SMP_CHGEN;
+
+	return setup;
+}
+
+static irqreturn_t rx8111_irq(int irq, void *dev_id)
+{
+	struct ds1307 *ds1307 = dev_id;
+	irqreturn_t result = IRQ_NONE;
+	int ret;
+	u8 ctl[2];
+	u8 flags = 0;
+
+	rtc_lock(ds1307->rtc);
+
+	/* Read flag and control registers. */
+	ret = regmap_bulk_read(ds1307->regmap, RX8111_REG_FLAG, ctl,
+			       sizeof(ctl));
+	if (ret < 0)
+		goto out;
+
+	if (ctl[0] & RX8111_REG_FLAG_AF) {
+		result = IRQ_HANDLED;
+		flags |= RTC_AF; /* Alarm */
+		ctl[1] &= ~RX8111_REG_CONTROL_AIE;
+	}
+	/*
+	 * If an interrupt occurred that we cannot process, we'll have to turn
+	 * it off, otherwise we'd be called again and again.
+	 */
+	if (ctl[0] & RX8111_REG_FLAG_UF) {
+		result = IRQ_HANDLED;
+		ctl[1] &= ~RX8111_REG_CONTROL_UIE;
+	}
+	if (ctl[0] & RX8111_REG_FLAG_TF) {
+		result = IRQ_HANDLED;
+		ctl[1] &= ~RX8111_REG_CONTROL_TIE;
+	}
+	if (ctl[0] & RX8111_REG_FLAG_EVF) {
+		result = IRQ_HANDLED;
+		ctl[1] &= ~RX8111_REG_CONTROL_EIE;
+	}
+	/* Clear all flags */
+	ctl[0] &= ~(RX8111_REG_FLAG_UF | RX8111_REG_FLAG_TF |
+		    RX8111_REG_FLAG_AF | RX8111_REG_FLAG_EVF);
+
+	ret = regmap_bulk_write(ds1307->regmap, RX8111_REG_FLAG, ctl,
+				sizeof(ctl));
+	if (ret < 0)
+		goto out;
+
+	rtc_update_irq(ds1307->rtc, 1, flags | RTC_IRQF);
+
+out:
+	rtc_unlock(ds1307->rtc);
+
+	return result;
+}
+
+static int rx8111_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	u8 ald[3], ctl[2];
+	int ret;
+
+	/* Read alarm registers. */
+	ret = regmap_bulk_read(ds1307->regmap, RX8130_REG_ALARM_MIN, ald,
+			       sizeof(ald));
+	if (ret < 0)
+		return ret;
+
+	/* Read flag and control registers. */
+	ret = regmap_bulk_read(ds1307->regmap, RX8111_REG_FLAG, ctl,
+			       sizeof(ctl));
+	if (ret < 0)
+		return ret;
+
+	t->enabled = !!(ctl[1] & RX8111_REG_CONTROL_AIE);
+	t->pending = !!(ctl[0] & RX8111_REG_FLAG_AF);
+
+	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
+	t->time.tm_sec = -1;
+	t->time.tm_min = bcd2bin(ald[0] & 0x7f);
+	t->time.tm_hour = bcd2bin(ald[1] & 0x7f);
+	t->time.tm_wday = -1;
+	t->time.tm_mday = bcd2bin(ald[2] & 0x7f);
+	t->time.tm_mon = -1;
+	t->time.tm_year = -1;
+	t->time.tm_yday = -1;
+	t->time.tm_isdst = -1;
+
+	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d enabled=%d\n",
+		__func__, t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
+		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled);
+
+	return 0;
+}
+
+static int rx8111_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	u8 ald[3], ctl[3];
+	int ret;
+
+	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
+		"enabled=%d pending=%d\n", __func__,
+		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
+		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon,
+		t->enabled, t->pending);
+
+	/* Read control registers. */
+	ret = regmap_bulk_read(ds1307->regmap, RX8111_REG_EXTENSION, ctl,
+			       sizeof(ctl));
+	if (ret < 0)
+		return ret;
+
+	ctl[0] &= RX8111_REG_EXTENSION_WADA;
+	ctl[1] &= ~RX8111_REG_FLAG_AF;
+	ctl[2] &= ~RX8111_REG_CONTROL_AIE;
+
+	ret = regmap_bulk_write(ds1307->regmap, RX8111_REG_EXTENSION, ctl,
+				sizeof(ctl));
+	if (ret < 0)
+		return ret;
+
+	/* Hardware alarm precision is 1 minute! */
+	ald[0] = bin2bcd(t->time.tm_min);
+	ald[1] = bin2bcd(t->time.tm_hour);
+	ald[2] = bin2bcd(t->time.tm_mday);
+
+	ret = regmap_bulk_write(ds1307->regmap, RX8130_REG_ALARM_MIN, ald,
+				sizeof(ald));
+	if (ret < 0)
+		return ret;
+
+	if (!t->enabled)
+		return 0;
+
+	ctl[2] |= RX8111_REG_CONTROL_AIE;
+
+	return regmap_write(ds1307->regmap, RX8111_REG_CONTROL, ctl[2]);
+}
+
+static int rx8111_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct ds1307 *ds1307 = dev_get_drvdata(dev);
+	int ret, reg;
+
+	ret = regmap_read(ds1307->regmap, RX8111_REG_CONTROL, &reg);
+	if (ret < 0)
+		return ret;
+
+	if (enabled)
+		reg |= RX8111_REG_CONTROL_AIE;
+	else
+		reg &= ~RX8111_REG_CONTROL_AIE;
+
+	dev_dbg(dev, "%s, enable=%u, reg=0x%x\n", __func__, enabled, reg);
+
+	return regmap_write(ds1307->regmap, RX8111_REG_CONTROL, reg);
+}
+
 static u8 do_trickle_setup_rx8130(struct ds1307 *ds1307, u32 ohms, bool diode)
 {
 	/* make sure that the backup battery is enabled */
@@ -943,6 +1176,14 @@ static const struct rtc_class_ops rx8130_rtc_ops = {
 	.alarm_irq_enable = rx8130_alarm_irq_enable,
 };
 
+static const struct rtc_class_ops rx8111_rtc_ops = {
+	.read_time      = ds1307_get_time,
+	.set_time       = ds1307_set_time,
+	.read_alarm     = rx8111_read_alarm,
+	.set_alarm      = rx8111_set_alarm,
+	.alarm_irq_enable = rx8111_alarm_irq_enable,
+};
+
 static const struct rtc_class_ops mcp794xx_rtc_ops = {
 	.read_time      = ds1307_get_time,
 	.set_time       = ds1307_set_time,
@@ -1012,6 +1253,16 @@ static const struct chip_desc chips[last_ds_type] = {
 		.century_bit	= DS1337_BIT_CENTURY,
 		.bbsqi_bit	= DS3231_BIT_BBSQW,
 	},
+	[rx_8111] = {
+		.alarm		= 1,
+		.nvram_offset	= 0x40,
+		.nvram_size	= 0x40,	/* 0x40 .. 0x7F is user RAM */
+		.offset		= 0x10,
+		.irq_handler = rx8111_irq,
+		.rtc_ops = &rx8111_rtc_ops,
+		.trickle_charger_reg = RX8111_REG_PWR_SWITCH_CTRL,
+		.do_trickle_setup = &do_trickle_setup_rx8111,
+	},
 	[rx_8130] = {
 		.alarm		= 1,
 		/* this is battery backed SRAM */
@@ -1063,6 +1314,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "pt7c4338", ds_1307 },
 	{ "rx8025", rx_8025 },
 	{ "isl12057", ds_1337 },
+	{ "rx8111", rx_8111 },
 	{ "rx8130", rx_8130 },
 	{ }
 };
@@ -1137,6 +1389,10 @@ static const struct of_device_id ds1307_of_match[] = {
 		.compatible = "isil,isl12057",
 		.data = (void *)ds_1337
 	},
+	{
+		.compatible = "epson,rx8111",
+		.data = (void *)rx_8111
+	},
 	{
 		.compatible = "epson,rx8130",
 		.data = (void *)rx_8130
@@ -1880,6 +2136,12 @@ static int ds1307_probe(struct i2c_client *client,
 				     DS1307_REG_HOUR << 4 | 0x08, hour);
 		}
 		break;
+	case rx_8111:
+		/* Use memory as user RAM */
+		regmap_write(ds1307->regmap, RX8111_REG_TIME_STAMP_BUF_CTRL, 0);
+		/* Disable timer, events, frequency output */
+		regmap_write(ds1307->regmap, RX8111_REG_EXTENSION, 0xc8);
+		break;
 	case ds_1388:
 		err = regmap_read(ds1307->regmap, DS1388_REG_CONTROL, &tmp);
 		if (err) {
@@ -1955,7 +2217,7 @@ static int ds1307_probe(struct i2c_client *client,
 		dev_info(ds1307->dev,
 			 "'wakeup-source' is set, request for an IRQ is disabled!\n");
 		/* We cannot support UIE mode if we do not have an IRQ line */
-		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, ds1307->rtc->features);
+		ds1307->rtc->uie_unsupported = 1;
 	}
 
 	if (want_irq) {
-- 
2.17.1

