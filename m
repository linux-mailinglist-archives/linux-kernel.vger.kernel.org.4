Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A1721F20
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjFEHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFEHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D8E53;
        Mon,  5 Jun 2023 00:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948957; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M3vcM1EaSIEuwhPTdmCsBNTsmaK24EJTUjNKNjA0ach/WF1SsMloBGIGBOYFgGH7ll
    n6Eh4+jWRa98vwPBTrEfYuPeosoyPc1xK4YnIzAzqnk20RRzqxf2RyArKKLcxJmUlirQ
    blyuVFKzyCZRoW60B/dTKWFU+2xuHd9viM/kKSLY5hnnXe2GofkO7PmRyCY76vgHt34G
    rpCPVla62U6deoKp3NZdHvs1PnFiQodInqGxCORhSg+V0jb2ZkpSnrjVOMK0mvFX+O4b
    emgOFnJ1da2oz0VLRc95gPdx+oP1zWu5uGqXJqXsuTDblC9JpHn5niD35a7nXVYoGRjy
    ZABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=x/WGFJ5dS8IBUV+BspimUaGPpfE9XxQTRhMM/mkoqZU=;
    b=N9el5c6Dw2OpXsq2kYFq4ieIccprrpikDkUZPasmmnQkgG3IKsdh4eiFTSJaYKQf2A
    ksmcg6Iw7jMpN1kw4SX4YFjNIzSHroMZ07PrNWL/1AwYx+EL6AxV+VVzzBsnswKp9xuo
    xcD0S8SYpkAsEJmoCGtkucprEtm8LvfhSjEfOQhoVcyKrop238i75n6WSoSR+P2X13/C
    KukMl1c7K6T2FBp+tFflHSxaCsmEpRREFk78kBFE96VALMRUA4hb7wTZ4QXWYiHGCHJo
    sPZLVEQJXCJj4HG6gSNKPFCUJ8db00KkcEYkAp/JEKzCH1Qa/VsuC8QTrJfp+jLEH80a
    RWew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=x/WGFJ5dS8IBUV+BspimUaGPpfE9XxQTRhMM/mkoqZU=;
    b=aRQ7Vsich/tdPpKsodHnaf0MJKx7gaH8RltukTCixuQoh0Q3DWQaVbkrlHPRhNGPQf
    HVWnK3XyO3Vy0PLMQ9Zy5H7xGnKdQB95MMaQKrWmSOpSKwQIYQo08UJ9SKyMT+TgIPAc
    cWUHcn+lcbdo3lNNhKQqJ1Qucr1sc3iA4Q8c69ykz2wKqrQW62orPvUzxw6TqzCXjIWi
    SOfX4aHdQcFf7jrdwQr8MXh+XuzFhVaB9W3A6jP/dwrjOPPbX0ndeQvqx/WLPRzf5f4Q
    VuP+AawJlIDNGJ71S7wmHnxcPgq9mp6Uvu2sGWVadk4idSzYOJRXwzBpu60ZmXK7vy9p
    70HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948957;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=x/WGFJ5dS8IBUV+BspimUaGPpfE9XxQTRhMM/mkoqZU=;
    b=h8pQOuTnvtsh4jDMC+d73UpD7Wrcp3XKtyY2GUIxDuZYvHUeAkbhloqTb6ij+SOMT/
    GvZNhCVMhgrqjGIFiMAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579H8aD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 05 Jun 2023 09:08:29 +0200
Subject: [PATCH 13/14] ARM: dts: qcom: Add rpm-proc node for SMD platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v1-13-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
In-Reply-To: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |  6 ++---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 38 ++++++++++++++++----------------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 44 ++++++++++++++++++-------------------
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 8f178bc87e1d..b24e3bd89ae7 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -784,10 +784,10 @@ spmi_bus: spmi@fc4cf000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc-rpm {
+		compatible = "qcom,apq8084-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index a3a9162e9c28..38867a9e07a0 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -53,26 +53,10 @@ pmu {
 					 IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		smem_region: smem@3000000 {
-			reg = <0x3000000 0x100000>;
-			no-map;
-		};
-
-		adsp_region: adsp@dc00000 {
-			reg = <0x0dc00000 0x1900000>;
-			no-map;
-		};
-	};
-
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc-rpm {
+		compatible = "qcom,msm8226-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
@@ -120,6 +104,22 @@ rpmpd_opp_super_turbo: opp6 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		smem_region: smem@3000000 {
+			reg = <0x3000000 0x100000>;
+			no-map;
+		};
+
+		adsp_region: adsp@dc00000 {
+			reg = <0x0dc00000 0x1900000>;
+			no-map;
+		};
+	};
+
 	smem {
 		compatible = "qcom,smem";
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 58e144957c5d..edffd3afec2a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -113,6 +113,28 @@ pmu {
 		interrupts = <GIC_PPI 7 0xf04>;
 	};
 
+	rpm: remoteproc-rpm {
+		compatible = "qcom,msm8974-rpm-proc", "qcom,rpm-proc";
+
+		smd-edge {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8974";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8974", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -293,28 +315,6 @@ wcnss_smsm: wcnss@7 {
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
-				compatible = "qcom,rpm-msm8974";
-				qcom,smd-channels = "rpm_requests";
-
-				rpmcc: clock-controller {
-					compatible = "qcom,rpmcc-msm8974", "qcom,rpmcc";
-					#clock-cells = <1>;
-					clocks = <&xo_board>;
-					clock-names = "xo";
-				};
-			};
-		};
-	};
-
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;

-- 
2.40.1

