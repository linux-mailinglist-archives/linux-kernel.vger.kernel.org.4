Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3171750078
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGLHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLHx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:53:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E17E6F;
        Wed, 12 Jul 2023 00:53:23 -0700 (PDT)
Received: from [192.168.122.1] (ip-185-104-138-31.ptr.icomera.net [185.104.138.31])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 82344CC3EB;
        Wed, 12 Jul 2023 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1689148371; bh=W0P04Vhx8qS619L9ZTBVUiI27HUFLd5sCIaoSWjtgkA=;
        h=From:Date:Subject:To:Cc;
        b=mxxkdumr4hGkQzgngKVqzaYk5JsKFOFntqLbo5//OKIoSSLA5jeDgGskhA8ZWp/ku
         K6hKyzCeNgvgFsAWYl8rRXoYC0NOS2eV1ODnuqt11tVotxClSE0L+Ey5kS1s7iyDAY
         JrSuZ/mUzAIZ29+H1KmQAVSgnf4u/7r+ClNBWAW4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 12 Jul 2023 09:52:07 +0200
Subject: [PATCH] ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-msm8226-dsi-clock-fixup-v1-1-71010b0b89ca@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAKZbrmQC/x2MSQqAMAwAvyI5G7BR3L4iHrSNGlxpUATx7xaPw
 zDzgLIXVqijBzxforJvAUwcgZ26bWQUFxgooTQpDOGqa0mUo1NBu+x2xkHu88DOlf3gMmO4ryD
 Uh+cg/nPTvu8H8H4GGGkAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=W0P04Vhx8qS619L9ZTBVUiI27HUFLd5sCIaoSWjtgkA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkrlupfex/RXqA4VNxPMkUWev3LX1aRm99yBmdi
 T+wnyLBCsSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZK5bqQAKCRBy2EO4nU3X
 Vmj+D/93y5smNx9A9xlHXoL5FiCXexitXuiZzcvXyX3QubiH+E++JM4hYX+wW+L7sPUFoqoENbd
 aHuj9GSSgilf0RfE1cdHE+dFsi5SGQHVCo1cYU8+goWqXhccnBu3hX8Ll2JgS08e+L+QZLZc91U
 TldzwCN7SNuG4Of+whf1R6L4BSFhLiGEbl80b1Vc5e7GuGpJhGMn2jOPpKAeAomdllY51U86+j0
 wCKTjym1h7YluHeMWNFjlb7HI8LiAPNJ5dDEoEHT8uoPMLMP23Jh5ZeL1GkrqLCiqb8zd8f3OQT
 bTnuIL3m9pPToj9JbbV0QEKcPoj7SJWun5LyGQYzgJAZebXAv83xde+Wmy9ZxX9mTUU6s3GnN0E
 8E82h/ciX1X5sm+HznoyJsHmfmcWe2rPJB9gD6XEgO/5dxJK3qM31bBzsirx/6azdGqrKPg1z6m
 rXaVTIm7I44nmc1CNWrv1LV4+orRh56icP1pen2tBprLjpSWJKgoZJl4D62JbBrd7xhFc+vQ93T
 /GZ+bHvuljtJ9GtOtKsoo2Li/kulLPUsNOfduwMNYSmBaqwIMqBkEmfJWYdYOZoMXn7RSVRGBxB
 0EjrhBL4Y02Q/fkU+SnhitQ1aldBKp3Ew0Um4jgbk9R/QEikNYb9hU9LVopbDePPA1thZKuqHMM
 oeqfMqWAOw8RUkg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mmcc clocks have dsi0pll & dsi0pllbyte as clock parents so we
should provide them in the dt, which I missed in the commit adding the
mdss nodes.

Fixes: d5fb01ad5eb4 ("ARM: dts: qcom: msm8226: Add mdss nodes")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index b6ae4b7936e3..d2d09f2f3cee 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -404,8 +404,8 @@ mmcc: clock-controller@fd8c0000 {
 				 <&gcc GPLL0_VOTE>,
 				 <&gcc GPLL1_VOTE>,
 				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
-				 <0>,
-				 <0>;
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>;
 			clock-names = "xo",
 				      "mmss_gpll0_vote",
 				      "gpll0_vote",

---
base-commit: 40b055fe7f276cf2c1da47316c52f2ff9255a68a
change-id: 20230712-msm8226-dsi-clock-fixup-ad8bfd411eb9

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

