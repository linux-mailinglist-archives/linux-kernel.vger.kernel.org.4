Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194A1689B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBCOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjBCOEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:04:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32860AC239
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:02:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso6072827wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEkaRI2/7OwdP6CFOGx3AkcXyupYh3TuV6fnAqTrbn8=;
        b=sHxjOK4xLPki6HlXUcVjIamFw7gcPjMf3aifkU7FVnaJU/10MVvRXXqhp7M2fLNP2b
         S6aX3jACu7Va+p8Nf9e+A5FzZ2AoUuTzFAr/1A57g7A6Ilu2d6yLziBbSNs6NqtKO+cS
         5dNk0DjzNtDEWG56WWuuRALima53OCtPLY9N5eNVFRxka43H9LJ9DTJuBjJFn2o7NjpR
         0EELvc7//3E6Ax0xn85aKg1VIGKqUinYZN71HQX2SoJ6ckQ33No8i7E8S9t3x/BSG7R+
         dL7hKNdgme6iGklgw897tOI7R0laQWDZxjegSq9ktY+Cm0JbBaaoQztefgK4bvD+EX5t
         YiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEkaRI2/7OwdP6CFOGx3AkcXyupYh3TuV6fnAqTrbn8=;
        b=2Q4x1Y1SEJD+8HPgJVuFhHUGlN+HTd866Rt1cWEONWkGu7Nv6l+4Zve6EFQTx4reiv
         bF2DHkfC4E7AQ3sgqO97Ri8NkH9yi2jarME9Y5uNLUzbjkhz5bivKlMr22DxxzN7j8zs
         uPuoSasPeUqe5wIbVxsQ+f8WxJtjr3/OXncBRoRxEbLG8pFkhI4ytsz6D8c9h98BxWy6
         e0iEAMeJSKj+QbcbUOIEebJb7wi9CDssZQyEht9x2xOkWY0LViFsF/dky8GtU/++gPS8
         GDYquX0nKAmaY+hZxE3D6iQJuGeSUwXVCxWDfqFLpBn3yqmdkBOIgIG0xExdx7XBBqft
         BihA==
X-Gm-Message-State: AO0yUKVFbFg7m6rtVJ0xS6i2cGLoUeivryplg5xlC94TnvmIzreufSIC
        RRo1OYyYEGZwdhw9VeszjY8Vug==
X-Google-Smtp-Source: AK7set/td3giVdEyQMU1/tNN5LqZolXDlM06sT0CPDRovFBWDn9DIptflRFLfdzI+M12SsOBkGWKxw==
X-Received: by 2002:a05:600c:1e84:b0:3dc:5aba:f287 with SMTP id be4-20020a05600c1e8400b003dc5abaf287mr10085611wmb.23.1675432913358;
        Fri, 03 Feb 2023 06:01:53 -0800 (PST)
Received: from jerome-BL.. (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm6859209wmk.25.2023.02.03.06.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 06:01:52 -0800 (PST)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     tony@atomide.com, lee@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, nm@ti.com, afd@ti.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off API
Date:   Fri,  3 Feb 2023 15:01:50 +0100
Message-Id: <20230203140150.13071-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new API for power-off mode support:
Link: https://lwn.net/Articles/894511/
Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/

sys-off API allows support of shutdown handler and restart handler.

Shutdown was not supported before that enhancement.
This is required for platform that are not using PSCI.

Test:
- restart:
  # reboot
  Default is cold reset:
  # cat /sys/kernel/reboot/mode
  Switch boot mode to warm reset:
  # echo warm > /sys/kernel/reboot/mode
- power-off:
  # halt

Tested on AM62-SP-SK board.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
Suggested-by: Andrew Davis <afd@ti.com>
---
 drivers/mfd/tps65219.c | 45 +++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..c134f3f6e202 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -25,25 +25,34 @@ static int tps65219_cold_reset(struct tps65219 *tps)
 				  TPS65219_MFP_COLD_RESET_I2C_CTRL_MASK);
 }
 
-static int tps65219_restart(struct notifier_block *this,
-			    unsigned long reboot_mode, void *cmd)
+static int tps65219_soft_shutdown(struct tps65219 *tps)
 {
-	struct tps65219 *tps;
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MFP_CTRL,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK,
+				  TPS65219_MFP_I2C_OFF_REQ_MASK);
+}
 
-	tps = container_of(this, struct tps65219, nb);
+static int tps65219_power_off_handler(struct sys_off_data *data)
+{
+	tps65219_soft_shutdown(data->cb_data);
+	return NOTIFY_DONE;
+}
 
+static int tps65219_restart(struct tps65219 *tps,
+			    unsigned long reboot_mode)
+{
 	if (reboot_mode == REBOOT_WARM)
 		tps65219_warm_reset(tps);
 	else
 		tps65219_cold_reset(tps);
-
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block pmic_rst_restart_nb = {
-	.notifier_call = tps65219_restart,
-	.priority = 200,
-};
+static int tps65219_restart_handler(struct sys_off_data *data)
+{
+	tps65219_restart(data->cb_data, data->mode);
+	return NOTIFY_DONE;
+}
 
 static const struct resource tps65219_pwrbutton_resources[] = {
 	DEFINE_RES_IRQ_NAMED(TPS65219_INT_PB_FALLING_EDGE_DETECT, "falling"),
@@ -269,13 +278,27 @@ static int tps65219_probe(struct i2c_client *client)
 		}
 	}
 
-	tps->nb = pmic_rst_restart_nb;
-	ret = register_restart_handler(&tps->nb);
+	ret = devm_register_sys_off_handler(tps->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_HIGH,
+					    tps65219_restart_handler,
+					    tps);
+
 	if (ret) {
 		dev_err(tps->dev, "cannot register restart handler, %d\n", ret);
 		return ret;
 	}
 
+	ret = devm_register_sys_off_handler(tps->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    tps65219_power_off_handler,
+					    tps);
+	if (ret) {
+		dev_err(tps->dev, "failed to register sys-off handler: %d\n",
+			ret);
+		return ret;
+	}
 	return 0;
 }
 
-- 
2.34.1

