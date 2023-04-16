Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0836E3846
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjDPMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjDPMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:45:18 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D95BB2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1681649111; bh=po22Pka6e1k6bWH2o5z/cMQ182cbRZtmE52Iz+lWe/U=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IzIxiWohCKA7+KYLrVB89fpkhRJjfiUKNN3mZjSEkndxYhz9NzqCWdVUlOPMH8r8FHVh11Mfiw7PXxHv7/C6mpfdXPZLdcH/YXHs/kWE0YJ4izXTY7f/omtX6+zsfEzefMtgBzSV24fMz0chYuNrLTXWagDtSSzxnZ1fSLpZma0itoPLTvSvRvBSo4zeLpjHLRv6lFTHzV/Tz2W4F+Kt7Ky7WHN6yGNEtsllMAcbST4hydTstrOyLPdOo6a3Zhl5v9Nw9nY8ooBOcPpNokE1RyvMRXqIj/ViwJ2HtAbguFH15n514XYQBrRffQiJfrl8FmV0Bt1eErzqH2CjFs9HEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681649111; bh=pF2rsLDQVLHDo6glnY5gsdjGqpZpEY01AJ1+FhIohsN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PsrBbSMDz4WN5+GAQxBDHs8MnjBMUYm7ZyUKBq75ZBz3/7h3YuZa+phgOXLwiGV/AcHeUizrSm5BdkF7m22mjKhHG0UKsL3k98VfmIlNzGNiCEvSdHDaqGwlcpZlqSJxEjaX3N/TMCIrDLzeZIHKEolMvzDtlw0zG0U+/DvAvVZahyR+qOgZhn5siqJRQMl6G702ywNzNwDfSCmRAmzIMQsLhR8U1W42vvdDThUVtb/VaSr477vbp7B4+sgc9ZW9GVmNPAhnxGtUWdzA9uOv+QVIH7sgxIDzFqP+L1cGS15xLTBSq0gxGyABIyiHqoyEor7YXYLm/e1uQ15Yqs9VXA==
X-YMail-OSG: UsQXUSkVM1kcpFdkV.z5vAaCH_VMbfFfSVcqTcISR_ia8ry6OQG0utIEFy1aCmc
 R0w6k1L5zAdpXTDXkEeMIwH5TCFtut1XCQrmHwn03mh1DJAOXAxlIxD5Z0_KIKX0AIhr4FJvwkBc
 I6i2tvvwMo4XyJE7nN608VWYnfChaXAAZ3RjSyw18k00YZ4F.SDL657ZnVkp6XmRnOaSGIwEtW_x
 JWzqExY.Z0AmwS9OeluCch0dHVwECnwyGuQh1N7F26hEMpqnk3RsbhlHl9alYws5j.DMbRi7nkAy
 CoR8XTTz1NmSTr_I4uA.1onBEDQRFmPh9PkWcrMrgpu4fdO4fERVB6x8HkR0fhDN4u2lDpaZG9a2
 4BSYDCevAiuFFTnhrfM1d3eSKbMQ970O577874EQ_ITHKhrM5D282cGhKUWtrblOfsf_BNwajQ9n
 pyGLCd336VWnMpalGhZgLBWpCmVfhWZLT7vARXiOGXClsaDGJXwaAn8E5iI6Lb4OI3FelMZF4tBV
 d2sL14KLSijVBz1fqgY1kl1aWpsR30aobvujhyqcSh7bGKDjM0ZOYTt6VCWq0xumjlmyQ6e75YwA
 GIJox2K.xOSvigPxdu5_vtEDgLvZU2F9xTEK2_7IOlna9Af.h2tvN56ZIY.S0t96a7cRlPXWnVg2
 XzRDoZ4_.RhsI_7cIO.xBC6bQ9m6sTu7hBlUmMQ3DhUGXWwzkTbZBJIPaOcUkSXGZDL7DzvULC5L
 s3doFoHZdglw3fNJHJPj8msmeVk2.vCD4y8L.UGYfV7Z7ebmk7e1d1R0z6DD2ZNQc5qe09nHkZMd
 wAF3EfxEjdxwTzuArZ3rGO5PcO4x_UV.xy19qdBk.FREfRT1t5f77oTv3AQGKHnIS55Xjq3sFJno
 lcAqRBQSRe4LrMOtuwsbUwW8Z7REMKXFuebAG5SUX_zm.0BlqBoN4gRHRLEwshzT9spQDbk1PsQ.
 iKDKEzJTxXsarX3ktLdmgefRTOOK5U7.vZPJGuKkvZtqlBY8X_pgRwl1NXRv07KEnInUI6QCh_Za
 ve8fk0.hlL0OzKhrVYD_3pSH.EMcxbK6KswPfUNfu1IKFHbOiIUcGVjfA7oq5N4wj_i7CHaOJYNf
 lPIknva_hZFFXJibnmiXX5RRSFvjdZx0lF._Yk2zTmWSgBMwx0USZQAz7kx0QXMuEuX1aYGyrnIc
 wWmP3YWHa7I1MGDRoKSvne2LPpxlE1l630HQ0_GvFpTD3wvff7QPm5nN4l2rv8UVeT7Lk8v80xPx
 0LZe_ryd7UrIU5.gzBAq26b3XuNmr8FynuiJauw4MmgiXFX.lg6Vnibs44qnFYdchxHkASOQvrLz
 iA3ANgz2J.p9iBJ5wwf6XTKa_5JctWPCG6C2bvePfX1jhWQwNvqak3Qeewhp9bwlJ5bwklU.hL6v
 Dp06VBokXNXAC_2_HNy1y202PMaNm5jK67ETQ5eWibepvUIhy7MTRvkJ52a7PIluSTz1Per36f3C
 2cIC5qBNj5hmzO..IIki2_4wU.wnrZ5Lt73MXGlHClvbkl_jLR_uzMLUmg4_Kb0izYgDZCllVUjV
 wCQ9eq55kDFp.PN5E9F5JH7h9e2BPxJYrFlEwuR_X3fImdqcy9z1YaE4sAVUYd1z5r_0FLM7idX1
 2gxFaggdjZ1_kNSpdrJCssdKao986lsrcH.WdLNyntfTWPfYVWE.9rGWwmqOIeTd7y0BcEDt_3HD
 nrVNqW.BwojAaBqYLMTkaVpxqfw6PJ2ZYa_aqQwXoSMVG1P9s_V.fnxNK9iEmT5XA7tNn2QVW5Eh
 YQ9jLEoNqCzD9xQTvdAKmZ4CcrfhR8NVdIGp6Nh1Q8SBK1nsqEqmTrigeghWEuBeoeRgRfjTzQee
 6E2vc21vJ4hvyNXI1PU07oUu_DfGJNon8pHOhIUO.2XxKdwweNkgZfvOIWQotA9MpuBhnunQOj6m
 f8PpTDbqLMjOi1K3ppdxaWxQkhAena7pUMhvfuoel_X1fWS7A0j86BZA0GDyyr3R52aWYUOmhXJm
 p48nNsl1vsgdfBFx8m4lwlQh00aGQ.jexlcV9KQU19cA8NkHBvtNajkqioyk7ZvHW68.JyIEOF8h
 6SXPdTHmJWZEQ1Of.7oblespE7a4HrRwVLpRLw8qUVAHJnMzRDob1uDa2eIvkOfNT9whxt2BRG0I
 EkUBmt0p2XGDdR6e2hw9zdLrtgJFxeZ_eT.qK4nwKcJlbGl_Pe5y_6BhvPrkNze0ZiEnDygeaAqN
 LbTnBhZo1TQbP7oV1YCsD5xdmJngqZYr2jJVWwSjOcRUVqn_v26o7svFtHTiz32t3Zm3aTVHMsA8
 pGJC0hU8LuztGTVqMpho_Px84i1SmtMK0NR3RlmhAVozAjxVnmUVI0A--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a0f80762-b46e-493a-b2ed-7d0ef27e2824
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Apr 2023 12:45:11 +0000
Received: by hermes--production-ir2-74cd8fc864-4bl68 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a53f7a8722383f9609d619e4fab1862;
          Sun, 16 Apr 2023 12:45:07 +0000 (UTC)
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
Subject: [PATCH v2 5/9] regulator: rt5033: Change regulator names to lowercase
Date:   Sun, 16 Apr 2023 14:44:32 +0200
Message-Id: <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
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

Lowercase is preferred for node names.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: ChiYuan Huang <cy_huang@richtek.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/regulator/rt5033-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index 2ba74f205543..dee272dc81df 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -41,8 +41,8 @@ static const struct regulator_ops rt5033_buck_ops = {
 
 static const struct regulator_desc rt5033_supported_regulators[] = {
 	[RT5033_BUCK] = {
-		.name		= "BUCK",
-		.of_match	= of_match_ptr("BUCK"),
+		.name		= "buck",
+		.of_match	= of_match_ptr("buck"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_BUCK,
 		.ops		= &rt5033_buck_ops,
@@ -57,8 +57,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.vsel_mask	= RT5033_BUCK_CTRL_MASK,
 	},
 	[RT5033_LDO] = {
-		.name		= "LDO",
-		.of_match	= of_match_ptr("LDO"),
+		.name		= "ldo",
+		.of_match	= of_match_ptr("ldo"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_LDO,
 		.ops		= &rt5033_buck_ops,
@@ -73,8 +73,8 @@ static const struct regulator_desc rt5033_supported_regulators[] = {
 		.vsel_mask	= RT5033_LDO_CTRL_MASK,
 	},
 	[RT5033_SAFE_LDO] = {
-		.name		= "SAFE_LDO",
-		.of_match	= of_match_ptr("SAFE_LDO"),
+		.name		= "safe_ldo",
+		.of_match	= of_match_ptr("safe_ldo"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id		= RT5033_SAFE_LDO,
 		.ops		= &rt5033_safe_ldo_ops,
-- 
2.39.2

