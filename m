Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2D6F0EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjD0Xan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbjD0Xak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:30:40 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBF14487
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682638234; bh=tWxmac8mwRjMj71krRu9An5Rypa20FdRhR7NzHl2dAk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qyl5QOZKJR1uJ5cJEQdHB6GQivVff1J1Re7SpKiZs6yBFpa95G4NtVX1ySYMgih4uiIZTmxBvKs8Tu8w6DIfE/vtJjxiw0C+qi0lkPIReBF+C85iHFZzJz+NIu7go2St/iQeveq7HiXeCz15F/Yw8lpc0uDu0uWPSn+0KWfekmKbTtpmwoW1awr7PsSrnB4S8+9sK3YCoCh01Upsa/A82Vi5wwGtDrwkgraz1QjZM11+E5pf6+YlRDU9zQlSEJ0Y8xAtphat0CnPAJWuc57nSM69dChryY7F8hkB2FHUdDIFoajDQdS8DK1ADxxmCyLZyAtiqC9tRmzChAwRtWIXKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682638234; bh=E8shyK6oiWaHIQoUePMgE24PvumwHbB6imJB7heussg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=F7TF9x2rMD0s5KHd7+SMmFgrI+BpZ+SyT4XRSoquWuqcG1b/eR0c6SRo+PwBN7UQ1ivBiUG2uImeSc4RwhNl0fwk9fnPXqCBTKcInZxJcaoaooEBrVIeEbrNh/2/6NlglWf4smuvLMUWOorIs+gulm5KLQCcat5I0RulRl/WPANndzTe1GkE2wBEcePmmZfteHj6fbJKqjGfL83jrBpjnanW9uVvwRmfjvbE6MhnlDStuudhaFJ52jMSvmc3rA/uqI3fVFrvOQHqAAH2DXfBYznEkrO0HiwvolXia/Gz88vNXxIc+/DtTYllDaj3axiaHrr0w4vHJqvg+ucyKUQGRg==
X-YMail-OSG: sOLyiosVM1lcjUTFeP3Q_IEVUmN8ewO53k7X3CH7xzYDdJ_9VgCynVyeNPyDF.V
 ZZH5ybd.dJpCXQhGRTGfm3.oN7.iJ5glWpWncdfwNZv5Z9czOn3RJ5ML9xv0UanBRTSaQgwbS5np
 3yCLG_JLcb.b_6XvoEsUOlNPdYZZrwFREumItDgRz35w30l.ETL_RN0Id.5l2xpXBej6kWnQ9w.A
 _KKru5dod9Av.1Q9x33DgaTXbYaxcEi0I4cc5PTIiP2_BbwNfRrlUL5R.ehxG.ZTp7jwsawH7Nkf
 K_dO34yr0mhR2obHtfi9PXmWp1hb7yvdkGtY.ROtcAf2M4Fahaxs5x4so39S1xrglI5aXs5KqiUk
 FDIDpzPXkhU4p7hRd.KVbtq6dIW0m1DH_ntjZfM2d.gGpCpIog_GxeyxuH37OZ_s7C46ekmA79p.
 pSs4zoKmuME1DzjCUSP953Vm.7kViina4o2_06OGYU_aPXrjk2hcSY617sMvg273p0NGcN84yqz2
 uctWozqThHNdJZSzy_6gIVo4T4KntLlaiAA5d5H3k.C2DYdqYKdjo4sZiJToVew6SADpHiHBY3fv
 gaA7pYiJy_7dMHN97fqWtmJGZ9zuBmz1WcdXbAyXR868DcVEKBuDbiJGL6I9VNRnF86AswKxRMkD
 UQOVdCTANfyFz8V1cQRix_.pPsBVaCEhy5JQ6tffB3eZ2kGi6G37sagI4kOF4zWvsRm7xm6CSkX.
 qFPct23dl2p5u7.xZ.UKmAyuTkuzgVQq3rzSwyslISMHC3fixG4vEk658YXC.kMkhg2cobSpMRF9
 CoAcEAf_uXpEhojX8c5UwQDW.zpL9t8gMl7jZ7VZH9QTCBPwken7dKvdREvsr8g.I..8wPkJEFCV
 AVJHgvCWDLmgUtDmk.PtEG.jLjyrx9DkIRH.RQ6f5FmQNyy1Smc88csblF66XQhn9Su4LEyUp4Yt
 56L1LZf6n8hKBasvIU0BRX4aDsxciOzs0_PF4a0qR.EGJBWwmow4zf5MlbXhZ7UFQqar.G0Pew3G
 q8mTtNtwRFLAo9lCICdJ9jG99mbkkuT764l.G9qHIgFhOIRsRfgYf1FejzNgEKWE6p35HCtcgRwB
 wt3xleRCmzLms5GueICvEgtbDwQzkiwyKM9pveWGzfeGOnq8uwEmLr7LpA_eY7c9OKig7ETLnsbX
 xvFBxP6ye0LpboXF9AhHQuuuoDDiY5MhKvOuHagJp_2mjqKUz_q5A2FlvWEbx0fJtTFymhiQ355Z
 9Iw__ynjKwm9Hse7G2nPsLZZdN5.VhD4HoHFFHvkLgx6hCKJrBqHwstddodFY_lm9dKQRpu72axj
 W_jFXe9IGLxM_L_AIPRCi4bpoiFOjumoKBrvwch8MQuUqVzR73Ek0keJx8DBb6mmWHTgUb48BCUq
 kYvc.w5.Hpywp1ZaGqFRbBlQ7S_OMyuPd27a2RVuomBpk5WXzT6XbNUCF.IiJqSCb9VjDmYuTGlv
 GKmjVpPVAZCxLWgcYm1cH6MN97kcZCIzzSJItE3otQaWLN11purSLD_TfN7JKlzBwCh0Et9smrXa
 D9y2Aeh6pZSuEWYMvVNoZmoRPyPQNDshEA6W_8Qd1V_pInWZWnzCLJ_D0AuV2S4PIL9P5cEIM1oI
 fJnxWEcB0rVpbsFt3mimIwvCkBcyPHuMaEIgC76f38TUYRJqyIo4TB18zueTM7KBqsf.4KO.q7im
 fGWA2kKVRRea1_pBqlDfr9M9i4uFH7YkKwhmlXf.3Nb6duQ1xsOASFL3FLYk_uvhVIAQ00LGFDrT
 vNLA1F3HV_PJi1qWbl3S6UQwIBVdrmeWtbVkJzcXJl2b9Ab3JaxN3QGKOmlGFRDeCTe._bRRVTMD
 xJ7h3jxk9yVyujki8SCtFv7BNTHP2f8F2fZsLdhgdpokFZQYBaQhA3vlpM4wCDj_9apPG6ZuIgxF
 6mkRsv1Oabrk8HHU1XsyWVT_bJI8FiwfAdEimgMwtasf2gBDOarZpCmlvjOmbaYoI3kdR_OqgkE4
 TVYNOQzzjdP0tTmxywirhGz_4JxDO6dwj60Y0GMsp3mfuJk1RLIZOBFNmS_UPG_9DdEDARTtdSn7
 ju6IYdn62uAAHDqq1gNK1DEpTjenUw6prM_tOmT1OV1MhsSXLtCAgq0GLlmr0L8wPlH6k0vqG62a
 Ln_MHUGf9Jtz5NauZ_c2OlecPZiWOv4ccMQRCdW.e.0Q.MDns.Ylj7Ue03YbVgE94Sn8LyUY88Jb
 dFThK6QC42S99QYxnrXkGg1zS9Z1GEYBjI9udhrTQxvEnrbj.zKLNdYDmg1cS1Ck88EOQvy_e7il
 56ISKOAe29mHZVhlZjU6X10A-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 496de9a9-910d-43ca-9817-720c78d0d241
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 27 Apr 2023 23:30:34 +0000
Received: by hermes--production-ir2-74cd8fc864-9w846 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 912b1d1a256b22e43f453e00130c1256;
          Thu, 27 Apr 2023 23:30:33 +0000 (UTC)
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
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 1/8] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Fri, 28 Apr 2023 01:30:04 +0200
Message-Id: <16f1dabc331513ba69162d0b2496cee0961276fc.1682636929.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682636929.git.jahau@rocketmail.com>
References: <cover.1682636929.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

