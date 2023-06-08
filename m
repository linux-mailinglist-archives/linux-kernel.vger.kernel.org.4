Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095EC72786B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjFHHMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjFHHLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:23 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6371FDA;
        Thu,  8 Jun 2023 00:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208274; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jFxSWS4yvD+4hQrGzIfda+cq9vuzRBHvzke2SDtM62/Lmj1W8y/3DyxI4VxRzMQ42j
    Rtml9+DsO+D93WiwVhthq0K7hEZI819OY1zuV0QnFE8YOkGZKOg5QUfVmOqTCMGdnyKB
    HNuRddOH5gD3JoXEYV8rqQJD0VOR6Bi45jNyhOkfBYfZDXdcYIu1D2y2UWKBZDhKDWbh
    m8oF8Oco6k9ITCmJpwi43/ZdR4Bl52ekb7R+8wHBuCXwfaje4OJ/14NvWNt0kUfTiOIe
    YcAsYbzC38rm8EZgIVBmC44UJhXK3nDhi9G8Dbv4MefzZ/NdYYM5ImKuP/9W8t7J+fBK
    EjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TAJtDST/boxOR+FPwAwQzdxSm63Zx6Bn96pj3yBKZvQ=;
    b=me1cNmgDgVh8O11zgGEBzxRSWXtUWSKUuAC8gaB8rbW93mR2Ecf4Wn6I93BXZJFiwl
    +0woNmCj1fwTZcSYUpgOcOKFQnLvRKB/EakPiKlEOftwhNRQM/cNVzaOCg3+MymMoGcl
    aCBRxOUl/G0vfx52A35pLRocROBqWA8nVy9h5KI9J2pie8r5bVmDfKZOAEDL9dNEKrEN
    bo/9+9yB27Ax1uJx/gOpN5R1Ew2wWKpPqnjbabd6jUS4CMiKX/LGCm1IZ0TnhDWPLA3d
    fuhBg4vKzYq+NtQYF3JqLC97CKVT2xIgS4t/D6WC0e7UJZ59ftyh8fOaEOFelZydPnDD
    vgSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TAJtDST/boxOR+FPwAwQzdxSm63Zx6Bn96pj3yBKZvQ=;
    b=RQevX07CrUbJUE1OL+6lMSWpRTLv96E8bOf25dnSrak+ZoPWh6QUxWCa28+KmrqgVh
    EUnTMz7wTEoaFdTqFGf5qk/TN4uPD+JVk44buUc9YOPl696ZNT5xGpT8j/fHK4pedHuB
    kmDJ8kra6u/I01whjPk/bkp6OweqtXHiMyV8vJoyU5+lDrdjBMbptM6Io6tgKzGLveY9
    Q6d9Mi03kv3r/RmvVgToxCkSuk6cNVj7Wf23pjeZZidddpYG58bxbrSlWMowPSabmBRv
    4gfLbRG0lefnFnOwf+9M4syOTyxaQ6LaN+Squ2lzMrUtcwFnp4cB109849RuAXOD/KKc
    X52w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208274;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TAJtDST/boxOR+FPwAwQzdxSm63Zx6Bn96pj3yBKZvQ=;
    b=QuRL4ivcM8oVLCpfwch6o3GW+qJ4D9fVn5aF+uzuV+e7p99Q+FkGyQBRqbo1NpVbMg
    vNsI7SoXdK4aLpH7B+DQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BEKI2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:14 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:29 +0200
Subject: [PATCH v2 09/12] arm64: dts: qcom: Add rpm-proc node for SMD
 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-9-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having the RPM SMD channels as the only child of a dummy
SMD node, switch to representing the RPM as remoteproc like all the
other remoteprocs (WCNSS, modem DSP).

This allows assigning additional subdevices to it like the MPM
interrupt-controller or rpm-master-stats.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 112 ++++++++++++-------------
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 136 +++++++++++++++---------------
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 152 +++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/msm8994.dtsi |  99 +++++++++++-----------
 5 files changed, 253 insertions(+), 252 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9494b6512d87..a597890a37d6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -282,10 +282,10 @@ CLUSTER_PD: power-domain-cluster {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc {
+		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 0d9f8b951b66..d9fd48f5b506 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -240,6 +240,62 @@ pmu {
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8936-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs1_mbox 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8936";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clock-names = "xo";
+					clocks = <&xo_board>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8939-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+
+						rpmpd_opp_super_turbo: opp6 {
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
@@ -308,62 +364,6 @@ mba_mem: mba@8cb00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs1_mbox 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8936";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
-					#clock-cells = <1>;
-					clock-names = "xo";
-					clocks = <&xo_board>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8939-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <1>;
-						};
-
-						rpmpd_opp_svs_krait: opp2 {
-							opp-level = <2>;
-						};
-
-						rpmpd_opp_svs_soc: opp3 {
-							opp-level = <3>;
-						};
-
-						rpmpd_opp_nom: opp4 {
-							opp-level = <4>;
-						};
-
-						rpmpd_opp_turbo: opp5 {
-							opp-level = <5>;
-						};
-
-						rpmpd_opp_super_turbo: opp6 {
-							opp-level = <6>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-hexagon {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 7d193a467819..9c44697aeff5 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -190,6 +190,74 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8953-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8953";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8953-rpmpd";
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
@@ -263,74 +331,6 @@ rmtfs@f2d00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8953";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
-					clocks = <&xo_board>;
-					clock-names = "xo";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8953-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION>;
-						};
-
-						rpmpd_opp_ret_plus: opp2 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-						};
-
-						rpmpd_opp_min_svs: opp3 {
-							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-						};
-
-						rpmpd_opp_low_svs: opp4 {
-							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-						};
-
-						rpmpd_opp_svs: opp5 {
-							opp-level = <RPM_SMD_LEVEL_SVS>;
-						};
-
-						rpmpd_opp_svs_plus: opp6 {
-							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-						};
-
-						rpmpd_opp_nom: opp7 {
-							opp-level = <RPM_SMD_LEVEL_NOM>;
-						};
-
-						rpmpd_opp_nom_plus: opp8 {
-							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-						};
-
-						rpmpd_opp_turbo: opp9 {
-							opp-level = <RPM_SMD_LEVEL_TURBO>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smp2p-adsp {
 		compatible = "qcom,smp2p";
 		qcom,smem = <443>, <429>;
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 753b9a2105ed..ab76806317a7 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -232,6 +232,82 @@ psci {
 		method = "smc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8976-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8976";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8976-rpmpd";
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
+
+						rpmpd_opp_turbo_high: opp111 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
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
@@ -346,82 +422,6 @@ wcnss_smp2p_in: slave-kernel {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8976";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
-					clocks = <&xo_board>;
-					clock-names = "xo";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8976-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION>;
-						};
-
-						rpmpd_opp_ret_plus: opp2 {
-							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
-						};
-
-						rpmpd_opp_min_svs: opp3 {
-							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-						};
-
-						rpmpd_opp_low_svs: opp4 {
-							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-						};
-
-						rpmpd_opp_svs: opp5 {
-							opp-level = <RPM_SMD_LEVEL_SVS>;
-						};
-
-						rpmpd_opp_svs_plus: opp6 {
-							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-						};
-
-						rpmpd_opp_nom: opp7 {
-							opp-level = <RPM_SMD_LEVEL_NOM>;
-						};
-
-						rpmpd_opp_nom_plus: opp8 {
-							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-						};
-
-						rpmpd_opp_turbo: opp9 {
-							opp-level = <RPM_SMD_LEVEL_TURBO>;
-						};
-
-						rpmpd_opp_turbo_no_cpr: opp10 {
-							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
-						};
-
-						rpmpd_opp_turbo_high: opp111 {
-							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smsm {
 		compatible = "qcom,smsm";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 5a7923d7c62a..c374fba5d8f9 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -178,6 +178,56 @@ psci {
 		method = "hvc";
 	};
 
+	rpm: remoteproc {
+		compatible = "qcom,msm8994-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+			qcom,remote-pid = <6>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8994";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8994-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+						rpmpd_opp_super_turbo: opp6 {
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
@@ -237,55 +287,6 @@ reserved@6c00000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
-		rpm {
-			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-			qcom,remote-pid = <6>;
-
-			rpm_requests: rpm-requests {
-				compatible = "qcom,rpm-msm8994";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
-					#clock-cells = <1>;
-				};
-
-				rpmpd: power-controller {
-					compatible = "qcom,msm8994-rpmpd";
-					#power-domain-cells = <1>;
-					operating-points-v2 = <&rpmpd_opp_table>;
-
-					rpmpd_opp_table: opp-table {
-						compatible = "operating-points-v2";
-
-						rpmpd_opp_ret: opp1 {
-							opp-level = <1>;
-						};
-						rpmpd_opp_svs_krait: opp2 {
-							opp-level = <2>;
-						};
-						rpmpd_opp_svs_soc: opp3 {
-							opp-level = <3>;
-						};
-						rpmpd_opp_nom: opp4 {
-							opp-level = <4>;
-						};
-						rpmpd_opp_turbo: opp5 {
-							opp-level = <5>;
-						};
-						rpmpd_opp_super_turbo: opp6 {
-							opp-level = <6>;
-						};
-					};
-				};
-			};
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;

-- 
2.40.1

