Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8D740419
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0Tsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0Ts1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:48:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A844211B;
        Tue, 27 Jun 2023 12:48:25 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D98BECF06B;
        Tue, 27 Jun 2023 19:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687895304; bh=Ostm2zHdZH0p0v7HIjFDUvWXEiT1vgOfotYTinqxDnw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=B+b5IhTcYygGMLNTFsywGQjZZ0YDUk7IjNbx8+juZ9rasFtoT9z5kDLhEk+f8tXeR
         ill+oKJGKLGI6nSR4Y/8c9vgbcNex/rJg9fFQyU1MaOn1pLrNCwELT0B5HJgwLHLjf
         Zom4BTTg/OAsANg8sdBr9/rArMmHcIK/MkWOCKlM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 27 Jun 2023 21:45:14 +0200
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974: sort nodes by reg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-msm8974-sort-v1-2-75c5800a2e09@z3ntu.xyz>
References: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
In-Reply-To: <20230627-msm8974-sort-v1-0-75c5800a2e09@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3881; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Ostm2zHdZH0p0v7HIjFDUvWXEiT1vgOfotYTinqxDnw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkmz0Gpfckjdpe/rIxKeevcCjMq5DlXGxgt6/rs
 3FE7qWpb32JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZJs9BgAKCRBy2EO4nU3X
 VhwNEACXCkY47XIvxXRMm1VWznKs0RPhZhNFjexeVtHakes6QfH/GAym4bRDY9KDA0+lJqSa9hX
 w30Q+K1sedj9pMZnUNMe+xNIgr0gZ8lGrGPRYJ1Qr9gQVXvtQpJw7KFGUM1SohDffvLCcORBzPo
 Fslh/HbhKZjwCo9GiUW3hdpON9Gd4pORQFnV28yEKiKt+/zIbF6dBbmrc4iWZJdfuaKye0uc+Sc
 qu5tQ0oflPImZY3LWRPu6mJK/JfRtyzJtUHIVqL0Wtcubj1iRZFn62z3uiCBMM8yK1DcuJcbYVC
 pD5Evx92yqu+BHjhl2F7eNefwuJ0JEalGzZQ4PscJIZ4yP9i59S/yw8sxJMVeyu2LlZpfIjcgNF
 y8hW4SMHYaoBINoEM+/UGh13Z/xfWxj0ud/vbWLYz+aaSHwDrkJ2QHnMS4OjQ+t91NULSdLtSWC
 +x8JaVfwjfWtTJQPFNM+jdXP+P05m15apKEe8FYYrbjTTd3jj6cwXKPE3T9o7/zvsQXmeAPwLJd
 zexmJqpCgnWORoA2i51C39bgmnfRpbQiCHjRuAB+Sq+hEWcSUgV6F27FaLg0mJLVtsHvbrqAOUm
 3BnKzKmrr7gPvYFA/fwdnOE0n8N9x/YLnG5aeRZ04Qtw86Milm+l5GXqVjjdMe6Ao5nDzN3Sj3w
 valxtLZgMIs5KBw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some nodes weren't sorted by reg, so fix that now. Now all nodes inside
/soc should be sorted correctly.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 70 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index c6475837eda3..9aa8f9a273a8 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -334,6 +334,12 @@ apcs: syscon@f9011000 {
 			reg = <0xf9011000 0x1000>;
 		};
 
+		saw_l2: power-controller@f9012000 {
+			compatible = "qcom,saw2";
+			reg = <0xf9012000 0x1000>;
+			regulator;
+		};
+
 		timer@f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -393,52 +399,46 @@ frame@f9028000 {
 			};
 		};
 
-		saw0: power-controller@f9089000 {
-			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
-			reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
-		};
-
-		saw1: power-controller@f9099000 {
-			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
-			reg = <0xf9099000 0x1000>, <0xf9009000 0x1000>;
-		};
-
-		saw2: power-controller@f90a9000 {
-			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
-			reg = <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
-		};
-
-		saw3: power-controller@f90b9000 {
-			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
-			reg = <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
-		};
-
-		saw_l2: power-controller@f9012000 {
-			compatible = "qcom,saw2";
-			reg = <0xf9012000 0x1000>;
-			regulator;
-		};
-
 		acc0: power-manager@f9088000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9088000 0x1000>, <0xf9008000 0x1000>;
 		};
 
+		saw0: power-controller@f9089000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
+		};
+
 		acc1: power-manager@f9098000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf9098000 0x1000>, <0xf9008000 0x1000>;
 		};
 
+		saw1: power-controller@f9099000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf9099000 0x1000>, <0xf9009000 0x1000>;
+		};
+
 		acc2: power-manager@f90a8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90a8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
+		saw2: power-controller@f90a9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
 		acc3: power-manager@f90b8000 {
 			compatible = "qcom,kpss-acc-v2";
 			reg = <0xf90b8000 0x1000>, <0xf9008000 0x1000>;
 		};
 
+		saw3: power-controller@f90b9000 {
+			compatible = "qcom,msm8974-saw2-v2.1-cpu", "qcom,saw2";
+			reg = <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
+		};
+
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
@@ -1051,6 +1051,15 @@ kpss_out: endpoint {
 			};
 		};
 
+		bimc: interconnect@fc380000 {
+			reg = <0xfc380000 0x6a000>;
+			compatible = "qcom,msm8974-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		gcc: clock-controller@fc400000 {
 			compatible = "qcom,gcc-msm8974";
 			#clock-cells = <1>;
@@ -1069,15 +1078,6 @@ rpm_msg_ram: sram@fc428000 {
 			reg = <0xfc428000 0x4000>;
 		};
 
-		bimc: interconnect@fc380000 {
-			reg = <0xfc380000 0x6a000>;
-			compatible = "qcom,msm8974-bimc";
-			#interconnect-cells = <1>;
-			clock-names = "bus", "bus_a";
-			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
-		};
-
 		snoc: interconnect@fc460000 {
 			reg = <0xfc460000 0x4000>;
 			compatible = "qcom,msm8974-snoc";

-- 
2.41.0

