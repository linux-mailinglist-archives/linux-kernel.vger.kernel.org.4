Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0087703EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbjEOU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbjEOU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:57:39 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F88AD26
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184256; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=KLgw59siLP5aTwyTLirAAR7oTmgqFrV09vVVj5D1YfewesFxRHGIXIUNL6JbaBHBKW+72axH92LMHj5iJW4B+BGd6o+L7m4cDooZkrNVbw3uU93SaDjn+3dx9rfu1ePVckrEseI+9XKrpqTQWL+Eavt4ftUIYj1JCFngjLbVB+262/7QyVcq1fNiHrF/bDzxnlbmFNN65DMHS8luN1nnQ1hSu+nD9fhmNqGEx0SG8pJbj+5q1IDsecFIuy8ssAMoYgsRw1nKoRjYykVzmFKHuaBWUqKH4oJg60GrQQRWrpkBX63vnuKFZCNVUQ30qYC2AKNchgc1/FJStxbkHvNuSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184256; bh=o2GHG1LhsZHk0TqMZ3cA2SyivK5FR+kgQeoAp/d/GMr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=f91xZ0WhSjjiTWDwp9+/z/kvEFvWymp7AfgsK+n2cpYamyW1fU3f6w+xNE209MdjOc7u9t8RJPFRIGCDGIcPM+6XcsgyIvT6SmU6FtASVActn9mBrcHi4EBHqMEcokYGUTaYU4zm8+vDHgCLNyLg2baxSIbi2aJtffmpeDnuoL+V8PAm+73At2lAHfkhko6SYiuvMo9ZHeoq6Wy1O5+0payOZimo4+x7Ih0u853K+0AlrtC0FM2F5Yap0jWPwBfWHcz8C2OdMSy+lN1bHHYFMrUnNeRIPzct31RWwZpp87zPhiiSHA2IxTje0srQy8Zu1onnExnC8FgfAud1hkQSCg==
X-YMail-OSG: XCDPuLUVM1l7gVzRyked2O3i4BOOmEyKDOPIbPujlG5bbMlCgmEwiajKyVtR0Pl
 8dQtvYkgiFANoxT7cctOIgxHueUQnq.EvtsVWn3WE6CMlZMAQsnuAslrLS4bakg4mJolTTcJjPzr
 8cAyZ5D64BYf2PVMcIZRV9iDyflUIoNPu6vBLI7dlIFhWzJfQVSE17Lxs2_6QtdGiIbMJnWXsCRY
 2ArYm4e.bPvplfMHnXwk07WBDXDg_6d4ehyypGGP1scbstn8mQC6COsKnAM1CzVumOixv36k.KAE
 IT0jM1WfMUKnLpdFgf4hgaFvy6C4Tx1ApLjtkdrOSaUOS7UL_qSC2N_3lXRSYPuyBT37H0KKrbA5
 wIDUZ.1OMKY.7L9FbbBBAV1nSMKxn0Q5DVYU9Ju2nFUaYU__O.j0L7e7Eh6AM1NEAKbMm7Ck4CF7
 sGygtGsLpmk_64k78CEYYT1tWWupZY3DmTXDlXTBsCdjr0GyaebKop1WrZtwC0gkKBf8NIICzCq1
 bUCU9ZnK2kUFLpFu4jG8NOth.HC8WVASZXZ1EvjickXzX0EQrwBJTscHHHoYy6_AuZIGlXlQ5hYe
 V5k1NLZA8r.N6Gc5nFfK6nzLQCSFpaMRKT.cfsUAztRDjylmsfBjP5u.nvJH93BXrYWcVhZakeVl
 99dhNmX4iCcLt_C9Xi3xaFK5JaUCrlTEu6_MxV4sYaVYri.BsefZi.nDr51tE9XMtyT6qs_f6t3w
 NnDX.r0hWhr.nfg4tYUEzdSAD_WSyd9ldYyRvQW.LcrbH_GsNXWjvoqpWzkskVUJ6eXohRZ1QhBs
 mXcvp3DduUBp9XNEDpkb7ameEq49jaOO1zzCzzz764RwH7bUfqj8TZCh6GDJANZctkdEFnLnTZ7z
 hOCtxuy90O37Nr4oVd_F37AJP_HTo7usNRYatq2KhXA_FWJENC7lNfW8P2sb7ctGECKJxBEvoyNg
 G03WPENqQZyLWsz34ejzI0WRF2yxvcGwoEKsEQiVsR4dEqma0QZ9QgpD0_plBgSWrPoW7mYA55cw
 6sE4O7ZO1wljprXNK1nxNcWJLhedLl6ADmf9lcKpNrE10kAr975xdr3UyToGBBvRDYKMgZQDzeBV
 bRACl2Gcv7UtxjRVwfna2THwJ4HFqqKpfVArNUGK_AHfXhyxp1Z6kpA91mKmuAAm9SWvOf1kaHDb
 f6hAqBWBErek38VTbpaVpCofHmM4nRpnsWnriiA2frsChbjhzmLExK7LbNV3t5dNEeGas8yvpEo5
 nSglEZULQZPhOM5Xfi6majEZ80DstCAISDni9JZekzR6SAU.Z3ORHMLkF1Zj.LNFzdTEWYWo6GZU
 TVvEu.N4sK9eHpodJsGf.DXLxDodggUt5C_47epz3TJeOYf6C909m2ekV.F3NYmDFFYwANT844e4
 WONvqZDRocZ7cgCcNBKHx2mMp4rzAekVyGnLsez8YxBb79PgtPVHj1_zRTDLSyurDYGncBIEiU1P
 sb.VKouvwt0.ZT_OlSTcQRxsGo_N36K_Gkax68ElSGKvGunBwXShnc37m133gEpB_Nm8PoxmeLL9
 0MxsaY8Kki7_.nv_i288eK.n3wfctlvGjfAqZ9QmafHk92li1gUQZerDg38sZ0peh.4Mp8I9tXQV
 DSgyVXZiWBae.rEo7da0q9vi6EyOT2h7Sm_4qUImZMaPBZopdDz54qb_h96T9cxPBJh_jqMxsz02
 3Al1k60_ChdKLDWEGY8uJJLxlqIyPbOAG_9zRUDwKovCAF5OrvKwnIPVusEGt1bC8AcxtNsdFY3U
 oA48cEanRPfeJ8i9jN5IIo5c59ytT9K_aTPdGwCunZFvnWfqVSnvEzq6qXfEZZ9VfrEh.iz2scqv
 OQSLv8nkN4O.KINZS00K6QSMtnJh26Bp5wl9G0l1Qn8i1eQZ1LOizGGsz2E7AWjsU86GHelo7ozG
 66UFuT7IGhiutjx_t43sKUdW5WSJnTRBxKIQr6FzyJJ8xt.nkU5GwTYWXTNTsMspTeSXo1N2541j
 J2T88Q6kTf6CQMbftxfaWbU8pYj.2P2JhLYHwE5qLSd8ECI1lpCLy7ma.Q4mrv9p7sh6CHp13Qsp
 qxhc_13vY_3E6LsLnJrVRzXG5mqacX8LVC1Gjf9WYwNuhKbQ6kwvTHFq5iuOoI2Mhia45DDqSKI3
 hBVyJ6nBx20.I4QXcBr0_vxmV7JYscWHK0siBugNaIkvmivTzcAb2aP62W3rz4R.yCJCiKGyiTZj
 BOlrZbG16JJe7Z.1HlNw1atjDqTy8yHZGIYXKrV651JxDmlShz1QKWidgRAQYjjQJY2NV_VbYag3
 xD7.k7Gs.ndXeSNRP8sOf
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 2a3477bd-9daa-4464-95fe-ecaf6f77d76b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:57:36 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9295bf04d78301a0059f933a0cc30ae0;
          Mon, 15 May 2023 20:57:32 +0000 (UTC)
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
Subject: [PATCH v6 02/10 RESEND] mfd: rt5033: Fix chip revision readout
Date:   Mon, 15 May 2023 22:57:11 +0200
Message-Id: <9a98521ffdf76851d5d344afa6ce65f692ecc024.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

