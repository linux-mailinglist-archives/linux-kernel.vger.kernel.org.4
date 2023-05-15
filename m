Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3444703F38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbjEOVDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbjEOVDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:03:09 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577D449C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684184585; bh=1v+m/grXHAScwxBU4YO/Z+1o7wz/5i8+x8kx+V7NuiM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DhtgbbNNu8is8WCDmoTt3T5oC60LbqcvnaOg7iyxhKHl2fAGpRg+uli54yC0NavtP4GUy4RKtPbL5P4bB+6AqF0zw1FjtTh4QwoJtnV9U05hRk5y8LDcc2ac2ZEx48TFXuzql/+/5bDj+NV652uuXr6t+Cr5A8won0RzurFAh9xXyJa6SlVhDIAX2U64rj36ycUv93Yj+G+WMONTYepm4im02fkCRDcPYhijC8GJq3+otH+YfJddQOKsHCm0TsVTc6dZmc4XL2+8vD76xHK1sWriT4/V2CWTcYgLNEd3U9DEzzLQqNA32I9VybnGmIlMLDX344XL8enZBDXoH9cipA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684184585; bh=3UZzEfKYDhdjz7kiDE04r0wGZyMshta7IREQt+tfcax=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=smbLLxUGZduk4LgYDfcgsPfGS/L2WqjyBt8Zt7USd5j3psaegMoN0cNeK75iAWnp+y+mR8IKWVR8lmvH9VBTr5wbQCJXClsSwwyUb7v+Bkp9cQHShCYxtQcHyeSuCUPDsuxs/EthcLLdv5y1PR5lKTS1iGbf+Po2PHNEr/gM4p1aSz6IjYIVQwmzX/EVR9EKcDdKln/0OOsWC3Q9plnZa4q8FsIT24EqPJmVIcU3AJYM1mBdFGiAGkSbhU++WdEqzqcsBoqZ3zio6p2RMexH90ejBDUa5nlsC3OswjPKMUGsrmvaT0P/dYBjn86RyCd+MHIbJZoL9jdUznQ1hSHrmg==
X-YMail-OSG: OLUlxD8VM1miDDGUjZGLs3L9NHMWRPcLo3HLEluwGGW65VcEh8TO.sQzsbCFaDL
 gxuWCDwDbnP6iDxPkOQAI7N4Ups5._qkxHv52ppLZgV_ytrwAZGhXi1U7N0cJgCVFrB1z0TQt7hr
 5183xScVqfzaVefKMRf7RDqFkzeoyNEGrkDMnairvJ9IgldWKaSjfiNBSElLc9DYvt1OZBP3Qp5Y
 36Nj50rNZDnNlKiBThtFkn6HH0FznKQhXKm6P_ty0LLI5LCTUk48uFccc5vK__pGknMNy0MP8e8y
 TJIE5yDA5dqsSsZAr4CSZDq4E2TpEyVwF9dSuuNlvWLIe1j3RgSwIHgwd4hYmAN3q4VyD.1NNwJe
 JJw3EyXTc5mtiMPpcsFWvxWI7UvDGV4DRZ0blcfHY5ilXC5xctmy6kAbKcSB7iZe9UfHOC_qbEDE
 0iUsbZbfg30vvX3KNnKRsAqfjjbJPHD988AXWpxAzy7Qv.VaHtt4Ne0lL5I2b4eJoottWhEzyyfe
 ZsYu6N0.nlzSGKE59wm.B_hFtlvqIwofsDoPrZ_B812eMJ93BGkOaz9UN_gUWiWXs7frT3ndB.K7
 HvmWzMHKOfurMhuaFCfo3bXIM4ppO_JtQdmRasWAvVo9JaTzrFL_bnH.AqgxfCtbWoKVS1Ug_5GC
 4KUSF0vlGkiyCGGEsFRJB4xf8m.bUD3gX77HJpnXYu6HGrXGK5EFpp6C0OKm8UPFW9.FX263lV_9
 TQRbcbgciGn10Lfeptp.znvqkZ8dLuIc2lXpBMM9o5F9dR9rrEUC8IuKlIM7hivTBrdW4vTBtv8Z
 mhAjyMcn1hxHTImoWxdff7hXRhnwnqFUmbTw1MWUXgwzYe3q50syabcnBXpJfsvFcRmzzgcOaEmU
 mLWAj1D3ez_rL7lzNEdfKEIviwCNdZwSH96EMo2q5a0YxfZW1q9qVXjdOYng2WivRRF_kXYJTMF8
 uoL5HD98802FPTVubNvAqbJtrxOSPe.0UnuRXJMXooIwOorT3fxIo.eaeUTwRARP0dj4iShIB7t1
 TZQaBnQN2uAptCFbxSrEMsxToGyjID7EYkTF.cGNMDnAwN40sqFGlOwfdNoqOT_pZXKs.I0KO5TJ
 dusmziyTaN0PgsPnplb08nTmylWl.8C8qj710BgeiE4uWicNFp2wRWzVk.dWcvpoTrTlSzA2Vu2X
 L0BIojjdWvOUvFa06JP0melf7ezL2VpDZSpX0Gi8BO_p2sTcC7ooGckDkZyxxoM2WvWbiDyrlEUB
 FXpFkjpcxNDsNbOwIUrySOK0xkX_eyXjoLPTpSpnzHtMnzDwpBkEUbsbC6wQ_PvsQuLaWv2kmmxE
 z96sa85bYo3tDPzi30APeU33cl9C6CQ9LnlkhpuhLWa7PvJ.WjTBOvwi3HKf3r4EQmVMauwqTmP2
 hHeV_CjnVoU4RjzaOMQ7pi4wEZ23AIPXjlTE4fh42Hhsmm7W_AI1Y4bSWp2TZ7EIPWBymQ2WeeET
 rqg26sXudShoIfHTxghP_WiVqksw0xtrAr0t.gufckEfpOvtiHgW76GILpzp0UBAF9vk20f3Aepv
 ehJX1fghFOAWgv_wU2YNinpSyPniV.q.YlkNSboQrT4LTDOXoLelLBJMLP9U561JoutLwaqSjUdy
 jzJzb53ZK51nMwb2rooS4apJLQAXkpX30LhkbVyEfz4As8_ObbdZJu4_67rMvBhTQeQyrN1WZimD
 SnySxawU60pfFxUe2iEnnu7e4cJ9Nwgr3ytOgLsAOtTSMIoUuC1NH5LBPBUqUff6whgFYV6Ien4b
 DkHh_OBDLlUkEjaECxeaxXqQ.hzlqNz8y9kzQQiNnbvsswyYpUEYsp6umd.YnITLP.9JmkLa7u_C
 3yxptWrrRJqbdJiTBTb9C5CxbxLeyngVReMN7NKV7HAFJj3YVID.XPqIH1C4e_4DfEr7gasHfu6T
 2sEh4XsVPP1J9cR6rcL9yCb4HRPQy.MOqdp9IT111MigRytwp9_wHtGHucX2NxiTdGQICtvf8mxo
 YOcsNAhICmoMklG_JYF39TUBPyxYbZ7PeX8LW7LzirrIlNOnwvTetDd2uUiAycHnUGCOXpNKUnzr
 z2A1FeTWqLOzkxwg35EpZl.uq9oawAFOEWtKsUV6XzfdHFvDzLkTfOB3JiUf3T742KwpO33OmFDY
 TTQPYU6ORiZjhQlY9knQJRGYH__o0hEGRRH7k1FRf2LVSsgYNEs.5L.yjIbFrtshjyq3zFjvNTtV
 f.QkDcwsR9qyKNzKxSEpBbSIwwL4hvKVr1baNyzxsvV6M1J4gAXNLr3JJcdsvQb39CS7rYk110PL
 zH3ewhYcKZ7HP8C3Oq5EStVl5R6I-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 289a800c-15aa-4396-a81e-04f4cf8de1e5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 21:03:05 +0000
Received: by hermes--production-ir2-7867f454fc-bgghb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8cd4b5b48eaefdf4c621d749d286a70;
          Mon, 15 May 2023 21:03:03 +0000 (UTC)
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
        Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 07/10 RESEND] power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
Date:   Mon, 15 May 2023 22:57:16 +0200
Message-Id: <736e1cbee257853cb3d1da6f05c184e9a053263b.1684182964.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
References: <cover.1684182964.git.jahau@rocketmail.com>
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

Move struct rt5033_battery from the mfd header into the battery driver because
it's not used by others.

Within struct rt5033_battery, remove the line "struct rt5033_dev *rt5033;"
because it doesn't get used.

In rt5033.h, remove #include <linux/power_supply.h>, it's not necessary
anymore.

In rt5033_battery.c, remove #include <linux/mfd/rt5033.h>, it's not necessary
anymore either. Instead add #include <linux/regmap.h> and

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/rt5033_battery.c | 9 ++++++++-
 include/linux/mfd/rt5033.h            | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index 5c04cf305219..91e1efd81f69 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -6,11 +6,18 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/regmap.h>
 #include <linux/mfd/rt5033-private.h>
-#include <linux/mfd/rt5033.h>
+
+struct rt5033_battery {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	*psy;
+};
 
 static int rt5033_battery_get_capacity(struct i2c_client *client)
 {
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index 3992fb2ef0a8..bb3d18945d21 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -12,7 +12,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
-#include <linux/power_supply.h>
 
 /* RT5033 regulator IDs */
 enum rt5033_regulators {
@@ -32,11 +31,4 @@ struct rt5033_dev {
 	bool wakeup;
 };
 
-struct rt5033_battery {
-	struct i2c_client	*client;
-	struct rt5033_dev	*rt5033;
-	struct regmap		*regmap;
-	struct power_supply	*psy;
-};
-
 #endif /* __RT5033_H__ */
-- 
2.39.2

