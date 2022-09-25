Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE55E944A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiIYQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiIYQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:18:36 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D62CDE1;
        Sun, 25 Sep 2022 09:18:35 -0700 (PDT)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A2FFBC6FA5;
        Sun, 25 Sep 2022 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664122714; bh=4FYGCgQFF9T6Rzp32aL6VP51rUdPoPVkxoGxiLSBfl0=;
        h=From:To:Cc:Subject:Date;
        b=xaga2AO8bH8lPkagTpQUpa5uoYFZnZi+1o9oBHuz9RGgkgfxhiz2EiIrM1QsYsNED
         CVmmlVr8XcoQ9qVmxgTswJNQH1Kj03aBVrVrHwyPzT87dsUWvKDLeMp1g5opPXBZ0G
         AJffvpow0wDIJLhn81ukb/U5si1BiEG7QIQo86dk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: qcom: pm8941: fix vadc channel node names
Date:   Sun, 25 Sep 2022 18:18:20 +0200
Message-Id: <20220925161821.78030-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node names for the channel are supposed to be adc-chan@REG.

Use this format and at the same time sort the nodes by reg value.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 9cd49deb9fa7..3c15eecf2f21 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -101,26 +101,33 @@ pm8941_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			bat_temp {
-				reg = <VADC_LR_MUX1_BAT_THERM>;
+
+			adc-chan@6 {
+				reg = <VADC_VBAT_SNS>;
 			};
-			die_temp {
+
+			adc-chan@8 {
 				reg = <VADC_DIE_TEMP>;
 			};
-			ref_625mv {
+
+			adc-chan@9 {
 				reg = <VADC_REF_625MV>;
 			};
-			ref_1250v {
+
+			adc-chan@10 {
 				reg = <VADC_REF_1250MV>;
 			};
-			ref_gnd {
+
+			adc-chan@14 {
 				reg = <VADC_GND_REF>;
 			};
-			ref_vdd {
+
+			adc-chan@15 {
 				reg = <VADC_VDD_VADC>;
 			};
-			vbat_sns {
-				reg = <VADC_VBAT_SNS>;
+
+			adc-chan@48 {
+				reg = <VADC_LR_MUX1_BAT_THERM>;
 			};
 		};
 
-- 
2.37.3

