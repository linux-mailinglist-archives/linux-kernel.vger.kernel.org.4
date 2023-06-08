Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D870727868
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjFHHLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjFHHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D51FDC;
        Thu,  8 Jun 2023 00:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HJarbOsS9Ip6JYmwc0l7ea03uO8IHL01KhIkVOJHjMTQUUCT6HZvR4yzVQDErR8s4h
    bMtvJqMwK389uDXF2NNBNbfcyNuiuul4MMc4Jo/yEfTf7qt7Ge6qNZT5V9Z1+qExLY8E
    jlrIT8qvpQMvPe/dFa2cjwJRyqbszWoKczPogRzEt7KAsFm6qEMNhQy2mtrEJ7HqiIvA
    q4zDbAfOVec1vD+Nd/8QejXiFSVnMmCOss8gny6jf9qD0GQxw6UaqnkEl9Vi48HPzoPr
    w+xyX8Qbkrcwxa7NkfgDvZD0FroTjH9h3oVa9R76X6lj8X9OaPjbcGWVMjKeOAuEmla5
    sukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=atGFNVhcudPWSzunIu6o4jd6PdOH+kV92QmDJh1lvok=;
    b=oK0fPSX+YC0WrFm4pv3QwmBTAo+kuXhOtgZadaLXlFwgnPMfijYiBxqznorrc6/AXW
    OGp/nJIPtK1Wv5vAJn3IXS/v0H+j5RxntBMHG7lA3qNU9yRBz9BfeBCzDS9+Tmw0MOqI
    sgCLT0fNkQ+IhwHNXf1dtiykjEYjekD8Ljjxt9wNig6k0Ad5aQLQZlsiT2vmpE1OdtwI
    M7PQbs0APwESKGBWyJu5oUAm9ncHtQuv5x8eMqeKmfSwGBNivqw5M1AQ1843hzHlJey8
    LFD6S7oIhcewp8zBPSSB37rXszXxDb+OXTc/iNAbLu+s7TbWBVbUcjk+G7TmqrWlslPr
    Sx3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=atGFNVhcudPWSzunIu6o4jd6PdOH+kV92QmDJh1lvok=;
    b=nv1UkSknAxnxEsLVepCvHxr8ERddZaPSBl8tVexLbSAPetQnNVfzzwjHmjLxqk1G6j
    UP69LNSyR9OFRMFNsptoT+NtJB46HlYPVIRMMt50vsXKoPomg9mBa/W3G/BUXWhPZWP3
    CUyfcWYqNVnLWF1RNjRLLLkWo0LvOKJ74yv0xXKsEE72tr6EMQjz4hBD1lCWMmdqazBY
    /Wf3IgteBRSyIBfKhqsGhACvpv2m4mMFziOwMtD5eNkFYvGeGDYgNVAOnfzlhByxu1Px
    iL6WcL2WXyi0zhX9TbV1pFjKhNLJEKKPJpQOddfcJiGfVYU8f7mD+aEdkcbKNQ9q3Exh
    PBJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208275;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=atGFNVhcudPWSzunIu6o4jd6PdOH+kV92QmDJh1lvok=;
    b=YzBrDpgrDg6dpqB8kmUHVuaZkweBLAyhLl76YO0GffO8lLwk+UZBktOQtjQyQbok/w
    0Kp6VHmtn7M1bDwgMnDw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BFKI4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 08 Jun 2023 09:10:31 +0200
Subject: [PATCH v2 11/12] ARM: dts: qcom: Add rpm-proc node for SMD
 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v2-11-56a4a00c8260@gerhold.net>
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
index 8f178bc87e1d..2b1f9d0fb510 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -784,10 +784,10 @@ spmi_bus: spmi@fc4cf000 {
 		};
 	};
 
-	smd {
-		compatible = "qcom,smd";
+	rpm: remoteproc {
+		compatible = "qcom,apq8084-rpm-proc", "qcom,rpm-proc";
 
-		rpm {
+		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index a3a9162e9c28..a3e8d023d0e6 100644
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
+	rpm: remoteproc {
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
index 58e144957c5d..0a5b5ecb5dfa 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -113,6 +113,28 @@ pmu {
 		interrupts = <GIC_PPI 7 0xf04>;
 	};
 
+	rpm: remoteproc {
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

