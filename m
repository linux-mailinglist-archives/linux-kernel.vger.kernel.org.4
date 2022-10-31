Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400886130C9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJaGzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJaGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:54:57 -0400
Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94563BF71;
        Sun, 30 Oct 2022 23:54:51 -0700 (PDT)
Received: from host-ubmmyvj.static.zeelandnet.nl ([217.102.255.198] helo=mail.zeelandnet.nl)
        by spamfilter04.delta.nl with esmtp (Exim 4.92)
        (envelope-from <glasveze@delta.nl>)
        id 1opOhG-0007ki-1u; Mon, 31 Oct 2022 07:54:59 +0100
X-Sender-IP: 204.168.188.16
Received: from phenom.domain_not_set.invalid (016-188-168-204.dynamic.caiway.nl [204.168.188.16])
        (Authenticated sender: glasveze@delta.nl)
        by mail.zeelandnet.nl (Postfix) with ESMTPA;
        Mon, 31 Oct 2022 07:54:48 +0100 (CET)
From:   glasveze@delta.nl
To:     linux-rtc@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 2/2] rtc: ds1307: Add support for Epson RX8111
Date:   Mon, 31 Oct 2022 07:54:48 +0100
Message-Id: <20221031065448.5746-1-glasveze@delta.nl>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: 217.102.255.198
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (4.205802721e-05)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+U6DmonnL9mbZRE2y8SnfwPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wqSBOxlRVmV45FJ8CYZCUIt8C9mOBdONdnsxgsk1D2p+TR
 pbxM0ISaJnfWkrHm7ptGxaGjWvYLz0l6AGvvRftgME5z5XaGE5NHNu7h534JJaFS4A6TO7+QrQWJ
 MkybRqNYGxLcRm31r7HJL906rtNS/YSALpmaJqtnIRDPv/5tBxXZU3s+BKeiVRn7TrBH4nejnKCo
 kQ2Ao8+ENfYcjPzAETJXdrVjqyOqfkkDsz2/xlY+5adZvWXoGLcQcb78Eui+mtbuPAbQ+aWD8hhQ
 CZMTEEe1sLzznCY3CGPOzCfYYPbQTl/SJIDeIbJV6Zcf430jRGDmKiHQCBmbL4/kVA5ilfR3t3lk
 efZwj1OjoVRNk0OBtfs8eND145V556pRoeWoiZFW8yMEtAB+QqbWN455cayBalMzNiQi+IaP6Ip3
 l1/Gfk/thginq2iQcOP+mMhCFzRIiEpzynty7G1sAhwpazrLOzVL2cm1v+nUTthXE7Mvx4UmROlz
 fITQPwXDdef+Xt1YVt34tXjgAnyScrZDbgZGFmIP8t6jENaJPnk2Q0EqJ2YhaHYKPX4HHcW4fmLf
 d77XZbPqWAY81T0FayDkAbOrs4FPMK+W+hB4jPTBjMy+REZzZZBkbyPIV/jp5XA84mAL2fYZt/ag
 6cJYhE+JR1THjBWZFF00ALVWc/sntqhVr03UHlrscRrHorFm3BMamUdylUIKhf3z2GAHxH7Inwey
 uebMOAyd9KE1KnR6Q/uNUZtOoISscGZbnZWaYNa7ovRVrcJH1vtKw3YgGZx3s6oM5c5v6nO6dxgr
 nLgL2IFyOv5cAKYGRAn40Vzq1+FjVbTBFy0HmZ7j54j5nbTw0F2VAitLyFstLTVGwdoo+nbOFKKz
 xACo90vCZrfvMYKWPHYo9X+hHrxPABGbYgYFQMAJdpT8SBGMx9Hio+WRxNN/qmhTU0uEq4SJAr3V
 DiJPpDjVqLlUsOzVGtyErgLSyB2oVjwpD0SDGnhQZ7XpT5syUIQR9jMhtWFgK0+Er7PJLlMHANA1
 bs2R4iRcH3xv9Puiud/hROIkQBFx9BA5yh8iLgxxK8ttJOgE22ySLDlnuktNvxRB2uyScQ1h73J0
 jHT9cO2eqPW6UlupkxNosx4GZ3jlszDBLqeHTFooTZCcSBYZDWQs5qlkvd6bQTUH3gkwE9mTsS/2
 b1BN8Jw1rw==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-ds1307.c | 129 ++++++++++++++++++++++++++++++++-------
 1 file changed, 107 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d51565bcc189..f5f0f0d02fe0 100644
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
@@ -113,6 +114,14 @@ enum ds_type {
 #	define RX8025_BIT_VDET		0x40
 #	define RX8025_BIT_XST		0x20
 
+#define RX8111_FLAG		0x1e
+#	define RX8111_FLAG_VLF		BIT(1)
+#	define RX8111_FLAG_AF		BIT(3)
+#define RX8111_PWR_SWITCH_CTRL	0x32
+#	define RX8111_PSC_SMP_INIEN	BIT(6)
+#	define RX8111_PSC_SMP_CHGEN	BIT(7)
+#define RX8111_TIME_STAMP_BUF_CTRL	0x34
+
 #define RX8130_REG_ALARM_MIN		0x17
 #define RX8130_REG_ALARM_HOUR		0x18
 #define RX8130_REG_ALARM_WEEK_OR_DAY	0x19
@@ -205,6 +214,68 @@ struct chip_desc {
 
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
+		reg = RX8111_FLAG;
+		mask = RX8111_FLAG_VLF;
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
+		reg = RX8111_FLAG;
+		mask = (unsigned int)~RX8111_FLAG_VLF;
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
@@ -212,19 +283,9 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
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
@@ -397,15 +458,9 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
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
@@ -541,6 +596,17 @@ static u8 do_trickle_setup_ds1339(struct ds1307 *ds1307, u32 ohms, bool diode)
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
 static u8 do_trickle_setup_rx8130(struct ds1307 *ds1307, u32 ohms, bool diode)
 {
 	/* make sure that the backup battery is enabled */
@@ -1012,6 +1078,16 @@ static const struct chip_desc chips[last_ds_type] = {
 		.century_bit	= DS1337_BIT_CENTURY,
 		.bbsqi_bit	= DS3231_BIT_BBSQW,
 	},
+	[rx_8111] = {
+		.alarm		= 1,
+		.nvram_offset	= 0x40,
+		.nvram_size	= 0x40,	/* 0x40 .. 0x7F is user RAM */
+		.offset		= 0x10,
+		.irq_handler = rx8130_irq,
+		.rtc_ops = &rx8130_rtc_ops,
+		.trickle_charger_reg = RX8111_PWR_SWITCH_CTRL,
+		.do_trickle_setup = &do_trickle_setup_rx8111,
+	},
 	[rx_8130] = {
 		.alarm		= 1,
 		/* this is battery backed SRAM */
@@ -1063,6 +1139,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "pt7c4338", ds_1307 },
 	{ "rx8025", rx_8025 },
 	{ "isl12057", ds_1337 },
+	{ "rx8111", rx_8111 },
 	{ "rx8130", rx_8130 },
 	{ }
 };
@@ -1137,6 +1214,10 @@ static const struct of_device_id ds1307_of_match[] = {
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
@@ -1880,6 +1961,10 @@ static int ds1307_probe(struct i2c_client *client,
 				     DS1307_REG_HOUR << 4 | 0x08, hour);
 		}
 		break;
+	case rx_8111:
+		/* Use memory as user RAM */
+		regmap_write(ds1307->regmap, RX8111_TIME_STAMP_BUF_CTRL, 0);
+		break;
 	case ds_1388:
 		err = regmap_read(ds1307->regmap, DS1388_REG_CONTROL, &tmp);
 		if (err) {
-- 
2.17.1

