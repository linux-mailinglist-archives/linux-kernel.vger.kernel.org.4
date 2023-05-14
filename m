Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EE701D54
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjENMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjENMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:31:58 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE626BC
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067515; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XlIWbq8PlxqdwrN301ADyRkhQXCiF993mORFVh/QN53NhnDCUYNFCGpTaqyu5mc3fODy68uA9E5GhrV+chzRZrC/IvaVor0PE+2YbwXGO/s3PcC/l+PD+cNk8U7Bu05vh0nd43McoGvJjhBfnPNb62Fg4gdpn0H89SuAYcjhZv+ocfHT8MGMyAoCgJBkGlyGIuUtoU1TUVGw/UCNZwDYetMpuNFkvIoPBnH9x8Uw28T+GbTso/jEgVBbZ2hKBvbCaMqwHxMd3aSykq7p7VOW8PYw17SSb3PPRd79vJA9NeaJzFSTPTmvIHy3ooAvs6i9uVp4w4tlkCVoswYZDOjEww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067515; bh=SBPJmK8rSWush7S0V6c3t1jgi55cFEd25HXBvBk2VfQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=a9iIGGZ+clnpQU3YamFPik3XCEtmAN3jcfPGL2ZlI2MMQuUOGfSkC/J3+Q3kcwfE4Mtzp4DC1Ka9w1N8zr4TRkVIB+8vWzplMtCZJw3GU/uJW9U4vbLaG3DA5lrErv/U3ksztoZCWbYOxaPdcwANv7UIgYBnZY+sIVIueo7IJ4yCj9CoT3P5KaSDoCwaXjprrY5nuvuyr6Y1Jmt7S8ruaUQQNqNKGU47OlkLTDJF2IcKdKN3x+yC4xrEDGKZwO6xuRVTSYiw4UEmm8tDAeNLMHMMLumapg4PY+BMYJPME7VjBwi9CcfvoyQ8F+iPtYGFf4zuzM4Tg349WPj2o72ulg==
X-YMail-OSG: hw.10HwVM1lpZ7Ff3X_oOtwwPjWZvbeXPqcza5P71_MNdkl9w6QjvcbZHbkFYXs
 GePaBGjYhIkUQpp_E7khQ77YrETr7t7QnaFkZlTRj0NIztDkiFSvycAmmrJNq1.CM1roc1u8lnXK
 wpmEHnXSIQanoG5DzBfuSfboFNeAEdYvLa6WANRUAsLrmnvBBaGbU4h38n37YJeDbDFmgCC9BcGe
 acNPbvtGZaFFE3ADKg.IAe5_i9cS4RJAs4cfP7zf_mZfGKoDQdYZjwoZ1BSNeSGU8NDBG19YdrRL
 QGCRFfmZC6EVvX2uPBp6nPTN76D4Ln0sG94.3xZXjSweBhe1sYz1CSlJmVQP0oqBmFmZrsK8iLht
 y1kInKHvmLuwMADrEib5JCnnn5v0H3jrv0R4OFVM2Lts1JUABjYPFG9jxQldju.m.1KmnLJWaLGT
 CCNWyNrW_qPocPvgTWgSS7G337W2IbWo4RRH30J.EB6f8arXIURbaw48ob2zVv5EQoVmMLNzhv.J
 fl.1NaGeY7kf8HoKoHCm_4udZvl0z_kPvYONklML1YE1nebjmjDVbRrFJ5MPQ8ApO5YUq35ko5yb
 phTxVcnIErwa23j8dA1WXENFJ.5F7pmN9M060Y6TaCcE7TNlRbYMCz96I7gl14hUYL83HZltAZNc
 c.rcGvuhpy4JAbloUq_ngViGNF6BsuroTponuoZlu2g5fFzmV2xZjF7_VMepUkNq3jhp.QjrA0TY
 vnItl0PGAZAf1ITt3apk7qTTIMnZQMeDnS22drMRRKXu35_gdo6K9sn3msJefz6GdnNTAWCzR5r5
 itme2pkH3wZppulDTvn3CjK0FnEukCvFZz0Gy0GzF_tyt1pci.VUrCSqILEvmwV6UFMAIMWlmsKL
 2D8k7ovB0ynHjLnJB4U77qpm5CcM0fwG5s9rf3E2bhBPPXNxym006.T6BulgObgVwvtN2FxppC2S
 wzoPgId383qZg34bGw6DNVDv.GNkwYOyK8ICH.uQPPmLdrVG70V6M3lRZUwqOeCw4SaJarBa0WBm
 iv9LSghXq1xvRFORD1BhgCdgBk5iKVnklHo19i18QR.06dbal810im.t0g9PrhRlFmmj_B3Evjd4
 4rMKXc6eoeS_OfUnDyf43N0PWxlSNEXrsVVHm.gFw3ehR5pd..4hy1xxYC7TesyybcCPvsVwKaeo
 wf.My6qvYPCqHyMSfLPXUFPCLMMWvxH5nPA2KhhXve1GumvpptPi0Sd.vCsXSOnOSxi_YCigJ0gc
 shmjH6rUvRr.s2jggdsOl_.VNOO5yQNVLosyjGP8ISrpBnZO2N.J6ZKJmXB7PCl.oj4pglrHbGyW
 aStR4Emuj0n_cqvutlnEWCT2Fl1lsqvCGQdaSIxt48iccC1UYWk0Fj071ZYPPOWQ3Q0_ZRHs6q5Y
 fxXZl.s_HpLhWCFOTvvN8Ifixm4f4oDs.iBNdpEd.qbB0pjd.f7EXt4IcYDo3C3rxRd22.B5RTVi
 jrze7zoIRHp7XHCu.fF61yj4gMaoP1QOxsKqiYP5sNR.Z6KmFmEQb56uA_qJMffrGxEKy0bOrbZl
 472EStfbyeKtgHipnUrvtRZt46he9E3pKESWzCxGogVYgM5mf1igYNBXtf15KZRzDWprDLHKQlf1
 52DVIgLbeaRFGTPqlDhaTLDsCbUQc2MP7w2.OUrt0mSWR05b6yMW3QLAe9JvlZ_Ug3MkAnO5Wm80
 gL4VCeThfabE_E2szDQMoyxdBuGD8XJQAWrmsdMRQXAPYOjfozVo5Gc8FkhmczocgYPC_jjM_ltC
 wzHV6V1hcpPDiP3AehXTigrWMMAQkwhWtW7IYr4dOtuqmtfZfZwJr8WSGbyMvtVknepxScfkcZrM
 hix3qQin8mkVhMGosK_.7bMIbQUiHjdNN5f4428bo0QHcXz_00UOQL7laP0E._I_6.RSrjwP4qOl
 _2nxIf5owOcqdeb_JzKK9Qpfr6n5D4Cae9fa2QnbPjyBpZXbrdAfV1yjpczQBqoMIlunucgkCOMJ
 F4rDjpXp.JiXnS9PwE1TgtsVrucr6NaT_ZpVLLYvCYp3zj2A4Nk9HUm_FFeSvihCpbiaxh56S295
 uBOy5VfsvUc1Dx.0Tq6lsSEInRjI6hC2aMOt3hCfdUpWwOEJgwMUL1rKfWi1qLU2BBLjaQaypY2u
 _WQlNWuksqtVIV0y2vMxi.dScVOFaIKErgK8GStv0z8gzVXiMm_VNFzSc1FoI.h6ShPvVZpD_SOy
 c3NNfwwtsphQqVhnCkR2krLmtJavzipgmT9g6IJBO3CMsiEPAAC6U1K53uYm5qfY55m00tcARf2K
 N.WAxjXX7hud8P4Uj7zYkC1v9
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: f11cbd54-bba3-4800-a368-3581eb786e2a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:31:55 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:52 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 02/10] mfd: rt5033: Fix chip revision readout
Date:   Sun, 14 May 2023 14:31:22 +0200
Message-Id: <20230514123130.41172-3-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
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

