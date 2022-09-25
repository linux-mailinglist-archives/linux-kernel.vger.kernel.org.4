Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E55E95D9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIYUV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIYUVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:21:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F7F2612B;
        Sun, 25 Sep 2022 13:21:54 -0700 (PDT)
Received: from g550jk.. (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 28B46C78D0;
        Sun, 25 Sep 2022 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664137312; bh=dBhg2i9VbI4tROrm8sG5HnARD1c5C/VJOwF6+8C7fTI=;
        h=From:To:Cc:Subject:Date;
        b=duDgC2cz8jcVEo1s4tDc1Ni+jB+An74D0jqAovmJiOEN7uzXENG1HrmXHcpbduTDS
         JagqAMh1oaKh3PJybvGTa/MQKD8WtfIY46xgn/sm1/VTfGDGvJeEwXsGeEezN4u/0S
         Prc0RGBGixWwPWyEHYmgBk8ZYmrb6d2SAk89zgHw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom-pma8084: fix vadc channel node names
Date:   Sun, 25 Sep 2022 22:21:43 +0200
Message-Id: <20220925202143.123208-1-luca@z3ntu.xyz>
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

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-pma8084.dtsi | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
index e77602e9f95c..7ad573c7b4ac 100644
--- a/arch/arm/boot/dts/qcom-pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
@@ -64,22 +64,27 @@ pma8084_vadc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
-			die_temp {
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
-			ref_buf_625mv {
+
+			adc-chan@12 {
 				reg = <VADC_SPARE1>;
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
 		};
-- 
2.37.3

