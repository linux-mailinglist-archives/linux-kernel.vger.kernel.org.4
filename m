Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3C66E383E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDPMpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDPMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:06 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B12693
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649102; bh=vcMGH2mB7eHRV3jsyfJ2abjxznWmNhKkivWuWeFmIyE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kaBAC3tyz2euOa7nEJtwnq74GCMk8VlifCkyRAyilRMdgcjqOlECd9pYdp5VVpc1tZ7++pCZHLvjG3I2KfG1eunvoqbHemEmDreJwS6YpOzDMCwpfEdll0/6P+FbUScecDOJkwYed7Fj+rjH8Pq4xElGZFXtWeca0rLs516QrPc9m7VK8xTdRgLm7yKq4Pha6etLAaBMwzTL/ycwlTHkNzCPOR9iihUD41w6VGuGhTQ5IJGSgtUD27ZYvTU3TWLPjEr0UoFHMI9y/7bVFMcBMpUD85wnrEzBB8+0YLZRYOKcn1L2J5Z0L5OAxBt3WbTl+xf2zX5SIiK31rGZrQzfSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649102; bh=8ZNE0MQuLwrNNYS0CbBCfLqbwkm0cePeENa4S1PfKW9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hRsQx2d8AyRGgmcs/kOmv+M59k8Q9/u8jPqqD03RO+86FVdd0fLOBx/e93EQmesORgV89OolRfVaNAh2o7EfcpBn3xeySTXQoPWd+ec03uoC3I3mOa9VBwHqb+jFHoemuzuQFI3ecVcOzehCB2AdiqC8qOpet7jUR+YNqLOAFkhwwQNKYMD1DQMax8ejBKztx1JnGV+akMR79oZ0XFrvs+pRWRIoOkLElOobbUSngV1xojqoFyRC5ipUntrAn64+5nXgSfRGaaBP9pvo54WUcULWMexKHjiKPHJ5TQ6VcUHOjqE8bvaalOvV6hPIR0qvyGPpoonTtiDzQ7yvDMQXZA==
X-YMail-OSG: om7kt2oVM1lj35PrV2MoYBW57IVgfU8uOtqOzmGulUyABjbF4TOc.nzcKzrl8Ab
 6wonre8A0VqBenbAvvW89jrNcydIMxk0Sl3g.XX6sSC2nh7C4XY3y0c3oTgAvT4IrvIq4ijTPb0V
 YpjSOAf1zhazDgfmRgeZuP96I49orFdYpVHe2oBMEUQAhpxNUwF0uGaZeot99nY87iYCwAR5ZLcX
 sR48RRB2VcCTL7pSncfl7L7NH7Eu2JTeTxbs8UPWZEJqe8N.C3PHeUnLw60yxN941eu_D3osT8XB
 u.i1knaXrygPTjiJ_CUWBVi.hdAqduhH5yBZNHyMc4K7YiZ_jb_rdxzxKO1r.j6d11z7M7neRutQ
 OPQ534.mNd1QW8bnca1QVo38TQJJQZ_BLwAbRPirb9gJBK4GA1O7KEd_VdGduALMnYy0J9sqPaoj
 BwOuofm5286Qm0.q0V5Uk3Uq1R50IwZ4jZ_Ky0GDBKfnuEc5tUGikbdCYlYrN5Z6geteCYFzshpB
 9eaPE_GBqs9WBSsTAap.b6_CISZS708MoIjYBZn6_eyBg8wdGZS7iI_XEguQ28aj_aQViRH9afns
 .G.bTfwzhQrKnIHs7yFItg2e9EajHo4UrKzR4LePkRnWHWqxrpt1NsBDpONh.bX70yFTeuVd6o72
 f1mdiigfmJbPiJSKyQtdDVCwrJcYI6fDn8hE07CsC1V5ywOj9a5u8_vt6hp0EcxeQSFqpuYTQeLq
 P2EU4q5HqnCATMz6D8CT76mnJIOBt.nQVZm9wFx0uW1KfGfs4BpN8ft.UWzWLfErtsGyI_Iec9gS
 6Mz.AWLeZUnlJe4eAsAm06LdTJw4pm0T_AObCKkW5La3K0AyM3N7yx6JDS1xmAP.R8e7brKqjNqI
 Q6jqTSjRM4iyQHgBdS6WqkBnuCFY19lOg0ApyD4Yo8wJWpKv_U2lGHMmFot5OXiNxUe80e7CX7BE
 PJ5oEFiKRZaPGGmGU0DaCIaBR.k6VFjhY3dQVqypF7PAg.hBzhFzfE5VzNEG6yUjpkQ__iaiqzFi
 YZum5yg.cCx7ygWQfqyUowhmJsBPQ.vqe533UaS2cZA9Fe4eK6SpQ7dkg5I7OKYtid6NL99S1dGm
 LoTK6ovVUfYtI4f1R032uznNL8jcvfnRntPyf_NOoVhKb9mY9OKNTJu.aRoFf2xhASeyNkuGQKph
 Hm8jTlK5Tid9uRPa6rzj_i.VzuAHTlA9WI9R0rCVUbwZSfiHo.Yor4ftnT1phCnAvrCJcOimqDdG
 SJHz44ILSLNA0IL73BhxqjFTOYcwvbOSbsjCAzPBOMgQlElik2KTJqV0k91vjRO1ZY8UulPzY1GG
 Z7qKH9e_5GT20eVS4.Wz9EUtBp4l778ZkjGwCo9tSSl87_YyOJlZLRivQ1zKpGUrdJm3Mn6SQt.9
 XtY_SsZWeUWcl5DSRtk7cfU5.cUdyGJsxFrOVVe_ZGTkUSjekrBfySyiQjaxLV2LECRfZOOISezS
 ZDLzpAUoeWmd.G8ssNMDyJdOE3Ka9uzvzSeJVqByuMWrG3Aq9mKLPixnSGYqdCtf6hQACoStHJYP
 drygj4L3cfTc1Yr4IFkww3kNe0rOL3n.qjfpcrGWO.YH4Lk_u_DDRYxH.EwwxStOUr7f273rPw9U
 OVbgt4YxjAvnI766P0Pn2whtxdAVXEoR_lS5Ru8R17yTDUX1VdURJgxo9LXmaI0OHEQxssVTDM_5
 rqMlqAHxX1bRxNtFKVh5qxhzCtsb8j0RU63ZIBAPFHjJVhVW_sP.sBMZW7Y5x_16VT4FMFU1gfE2
 MbtquMdYmfPE3.Chrp0Iu7ydc3DQyp1AgA_1A7Fyu1POfMhC9mDyb1lT0B.4DcTgB1I8.irEVhEI
 nMwPJPJoiSYi8Id0qEvyOld5oWw.tfUllNh1gJhR3CQIBnZxV0X3NmI.Pea3JjIjeOZ7aPO_ImvK
 zgyaQua3n.BARPv4zno8JTKTN83jSldWgtWLsKA6daoU7a4dcxPYIcbZ.ZgdDbgvA_tC3rYJWfnX
 pkTgde7bmb4TZOXS9z.cbNh9NP4rs8jcMZTDryf91KRZEoK8gK81WbKjPHGBkvogYBITknw5hjhZ
 A1mHXmpdKwnsTm_6dJ5d3H86Swx7greF6VIyKIh.zH5lCYu6pWClXArvPdOo65cLU9o7ZNzNiC1t
 LFV32NR4GnbiSXI1CbHJfO4obvCMrXLmFKn.6tsmfLonjOuTFPZHznqUUdV0ZBep1ij0BBYQxL2d
 gz3vRIlT1FUt8SxEOApEUKslUl4BupFHzJTvojDrUwY8a6utskkZgAKWTK9i2GV_3mMbuvAPIcR4
 EFsenSqEGC1UfWL9Rx63rkbd5
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 16ab8e62-c231-4b1a-8c5f-a2517dae839a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:02 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:45:01 +0000 (UTC)
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
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 1/9] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Sun, 16 Apr 2023 14:44:28 +0200
Message-Id: <a03e3939d733098a40c2ea0522da4e0bae9b2cb8.1681646904.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681646904.git.jahau@rocketmail.com>
References: <cover.1681646904.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
and interrupt lines. Therefore, it is not part of the MFD device
and needs to be specified separately in the device tree.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/mfd/rt5033.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index a5e520fe50a1..8029d444b794 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -40,9 +40,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
-- 
2.39.2

