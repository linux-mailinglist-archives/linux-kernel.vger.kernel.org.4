Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D26A629A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjB1WjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjB1Wi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:38:59 -0500
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30CD1B326
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623932; bh=KKArGEApjXBYAg0J0GNZwOaNh+WdVYCjGHfCqBUChNw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AWhW/jcbkzQdWr6roCxW88m/xDQMAJFmeVvtfsG8xnVsx76k3wZkEaKa2KmngLUav2yRH/uxAXIqoO0cUpdRpB1yBCg6dRPUStwlf/xpju/BdmudRibsFp9mHFIl55/L7TbtLJeGuITkBfO8Qx6MO+TV3Gf0ukMs3/YeFMH+jeT7YGrFCzTzgk5ni4obId+6T1u5WYh1l6GLsK23T/Vuo4g/+LpClnq5gHyaGEw5CgDKznSTXvnhzGwqr4za4pJlUJv2KKYJsMGHxfded1qDr4DcH/T/BuftAV63tu4fGWFUik0riSMFhyLVSFZBnNKcBPM2clh9RCwEpGoQs3pAOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623932; bh=HRs6k7UF1laWBQcY03G8zidW2528KM3PtV7I94Eflvg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kRtAkDtEhgqEMkWHDXid4+Nxfy+u0HWU146FPmXaE7U1HZnYeA8O3obslRfy4wDuOOFzNbiM8SDWC0LwbK6kZNU9AjvIyhsZI1TJViMKAeHTgdIih+4/eB3E+oIwq2IsHkOxdCOOp5CJ+OwBFyjWUTdO0VFLBgqG/Mutm9szk6oG1bWifWeFR3daYldlwElqLrZOeWrEj6ZJhaCsWXHVBSsTg/+BzGSBKxIuUhfObQap8/a7pgyhU9Lm+/qlqdrhghyzPuWC0s9CHFfC7RtDYfnEDGp8FcyY92sybwTiLclGS3wjc+SxcrJYzZhlZlCWhX8JOvX0MZ+QRceDuhXZWQ==
X-YMail-OSG: 9AyCvHkVM1l2j6ncmIXBeNZ4EyS0iUfqqLQ8e71ZZq3EFdFwDgC0AcCYa8ldD7_
 lqk0i3Yna9dfI0RhHrsu20MTEQ1B1EkDHLMwUlKB7X3jEvJKLqwF4FhUY1rKYcCT2viXgqOXYit0
 9rRXBAC3VBKMUnNk3t55khwaoEQjr6k60Ej9hvLEp.6vhiAOMJeBpMNQBqixOafjJhgdM_kEZytm
 fjVvFD0iya0Fi4XBGowl7MaOmo_DyZl0zgnjVhtdnRYP6XjvzWEytGfp1SvaSpjG3SKvvkr21VUw
 msctFyUv19bXhgvSi6xnwLZs0b41_beGugd1wAJVFXDllqSkimYUuG_d639c13St8jrFVJAhU1o0
 5FIRavXL6mtGCNHNhZKFLfgZTswFBiWrJgvZrIpY7N_TnHJfoJlp4OLHGpWhhLljusqq.A2EC2fZ
 hiwLS_Hys40SBIZJ8r.6bvJ4.UyPijQtcqrwoB8kX9BZ1Kg_13rFjGLpaAm35Z6BoCqELAggRlsN
 fz0DcdsNPjEeFWAac9eao0AGftIusMs69PM.Byk0MUr3YMpY5dThB0mPxPg49JnK177QlAik9XWf
 UN3NAsLi0UbxDJRUFrwVf7yxg.vPkDDQSuLQwhvmFCse2RYckSSiuj.Itjepuzi.CVioUfEJxi2U
 UL4XaJYiktj2nnRB_8CoJidFl2nD5BGaYiTqoPWfEYzUZdO_ODyYUKwO58yddtrw170MJ1mrbE2n
 Hzv0xjTRNRrEzwuEKkmGEuLTH_zghcVyp_gs2fxYjrLpYxM6tfvThE4t5BishZPny19JNAjVuMlE
 JgloYjEmCCHq95dliXjhE9cd5eekDTnGqTZIJQ6UELOybeIgcFvX3T_OSwlYhICHzlx5d8geNbpB
 1DuHXzmbZReCE3E8qPZ0sqBd3lh652Iqk123AOQeQVtfN31qITpGrmVkOqgoKWzx6FX.sEPaI0zT
 dwF9qpzUE6unlWTjnw5SHtibLKmO5iuX9.dVpanoRyb2gveNK4XH0G41X0KUOI_eJx1IzHzAaS0a
 D6CbliuOuGMb3oyLpkPCBB3p25TnN4JTI0wEpMLIEgI0CVAPNUlyYhBGldiHiKXb8yb0ed91dhT_
 iUe4yB9OROGvXb3swZvMzEM45lrDYidJXDUv4ReFWzNhWlRKrpqcUXOVwkDFmCkgQZfUqaE4oimh
 gxREirTFo8uhLmccjNameWpH815auT.2NEPwOFmZyIHbBA.UCvGy7qbAAMP3PWAuWC8NJg1qk120
 ojG7sBQB0gbyfRnJPTkDNeMosXf3rquT35FineTmgWOV7FTfT0zEeX0mk6A8p3X7JIK2MPIMPtr4
 ce_TxgKoWeG_5LecGimgGYUS3aIKF_kzBm2j_jRn91iHl8oUXX7nkLsB_VwCkKYV34ymCf30TVG9
 7x8NgYjGWDetjegxBThyIMK0sOtXqbuq18qDq1iNzZREX34yuKe.P_mhs2lZpFHDq3KL5l1DCder
 JL0.JxyPRCQJ2q5KgS8bgmWi5GFKdXnkI_a7NRiYJWrHp_S1XGa2ouEKMDDsIHc.69Avuf0YDpvp
 EfanXPjptBzi5FYI6dr8fNlqc9oJJndF3WXu4HJgTWZfBbX91.D46A8.OnMB2.MOxT97VYDV.fUZ
 MobHtQhkivqh2i9WNqLLkWM8eF3ecI9cepjhol8eCTkbE51hN9pGzAJAX_Kv7KVXXuxks9HV.12U
 O4LIY_sw8EcOz4.04MGYCT7S8PF2AKU3eAeyvQ58Gn2yx6UBbHKzOSo9lmerIZceilryOwS0XLaB
 WqSs8_Ar8PKAaOhHgZfGaOuSgaLKEDKnTM_iSyD.TDyXETmKY1dYf3v5Zni5rHMdwppxMCGey1ak
 wu49xeIAZqbSsdwNHK2J6i.O9imRZ3XA3TXjx1B91FTIheYraniXdY3GkWjlqfOYbJ1.XYn2BNwG
 Y8e8NFY3qB3o1E_h4V3fFncvGeI6fKpt8pQ2gZ30DBWEUK4u9oMdFDGBWIGNvA9d0.LwbhZtUank
 a5DS7VgJY1X8bRZwvchY7QlCt04oyhNgyqVFOQNUnOImOkR.xH.2gwsmk52mZ8dLcU58YdXFWTIh
 Qwicyvd77O7tU6Coz7YGECD_.LqPTVkh.f4AQcuhIX48RW5MhoyT48tXhm7XNBA_IvbgqA.Jm8NG
 zZj0IsCULZmAmc7FBfKG9_cfx78w61UWV2nnv7FhZG_zs_BIUIAKIV6rAWbOzMrUzII4tdTjGmWb
 CDczKLKp.ixTRfHiMnYL37xuG8_5yVrJhuCUIXgC.3xP7zWBXCoEI2JePd_6mWdhcP4I0n9Cxf4v
 6y2mq9i7qJrkQ8qvcVJEOVcyF.swW6x2z3.VmkBZlBifMGf65bg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:38:52 +0000
Received: by hermes--production-ir2-65c64dfd66-svnc4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1052c26ec2388683ab738a7f87fce466;
          Tue, 28 Feb 2023 22:38:49 +0000 (UTC)
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
Subject: [PATCH 08/10] power: supply: rt5033_charger: Make use of high impedance mode
Date:   Tue, 28 Feb 2023 23:32:25 +0100
Message-Id: <6b474e64f752ca6802dfb0bfc5571eb1adad8449.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable high impedance mode to reduce power consumption. However, it needs to be
disabled in case of charging or OTG mode.

Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/power/supply/rt5033_charger.c | 47 ++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 79e7f75fe634..ab406fc9fa19 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -298,6 +298,17 @@ static int rt5033_charger_reg_init(struct rt5033_charger *charger)
 		return -EINVAL;
 	}
 
+	/*
+	 * Enable high impedance mode. It stops charging or boosting and
+	 * operates at a low current sinking to reduce power consumption.
+	 */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_HZ_MASK, RT5033_CHARGER_HZ_ENABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to enable high impedance mode.\n");
+		return -EINVAL;
+	}
+
 	ret = rt5033_init_pre_charge(charger);
 	if (ret)
 		return ret;
@@ -319,6 +330,14 @@ static int rt5033_charger_set_otg(struct rt5033_charger *charger)
 
 	mutex_lock(&charger->lock);
 
+	/* Disable high impedance mode to allow OTG mode */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_HZ_MASK, RT5033_CHARGER_HZ_DISABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to disable high impedance mode.\n");
+		return -EINVAL;
+	}
+
 	/* Set OTG boost v_out to 5 volts */
 	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL2,
 			RT5033_CHGCTRL2_CV_MASK,
@@ -381,6 +400,14 @@ static int rt5033_charger_set_charging(struct rt5033_charger *charger)
 
 	mutex_lock(&charger->lock);
 
+	/* Disable high impedance mode to allow charging mode */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_HZ_MASK, RT5033_CHARGER_HZ_DISABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to disable high impedance mode.\n");
+		return -EINVAL;
+	}
+
 	/* In case someone switched from OTG to charging directly */
 	if (charger->otg) {
 		ret = rt5033_charger_unset_otg(charger);
@@ -431,6 +458,14 @@ static int rt5033_charger_set_disconnect(struct rt5033_charger *charger)
 
 	mutex_lock(&charger->lock);
 
+	/* Enable high impedance mode to reduce power consumption */
+	ret = regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL1,
+			RT5033_CHGCTRL1_HZ_MASK, RT5033_CHARGER_HZ_ENABLE);
+	if (ret) {
+		dev_err(charger->dev, "Failed to enable high impedance mode.\n");
+		return -EINVAL;
+	}
+
 	/* Disable MIVR if enabled */
 	if (charger->mivr_enabled) {
 		ret = regmap_update_bits(charger->rt5033->regmap,
@@ -671,11 +706,21 @@ static int rt5033_charger_probe(struct platform_device *pdev)
 
 	/*
 	 * Extcon support is not vital for the charger to work. If no extcon
-	 * is available, just emit a warning and leave the probe function.
+	 * is available, just emit a warning, disable high impedance mode and
+	 * leave the probe function.
 	 */
 	charger->edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
 	if (IS_ERR(charger->edev)) {
 		dev_warn(&pdev->dev, "no extcon phandle found in device-tree\n");
+		ret = regmap_update_bits(charger->rt5033->regmap,
+					 RT5033_REG_CHG_CTRL1,
+					 RT5033_CHGCTRL1_HZ_MASK,
+					 RT5033_CHARGER_HZ_DISABLE);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to disable high impedance mode.\n");
+			return -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.39.1

