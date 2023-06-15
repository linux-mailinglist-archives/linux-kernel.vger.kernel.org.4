Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BA731E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbjFOQwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjFOQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:17 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2257297A;
        Thu, 15 Jun 2023 09:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847858; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M1YdDjjo/qsjgYljy39Yzh5EeLMXaigOZww7RaFNKMakivNh/dkDQGJdUr3uNIaauy
    AnxWJijTosw2sr5TK3cY3WGlA1s6q2bhd8qqHdYSyzUYh6JChQhvRnW7aqIA53bUik9G
    b8rOOB+ddkbsc+0609p9aNtvP6nmG73z/vvxOv4v1kJ/hlKgfuAeVUWyIqnntdJWRgZU
    v/0h9vgEmJIqPhh58fCEdoHisnYfJFptz+BBp9D79MUj/aUrXQvo+oWBPw32Jb+pyFt+
    8bNhQ0su1CBzVJ9HmhlFBTzpuBLsfIZu7lImbH9QjxOTg4oL6y/4k7H4gx4ATA1iPhWT
    N4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+774+fjGedd5D7eRusGVR2yLC6izJuTCRg8l00UxM8Q=;
    b=kr3ayEuu/yHVrZcV1z2kxgCKbFk5Rj8VbkPyx9UbInkf2JyWqiwjeV8JUuJGlWPCBl
    NZN87SgT5oWwRHAChii8OStPjQFJ8vHd5fsr8Bsikpsfznilqx6qMlrbU67l14Qg/tMW
    Fl34cdhY85n5xVmmepFEEo/PgpLYH8BHabVg0mkN5piApC3o9kcX3wtbsIJFVT8IUNHk
    HWPqf7ap5x+tbCHDEF2sgb20kkANp4k/NR8KJoT7xIp17vhi0yo+5MOcacGoCchlew7Z
    dJN4JctLpJWy74NfHL4OqAcnkadqWhZq5wjCqtRdwt57Ph9ssh+8tiZlDlQIeR0M2mFA
    9teg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+774+fjGedd5D7eRusGVR2yLC6izJuTCRg8l00UxM8Q=;
    b=cM3qQbc21JdXitzTBOYZK5vz0uXZcn2WrcR2v7g9VwFEtVARnfLENrMyh/z0gjdfSq
    wK4b96MtZ6tA8fpj8nmlOd7R7ONSw73xztNUJQvRYX+IZGXQ691K74gX6og4WJVPV7JW
    f2cYqLB02GudDi9cIXR7wgyQr1Rt7+Nu5d8vyUfKzfEwM4XYgSGnWSjI5Wrsusl6PTu3
    F6rQJDK1A1boeC5tQZC/IOdx4gV7x5gnnDtm/d5KTKwOGsvQPYksO9K7ylWIPFdXgTaZ
    cyrweQNw3/qWnH7ak0gYdeeBSNphPUmcqxLeLfYs/ogiN9Ypm3JvmoNDDD+DzQ/neoI8
    opiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847858;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=+774+fjGedd5D7eRusGVR2yLC6izJuTCRg8l00UxM8Q=;
    b=xgDJhes8Q2/OtMg/dcy4fyhQQmDQcaWlUrEYUHMnnOFs4RApIhL9pSAd5Ots18YHZ1
    2EoeDuP2EpU8gf1CrxAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGow42m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:44 +0200
Subject: [PATCH v3 11/13] arm64: dts: qcom: Add rpm-proc node for GLINK
 gplatforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-11-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having the RPM GLINK channels as the only child of a dummy
top-level rpm-glink node, switch to representing the RPM as remoteproc
like all the other remoteprocs (modem DSP, ...).

This allows assigning additional subdevices to it like the MPM
interrupt-controller or rpm-master-stats.

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM6375
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  48 ++++++-----
 arch/arm64/boot/dts/qcom/ipq9574.dtsi |  28 ++++---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 113 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  98 +++++++++++-----------
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 126 ++++++++++++++--------------
 arch/arm64/boot/dts/qcom/qcs404.dtsi  | 152 +++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 132 +++++++++++++++--------------
 arch/arm64/boot/dts/qcom/sm6115.dtsi  | 128 ++++++++++++++--------------
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 140 ++++++++++++++++---------------
 arch/arm64/boot/dts/qcom/sm6375.dtsi  | 126 ++++++++++++++--------------
 10 files changed, 564 insertions(+), 527 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 7355f266742a..47b8b1d6730a 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -146,6 +146,32 @@ psci: psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,ipq6018-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-ipq6018";
+				qcom,glink-channels = "rpm_requests";
+
+				regulators {
+					compatible = "qcom,rpm-mp5496-regulators";
+
+					ipq6018_s2: s2 {
+						regulator-min-microvolt = <725000>;
+						regulator-max-microvolt = <1062500>;
+						regulator-always-on;
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -182,28 +208,6 @@ q6_region: memory@4ab00000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-ipq6018";
-			qcom,glink-channels = "rpm_requests";
-
-			regulators {
-				compatible = "qcom,rpm-mp5496-regulators";
-
-				ipq6018_s2: s2 {
-					regulator-min-microvolt = <725000>;
-					regulator-max-microvolt = <1062500>;
-					regulator-always-on;
-				};
-			};
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index f120c7c52351..36fb67f0eb9f 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -151,6 +151,22 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,ipq9574-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-ipq9574";
+				qcom,glink-channels = "rpm_requests";
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -179,18 +195,6 @@ smem@4aa00000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-ipq9574";
-			qcom,glink-channels = "rpm_requests";
-		};
-	};
-
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0cb2d4f08c3a..3347db57594d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -398,6 +398,63 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8996-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8996";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8996-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp1: opp1 {
+							opp-level = <1>;
+						};
+
+						rpmpd_opp2: opp2 {
+							opp-level = <2>;
+						};
+
+						rpmpd_opp3: opp3 {
+							opp-level = <3>;
+						};
+
+						rpmpd_opp4: opp4 {
+							opp-level = <4>;
+						};
+
+						rpmpd_opp5: opp5 {
+							opp-level = <5>;
+						};
+
+						rpmpd_opp6: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -472,62 +529,6 @@ mdata_mem: mpss-metadata {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-msm8996";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
-				#clock-cells = <1>;
-				clocks = <&xo_board>;
-				clock-names = "xo";
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,msm8996-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp1: opp1 {
-						opp-level = <1>;
-					};
-
-					rpmpd_opp2: opp2 {
-						opp-level = <2>;
-					};
-
-					rpmpd_opp3: opp3 {
-						opp-level = <3>;
-					};
-
-					rpmpd_opp4: opp4 {
-						opp-level = <4>;
-					};
-
-					rpmpd_opp5: opp5 {
-						opp-level = <5>;
-					};
-
-					rpmpd_opp6: opp6 {
-						opp-level = <6>;
-					};
-				};
-			};
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943ff0046..f0098db1da5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -321,68 +321,72 @@ psci {
 		method = "smc";
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
+	rpm: remoteproc {
+		compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
 
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
+		glink-edge {
+			compatible = "qcom,glink-rpm";
 
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-msm8998";
-			qcom,glink-channels = "rpm_requests";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
 
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
-				#clock-cells = <1>;
-			};
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8998";
+				qcom,glink-channels = "rpm_requests";
 
-			rpmpd: power-controller {
-				compatible = "qcom,msm8998-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
 
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
+				rpmpd: power-controller {
+					compatible = "qcom,msm8998-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
 
-					rpmpd_opp_ret: opp1 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION>;
-					};
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
 
-					rpmpd_opp_ret_plus: opp2 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-					};
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
 
-					rpmpd_opp_min_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
 
-					rpmpd_opp_low_svs: opp4 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
 
-					rpmpd_opp_svs: opp5 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
 
-					rpmpd_opp_svs_plus: opp6 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
 
-					rpmpd_opp_nom: opp7 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
 
-					rpmpd_opp_nom_plus: opp8 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
 
-					rpmpd_opp_turbo: opp9 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
 
-					rpmpd_opp_turbo_plus: opp10 {
-						opp-level = <RPM_SMD_LEVEL_BINNING>;
+						rpmpd_opp_turbo_plus: opp10 {
+							opp-level = <RPM_SMD_LEVEL_BINNING>;
+						};
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0ed11e80e5e2..ccb13ec10b4d 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -198,6 +198,71 @@ CLUSTER_PD: power-domain-cpu-cluster {
 		};
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,qcm2290-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-qcm2290";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,qcm2290-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_min_svs: opp1 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp2 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp4 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp5 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp7 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -288,67 +353,6 @@ rmtfs_mem: memory@89b01000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-qcm2290";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
-				clocks = <&xo_board>;
-				clock-names = "xo";
-				#clock-cells = <1>;
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,qcm2290-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_min_svs: opp1 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
-
-					rpmpd_opp_low_svs: opp2 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
-
-					rpmpd_opp_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
-
-					rpmpd_opp_svs_plus: opp4 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
-
-					rpmpd_opp_nom: opp5 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
-
-					rpmpd_opp_nom_plus: opp6 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
-
-					rpmpd_opp_turbo: opp7 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
-
-					rpmpd_opp_turbo_plus: opp8 {
-						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-adsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <443>, <429>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 972f753847e1..2153704ee63a 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -166,6 +166,84 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,qcs404-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-qcs404";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,qcs404-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <16>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <32>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <48>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <64>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <128>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <192>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <256>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <320>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <384>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp10 {
+							opp-level = <416>;
+						};
+
+						rpmpd_opp_turbo_plus: opp11 {
+							opp-level = <512>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -217,80 +295,6 @@ uefi_mem: memory@9f800000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-qcs404";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
-				#clock-cells = <1>;
-				clocks = <&xo_board>;
-				clock-names = "xo";
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,qcs404-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_ret: opp1 {
-						opp-level = <16>;
-					};
-
-					rpmpd_opp_ret_plus: opp2 {
-						opp-level = <32>;
-					};
-
-					rpmpd_opp_min_svs: opp3 {
-						opp-level = <48>;
-					};
-
-					rpmpd_opp_low_svs: opp4 {
-						opp-level = <64>;
-					};
-
-					rpmpd_opp_svs: opp5 {
-						opp-level = <128>;
-					};
-
-					rpmpd_opp_svs_plus: opp6 {
-						opp-level = <192>;
-					};
-
-					rpmpd_opp_nom: opp7 {
-						opp-level = <256>;
-					};
-
-					rpmpd_opp_nom_plus: opp8 {
-						opp-level = <320>;
-					};
-
-					rpmpd_opp_turbo: opp9 {
-						opp-level = <384>;
-					};
-
-					rpmpd_opp_turbo_no_cpr: opp10 {
-						opp-level = <416>;
-					};
-
-					rpmpd_opp_turbo_plus: opp11 {
-						opp-level = <512>;
-					};
-				};
-			};
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index bba0f366ef03..600646a4e49d 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -359,6 +359,74 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,sdm660-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-sdm660";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-sdm660", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,sdm660-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -440,70 +508,6 @@ zap_shader_region: gpu@fed00000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-sdm660";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-sdm660", "qcom,rpmcc";
-				#clock-cells = <1>;
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,sdm660-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_ret: opp1 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION>;
-					};
-
-					rpmpd_opp_ret_plus: opp2 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-					};
-
-					rpmpd_opp_min_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
-
-					rpmpd_opp_low_svs: opp4 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
-
-					rpmpd_opp_svs: opp5 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
-
-					rpmpd_opp_svs_plus: opp6 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
-
-					rpmpd_opp_nom: opp7 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
-
-					rpmpd_opp_nom_plus: opp8 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
-
-					rpmpd_opp_turbo: opp9 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
-				};
-			};
-		};
-	};
-
 	smem: smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_region>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 55118577bf92..f8936192a791 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -341,6 +341,72 @@ CLUSTER_1_PD: power-domain-cpu-cluster1 {
 		};
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,sm6115-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+
+			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-sm6115";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-sm6115", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,sm6115-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_min_svs: opp1 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp2 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp4 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp5 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp7 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -440,68 +506,6 @@ rmtfs_mem: memory@89b01000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-sm6115";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-sm6115", "qcom,rpmcc";
-				clocks = <&xo_board>;
-				clock-names = "xo";
-				#clock-cells = <1>;
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,sm6115-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_min_svs: opp1 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
-
-					rpmpd_opp_low_svs: opp2 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
-
-					rpmpd_opp_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
-
-					rpmpd_opp_svs_plus: opp4 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
-
-					rpmpd_opp_nom: opp5 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
-
-					rpmpd_opp_nom_plus: opp6 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
-
-					rpmpd_opp_turbo: opp7 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
-
-					rpmpd_opp_turbo_plus: opp8 {
-						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-adsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <443>, <429>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index a596baa6ce3e..d7c1a40617c6 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -181,6 +181,78 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,sm6125-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+
+			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-sm6125";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,sm6125-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp10 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+					};
+				};
+			};
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -292,74 +364,6 @@ qseecom_ta_mem: memory@13fc00000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-
-		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&apcs_glb 0>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-sm6125";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
-				#clock-cells = <1>;
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,sm6125-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_ret: opp1 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION>;
-					};
-
-					rpmpd_opp_ret_plus: opp2 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-					};
-
-					rpmpd_opp_min_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
-
-					rpmpd_opp_low_svs: opp4 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
-
-					rpmpd_opp_svs: opp5 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
-
-					rpmpd_opp_svs_plus: opp6 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
-
-					rpmpd_opp_nom: opp7 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
-
-					rpmpd_opp_nom_plus: opp8 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
-
-					rpmpd_opp_turbo: opp9 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
-
-					rpmpd_opp_turbo_no_cpr: opp10 {
-						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
-					};
-				};
-			};
-		};
-	};
-
 	smem: smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 3dba34210a6d..5ed2184485fa 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -494,67 +494,71 @@ cmdline_region: cmdline@ffd00000 {
 		};
 	};
 
-	rpm-glink {
-		compatible = "qcom,glink-rpm";
-		interrupts-extended = <&ipcc IPCC_CLIENT_AOP
-					     IPCC_MPROC_SIGNAL_GLINK_QMP
-					     IRQ_TYPE_EDGE_RISING>;
-		qcom,rpm-msg-ram = <&rpm_msg_ram>;
-		mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
-
-		rpm_requests: rpm-requests {
-			compatible = "qcom,rpm-sm6375";
-			qcom,glink-channels = "rpm_requests";
-
-			rpmcc: clock-controller {
-				compatible = "qcom,rpmcc-sm6375", "qcom,rpmcc";
-				clocks = <&xo_board_clk>;
-				clock-names = "xo";
-				#clock-cells = <1>;
-			};
-
-			rpmpd: power-controller {
-				compatible = "qcom,sm6375-rpmpd";
-				#power-domain-cells = <1>;
-				operating-points-v2 = <&rpmpd_opp_table>;
-
-				rpmpd_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					rpmpd_opp_ret: opp1 {
-						opp-level = <RPM_SMD_LEVEL_RETENTION>;
-					};
-
-					rpmpd_opp_min_svs: opp2 {
-						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					};
-
-					rpmpd_opp_low_svs: opp3 {
-						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					};
-
-					rpmpd_opp_svs: opp4 {
-						opp-level = <RPM_SMD_LEVEL_SVS>;
-					};
-
-					rpmpd_opp_svs_plus: opp5 {
-						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					};
-
-					rpmpd_opp_nom: opp6 {
-						opp-level = <RPM_SMD_LEVEL_NOM>;
-					};
-
-					rpmpd_opp_nom_plus: opp7 {
-						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					};
-
-					rpmpd_opp_turbo: opp8 {
-						opp-level = <RPM_SMD_LEVEL_TURBO>;
-					};
-
-					rpmpd_opp_turbo_no_cpr: opp9 {
-						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+	rpm: remoteproc {
+		compatible = "qcom,sm6375-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
+						     IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-sm6375";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-sm6375", "qcom,rpmcc";
+					clocks = <&xo_board_clk>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,sm6375-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_min_svs: opp2 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp6 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp8 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
 					};
 				};
 			};

-- 
2.40.1

