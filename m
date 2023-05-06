Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EC36F92E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjEFPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjEFPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:06 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D513C12
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388502; bh=Fg8O9S7CQWLvLBXMCmKEFeFmz8DxFrOra+7NQGOwBwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WtGiBPKHGCT0HmYAeS8TELZZJXgmj7WLRFkllJt5AglvwejdrVRYMC9G2iooy30rnVVBRHYUbvLDZbfvWm9zYRlOSYaaYdfH3kjKbVy7FTv5f7MCY/2Jn2uyZQNi02qO/f+15jzvt5hGxjxyxYRkaXH9SBEqDvwM6QHK3vzl9XDhTdg5jSEE4rD+tVqy8YLkShrW48MP/S9LQ//GkAJHI4LYKJHjeejpCWAlzI4KQ7DMieBN5/1axOtHaKF+YJKLSIuzv2Yd00V6/iqyUNEE/uXQp1vjfNTFG44ouaoYKHiMCbf/oo/9UZrjwILzoV2jcwQx9ipoZ5ZpQDPb716JNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388502; bh=HcogkcjV6csE5kF3G7NBXQpCiQjolSIP0mAnyuRaTot=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LUD8AEtoQH1I8yKJ0XAbrjklj/vLQX1Jb0zJ1nx14Ry8o5YwVSSJtLC8fp7be/SBr1lCAgRPp0mzpLl3Hmq8f8AHYyZtVXW+DVIqzH0Wp5phm4faYEaqungw5wFPNyqywS/QEsuhRMGv8pvAM0pzi8wAVOx3nfxa+iBj8sXsCRZarW25lvEpXVxnjLDuEQbGjabTXT+D2z+bStLMYmw9couD14MkIJF4+Gx4UsNJXU63ppJhUTFEtSKTJW7aZHv5a46OBCPte6IyJbZvDAX6w0UN8JD42z5+QkMdoph13XtzRgeguLzh/IrcGiG1lM66KtKCz2Fq0IjbKWbM/D61UQ==
X-YMail-OSG: vD2KDVcVM1mWcJSp.KFF7CpJSyLSk9dVuRvaLSvo6gJY9sA44Rc5i2fLas_pd7L
 pAdxQTmaN2rS_0tmepduHGWT84sCAh.WSaYTviHz26I79l6c7nCIZB2D650_mtBnwNM5vMlcUYGB
 kWt_is5mlrXw.HvSlEVh7kHEwVMnUb9O192KEBR4G.FNalwNIpXloav8HhsgJFUY8NjglT4dgave
 ign5IBggcsbzFGQVQ4x1SoicjIpmjhbNEzJwnFpH5ydo8A48Q7jYrkDdCWWM6oBJDyyJpTTzQXN0
 Dwq4e4a6_npEOWe1tlJ4NQugNTpi062TqogtBR0l8nPHBizVUByHbkAL2_F.50x8ufFh08O.5FHv
 7fYLSvgNmQ3wg2iWTfEFkVPuvlC64Dg61C.GQge6S.PwOhKne5xcru34G35fyqexOoKFurl4wLKD
 8t2HHxdmDst0JDf6OSHhnLWU9a.oukrSs9mOm3jgDU6BTKCUOoTY_8nw2v8BS4nCSJOQidRjwI99
 0FoQiJjbts6vNZ63O47pwJfmjs3WPJCp45nppqi32giC7gQmpPBhJ8v9rucVurxyJIEukOeKgzII
 UI8TtjYYc_rbS2jLMvwOYRdx6MDIXpjZLI.PzAo9VAix58ATDu1zKHI4nQQiq2bKiy.0GfwIoyYk
 XXiaGwwFUF7t5ZFzhsskmTgEcTDC8rJHe5TL9aT7L.4I_Lg81SxYhja36euD0t7KZXcRqZWsRFT7
 neaHcPf1uKRMhqXFujJ9ADYFC0YPrDq4GpBzPlRXE6u8qJ9l5PJ7c4gosulTuqq.1C4QzZOWYi4s
 bEN9hl.4UIE.Q5OAzYWrFc0as_8qimz1MwWpiM5QC5e_u_EnEXb5LRwcWlPlZG2kQ7zQLzN.Kcv4
 vwy8zIDCLvtzSqKV9.ONkxwP0uXrd09.v8CKnBLTFS_hy68jFw6KIb_B12S36vmyDvhEuvrqob2Y
 vtCpwZQ7BLpr24A9zKxegdb51OvawXr54hEnuzYXRIOZOUN_PWzQZ3stf18AyxZe.upSQ_tpHt2_
 2ysVW6fLIL.peZPf5prbw3HBnVPJuQCC2Sbg4pkyNkIYvW7xOE0sntATyE.vj00hSsriAXNF25ZU
 mH5iSHiscepr6a6hysEADJgGZvZHYj92Yr0VOqlm2U4EcTQD8cgT.y5rgqvIrkbexkcso57JoRZT
 XW3THstLb37GzhOQ8cc_KTslCykfO6y8ol8MI5lJvshUR7Q6y8XtuB6d8_e6FlVkC8.lOK8sS2vX
 KID06J3l9vbqLmHIWSd22XHf1MOBp5NJQ6nG_.iqDBBGL9c0Hlo3la9uBXEmjT62wjUwP2y6VaIB
 LihVSizT_n2Qwq0qF8lUN6Kjy7d5g77VsBrMT6JUpY9NG3Ne1snzPGIkkn55aLWvP4xiI8WYnEXk
 1JphvwsP4ppnDBKkhFa.1qJYkcsJWYJzIXbIvSiPGDhufiufHD4jGRiq7kVoT50Oew3_5L3AhJOC
 gkoyQRaYDJy7llMt7m4sV2g8Vz3c..XCYt5jkmXiVknsBh08mtphM5xn9tBCmC41XgKnmSQamq6w
 WaU8ySlT_5IkfJKxeHnhkvFKxRnsVw8RhGcd3Fp9YgMDarOXw2UZ1F83M5dXzrzRRy2xofT4OymG
 YHwULZ33w4c_z3_qEGzPfDABaBADpV.cdZQyu40ww5xHxy4_SXMfTAclVpPqVK4ltvY50NF0lp3c
 BYrpQGUxjquZh4PktHGQVeElJIxDfaRBo8KYYyPuKESr7CDx4Ihy2ollpShs6k8PkkJG4AQfYjkh
 pXZIVTGaz.dWpjq0eS1Uo6sHZvEChASCvtfCy142L9As8sO3Ss0Ei6RnOX1V1uzpRownnKU2JO2Y
 isnOYXNufHaPbVbMlsBKdHuX8ZIFeZhqyGcUcRhggeoQO1I7t.cfTeMda9HASXPfsdPcJP2.koka
 wyZ7oJWOLl3YzchA0G70spnBvroJee35ooDk2QH0SJD2m73n5MYVd5Ybcsi02nSMwGx8FWz3V43N
 0BRizYAAsufXqv3T2ARIQkSLUdfrc5nd5VKRpfzwk.Wu7eh5xvxhsshYuZv9gCglhI3BxDD6mQQe
 uI7xXkVOp2Q5tfb11GLydO4rVIor.E8VOIbFkvYXYM5GdQkxuK3pUUPys_YXQD_WDiyK_lPpctxP
 T228NG2c6wt5599a3k7p.jinrdT7e.i_EOXfrNpQ5lewa6S5BNsgG7BjVUaeaWS7POxq8TWa.Y_x
 1vUgfEWSderhctimFrL_dv_SDRcn78hpUwgxqPPmjWyVpq6i04I7jCtpEaBabdann.B_5253FnHf
 TlPbTCO39g9M_RVIjKrD9pPo-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: b30200dc-da37-46dc-8f33-94c317adaca2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:02 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:55:02 +0000 (UTC)
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
Subject: [PATCH v4 2/8] mfd: rt5033: Fix chip revision readout
Date:   Sat,  6 May 2023 17:54:29 +0200
Message-Id: <20230506155435.3005-3-jahau@rocketmail.com>
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

