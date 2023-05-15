Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF5702A45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbjEOKQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbjEOKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:16:11 -0400
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 03:15:34 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C71720;
        Mon, 15 May 2023 03:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684145545; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AVNObnpCebT2dn9dpdOekcEmluZb2EBW4sKZD6jFw/NAVDirkVYJ82rz19Vjn5aAGh
    Z1graIDVHSBvFIDTW7U7rIFOllPtXIoFDjS0HnhZ9ruIYTYRyM8S4iW20W1sui75ruIn
    kmrVY1fvBNxANYwcvrDjc7vsRw/buDWjpqqP5AYAME6wPLgDOaKdaaf/TFaAyMES+eWH
    R03OAYcDSws9he0qbBX4GuBdSCLg82+TJ3+69UhyPbkiDvZgTAmIsMksCdIfQmYyyBGD
    9IfAs7xwvGtgwP4tpO9wk2n1CNVmf/tW5fWrwBrTkUlQ1tbvQdnagJ06IQFCtWZo/Lao
    ed9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG1/HhYRt67ZjjvC3b/0RRaBqAYMx2ZNVcQFqLHzqRo=;
    b=p747C66IiskdjUifiSHaiWrLKw14UypkT3bRPBuwm6G4M480pvY2afWQ9sJGRryx0a
    YnIgQOvzhV/bYqlf74HUEvPreAlU9HxeocCDEB5mbQAA34dnvjwg06O7QBsjxXi+P0UQ
    FF5pZCFIMjVdhetycfMzf/KtYLUxC7H0qcYbHRfQVljjM9z/MakPP/3i6V8VLwCJrTKG
    KYCGgQaSphbbL1eACnbQZdtsUAx3g+viHkPkjr5J9vEzy4erAkWg8048/AtmCf1OgsxZ
    VrSyVNyTAe96640kbB6dz4J4X2EpTJyqZu5vwq8XuOKPhOKZHmgBgBnthc5oKtUSnkfE
    DUrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG1/HhYRt67ZjjvC3b/0RRaBqAYMx2ZNVcQFqLHzqRo=;
    b=e6GsGuerdYL8cTjyPg0uxiNq163vL1fxE+X9VM7QMXjZ44YbW3lqpUfuvqcemzZSG4
    HQyIv0Xv+GVTB5g6ydUvhrIXxJ43/GAPC3FjVJpRf7BfnYurtUk4tOH3zS6CkwUea/Kh
    Y15Iwgt3viuWbRfA3D4mBmkVfZuoHVaB+yKMnx0iBJNUX/xERZaB8n5GGPS14oMwoHm5
    wehaN2YWsnfFUu25vWoSBZZKO9ERbXPgsQY7EQ+l/PzwA7TnHzKYxWig73mMTSeaxhRY
    FCNALeXZkQ3Xu3SgV9wPJijoIBeevmlhzXVGF026xnjybXWC/sXXin5FLefE8sRZMfQH
    imPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684145545;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG1/HhYRt67ZjjvC3b/0RRaBqAYMx2ZNVcQFqLHzqRo=;
    b=0XaHEr06/C9yX8Cr6qL0DbAi7kImA8Lndmyn+KVE2yj7oUVzbVuPmKljvDZAul9y8x
    MItCmQ6Xf7BHmyH1z6BQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4FACP1JK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 15 May 2023 12:12:25 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 15 May 2023 12:12:20 +0200
Subject: [PATCH RFC 5/5] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
In-Reply-To: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT APPLY - this is just an example to show the motivation for the
patch series. For clarity only some of the device trees are updated.

Most of the reserved firmware memory on MSM8916 can be relocated when
respecting the required alignment. To avoid having to precompute the
reserved memory regions in every board DT, describe the actual
requirements (size, alignment, alloc-ranges) using the dynamic reserved
memory allocation. Use the new "alloc-bottom-up" option to allocate the
memory contiguously to the other reserved memory regions.

This approach has several advantages:

 1. We can define "templates" for the reserved memory regions in
    msm8916.dtsi and keep only device-specific details in the board DT.
    This is useful for the "mpss" region size for example, which varies
    from device to device. It is no longer necessary to redefine all
    firmware regions to shift their addresses.

 2. When some of the functionality (e.g. WiFi, Bluetooth, modem) is not
    enabled or needed for a device, the reserved memory can stay
    disabled, freeing up the unused reservation for Linux.

 3. Devices with special requirements for one of the firmware regions
    are handled automatically. For example, msm8916-longcheer-l8150
    has non-relocatable "wcnss" firmware that must be loaded exactly
    at address 0x8b600000. When this is defined as a static region,
    the other dynamic allocations automatically adjust to a different
    place with suitable alignment.

All in all this approach significantly reduces the boilerplate necessary
to define the different firmware regions, and makes it easier to enable
functionality on the different devices.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 13 +++++++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 36 +++++++++----------
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 41 +++++++++------------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 29 ++++++++-------
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 42 ++++++++++++++++------
 5 files changed, 96 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 59860a2223b8..534fc9b2f816 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -310,6 +310,10 @@ &lpass {
 	status = "okay";
 };
 
+&mba_mem {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -320,6 +324,11 @@ &mpss {
 	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
 };
 
+&mpss_mem {
+	status = "okay";
+	size = <0x0 0x2b00000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -418,6 +427,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 /* Enable CoreSight */
 &cti0 { status = "okay"; };
 &cti1 { status = "okay"; };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 4a5eab06c18b..2d2bf255b315 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -29,29 +29,12 @@ chosen {
 	 * fixed address and all other firmware regions are moved to a fitting place.
 	 */
 	reserved-memory {
-		/delete-node/ mpss@86800000;
-		/delete-node/ wcnss@89300000;
-		/delete-node/ venus@89900000;
+		/delete-node/ wcnss;
 
 		wcnss_mem: wcnss@8b600000 {
 			reg = <0x0 0x8b600000 0x0 0x600000>;
 			no-map;
 		};
-
-		venus_mem: venus@8bc00000 {
-			reg = <0x0 0x8bc00000 0x0 0x500000>;
-			no-map;
-		};
-
-		mpss_mem: mpss@8ec00000 {
-			reg = <0x0 0x8ec00000 0x0 0x5000000>;
-			no-map;
-		};
-
-		gps_mem: gps@93c00000 {
-			reg = <0x0 0x93c00000 0x0 0x200000>;
-			no-map;
-		};
 	};
 
 	gpio-keys {
@@ -241,10 +224,23 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&gps_mem {
+	status = "okay";
+};
+
+&mba_mem {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 };
 
+&mpss_mem {
+	status = "okay";
+	size = <0x0 0x5000000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -294,6 +290,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 25ad098b1503..82402689b414 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -36,35 +36,11 @@ chosen {
 	};
 
 	reserved-memory {
-		/delete-node/ mpss@86800000;
-		/delete-node/ wcnss@89300000;
-		/delete-node/ venus@89900000;
-
 		/* Additional memory used by Samsung firmware modifications */
 		tz-apps@85500000 {
 			reg = <0x0 0x85500000 0x0 0xb00000>;
 			no-map;
 		};
-
-		mpss_mem: mpss@86800000 {
-			reg = <0x0 0x86800000 0x0 0x5a00000>;
-			no-map;
-		};
-
-		gps_mem: gps@8c200000 {
-			reg = <0x0 0x8c200000 0x0 0x200000>;
-			no-map;
-		};
-
-		wcnss_mem: wcnss@8c400000 {
-			reg = <0x0 0x8c400000 0x0 0x600000>;
-			no-map;
-		};
-
-		venus_mem: venus@8ca00000 {
-			reg = <0x0 0x8ca00000 0x0 0x500000>;
-			no-map;
-		};
 	};
 
 	gpio-keys {
@@ -287,10 +263,23 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&gps_mem {
+	status = "okay";
+};
+
+&mba_mem {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 };
 
+&mpss_mem {
+	status = "okay";
+	size = <0x0 0x5a00000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -348,6 +337,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 50bae6f214f1..ec073cfbb435 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -16,18 +16,6 @@ chosen {
 		stdout-path = "serial0";
 	};
 
-	reserved-memory {
-		mpss_mem: mpss@86800000 {
-			reg = <0x0 0x86800000 0x0 0x5500000>;
-			no-map;
-		};
-
-		gps_mem: gps@8bd00000 {
-			reg = <0x0 0x8bd00000 0x0 0x200000>;
-			no-map;
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -91,10 +79,23 @@ &gcc {
 	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
 };
 
+&gps_mem {
+	status = "okay";
+};
+
+&mba_mem {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 };
 
+&mpss_mem {
+	status = "okay";
+	size = <0x0 0x5500000>;
+};
+
 &pm8916_usbin {
 	status = "okay";
 };
@@ -126,6 +127,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7e0fa37a3adf..bc072a0e4d4f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -78,24 +78,44 @@ rfsa@867e0000 {
 			no-map;
 		};
 
-		mpss_mem: mpss@86800000 {
-			reg = <0x0 0x86800000 0x0 0x2b00000>;
+		mpss_mem: mpss {
+			/* size is device-specific */
+			alignment = <0x0 0x400000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+			alloc-bottom-up;
 			no-map;
+			status = "disabled";
 		};
-
-		wcnss_mem: wcnss@89300000 {
-			reg = <0x0 0x89300000 0x0 0x600000>;
+		gps_mem: gps {
+			size = <0x0 0x200000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+			alloc-bottom-up;
 			no-map;
+			status = "disabled";
 		};
-
-		venus_mem: venus@89900000 {
-			reg = <0x0 0x89900000 0x0 0x600000>;
+		mba_mem: mba {
+			size = <0x0 0x100000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+			alloc-bottom-up;
 			no-map;
+			status = "disabled";
 		};
-
-		mba_mem: mba@8ea00000 {
+		wcnss_mem: wcnss {
+			size = <0x0 0x600000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+			alloc-bottom-up;
+			no-map;
+			status = "disabled";
+		};
+		venus_mem: venus {
+			size = <0x0 0x500000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x10000000>;
+			alloc-bottom-up;
 			no-map;
-			reg = <0 0x8ea00000 0 0x100000>;
 		};
 	};
 

-- 
2.40.1

