Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5716E3842
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDPMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDPMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:13 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFB3A81
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649106; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KszPe5nUvNjng6faEv3yoQCb0HsZzD2YGWMLl/YxpjKxzXDXSgY8/SMEOHg81nvlSOQwKPrR0btBR5Uo42mog+ShPLwnLkLJTXjxE3aHterfs7/oVofN9quuRpfbK4dUfw/y1NHLbhqSsdT3/b1Ud3x3JV43YuXknZ9Uc9J2QAhgIkBSaWByxvWcdlyvM5KsbGnt9xhfPe5ztPMWTa65JO2xCliYgPmHkX39gSVBsK/8/8uuX5hi8IBFcwQFnFmfztSCQL2a8t0tJ39DPdYGb25/89dDzHNxC/xs5gKXSIitjG+OsX3/UfmB8j887drF3VlySUSRQ76a8xwJA3GFrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649106; bh=PmzEobjZYlreqbgwJRMQ3U9bSsfqaPE/JSDDCP6IjM5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FPTF2ZiXdrGn2NabX1DCmBrxqvVhrA7IofWPqKlEaH4b1Pse/bgmdxqQM1zRsH6XuJpLIDNbrDaQSSTDxQ3FnSL8cXsdPzi/Ru4HEDQxHOlOcHQaEZN2uLMfSK5U6QPoi+o5cZaXh3ZcVkCrUaQoMsO3Wtt3goc2wDyo8UkNP9+CF9JwLIZmcikY2LIZIJuXrItB66+wmXt8Smjus2tTEyn/juBvMieSO6XFRoFzkMIQHz5RLBY3jY0uoEKBQjELizWulWkhD6rqXCWQpYvnooRA3HqrBNKnnT7YA2tUjsvl66ffDU8jMlMfy8OsjYVsbaWzFBSZI866hiqQi/MzgA==
X-YMail-OSG: TE2VDu0VM1kkL6rkZ6o9hLwaMBLffhFWwGm9UbE3kZjkcmhjU7L2rSVHaVfwmZR
 EbHHP7FEVXNLkdVmkN_Y2nNxIVqsgZ6iBvgX2Ed9ZGlZDkhqB5_zOdqElHZkyibq3MdIbnCxffuy
 pZ6KWUM0JkrSIzhFVSx3MO4XhTee7MT0H.ASxC1p8eEhweuG1QXrsdRgpL.2gMngd_1u0nO2pHzA
 uJdwAaNj_PVFMYpV87_tmu7TWur7tH6RzLEra_akp.omUmpQA59KZayL1N9sL5t4VRnGWzRLGEAP
 fzocdWLYnetMXp2nXjhy2PxSaB3LZvJ1MuOBXoDRMEmD8vvNh32bHeApo.neWA2AeQLQRjJqtGVk
 NhoBEehuN4j9m0hyyGKOPeLqTr44_6DxZ5Tsb0MZxtWq7IU21b4BKi_fOWBaJFVj0om6jXlUz0ZT
 cbnEfl0WP1YYFRQdU5hd.CVMKyKNXaqihfgcTqljuA0tiY5W6DdRWppToAA.mUrl2DiUWXZ8k9Fk
 ogfgsqLsgaJILJDxg9osUeuEMdcDUvjfNPZnpqqvkm71nSgwBIVEa5.6xcIQbTLJdVNZWGEPCGFd
 FH4l2W0LPSch2KsiTIKhvl2dptgXWz2TPrfwijqhpLL.9Fe0ciU4UW6mMovO85ttJkNr9r2LQ7j1
 m5w_qh4FRV21YmznPBBl7clJRZQew6rX0f3xV6hAB.pqqd3TTK1KmEv0ZWIdYnKfP.OYMWUwWS9g
 s4xPU1ffTJ9lSN4Ohoo3hUqOcJvWkmSPdhEONxWPj2fRH3lVysH55SlAAbA2fW1_j81RjHtM3_Rc
 FVTtmhf4hxzfs5QOtVkRhs0IAsoYYuz5wHp0AprSnaAcyh_SOZqGwJRaaPxq0FNxUn.XcfJvJhq9
 g0j12uzBVzeZDxm7tW28sv1OZQ8Y3oK.utAw1NLtZp9Xk_Z_M_cfRS8rHVFNCOwzLdYNEzBLqTF.
 CYx_UdwzEB0BQO3DIz7lLRP2dnRisw08NP.mltZZ7l5ypcpJuregqv7gsyesovqr9YqRGnHT6cAV
 eeDHSV2qIXNQoUdb3BYwkZXDbOJvyYZTx9PUdYte8Wwb.HjEWBtuxQ7WmCf7HWz0SokMC9qYIwPJ
 FKeBOfhryULzBA9qk0wGxln_ur_n4XTienF1qozGbJ6AWMwdo_w0CRJ0Hr0PspZSDlPGpBMdq1C4
 bzEQpuinJ2LjfAh8xt_sJ.bJv7QiFji_kX3wHDlVeyP3oFJ68kp9M_0SyVBixvKOyGD54CLhyL2h
 2jaR4Q4UgBUC06kyBQq4rdE.HU_6dNRFxkOIQfZ_zeK3hILlAenVv2UfiAgXY_.tgkQN.NHLJNpW
 X716glIO9ckrVl1z9Qb2cn8XE0ZMZ5HX2UWp9l31WCDN4m0txNslE8irp4LPhV_kMVJADyaJKxyu
 Jb50X7gLdaSwInpptMh0mAmFdx8VeVroHgLDd8N6l5LjN7_R1tlGkMQT8td77rEntJ971fOv7Y7t
 xzFtdl4R3geuwgN0r9R2DTeB_qAj.4HQhScsznVmtXtQP6Lxc3CG0eOdcQ1x7AwTpjAskrdTy4r0
 ubSseTslvfRdcAWAgBpnFTNZbwL2tcwkhqmrQWTbNK3.dPGHldlmJtm0Mf09K6T0JZO8lUGGcsN_
 vz22_lOGa_KHtP7jFFpX1UgnTjjldrnFTN4l_xMdY3QJYjwmVongkNJws7nZIaYWBBxE7zVnF6hH
 pzpkYmd01n7SrnQwCJtmXxlhfwwvyMxt8VqB6v3EhNE1i1TQcK2c7rVTV.zKM1ciR.3_oHE0MymP
 w6Td1y3XZzDI6CEyG_8zsb.QNQrJ1Xt9rIZaZLBgwz14e.i.bKOjXotYLnTIRLrfPsxwyYa8ovQX
 Ze6d9wHSJuAzMpIv8KvcqJZybbJ_IGC67wGBNICrBFrZCBqeoPeP5X4oN7ukpkBOpmIJBWjqrZoW
 rOdMii_4MIxzA2M6jB7lY1MAw7BsSdekdIIkeflwSLttVusNlzETwsmknOhXkfmNQrNFFsskwAYW
 Dj9y6iL0nG6Q9LzoAwOVYmMjjsz4CiHtb5151u78mM2TXT33SWoh99ijkLcFImqWgbKTE1.1oCxd
 xU4ssssvH9CSbmNmXYgNaifk0fTPPUfEYcp_u8eQcnChYAhb5_xPIIuVHd8PehXiuUh5cSXTjAJ0
 NvmmufAezPNg2RZWXLNYeeYGC60KJr2o5wGVQtl36vlR24.5Lcy81Bnqw6xkdjvsrlED1ZNcUIjF
 CCMTPWgjmnSexjzuXHzj26oqcfMATY.3sfuN1rZ.smrizQnnj6eHatURYV64YTmGYvfCe7FG6jy8
 nhCu5JlTaT6xrsXeJ7SfjmMbGOFp77RInhYlCaW01Y_U79EY-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: e071def9-0b1c-4e98-8221-260d1abc3263
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:06 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:45:03 +0000 (UTC)
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
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 2/9] mfd: rt5033: Fix chip revision readout
Date:   Sun, 16 Apr 2023 14:44:29 +0200
Message-Id: <7eab1fd42adf0428cd80cc2b4c2fb3d928014125.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
References: <cover.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

