Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389BB70E6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbjEWU4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjEWU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:56:26 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64741E4F;
        Tue, 23 May 2023 13:55:57 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 225CDCFBC0;
        Tue, 23 May 2023 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684875322; bh=/f9dqg9L6IlOJuDdcS8mZ2hEPNfzmqpNeoG6GKRuzBk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=kTU+SPIoooPWjW1kd9VLXHp2SOo1A9Fkoq6bV45jjH8L8FtkiaVwX58XAU6lCdYYb
         4ACwAbEKWm2AvdNVwYadHMO8M+BDV/H71yFbMllYBTS6BlXgpzcQaWQJBcc+hBFxQE
         bQ3eSv6Nv/TEm/+uIJ7a15qSzyF7NGwCh/cPCp6M=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:55:13 +0200
Subject: [PATCH v2 6/6] ARM: dts: qcom: msm8226: Add ocmem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v2-6-177d697e43a9@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v2-0-177d697e43a9@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=/f9dqg9L6IlOJuDdcS8mZ2hEPNfzmqpNeoG6GKRuzBk=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSg0MIzSV935ZDPSAxyzVLovGYyPf1a9yrySF
 zmowdqy7OiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0oNAAKCRBy2EO4nU3X
 VhwfEACYCNM7mdJN4oOSZxaoDgx+xQTsWllDrNHV57pSzIortFI7G3syWNStMvYjrXm9j+/jTTD
 U0lCK522IX/UAbpVNT7rUrbg/5tacpsi7oS35D9oqdksTpDlJ4K8pXxT3tmuXQJ3FJilVJQpVow
 cG8IGvDBFejF7kbcSa2wBJvzSbJZUBzhawmZjHdDHShaVTMEUuApy7q+fhLruMMlR6VJ6aNVdZ9
 36chQ+IM8gJd4YBaFbGopL/Gw8QptWNR1WsgCH7xiMONvFW4Q/3mumc636CWE4zEid0kbv6zHqt
 V+bRwo+PhwV3qYX4NNcmgTtBmFBV/I1r0dwD+ls786ogbEBBfXsiFkzhl68b9Tjza700R0ro3Lm
 qO0IYT4Y25SHs+YF8jcwhn3PdOpDMdmaJRatn5F69+lzgltzMU3Y+6/3md7uiAtErVRYgmBruIh
 Cnyualdp8zXCosACUuhgatRTrSGjIps6Rk9yAT9QpGTDhkVhW4N/ulE2FM+lEf+bLRCtsM6CYJM
 D7rl4Cpmx8ScugJDRA56XwJbcfDY9GGMid5woeYBy4M13ciR+lwyp4/unWz1Sf1G0gwKXtjsyZ4
 3eJzqlNP6IrF8pDgfdGX+h3t6qQX7B7MyLNiuAv4XQS6axh266gtHr2CM+7s/ECKHbhowhN32Uv
 6q+G4xkJu1GoDUw==
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

Add a node for the ocmem found on msm8226. It contains one region, used
as gmu_ram.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 42acb9ddb8cc..7ad073eb85c8 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -636,6 +636,23 @@ smd-edge {
 				label = "lpass";
 			};
 		};
+
+		sram@fdd00000 {
+			compatible = "qcom,msm8226-ocmem";
+			reg = <0xfdd00000 0x2000>,
+			      <0xfec00000 0x20000>;
+			reg-names = "ctrl", "mem";
+			ranges = <0 0xfec00000 0x20000>;
+			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>;
+			clock-names = "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gmu_sram: gmu-sram@0 {
+				reg = <0x0 0x20000>;
+			};
+		};
 	};
 
 	timer {

-- 
2.40.1

