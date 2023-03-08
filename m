Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C96B01DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCHIos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCHIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474E9E67A;
        Wed,  8 Mar 2023 00:44:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so31767002edb.6;
        Wed, 08 Mar 2023 00:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2l9GniXbIObtfjCfu9eYVESux7iZ+E2zlwf2Uly32g=;
        b=TKjsZuaXBCSYomo6F0IqS68FnNt9dCKTEBnuPPYn8pHMZU/q2jpA9rqmzCmJ2EgHxZ
         mb4dAQ1fAI1cDUph43gD20kYtBfjthKnw2cvub+Cf23VwFBzT7NILACVbGKe6ZTBm4kt
         fwyo+ZO2I7ugpQUEZrJOdCpNICYVVDDpn+g3YTT5ACkpWSPfgJu3Dge0LjXZBftGnTSk
         Cn7o2j1RGgUhs8XJvMwoiTk7traCetguRESZyptgRgmUFWrOps4Pfe+oObxo6I2zOoDV
         7i1wQVaczBtA37AODdaSS3wxYVg8yLwdQVQlmZewpLbt/4m/kdIL2TbgyXi3gxUzofYi
         N66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2l9GniXbIObtfjCfu9eYVESux7iZ+E2zlwf2Uly32g=;
        b=rygeqB0aeMFO0vKFMacpz1N6Cl6/lDJSCDzbPi+5O/Ah5+ipnfi6R7yMhzAthbh4yW
         pHo8MdSGKpuPPdn/Sl5pVO5w7IPdidXn/99f+oK2SJh0BW6bUjMzli0vvVPdrinxnpiN
         sutF+S5T3W+iU3RTW1XklmlsdCk3aHY+CbTJe7V5gqW/qWW/tK67eLcXOxTQsFyfwjiY
         H4tqYHfVsPtX5vX08P46GJQFbRySOwH6qOs5ItU0LtMGx+y2WTjDsUAHuUkBUMQTHOCN
         NJfK4GJs0fH/KVwY6S64iiep3iJmeeNKLleCWA4DGLNBuWOOOMbJgbjHKRM0GzUeNtot
         /MJg==
X-Gm-Message-State: AO0yUKX1Ns0Uxyxm4nNn4QbC9UsMC41Fzz1h6HzMU8emMX63GWO6bnas
        M9wpsIG1iY7bgWmAPK7Rc6w=
X-Google-Smtp-Source: AK7set9KP1K02Uv78u/AWya07GL7x/CG3QgyFA+hboC76A00zyPjEPDuGMfXduiVN70esfswId1/8g==
X-Received: by 2002:a17:907:8686:b0:8f7:5038:9896 with SMTP id qa6-20020a170907868600b008f750389896mr21227842ejc.70.1678265075961;
        Wed, 08 Mar 2023 00:44:35 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b008ee95ccfe06sm7163891ejx.119.2023.03.08.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:44:35 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] power: max17040: add simple battery cell support
Date:   Wed,  8 Mar 2023 10:44:17 +0200
Message-Id: <20230308084419.11934-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308084419.11934-1-clamor95@gmail.com>
References: <20230308084419.11934-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple battery cell allows to pass some constant data
about battery controlled by this fuel gauge.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d1075959dd46..2778ed5b5c14 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -141,6 +141,7 @@ struct max17040_chip {
 	struct regmap			*regmap;
 	struct delayed_work		work;
 	struct power_supply		*battery;
+	struct power_supply_battery_info	*batt_info;
 	struct chip_data		data;
 
 	/* battery capacity */
@@ -400,6 +401,28 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = chip->low_soc_alert;
 		break;
+
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = chip->batt_info->technology;
+		break;
+	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
+		val->intval = chip->batt_info->energy_full_design_uwh;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = chip->batt_info->charge_full_design_uah;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MIN:
+		if (chip->batt_info->temp_min == INT_MIN)
+			return -ENODATA;
+
+		val->intval = chip->batt_info->temp_min * 10;
+		break;
+	case POWER_SUPPLY_PROP_TEMP_MAX:
+		if (chip->batt_info->temp_max == INT_MAX)
+			return -ENODATA;
+
+		val->intval = chip->batt_info->temp_max * 10;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -418,6 +441,11 @@ static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_TEMP_MIN,
+	POWER_SUPPLY_PROP_TEMP_MAX,
 };
 
 static const struct power_supply_desc max17040_battery_desc = {
@@ -470,6 +498,12 @@ static int max17040_probe(struct i2c_client *client)
 		return PTR_ERR(chip->battery);
 	}
 
+	if (client->dev.of_node) {
+		if (power_supply_get_battery_info(chip->battery, &chip->batt_info))
+			dev_warn(&client->dev,
+				 "No monitored battery, some properties will be missing\n");
+	}
+
 	ret = max17040_get_version(chip);
 	if (ret < 0)
 		return ret;
-- 
2.37.2

