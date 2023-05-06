Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1F6F92FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjEFQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjEFQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 12:00:38 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEE13C12
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388834; bh=TVyy9/b03N8nbazd1B41Q2wdYfTHpwuv2C4n1t0mm1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cIEPWwpXOlt1jTqYWCsC4oCdtRewMPi6jLSaoNbXpB8wBoi9J6KyghdaGgsVPuBqc09/BlR5a8pEWx4Y7WObYoHkco48nHJpN2qEm3i7a16TMfRCBKggEZ2fcdqcCU52juGM+3+Mr+VNaGYd/474O4QebXByS5kesTtCDKUKGfDaTf3NZMo5jescGJAjFGrDwDSgLL+sgTx3Yaf2bqmXYw6SyQrApAtdn2dWeRDkoZABqKWKrPlwfIAy77+cOEywxfUompPAEaPTaQMWXsjurG4ipIXzDydM3RDjONNjJcQOaqG7vX5SutMaYMTDzDIzliWj9XPz1lVsk9uJ5mvVCQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388834; bh=ILkRoX3qoIYySx9+AaDdPHj7oz4zrb4LO33mjV167BI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DgzfpaMJk20VjZKOr3C/BHEgA7oIGIiCaqkMM8R1Z4tuxwOLCIJR0kSIZ+X7KKIsQRNfrgnNPK5l8ZPoZvu6vKYXrZXFupEzYxXH7t+7FwaEJrYgWGnFN9QorIWxN6+jMKSD7BfYDuKM1HETillY9iz5v10tp+I7iEpw9DF1fCOdedt0vNfTp5vZN0YZHl0ZHc5fID5+uCKxOsvBNGKWz764prh4OEazuE5yuZv4XjJyP9WGHJT8Swdr3Ng2OKChJPxQY+8dEstpjYj8/aY7P3lKh5QO/MVa3sW58kh7UaNyQoYaP9jy2k5VsnuEiQWaMFwih5m5DdZu/SqtQAwtdA==
X-YMail-OSG: 4sHSO4oVM1kTvtoGOnBOHkG0QTJRHYCftL8CltIYnHoeXH_FKLVAzPjGQWw7hCV
 1khRi83bpAGEjaSCRZhSDQgwBNED3t_uJ9J41f.cIxBO5gcNQeMNgvHdjOO2ryzP_3mDD5PTUeCJ
 v9W_kuW4jXvM_X_uW39GbE5r0u.q2b8OlnSektTucYYK57K98YPS6ICphJ5jBOVAEWzQ63roMiXf
 D_adBxmtWrzzDXc0Vt.ZLda54eqi.uTJ4fK_kr2zQ4ho37U7nXY1w0MsevdfpQ12gocIaaubEyew
 BH3Sg4K8Sap0LC0_TIhlgSDMCbA4blPo8ilW6Tu8jhpFu.tVfbsVR4bRlx8feMLTqAnmQgR7Z0dU
 uE3jytqxN0TYzeZyKsl2H1Qy4dBvkzu5jmsXwmpyTmqBlS2VWm5.6vz0djQsCXHW.b6hHc0ACPQm
 BmDbcajA6aSij_49x8D4WrgCdfBm_9Do1SiCDQfAjK1LX4vbVcc7QBudGifSGpJEA9DkafkbgBQY
 amWX0MHPoCdZGAEApLyaNuV1Hd6ayL5DgH8Am3edtPpCoRHxMY9z9QMMLn9bUEdQJGgBrVDmS07a
 Xyi7eX02j3hDZghuHhbm1QiPXWpqMWod0xWxWZpDKqOg_.t4QRq5tH0u5kUJ20CWR5ybWeks_0NT
 HDyCeiTw.thk9p5XogYdKox.iyM1.QljrcK9VybN2IK5k_LYHXE_e_O.St3CDJZIkPbfOnidESbf
 creG_1zziB5FK_3Sr50ECriRXD55MlgrMk32z.GwsaoaHxaplICLwTclsv8zICN2MUrt0GNU_S7G
 1idiXz7ntyK31Bh83Ko1So.fllzP63QNWqtH0tjWFzMfJbgRPbckHU.c73f6yTZ5ZYLpZONTHdXR
 JTqyuZqnh87NDuaaEXtEEQW95wpkqJevuVpzJSY9CrbgN98g7VWmgXj83IrOc7m7wH1DOZDx5VZG
 0rjR4wBnmDuULRvdWKcEiRWAw_b8g0MITKp1J6EIfV64Qx8w.0wzZVSUZt1cC8D3MWLBNMQ1GKFH
 mxadGIEadyyIILD2LVtO_BDsC8rVKHSC1XjSlm4tDhQJjqgJ2ny9XyqUetbb2UfBdReZN7nphpGa
 tlAINHeF95SlNbjbFZKJCTARqzAQAP.ZjZdfRiEG1cFUfZO1UC40uXRQ6dOMfSq.6NOaRVtkeuuU
 BILl3bQVf25fmsuWJ0CYFDoMiExHP3_S8Xey.HfFkoWxyUF7lW.SPBq9AUjovFSgGs5wRxcb0qqS
 F55f6c3xqCYQ4hYjpfVcqu5bm2gEG_WXvR2Vw0yvuaxJNhV_7XFH5F_zoSVbDnaZCKl.j46t0CVQ
 AGjSc7FJzvtsVHqsZcoBfZDfoPcIbZd3PO8QGIaS0bJ6f31pvZAdd6wCC5gRhX5Bi8ORlicYZJfc
 usiV_Tihn_NeIspS27vHSi3JlvPj7NzpO30XO2T3QsKBGCBSqeooUaCYwzUgfZKhu0.lf2hOZbuY
 1ugiLHlLRa50yru5i66s8G5OP25JV3RS5FiSWaptmvVvw1dtQw2V9lv.zlmNx2_Gms3BVI8Oeojh
 PTqaQm1tEeQzhDP0LOMPxQhv_nRJpuMpXyBlQsvWtWL0vLxzCqfJJtOsJbMG3CL.d.C3WltPNEqo
 ihiEQ5s.KsWipEW3Bk.USx_G0kjDflQzG3EAfydVlbGe2dYxaf6BKCwINWS4njnGJ0sk6cOWsUNf
 6ucDdv2ScaQEOK242FlM5Ialu8jPvDOPAjj6oAt29soV6Tvg4DTjZJDNApAZRe7LH88iZvYFq4bU
 X44TfdjKGhwEjHxyxjKXesN1Sq.V7lWJ3uHzOGp8D7E.X6Vty8tjI__aj33cdgWoGH1nJ2lmwlvj
 mKeAv4_p5fRiQvhaU.w5BWeMa0vHuSaR2xC_foNsAjMaSSApQh_wHMAZrm1PdylIknk64NP9FqEx
 jE0vmWsHfQSLB9Lq.rArkCvxEDRMOscsO_GM4L2xvMNTgF7ZQTLrG2G8PJqow6rCTo1oZzVbXfgR
 pyIoUAmlaE0gCUBbfOM7fTmF6u0_ZQfzz7Hjdp5Fils2JOcy0SbfutH8gLiibP_F.a4XyNG3poke
 BxntG0pXz5EfbH0MFQqqwQwjK6iOJJHU2rJM._i9n5PEMskSLnvKAh12YHXlA2WWBek0T7lsQ.Zg
 AiXJchcqBGpAJDktPxExf_0xVhyuubGyH_yzm66UMzAaxc1HnorAdw.ZJEVzrejyYGX0VrAXDthq
 0PF2HKb1F7K1vSOH.QZf9e.ke5p0_RXWAq1c5nVQgqC87VTEF.BYOy1j7fBrgo4k1wQQUmksdy0s
 5JcP3Ypp37ItH3uldIPUS6DViIIGK
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 4c1167fc-06de-4df9-8b24-0f0d3fc2a041
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 16:00:34 +0000
Received: by hermes--production-ir2-74cd8fc864-j696l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b71ff572232817f95ac730737b6b2406;
          Sat, 06 May 2023 16:00:30 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 7/8] power: supply: rt5033_battery: Adopt status property from charger
Date:   Sat,  6 May 2023 17:54:34 +0200
Message-Id: <20230506155435.3005-8-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

