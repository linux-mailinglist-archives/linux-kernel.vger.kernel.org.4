Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08AD703E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbjEOUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjEOUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:51 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951211B54
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181431; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jEBBahPb3SQ9TeLL/uJ+x41sD4UL2AAa/47ug7aWCX0bnkX3GmZLT7f3weD/kC57koLEKlIXEvvg4pyuyOPGF59YuMthUOcvSRqkUMDluFZdqa9M1LSrv6IvAMSFpd0glkLOW8ZQH5IhrZOruQoz/6dtMTGLO8fO0vo1ciS/3LqbaiAKHCevdaJtiD7whEZ20X7hmREcGtJ5Uu+qTHUHdfwbprS4VhV8Z8hkqQNGw052avciCYOkBZ2+Mw5lAIM2dOxGrokcwsJ7bC1lq/RQ4xmrjbfA7h6rnCB2K591T0CTfU9No0wxzeVWBlt82bpoAe/Vf1jaRHveTJ8zwN4iPA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181431; bh=WppaCNL7syHbhGvX2D8e2xgLa9bkIY2oui8YvfcnOMy=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xefv0thz8dDlnC6MR2oMy/UQlNw2k8+NWZIvg5c1ZwtyZJpypBYcq2Z8P2z01zPDGOzzM71Y5XSm9SWh/xm5JR2bjmBssMGm1piMF/kTQluDzbfKGwEF3W88iRscZFMgZRuHGIpIoBEdda6p2+YVujAC6vJBbjoo92lw/jGxXbd9xb6eFf+2B2Z45VirH3Bxia9Z2nKWQJF1464Rao3UYXuvrdkMUu9PWGojrcdGBOyL37LnnLFl/Jg17PS5dQvlL/3AttBFtj2Br/75Fw4yVpAEsLejrwUYWVHaiQ/cN7ctp4BKwuzpgZ86dhy6nNEqHHkyjxAXw6Kiy7c/9MvB1A==
X-YMail-OSG: EG_oagUVM1no2rIIGhCyLeOFOVhnAqqo8UpR.Kyo7u747TowdrGJFw0eSAztJgp
 j.zpRO2BiLdVgSMdj_6.UPYz8wWtiRrmSFr4eLryfRHfUkL6lLCdo_RYAqDaajfaKUfRV.HpO9CD
 hR4vg9LLcBX9c9wvgyECZmWuwL6IQ3NGb7d7jVW19BOqC6NTjD.qjMXuSF5wyTNGmF.oFyMvy6DX
 tfYV41sRcj5usI48PhZpGIGei_m.pWVqAiOlnGnhQgJ3XPs9vMhjJU41hxAIKEUg2h3T8e1eGK_0
 kKFx4u5LtrCNu4GsaHCrzJDDkulfdWbVYE9Lq0XrQITrKB4HCk24HCY1KRM4_6WUmgqKIOJj2.RT
 CFqBxFH1CXwV3RCZI2ovyunfhuhQXwusKUQtwxINbdNkTtGO_Yec3s55jOyXJfSLyoowuo4xBp7Y
 5EpGP6V2tUrOoTytj9wVKUs._tQvYLnsB0qHTaxp6RcQSXFLvrsmC1JPdPCkUtahRco0C2dcEwjM
 M7gpoCzHAa8TKxxij049AsBKmX.p6Q8QULKvIiSXAf0cgfuHuZSbtrCU0zi.Xy4hrwNS2h02Gfb.
 dA3hC8iaIptUoeL3CmheWv1ToOJ9ZpHr0hrH51nNMTnTXkWhXwLtXSLg87wKPfRLfErI3qb3yk0O
 auyTlEISr1fwH.NhPcs3LvyY7e2EXmhxbVvc5wwZtS1G0WNeYfqWZb6CkGlVjuqeVtRQK2h6UVc.
 YMwbcYtq9fHBA7VMo4QqgyabHD5k3eNyZz_MqVz.3YW3.B7Zh8K91E1OOyM6kBTjOmShe1abR1jT
 x1YSHmtPpRpS3bvB8mJ0d8xvjag6u87vGNhJQonk1okRxlDcNNmLCmUCRRWsnBVGAs8cFAgoC4Qg
 IYfQF41Q8Z8MKDt7rOgGJWu.0kRw5ipEY3537Esit0Sv5lnJLa0_.YmjBJeT1PBNzTI1b.0JhYd1
 RivmvuzIgU0oqXI5vP0Bl5ry71JuQDEX.Ux.45yqCKmYMSanypqWEVswq80EJqq3WET3zitq18AK
 k6u6iqG9D1DO.UkYSF6Xt__Pr2lurIUR36M5Klyc_XSx7l1nARiw1PkAhGesVUKBSsApt7DZd8QC
 0.1D5cQS_PLozx4vR9pTTyJ4L1XU5WcskZHXu9vFU4URTSgUaoeiAvPDFBiRrUWbF3dQN_a.xj4h
 KtMJ_TvGTElNgEFlOwKp._nfPwFgyFYzllprrJCbwsE5TLdObmjo5UtQIxYXtiHDhQ4Uyx1P7jFc
 Wt2_T7C3xUI.5_jUNY008K4s16FeSbx45YrbsFdevjOOIyr1Sv8gskHCOzUvC8SC8xFp4N1Shy7l
 mgSfFue7A9hz06E0ZJh84ilLmZahPqyXiDXBUtwmLydDtNSMZ5P7oGHMgDUbCXgyc9qMJ5ae1f3x
 0noCkD2UeGOsNz18CC23sLntiPZRIbvoZstPd6aImpFkdbC70JufCKeftcym1Ce2dG2c6AyqycbT
 0e4MGHuhe7eLCs9f7MzFh7nO39XYd_IhuEhlfQC_eBZSEAIZ7vYSV_yDVlwsGLeidig8VWVwiyF6
 uagBS.At8Cp93ntcZ.meVmeOCVzCfNG26VcKrl4HiGWQ5sgJ2y0K1LvZEV9Xk8XA7y466uQ8PD6u
 2MDyW1Cw8k3au90lKRBSEvZHwgR_SwyffLsUKkPVQFkA6QWrbQ.yp8YsWmc0vCDq.5JAzDG8_4hl
 C5CIUYxWLUPokQ3tV7sq9Y1OhRzSjezZEX_CupiC3wQ1E6FR9gSMHbs4CcyiqVaOMMbQJgf8KQbA
 qT0jvndges7mjqxT.7ZfIoPJVFK3aBmm1OM_nSQHxvI8yu1ALfHuMumlH0BD.ZiLeoXlVI7R3JBU
 9oljZGvesstZAgI.FN6jA5lFdU5cKNjWeSVnWLGxXqKbnCN0siBJkFQ0hS67EwT72lx3CpvIGHPb
 Bv9EaD5ocvCojJziUJKec71TXV6DgcqoZO3eYRf6alun8yC5qpIOkktQ5.KpxCBwpjnh_VaaN01Z
 x1UjEiWivAeHqm1lxTy7z8YPhw3FuGNIoe_B.LpOy935Wbvju85.p80PvybfCLGtY_qX8RG_q_f_
 WqxmWc2y5rkHEz_xEOhpCc4gtbocunR6ZxHbY5xQj7ZPvv_TPY23J8Hw.aTbJd1tHKEc0fi7vLRK
 TPnhVhxYEtUBE1qoGqWK8jyliOMcdZgcyg0NT_FgmFqLMS0k_goZIDPR5McVlgHYKPunP30lpE4o
 hhjW_QrpGluX9TBFjSHmuoB9gVbGcdNOxAW8i8P5dgXLj9zNwxauDxY_FHJOSQGfMFMqBio_FZ4_
 DwNQ5wUklVuqEMX4lG2Kj
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 80ed7746-577e-4060-8dd5-e78275993d36
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:31 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:26 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 02/10] mfd: rt5033: Fix chip revision readout
Date:   Mon, 15 May 2023 22:09:54 +0200
Message-Id: <20230515201002.29599-3-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201002.29599-1-jahau@rocketmail.com>
References: <20230515201002.29599-1-jahau@rocketmail.com>
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

After reading the data from the DEVICE_ID register, mask 0x0f needs to be
applied to extract the revision of the chip [1].

The other part of the DEVICE_ID register, mask 0xf0, is a vendor identification
code. That's how it is set up at similar products of Richtek, e.g. RT9455 [2]
page 21 top.

[1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L484
[2] https://www.richtek.com/assets/product_file/RT9455/DS9455-00.pdf

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/mfd/rt5033.c               | 5 +++--
 include/linux/mfd/rt5033-private.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 8029d444b794..3eee4242ee02 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -55,7 +55,7 @@ static const struct regmap_config rt5033_regmap_config = {
 static int rt5033_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5033_dev *rt5033;
-	unsigned int dev_id;
+	unsigned int dev_id, chip_rev;
 	int ret;
 
 	rt5033 = devm_kzalloc(&i2c->dev, sizeof(*rt5033), GFP_KERNEL);
@@ -78,7 +78,8 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
 		dev_err(&i2c->dev, "Device not found\n");
 		return -ENODEV;
 	}
-	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
+	chip_rev = dev_id & RT5033_CHIP_REV_MASK;
+	dev_info(&i2c->dev, "Device found (rev. %d)\n", chip_rev);
 
 	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index 6bb432f6a96c..b035a67cec73 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -71,6 +71,10 @@ enum rt5033_reg {
 /* RT5033 CHGCTRL2 register */
 #define RT5033_CHGCTRL2_CV_MASK		0xfc
 
+/* RT5033 DEVICE_ID register */
+#define RT5033_VENDOR_ID_MASK		0xf0
+#define RT5033_CHIP_REV_MASK		0x0f
+
 /* RT5033 CHGCTRL3 register */
 #define RT5033_CHGCTRL3_CFO_EN_MASK	0x40
 #define RT5033_CHGCTRL3_TIMER_MASK	0x38
-- 
2.39.2

