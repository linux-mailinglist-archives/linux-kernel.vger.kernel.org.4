Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E267731E77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjFOQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbjFOQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:15 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCD297B;
        Thu, 15 Jun 2023 09:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847859; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q1BPpixcWCrnN3Om+WeezEJOrJZCrEXheP0xrzO8DhC6tthXM0aTmrg41RWsq3fIak
    cdIfxjD+jcIwBqZn8IND1YmOn0jtc+Q6LezfcH2UYI6diSHyVywbCUsqlxl1GcSvPWll
    +RoH6Xygkee878KeB6D5Mdb/JXLTavSYUXxJLESwdZERgtg6ADrtFtIp7VAeF2bK6bcS
    CSkEGsvhTd7HBvkpHEFJT3vmpym1vELHqvC2FLJeGVA4PrZ187qrFjIa9lyTJttBI8o0
    VUZLcqkotixhMOAGgb3TP9FzdsnI01HZpZmU8+SUwtVDSxp5DmmlB/UQe1WTgAkVkUkK
    iz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vj5Z5EeVRMBdfZYdOR4Fv2Get1Ee6bFBctEVmqEZJKI=;
    b=azWN9MDhO0mR/ouGwI6ftlh/HmnDENE/rwje2yy9X2UUR5xQmTkb0evKbNiUyYHj4j
    +njyyd3eWn1+ROG2oqCXR2OYtMzA3ZwPudTS8/A4Pu527ipPZwa/QdJLXAWDm4/jLJSW
    xAe5BHWFCgnfO4JW+zveQmA7xraZeHv/5nX/bfXLaSovPSetkBp9sYp51tNXCrqUYFl3
    EhS7kRjGCZBI/1MGYXHgavakT0xqA+4nWHgDMA1o8p8rPHEAcqfYRo9hf4f1UG5H/NT9
    6Ytk/SY7G6yR0e43D3R2GDxqaSoPujSeCl1/Q16aC16jywd1SxDiiYIHiI3PHspMhw9O
    mU9w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vj5Z5EeVRMBdfZYdOR4Fv2Get1Ee6bFBctEVmqEZJKI=;
    b=Vmb8S5jGoHwDyAZxsKz7Q+NV/Jt6J24Sxq+fg9875vi+RdVvTNeGjsymzOWOqpF6gh
    opZZFXKje988RKLh8J/Ox6lAbYFqKdIyS4hz6l8M1yIDSj0pcp/O5A2EqberMK1Pj45P
    +syxVQcmOKEuwdgrHWfCZFRb4Yn9jRt+cYIOuA+BbcaEJ+3WCsZ0Am5T9AEqB4nKHNMz
    QttZaTJn6joQbj5itLT5B5syYocm0733V+zxr8DBjU4wyTSqLjFPHPKx2pqlH7QN0PK4
    FY9Sxyv9+0PnDZHTvdnSzFPlMTMpt59qGpW7oSj0nvwiyKUFumXk2sWakzhpLUelcF/P
    aFVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847859;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vj5Z5EeVRMBdfZYdOR4Fv2Get1Ee6bFBctEVmqEZJKI=;
    b=IkoX7UXpRIv6CmNWgJapnA+R6/eemhsymGaED5VAWPBm3jvLJXLSO1z63/Gm4xqEFf
    ZwyOnaf+PdZjQxF6EUCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGow42n
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 15 Jun 2023 18:50:45 +0200
Subject: [PATCH v3 12/13] ARM: dts: qcom: Add rpm-proc node for SMD
 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-rpm-rproc-v3-12-a07dcdefd918@gerhold.net>
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
index 313a726f4704..612c305c1540 100644
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
index aeca504918a0..706fef53767e 100644
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

