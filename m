Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3F6A6280
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjB1Wdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjB1Wde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:34 -0500
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F862364C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623606; bh=tgDk+TZQ7fwBqx1EZFVd7dk+gNzKRgzsfoB9HPZliCM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MFgeLyikwgC1V8wNrC30LV5407zKaRwotcMTLmQ9XOUiK95bK5l2fEB1rGacKxL+cbuiInk16TdUGoUVX6YDRJCLTqPs1IBMawFw/3izn+NbVqApwy4ylrjwtwjxTeQMApIs3VRGdcEafHg+u+z12uKfQR3WVsOJRaRAQDVlOEeDK24FB7GPxKVkfMM5us443WWQyVJPQmLMLBATJR+RkszyP6dRjy6p/QpGqiIw529kuWr5/SIiuf+Z5s1j55jkxcyya8y5/CeDKHTcjy+pVuQNyWfk8NFfE2YPWDy2umcOk0o62eXI3vMafC31ZtlCFYbN2oIsQVG3sUJNfEsrgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623606; bh=cuwU/M3pDTaAi42zbzXNOuKnzDT5HnokJR4+BJA3mLc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qXaE3LUNH+pHSSsffFA1R1cW4nbnJNf+mjkdQmZPGfLG+h6lLcwn7xMJO5IygmJ38odeR7N7MPL3UQl7E48C2BIOCR4fr4PNUao4/mfpFNr08S7WsR/LsrusUKHqeljoe5CaUcn7TYi87LuROhzpDsoRR498hnB6AuPcjFweZIQiVSMIZ46ALpPmtaZ+ycq2kDAzJaevVQQ1vltcH0T6qCe+QG0/CI97MS4fWiGObtGlXjYq45Tp7F55n0qw7QYsjn8Iv+jxrLYRCnpMZ0KEUNebJ7cjjtxwOflWdYDoj41/XtYxapQjATHZg6DnT9EU0tNfa+miiWU2OfrQZEakZw==
X-YMail-OSG: lpR5oDwVM1mkEMrFc1rJ2gJGpYwKBVT9ACE5Evlyd22LPSXUZL_8EGLBZYn1Yu6
 c2zM9zRq_5UqP6vYoPfK76mT24dTEeUzaNJNrRxRvO0IKbynGkYn2CpQp0c6QtgmMxhLjbVaS43_
 HqzZU3jFBKEFjGt1XlekuTQididgcsTdy0xB7wmsmUjJ3yAEzM8a8QiZ4Ur44exk0prTh07JFy1g
 qNBQqA5C0o3Qn8OqusBBjBJtcYrZh3nVT_2n.toJzvRdcp073LM5Xnv.iu_gTUZDRUvw0ia5ti8A
 OILqSa.UQiGDuOKrba5BeLefgxKfhL1a4zITAWVntuDpo2zDuLSOcDA6fz3UxHEaXtICs3RuyICH
 00bxiYKExm4ABcy2wvJaZ0be6z9CBtgk5EoyBejUgNeLaQ4RnSDIPJ3cuiY7gaI3MnkJyelX.OWi
 ibvvUn5vzSLC_QDcdu5Qpnc3FB5tUEQ_zieqLJGLfz3_oidXzX8LhUQfazeH36fNoUBdG0j7SUZM
 M8Uwv0RhN__EHDKMaIonERCfejPiJvI18LmkU2C4vpqWejhdtZ7mcJW9Ra_l6liGZj9bQdFQy1mo
 VaEQmJNjxIERPuZ49JS4NlTeb64NMGShjfin1aJhMyfTDwpBqrst_F33OWUbCt_0t4vgXpgdozB5
 sVLszvdGu1tRFnUJYFJ5xRaBAb1oYPWdw1zFJwsaHfBlsFSUVwgndpBZiznkExdfAKM71qY4wrF8
 qsC3MgAv9l6wnku2Y4GG64rWNJNZ9I11lo40eA.ykd__QAZ4VqLPVzIXghHezyoCGQ_.PipqMOVr
 snt8XcYPjQB5VrftpQknVGWYAg00Rh4pNsR7rYNLaMw1yp9hjcHX8T.H1TvKPj25yxzsYDPP5Wuh
 D7ET8FFfXRxZnSABBrDxh820SeudI5WJVRrO8ZmTRZCac9zgWKQUosooQTjT9te6KhE2i1U_hehr
 x3oDTqX.mi3Cs.hna1AO6MtT6druBDeJ13GCmDSUneivcOOHQMbevcSL5U1746CktS4OOASd3UxT
 gC9UenlF0KTaqqmn7S2GZUy0Gj6SyvcNWQH6FvZcKusjRpA7QwZ7sMbF352X93GFmlX2aHZqobFQ
 q1uZM.svjjHzFIqbNI7exVQkgxh33jEXjx2GzvV5wvnng0v.ZqRpfkSjDUoRkYCHPMSizscKeoFD
 55graY5oWw5IEu.CpXFf6fPDYdZCp18eIA2aTLmR4z3WvSUnHdlU2e88oL02sP1JcVfEluVArmtl
 g30GK7G32GeDz7wzGx4m9ISmUzgPSvpdpK.HrMHY97FNJC5TbxGEU.EPuBFFKjbO.qHWl5IL_j3Q
 FOet4NISyyvaScDFYj7LMtegjIvDwCMc6r205DOVwMVW0IoijxlmYvvZrkuZ2QqZI__lpac5sC_t
 QHtqsFqf3dMEJVi9qVBehdAJlIFO9owJnScdGEExr8WRiuFyIy57V5mXyM7acegqBTEdGAVDUTqj
 yiNTCRDYt8W0c9LqZAtPLwjHeAtLlf6rE916TWhSonYiWlRMaP1pcz9pq7m2iFayHMtKzcxOkQFI
 gr7zKxe6jVq9AEtCdQzfap6YBEHmIGNtIZfqQuHjQjq9EPRKWmGZEyUSikypPEcFfsWWCD15Jail
 qcvApA_D9xNW5EdrW9TFZM1wjsBiyHNdIUMbLmkiA6TozbgxYNeK2Lwb.I_dKrwmmtlRfR7kA2X0
 zN2zJdc7vMdoOMCnEASFsRc0BDszqYA7geHAtzLEAigkXwsOskKYpSLyQVYPORa7TT76ArGSKlmr
 vSaSQu3_ZMNoMAPXT9Mr_uR7AokDWVyCvsa6pf1rtUXoERGhjpEsGB.YHKRycIFGJQ747VlAs1qz
 kS88JoskC_Ttib4rx2XEAuWAR.n0od1Wi4rTPVYooz07b3jhdml9AE5dNioYpStktfPxSKPAv7qm
 9Xs86Zk8G_mkj7eWRpXufQhyZ7jui87eiCueo64PobzGygddd3YVcFpsvfRpqXHXjkav6QnOuIq3
 rGTu8O7xrvd7sdPW1uELJYwZo3vH1_1fE_qhj7yMN98sv1HR8JplEXwLyBlcaeP4_FgtIDi8CbkD
 nCfq6LkpdW.RNQk1W2GnKm7pRzodsbGu7ZWjbI1P9H1Bx5GRCVkkhMvPMWKzvJOZqZ5kTNX2HYmB
 vUf63fT6AVXoTmWF1e0I3qGf.cD6HG.etF3Q3Z3qPnmDiDtsHl5YOg_p71yGweMqU.idDn6cQ6qp
 NF7lB5qZtlCK.WPRwdvTyHj6PEeKwAIfoHn0Irw2PFLQ5JrMgZp1LSOFsG25E47d_GgwzNC3skAC
 KHa3q.pAvkOfrgI2O_FsfU_r1ECnWmoI4W9pw0xoeqJNEVQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:26 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:21 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 02/10] mfd: rt5033: Fix chip revision readout
Date:   Tue, 28 Feb 2023 23:32:19 +0100
Message-Id: <a667a64d0cbeef00baed2d4b117ba9f50eaf3988.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/mfd/rt5033.c               | 8 +++++---
 include/linux/mfd/rt5033-private.h | 4 ++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 8029d444b794..d32467174cb5 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -55,7 +55,8 @@ static const struct regmap_config rt5033_regmap_config = {
 static int rt5033_i2c_probe(struct i2c_client *i2c)
 {
 	struct rt5033_dev *rt5033;
-	unsigned int dev_id;
+	unsigned int data;
+	unsigned int chip_rev;
 	int ret;
 
 	rt5033 = devm_kzalloc(&i2c->dev, sizeof(*rt5033), GFP_KERNEL);
@@ -73,12 +74,13 @@ static int rt5033_i2c_probe(struct i2c_client *i2c)
 		return PTR_ERR(rt5033->regmap);
 	}
 
-	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &dev_id);
+	ret = regmap_read(rt5033->regmap, RT5033_REG_DEVICE_ID, &data);
 	if (ret) {
 		dev_err(&i2c->dev, "Device not found\n");
 		return -ENODEV;
 	}
-	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
+	chip_rev = data & RT5033_CHIP_REV_MASK;
+	dev_info(&i2c->dev, "Device found (rev. %d)\n", chip_rev);
 
 	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
 			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index 2d1895c3efbf..d18cd4572208 100644
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
2.39.1

