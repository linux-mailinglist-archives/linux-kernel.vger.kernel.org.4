Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3466F0F19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344323AbjD0XgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344295AbjD0XgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:36:13 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE03A9D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638568; bh=TVyy9/b03N8nbazd1B41Q2wdYfTHpwuv2C4n1t0mm1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EaLOn+/XmXNN5NFCL8n1L944a6/vsnMqagPbWxd3/nPRBB0Sr+FBxCNoUpDKFCSlol+8tmPnk8R1wmRhUHTcm61YbSuez31WXeKWNbqr8ys7iavHwydNKplNoJeR3cNFCuh9Ga+bh2e4U0C1ySK9iJUBQpluNExPZPHFv1an3WGHCggPiWfFPBn8E+0Lgr0S2NuRNCPi52/DfVCtJNzC+KEVdFdRKCmMifeKBxSEIMI7fgIlCXIplnuyjPMdDvf4GBgVDdSz0mOTrvVJFWmKG35ShCDv6eM+HrqQ9Q5FzrHOcOjQOsNjucDIVgg+Sht754s54geGZRtQY3zKzusTSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638568; bh=H6QAeUAfPU8qA9SFl4JWKCkwkojo3613EmzTYADDT/f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=i2P8RaevaCe+BjtX/tY7kyCt6QvD65fNG5WjQ4wW7SPdcYhVZkEa1UlSyRRgOL7truX53tZA5XI+mpr8x/AYwsQaCqqt1YiCGhGPEu5Y26lEe0aZq8jntWgrmuWWoKySz/xj8lawjprmMYGENWhBILiN/Di1JzkADLzdJLxieRbJUMowbtElV9AssxTzySCKYs31YdOyd05xqMrup+Sep3hLt8UXC7RG/dFqHFyvByviYfHwPhnLgyGHND9UE1NaYyvgox6u09gZ2anCpyspZOaTulErtjS1vXNnaO84egpIEMOTX7exjJJ1JmlKx7mzFlqqPyHCvK8IB+hiK5JpQQ==
X-YMail-OSG: GxSgUtUVM1mDps3zNb2GewA1aDRc7SuXvavYTqd8fqOfd3pmslChq0hsY4SAgPZ
 szi1nfGO89PxaeJDdmcuco7XrLzn_vb6fQUWyMfYu5Jp04RvNbHCc9KlLXzZONzP3OhYB09QjPLe
 1.ylwdZH0L0rDNLh9Y_dyYsKZB6ThvwON3rQahCpQdu57KYbHO_IXujOr.6wSyxanze.lu6ilFIr
 QSzirJ5HuZeaZRLh3tLEASd4yHyuhLaQeplZRAWfnKokd8CHRLT95Qsv5i_I6wWTyWKWvQ9QBkCP
 OcpuVFnX8uLYs33xoWKFKdR5uw5jq0mUJhJOtstkJEuxinurELp6LGWrk1zvo0oKQ9Ze54khgzXR
 .Sqt6wd2hIRSMJq_xOv5097gQ1QlH9jJ2RF1QEEqJki_ejsI8Cwg5YlTMlCDWC6Q6gRYBB6IXl_j
 XVQWBZcq5qxnc4.DmgI3eqa.hUrScCTtzmPepLG21dmHC6H8zsoWg0qcmLlMpcYWzdvlti_v2Yfd
 M_pst146wQqamFV4.pBlc76virLLpoWeMUYaw61KIO3kkWU9jJzhH5v4oC0_fJ12su6MLqrQUpYZ
 UDZj6R4g4qLWfp32ImHe9294Ga7HfVfrYIgxrlsi34cS4l.QIaBnI557R2iLtZHBQtPNot160GFl
 t9i._MvDs8EHFtEMrfalRl8WzRJFqAEW6qrim0J8aEQWO5lxvDrf1sxiTgiCQrBkRh4bWEr0_SVg
 ZpC5nWPxzDtitzW1hks9K4.2g7jKjhQQ3HZx1.JttGMUuJ08TuqM0BK3iPigGoV6Ci04XKLtxkao
 8CBLIm2teCwywktfzcnqgT3NMLu0DyolNx6gJ2A_X6EjVY8JH5L5hiCQtnASHctDyLp5oogOuiR2
 zVO72L4FdvVQigH_qRXF5YfcHuQReXOPPwdfP9.1swjbpS_31gUIgKbRVXIRQ_RkyRQRs.Tv9aea
 ZYehwgfeUChaofeHZIyn5DXEQ9HnDTFx3qwgTmmEZsDlxPsUkISB9KUgMAXEO9TF_w7f5p_HgR3l
 sCn_.zG3XO6sf.YUIdl1Kfj6WNHqD0RXWRHUV0wZ2RVOyn6rWueNAIbpn4h5YJf8f2Fza9zhOBxr
 9r1XFB2FR_VrnKLylfl5sOPSGG5b4uW_qmfYa1oAnXqEIr8UK2UggyZ4D2I.MW2Qx4wZy5spKCiv
 jKjlVOQYFw2bTdkadm9YzXfcNX4cNx0ghYytBcGQDvsoE3irlpMEcKnoc1FdFwQAu3a4j.4uJ0di
 gBOD_UsK7_Z8WLF5QOSSRiiAmfmALDl71vaPzrD38VOTfU938oi1UK3dbkpz_AW9VNgExuPfOSgN
 RlrcsvreX9MQoxkFfhoqWxAikoi1e0vwC4Psh2H6.ieaDP2w7ZGDWk7GD3aBKpwgBaX3L3GwwpDT
 Nxdek0AD4LiGcMqnVhP9IMl.S.rNVHsjpVQr14N2UJ6Y7u0wa7f6ewfuBn7oQqh.E_NTMSp5DuS7
 .LKBUzEniiXEk6DtB5n5qBHxX4qAOHB8N5FmlXB10C_OH9toVw5s81T2P.B4rDVU85Xb.yj4NTBZ
 n4c0Ept9_ZG4C6tCplBwimG3rRmaT6a8AQttdPnr4LXhOFxDyR4Gtj3bh9XLP0cWF26bONa.ksxO
 XfXleSMJ3yFDJSFOvpvAuqb301ai2vioS05Y8Ke.qS2rR_m2GNI5Aw84F0vIN8GrLcGCdgTuNCfI
 NW0PejYQrMKiN4KygFHgSiDoDX1kzfWhD_6608hURIyjE93sFbFoeIZhEcnZRs0jqCzPVZLyy4fg
 x.J5p0MgY4Fmll5BJTGMmGFVWedKnhUQPCgDjWWfoLVjX5l2z6rkcRv8UF1VtR_ZWcUHj8afvW81
 TGTokowmSJF0eHmMqvNywbMIP0ZmZYISvEIRU2TyVCZQlPnpK.K3tNE3DWuyCJD18uiTC2ok9mJ0
 nE_9anX5ewbjV_kxyEuPsQdDUJ48YeFdQkBWCcnwtx_NsTP65rC5eBJ5SCcMKVjR0vJ_xZEZdg0x
 9tBm547gKJiIZN.UMgcZUedYsXqbOPvuLLhoSC0MN_7pIGNscdOUn5xCjTdEZx.5Zg5LgxLdiQFC
 W3HYxQI9KC4D5adsoOdbBhz3mRuuW4eFVznLqVoMSSp4mlcPDwguWtpal7iiUj9Pfc6e356lWJm7
 e6cRa4tfxbfGj3mioOk4LIzw_3EzZ5HThE0fL6qagUT91K3zuvwPvesl.mlp9dzBtWsK1qPof98O
 X7lSM8Cy2v9be_ALe1Xl9S.0ckFyJKkUYXCmq_eDdY56UGVuA_7wSYcCSGmhMIQ_B_9ngqbqaibD
 etHGEMGkrvGf4cc2bG16a7R97.6Aq
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8394d146-4d61-4725-9ab6-e269909a2dbd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:36:08 +0000
Received: by hermes--production-ir2-74cd8fc864-d5c78 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b559be960ee93a958c6ba15207aea559;
          Thu, 27 Apr 2023 23:36:03 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 7/8] power: supply: rt5033_battery: Adopt status property from charger
Date:   Fri, 28 Apr 2023 01:30:10 +0200
Message-Id: <a802b8ac5030cc5b0edc5f7bd5053f0495cc3747.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
can, let's get this value.

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 5c04cf305219..a6520716d813 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -12,6 +12,26 @@
 #include <linux/mfd/rt5033-private.h>
 #include <linux/mfd/rt5033.h>
 
+static int rt5033_battery_get_status(struct i2c_client *client)
+{
+	struct power_supply *charger;
+	union power_supply_propval val;
+	int ret;
+
+	charger = power_supply_get_by_name("rt5033-charger");
+	if (!charger)
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+
+	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &val);
+	if (ret) {
+		power_supply_put(charger);
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	power_supply_put(charger);
+	return val.intval;
+}
+
 static int rt5033_battery_get_capacity(struct i2c_client *client)
 {
 	struct rt5033_battery *battery = i2c_get_clientdata(client);
@@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = rt5033_battery_get_capacity(battery->client);
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = rt5033_battery_get_status(battery->client);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static const struct regmap_config rt5033_battery_regmap_config = {
-- 
2.39.2

