Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47CB6BF596
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCQW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCQW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:57:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE52F066;
        Fri, 17 Mar 2023 15:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD08B82709;
        Fri, 17 Mar 2023 22:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840FBC43445;
        Fri, 17 Mar 2023 22:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679093833;
        bh=qkCtWxh/5oWlgnhNQ/wW4H4FFCmcLw0ABvjfTL/yR5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpprXibR7dBjn5e1n8FJWnJxvvXRXTUnHXSG5PKMWZld5HS+DM4i9ZcUg6+tDC6pj
         KX4qNSPXAZcfNxWEkNLBGylIJ9SLNq23lrHoPE4E93klOCGwB7pqIhGeedXT6CKTfg
         NBFkSNyzl04F45B+n0CMAMc1c/26fXz4ODFjvuGQBu+h2FMW4hzwi6sFAudEW/jKFj
         PY04bObeaT7zh1lW4HNOKpeDAWxgg2DceJT8osaPHEn1XxD8bQVegSJ0P1GrdgoBRJ
         Kbt9NrCLKZRynO86QYlY+aaGmh4uZoi0zKDy3S0AvWjGp1O1D08c8PoA7YIxnBwfFj
         4Iy5hNpitjk5A==
Received: by mercury (Postfix, from userid 1000)
        id A1BE01062116; Fri, 17 Mar 2023 23:57:08 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCHv3 14/14] power: supply: generic-adc-battery: style fixes
Date:   Fri, 17 Mar 2023 23:57:07 +0100
Message-Id: <20230317225707.1552512-15-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317225707.1552512-1-sre@kernel.org>
References: <20230317225707.1552512-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does the following code-style changes:

 * fix inconsistent indentation in 'struct gab'
 * remove unused cable_plugged from 'struct gab'
 * remove pointless temporary is_plugged variable
 * add gab_ prefix to read_channel

No functionality changes are intended.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 26 +++++++++-------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 2fa946c93fb4..7bdc6b263609 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -42,12 +42,11 @@ static const char *const gab_chan_name[] = {
 };
 
 struct gab {
-	struct power_supply		*psy;
-	struct power_supply_desc	psy_desc;
-	struct iio_channel	*channel[GAB_MAX_CHAN_TYPE];
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	struct iio_channel *channel[GAB_MAX_CHAN_TYPE];
 	struct delayed_work bat_work;
-	int	status;
-	bool cable_plugged;
+	int status;
 	struct gpio_desc *charge_finished;
 };
 
@@ -85,7 +84,7 @@ static bool gab_charge_finished(struct gab *adc_bat)
 	return gpiod_get_value(adc_bat->charge_finished);
 }
 
-static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
+static int gab_read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 		int *result)
 {
 	int ret;
@@ -109,13 +108,13 @@ static int gab_get_property(struct power_supply *psy,
 		val->intval = adc_bat->status;
 		return 0;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
+		return gab_read_channel(adc_bat, GAB_VOLTAGE, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return read_channel(adc_bat, GAB_CURRENT, &val->intval);
+		return gab_read_channel(adc_bat, GAB_CURRENT, &val->intval);
 	case POWER_SUPPLY_PROP_POWER_NOW:
-		return read_channel(adc_bat, GAB_POWER, &val->intval);
+		return gab_read_channel(adc_bat, GAB_POWER, &val->intval);
 	case POWER_SUPPLY_PROP_TEMP:
-		return read_channel(adc_bat, GAB_TEMP, &val->intval);
+		return gab_read_channel(adc_bat, GAB_TEMP, &val->intval);
 	default:
 		return -EINVAL;
 	}
@@ -125,17 +124,13 @@ static void gab_work(struct work_struct *work)
 {
 	struct gab *adc_bat;
 	struct delayed_work *delayed_work;
-	bool is_plugged;
 	int status;
 
 	delayed_work = to_delayed_work(work);
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	is_plugged = power_supply_am_i_supplied(adc_bat->psy);
-	adc_bat->cable_plugged = is_plugged;
-
-	if (!is_plugged)
+	if (!power_supply_am_i_supplied(adc_bat->psy))
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -177,7 +172,6 @@ static int gab_probe(struct platform_device *pdev)
 	psy_desc->name = dev_name(&pdev->dev);
 
 	/* bootup default values for the battery */
-	adc_bat->cable_plugged = false;
 	adc_bat->status = POWER_SUPPLY_STATUS_DISCHARGING;
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
 	psy_desc->get_property = gab_get_property;
-- 
2.39.2

