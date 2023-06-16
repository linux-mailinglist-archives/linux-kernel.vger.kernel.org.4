Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2654733B60
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjFPVLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFPVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:11:21 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D45359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1686949878; bh=YjKr9kfUpqIEiBIGHJQUMWUtyBPUuXHIW1WGIJcpt2o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qOK92UQBcz4YTCNRW/ckInwSTYODoQGpaIcDCWIvecXWa5I8Vb9SAyq7k4que5nszxSJsmdqHWSPyXoAqDcHN2YKYgqeWd5DTDk3zGJ6c+j3zqYYpijPqz10s4e7ffeZl0IH1XGiAtTxGwSOmBBp1k+EgglnVUxgRVd+ccetxUuk/brW2ahvGnbKJyDa9sqvyzZ8vCyDCQCuJLTuQWKSNlKDF4uNRinq3NJTfhsfka5XVVT0WDlSqwjgLou+9QlhU5841UtFkxcLV5RplZ41TZfnakBQFpdeYamx/DB0atocO+grUlzsCwPfBnn8hyj9EUJ545q1xrwtQGuwaB+AwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686949878; bh=xV9Ew2IZtRvoMvZ3PbQTQkgjLFdHGDcn51oVjLpziI5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fh8DIma2QIDPYYVdHjhdudItXi16ZqEt0Zam4tLBHMSsIHineJLTD+/E/idoA+DhYhVgFn/S1jMBGJrwx47rgF7qMCTlmxCp7RJEeZ1TxP4EiwzGvBzyxSQlS6jI+zZ7s7fsRFxaeD3MWCNyOb9QOfb8HjTt1s82wKtEsin4GujbM5dJ0oOJBXEj1zJIn05cqn0fyyNRhPBwX5mf2ZJKBMgryU+gqCjpRdFCUPzwVLU6WDE+ztXlfNoDbdnTmV6bldlR+LzjOL0yM0PEFgY+Lh0vzFOmXJuJWeYUlOUAKEmjFvwfhmJxu2B4v4dAxB3vZdp/udhUmwUYNL6Qi9ds3A==
X-YMail-OSG: tu6Ow8cVM1kFUR5B8_LSKVkmjInbn1l7C2dK1MaB2XCCxYKpXhtm8Jl9i_HULnn
 wNL5dPW3rdJ2Ag_NG1jf2VZ7H7la7yUfsABxO3BRK9TGA29f1pf2voBKjFvHR6KOtrMU6I90W0KU
 fhIeB4aaLQmFl9LZZg3fv0UvQl_kSt6yMua_zhoHNHMSSv1Rb1paEdpR3ZL0OqelN99ysfpuCPFv
 FRGGQgLyZj1NjoR2q.pUCDWtklJ9UwWtRZfH0BGWysZkbzj.vipf7Y6nm3H3XoP5adg7QbPIKzlL
 Y.P83m96aA.o7zTLO3HZUHuNMWaA_lJc3.Y2OAvRtcqf.DU8xR_XQTkYRLfC08Y3pfodNNr30yzH
 KwTCsRbA8Ky1pIdJldo1Kvlldd9ectmV03z31IUGQALuOYHt7mQLIQlEhhNQKKF526sh8ukW1ihU
 M5b63araRmpphHYC8tSQ7NY8JP.pyuCWrrFECr5ZWiS.qJvhIIUvzg.Dnrx3RY3726Sj1DKZ5U7H
 QiMbG7rtS22xx.qBppUdTtDRReV6QsXHOqWIkVCdToVCM5MElVZzU7aohhMKHa68KpyzCJB2E2Oq
 EJwlAcx9C7LhbMF7er28BdV1YMB7yXoIPi0Hndcr2xXg_iBc20tAJP3xWtdRUibx7qQwHAW.YAKG
 KdPC642bEbuvs2PQXjF4Pg915Vfuhg9JvW3Cgwh1nj_X4EQZQO4I1Bv8_Uf4eQaIh9CQW0HcMKc.
 RCW.Lb47z5hmJn57Orn5KCEJ0CYlcxkhZ3nPDRxnk32CH.zlZm0HifufBdgHrtuPb3PsGQQBEd5l
 xygCYt7oPDXNtM8V28E6Y15kcB_9Yfx2Hg7UwIwIqcCkkHWN5915YWSZ.nPEgOiC2r.6E9Nrd9Wr
 XQ2iW5K7r3kDATsyi1joKkIr0nzFyV3DowG6tgS5Zqi51DNPjIVnXmRWR9OGm1UrgUO4TcItEkVX
 WJXEltzWDGXyZYSTVS9ESmzPytKq_5qOI1wBqN9iqBo4.kZZa_Lpry7M6O31g1eY0ONfZ5uS3CWt
 KXIxLchoAJimymYq_loz0tXMoKiptqqklEwrdu0JU3Oot2jtQepjfFJRevjOziUyRFtvoIPDnk8m
 dlqNVrDLMvyhkbgVo9nHGS5kFf_R5o_XnyY41PvB03TlgPVSqROUdZaDMTuBuEvGe0WBQWZJtLfV
 .BHvnGa_ynmG3s7H339MWUsl.5KTT6_otsRyAHP0p9DkgTvu0eWNMFliD9QUHchjjZh94dlkD5iB
 ETWIm494f.HU.AQqRVqQT5z03zbY0dpFedwkBdAxaFK2xulbqLVXUCyzBuBRJdBrb3YeVDiM2aa3
 wpaPYfXYH12Ipl1cqUdV0vVkK8LDqIF48l7Vu8YCmETJQys_Bk3NOcOsTTPnFT.fYGRsw4Pk_JdE
 lF6905BdYMlwuT_5P1IjogqO226oCT72qai8jfcXRESBJ46QFyx8ZLIucXCZdHu1v7WL1hLlQewt
 iHzZ.GY.8l9V4OQwsHUnE90VATlSM94GQtQFYfbXlNnp81G9sa1xHA4aJjxjeSOXlNcaSrMzoN1t
 qNK8Q4wxY6Guj8QT4wEs9I.Cf3ijOvfqXg_SjeUmjpxCkSXA2DmCiZ4YBAkmD5KkWk54FfZj3___
 txy8GQLXRuXo7Pmo.FOO.S4y1nbExiSfNdF.IU.MScI5yv7eveaNBy1LwkRqEfeexcLVDuJsdg85
 9Wz4M_hHJMmmRR4mOy50wPn6W2Ssz4EAnUPFEvfrM4yMJ9onu_OTHYK8PHYwskxL24Hlf1AY.YrI
 sAb7le599nRuOxOCGfaoNktC4LgH641RVpblADHXx5hOBMFm6TOfGV0Slqvlobyr8zUmoRQOVz_f
 FG6eHMgb83V_QYhjgYoRKEXpPjScSNy7IqjVlGqEAMJ2sYFpGAAenYcxWxGOwpcmbWcG6pkpBZto
 SVE6s4VlLLyCvYoxjFerEh81H2lyhzUblm98u08_X4rRKWnVOjOqK4U0Uvb9yVzz5qwipVyOhZOO
 AViwEts6h.F3VZowoSoy_oaJ5MT7RlJihYhfG6yC9wi9V09x4ZyBnKs.NdKQYizRBN7rfmCIRqX2
 I143kwMeO4kr7NQSbUSf9tIF3a_ww.061IeMThKf5kv.AQoOWCUoVYLCYO_.OZ.qtUEoAIOear.n
 9S8zROeEKdgyenXF_p2_6glhtDtLZS1LJtGJZpP33bYMSNvvMVqDJz05cwV8jkwHWxxNXR0XkSve
 H6cnQMf1te6pqA8uqYinJLOg9wd689fM3kiJzLP6zpAhK2MBkfGDWZs5cMWKYdVc2ovRjIGhiVNe
 mCtvw2i6hhf5HuZzBEq5p92E_vrFev995yg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 03f28b74-5c07-42cd-8eba-1a8f59d9f5b9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Fri, 16 Jun 2023 21:11:18 +0000
Received: by hermes--production-ir2-7867f454fc-gg9x8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c618d34c94eed5ad1e4505ee686233db;
          Fri, 16 Jun 2023 21:11:17 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 1/2] power: supply: rt5033_charger: Simplify initialization of rt5033_charger_data
Date:   Fri, 16 Jun 2023 23:10:47 +0200
Message-Id: <3936e777efe1e9d11462ce81bb177690b982a807.1686948074.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686948074.git.jahau@rocketmail.com>
References: <cover.1686948074.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the struct "rt5033_charger_data" is initialized rather complicated.
The cause lies inside of the struct "rt5033_charger", where struct
"rt5033_charger_data" is implemented as a pointer *chg.

Therefore, inside of struct "rt5033_charger" change the struct
"rt5033_charger_data" to non-pointer "chg". It is then initialized right
away and can be accessed more easily.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 29 +++++++++++----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index e0303ca5a8db..361a36c2a195 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -28,7 +28,7 @@ struct rt5033_charger {
 	struct device			*dev;
 	struct regmap			*regmap;
 	struct power_supply		*psy;
-	struct rt5033_charger_data	*chg;
+	struct rt5033_charger_data	chg;
 	struct extcon_dev		*edev;
 	struct notifier_block		extcon_nb;
 	struct work_struct		extcon_work;
@@ -130,7 +130,7 @@ static int rt5033_get_charger_const_voltage(struct rt5033_charger *charger)
 
 static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -204,7 +204,7 @@ static inline int rt5033_init_const_charge(struct rt5033_charger *charger)
 
 static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -249,7 +249,7 @@ static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
 
 static inline int rt5033_init_pre_charge(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg = charger->chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	int ret;
 	unsigned int val;
 	u8 reg_data;
@@ -539,21 +539,16 @@ static int rt5033_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static struct rt5033_charger_data *rt5033_charger_dt_init(
-						struct rt5033_charger *charger)
+static int rt5033_charger_dt_init(struct rt5033_charger *charger)
 {
-	struct rt5033_charger_data *chg;
+	struct rt5033_charger_data *chg = &charger->chg;
 	struct power_supply_battery_info *info;
 	int ret;
 
-	chg = devm_kzalloc(charger->dev, sizeof(*chg), GFP_KERNEL);
-	if (!chg)
-		return ERR_PTR(-ENOMEM);
-
 	ret = power_supply_get_battery_info(charger->psy, &info);
 	if (ret)
-		return ERR_PTR(dev_err_probe(charger->dev, -EINVAL,
-			       "missing battery info\n"));
+		return dev_err_probe(charger->dev, -EINVAL,
+				     "missing battery info\n");
 
 	/* Assign data. Validity will be checked in the init functions. */
 	chg->pre_uamp = info->precharge_current_ua;
@@ -562,7 +557,7 @@ static struct rt5033_charger_data *rt5033_charger_dt_init(
 	chg->pre_uvolt = info->precharge_voltage_max_uv;
 	chg->const_uvolt = info->constant_charge_voltage_max_uv;
 
-	return chg;
+	return 0;
 }
 
 static void rt5033_charger_extcon_work(struct work_struct *work)
@@ -679,9 +674,9 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(charger->psy),
 				     "Failed to register power supply\n");
 
-	charger->chg = rt5033_charger_dt_init(charger);
-	if (IS_ERR_OR_NULL(charger->chg))
-		return PTR_ERR(charger->chg);
+	ret = rt5033_charger_dt_init(charger);
+	if (ret)
+		return ret;
 
 	ret = rt5033_charger_reg_init(charger);
 	if (ret)
-- 
2.39.2

