Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1F6F0EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbjD0Xa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344249AbjD0Xaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:46 -0400
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438D40F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638236; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=izqek3gebLUiMUc++qyVsn6UxbtTlO6eLBY78E6g1uHBnCFMspBzLw89x9hcC7Us5j/b6Ap84i7bRwDiUgKP+kDN47oRG6ncHm5hbDALcZf+aYQaBYIypQ1qlK311wuGWgsQ4PaOey1crKi6vA2/qIyOctLCY2a33HL+mLTx+IemPx/+kkKdYnjS94K4OvAG6xInl775mh/gStsu9nFaXiRJWPkb93uRQeml9+z0WRJpL2sBmkI3DSnNeZIMK7hDmXupoSi4WeN6ZOuBFN+lceSD8ePbbjT1ud8SnCzs29DdegZTP3/dxhWRn2n9O9PJ0+ix3Ew0MuqkRdO91tBY6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638236; bh=dWiTtY/4/MaCv5v/MxK2MH2OmOYdRFb5lS37KN6alH5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c3d29tgYDQngI638H8pobPDqyF5s82vN6sFnYq7oOkftxPp+p9d78hNuJ2sE00SpX1e6Jth6/lKa0aczWU8Na5kNNd1yPbJY0jDJcnCxQRjU2XiKIy4FqQVkHFKNshyDcUHIXI5Z2uPHVFmP+gkbrpvVS3p/rY1bFu4ntczPPFmBlkX8a/q5Hysj+CHqrLEAU5cq1Fwammbh9OLt1zzt6VUF6ZDVIS6PM7rKmqqG1PGDqs1/rL159C1j3Kpjtws+9IhlNLFQsBM7H4qrGCBSrb6TxqeHM1HUV3Sj9caRs7UI1eLRmShmDAiMU7xGH3KeEUMCiEF9+y0VhyR9uTXsHQ==
X-YMail-OSG: xV6o_T8VM1mMCxldKnBSjCDCAU3ScFxjRdNVVrb2DUwiGWI3hIGgLk0f6YWtMNM
 Zx9DCNWXIe.BCma2rty502vbXglqxTsWun3D4Sg1r0ZVoh7W0fusCHjyrwxKQDdq6Xl4sX_zzu8n
 6z4PAVrdBaRuTu_YATDyZsBE37OvL3ld.a9Buo631ix7hxPn3IXHFgv2WQa5Dpt4pW8r5EdvLWt9
 B75XxLvKNzLJCueFzLSuF8rNZ39vC7N.1PIVn4njzMdbHRkPRhNRfLe4kwZ2w2mGx2nSBon8i5Uc
 gFG4s.i8tyXu_ZkrGQJiJAgUH67ug0rMXxoxYg95pUDx8i6h6WHQdZEsdTGVyHhigRgpDgtryolx
 een1ULFX4oYOBM_2s0so_jwxBCee.978VZdEvuXbo90uOZ8rLUE00zF0mIna9C.dVrPvPq4rh6kI
 w4uIgfJcJP2qylb0vXI_tZst5qWBFUDSRzKqja6lFNbJLbnJBGvAWMSZ8ri6p8GRwegBgcuL5Jfq
 Ci5i1MbK_1Of1kihOBzMtOEIzYKgffsRA.i.HN4in.MS3GDrAS9.ddRZCkLHIQimkBa5fn.54oCj
 k6La0dxU.AD10tlC2VA81J.LiT2ymmH7yHXo3z3ZKtwrfTXbZVAEO5ijfiIckD3bS6_5WDlFhZZS
 RGEW4AEv3yBdptrg71xMzgA4MIEiU7yrBGibHdk3AxoavOEHOrP4G9m8BxlSG8DO5psk_EZiGSID
 GdrdvxxdxSMtzGvq5UtvLT5X1retWVzYFs_4fDwNPUps.R_GfioEDcgSoRVm1fuwWcAFJ7bg44kt
 r3yvuhuJZn4TUwXCwRlL7te.p22dsZEQFe5w12dwd0zMnvA1H29Rxg1zggBOPJ37IlipGfqqv9I9
 NwinsVRAZRlSOYMut5T8KWnTcYdyRIQUtJgTcV.OTKUUdVE1fzUE1p3Sg3EiWc2Y9VcUVd4v4N5X
 aU2QLLksW7IiZ.4YCJ5zndpCkWysgXRJG9_74HSRQOSA8hmXSVKWiatLU5voi1ujV4zI8RF9TE_d
 YPTvdQo70PgzFq4.U6E8hUqmdbdPnAg6Dsc6Y3IXyd00fKA3oZ9A9.cnjibkyo5RzIBZ5ZAmDGNs
 LAxFtL11ey.h8qYTJ2yghMMttGuv1gXL5wKkozjN32AEsMUe.AzZuzMzebpeDcBEYKEpLPDbn9oR
 J6.PYRIb3n06QBBErEog0ZMZSrbnu8dk727kaEog.0m4uN0KXxlrGd0m3ybMsR_WYBvfexrChaLX
 ZQeXhe3DAW2ALFr3Oe.bn7Q42ylnPS5UDEEKhRZuPYzI15oGgoISNvnAaGkOqOJcZ9uPfYPHmID8
 MFUuMxuXJ88bWSi0x7t947dHl1pjHGaCZOgrZ.GI6i46lNfNsmk1EVRbxXSR4lCwuiEMwcDs.GfW
 KpL9IQKIrPyKYdR5ZRj0jmzVK4qmbZe2fHBHFhRaWJFJmv1kw0enVa6tqAadF1ksi91AxVYLxVPv
 LAXvMoKc6tMeV3DJI3de7CG2wYiBtptDYpqJX5Gbr4dlXbaP.qf1vZ_zP.iE9k.PuAOTkHm3a2_c
 3Ofrcvq4xUDXQCS0UUcHKvNIj9XyHEJchYe0tzGkoZmCaowxdSXeBkKneKfLNpat8oDKRs6SmdVn
 Cld51L5MYcbNj9EoUWo5H1ARGokXTgHWPkvGQA5DqL2qwX4RIheFnyIZheu6DDKXC4vfzekvBJs9
 Txjum4dZuCJ5aghNvHZVPTrzz7GFs.WCAnplrvuuDjJdju2opqAAu3pR6HIQz8OymWwmiMSIESrM
 CVAhSDUaZnYX.V79rwsw3BPPGcozLgEndmyYpYfL4h2c0Wdsn3WUvSbxJ6b4pR20c7Io4H4_AAI6
 Fp.oCNdWMgR9ViPmLk4csOQNzCt7vhzWREIkGBxlru9kn2JVdlNiqffW6I3yQCTG0kkFGQF_rlFR
 YSUfAGjyLLBxL39Gwy6zkpzejCINQ4PmfpbguWF74sMmZCkrj8gwGZanS1_nrwMcCh03BN6Uv6M4
 RSE47uf242B4jZrFezkeR7JXXxn7Aw5wrucbvRFQijOYUy5fcynwRnRZJ6TiWxFsz3JprIRWqINv
 0An_KVzh2d_Z26xVQ0mGgN1J5HpM2oSfdO998ZtIVA_zOJXesdtVI_hJaZ9YWe527pcGUhVVjybu
 UWXRFnKQGs76TIEp1ZmncXIJtzXInQirfrHZK.GG_1konzXfsGj9N8x3bHBZ4hFSuiVXLAf5wmHY
 3baoYku9FQLU1GnECNx_JOWvBAWFJ.RR2ltvUqkhexCM9lw1Jp2yoVtM2_EVQv0qedaxW3Vzqmwy
 7x0DCrymQUNf_RrKJnidErQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 2e63afa5-df03-43b5-bf09-af9c6ec7a812
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:36 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:34 +0000 (UTC)
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
Subject: [PATCH v3 2/8] mfd: rt5033: Fix chip revision readout
Date:   Fri, 28 Apr 2023 01:30:05 +0200
Message-Id: <36e5dfcd1c724060e44798dbb1eeee2321cac583.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

