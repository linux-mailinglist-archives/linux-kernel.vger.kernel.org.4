Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117F65AF07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjABJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjABJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:04 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D56E81
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:47:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bf43so40923232lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf28mKbP+5jCzsHZSqVH7gfbDas3KwafvGcqx18n5Rw=;
        b=InbnnB/8Gca+M61yaVMJ3PBRAKfVDNjoOtJffoPflcwvGSlqY8qpIeJ+TW0f1PRC87
         xXWnlpPNrG8z8m4JKq9KW12WhjEPnyviO3hSlkOoRF0f4nHvG5uYCJTxOl2rw9ItVUZr
         2IxyY0Gyf22xSrMpHTAs7eL1yAJOeCIxYeQGCeQBQWeu8cF/nLKfe8Th7hZgbBzCkIN6
         W8eNPQ9OwybBDBiwCY9df2TALkimkanySIMURNYPG2Ta9gAqiapRtAkBGYEOGKoFeF/t
         De+Wlauc7W3YooqNkknCmZ64Fc43f1xBhiVJFzUHwqKzgfrQg2779mwrDngoqMNO/jEV
         ovyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf28mKbP+5jCzsHZSqVH7gfbDas3KwafvGcqx18n5Rw=;
        b=Z7VMidkcpPA3DC9Cb7wJKi6UiIfMBarts/JL8KiL7py6hNuXWkeS5tpUfsD0gzBaNa
         JtH2brxdtAGgmDdH9u4jKKYrXiz7OPnj+50D37Gm4hx/w1u1bBlemuTBWIlhfs57FjfN
         0HdhrkkEKKIxO9eWiMXgaoNm8z7zy0tHRJUm2BB39Lg6e56gIZfQW+k3Cx//SumlZ0Jz
         n7x9tBRjycubXxHte2OTh4KlDkhWBCMU05JGU3rhovtNDezkfbDaVd7kqMF9TUGwQeTI
         Qc7g46rfATfJSKRSEpm1HAULGSF2I7sK+pio0ie/NFh+vGz+yokWZeA99vQtYo6AI8A5
         DOHg==
X-Gm-Message-State: AFqh2kp8znbxI1oiAciNwMnPD/FmOrKCyxnU5RKW9N2S8+Pvaxsuja9/
        7W+zZ6HMzmmcfUbeo2/1Sj7QvQ==
X-Google-Smtp-Source: AMrXdXuOWCF9XtEeOtyGI775hz8fhAY0SJY5ctQiPoFcToKRAmq12Qrg3smim3eHGGctBZQaq/IXSQ==
X-Received: by 2002:a05:6512:3901:b0:4bb:70b2:6f4b with SMTP id a1-20020a056512390100b004bb70b26f4bmr10706515lfu.0.1672652818482;
        Mon, 02 Jan 2023 01:46:58 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:46:58 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:35 +0100
Message-Id: <20230102094642.74254-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 54 ++++++++++++++--------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 0b6a6a809503..a642ff1af094 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1899,10 +1899,10 @@ pcie0_phy: phy@1c06000 {
 			status = "disabled";
 
 			pcie0_lane: phy@1c06200 {
-				reg = <0 0x1c06200 0 0x170>, /* tx */
-				      <0 0x1c06400 0 0x200>, /* rx */
-				      <0 0x1c06800 0 0x1f0>, /* pcs */
-				      <0 0x1c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
+				reg = <0 0x01c06200 0 0x170>, /* tx */
+				      <0 0x01c06400 0 0x200>, /* rx */
+				      <0 0x01c06800 0 0x1f0>, /* pcs */
+				      <0 0x01c06c00 0 0xf4>; /* "pcs_lane" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -2005,12 +2005,12 @@ pcie1_phy: phy@1c0e000 {
 			status = "disabled";
 
 			pcie1_lane: phy@1c0e200 {
-				reg = <0 0x1c0e200 0 0x170>, /* tx0 */
-				      <0 0x1c0e400 0 0x200>, /* rx0 */
-				      <0 0x1c0ea00 0 0x1f0>, /* pcs */
-				      <0 0x1c0e600 0 0x170>, /* tx1 */
-				      <0 0x1c0e800 0 0x200>, /* rx1 */
-				      <0 0x1c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				reg = <0 0x01c0e200 0 0x170>, /* tx0 */
+				      <0 0x01c0e400 0 0x200>, /* rx0 */
+				      <0 0x01c0ea00 0 0x1f0>, /* pcs */
+				      <0 0x01c0e600 0 0x170>, /* tx1 */
+				      <0 0x01c0e800 0 0x200>, /* rx1 */
+				      <0 0x01c0ee00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -2094,7 +2094,7 @@ pcie2: pci@1c10000 {
 
 		pcie2_phy: phy@1c16000 {
 			compatible = "qcom,sm8250-qmp-modem-pcie-phy";
-			reg = <0 0x1c16000 0 0x1c0>;
+			reg = <0 0x01c16000 0 0x1c0>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -2113,12 +2113,12 @@ pcie2_phy: phy@1c16000 {
 			status = "disabled";
 
 			pcie2_lane: phy@1c16200 {
-				reg = <0 0x1c16200 0 0x170>, /* tx0 */
-				      <0 0x1c16400 0 0x200>, /* rx0 */
-				      <0 0x1c16a00 0 0x1f0>, /* pcs */
-				      <0 0x1c16600 0 0x170>, /* tx1 */
-				      <0 0x1c16800 0 0x200>, /* rx1 */
-				      <0 0x1c16e00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
+				reg = <0 0x01c16200 0 0x170>, /* tx0 */
+				      <0 0x01c16400 0 0x200>, /* rx0 */
+				      <0 0x01c16a00 0 0x1f0>, /* pcs */
+				      <0 0x01c16600 0 0x170>, /* tx1 */
+				      <0 0x01c16800 0 0x200>, /* rx1 */
+				      <0 0x01c16e00 0 0xf4>; /* "pcs_com" same as pcs_misc? */
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
 				clock-names = "pipe0";
 
@@ -3792,16 +3792,16 @@ camss: camss@ac6a000 {
 			compatible = "qcom,sm8250-camss";
 			status = "disabled";
 
-			reg = <0 0xac6a000 0 0x2000>,
-			      <0 0xac6c000 0 0x2000>,
-			      <0 0xac6e000 0 0x1000>,
-			      <0 0xac70000 0 0x1000>,
-			      <0 0xac72000 0 0x1000>,
-			      <0 0xac74000 0 0x1000>,
-			      <0 0xacb4000 0 0xd000>,
-			      <0 0xacc3000 0 0xd000>,
-			      <0 0xacd9000 0 0x2200>,
-			      <0 0xacdb200 0 0x2200>;
+			reg = <0 0x0ac6a000 0 0x2000>,
+			      <0 0x0ac6c000 0 0x2000>,
+			      <0 0x0ac6e000 0 0x1000>,
+			      <0 0x0ac70000 0 0x1000>,
+			      <0 0x0ac72000 0 0x1000>,
+			      <0 0x0ac74000 0 0x1000>,
+			      <0 0x0acb4000 0 0xd000>,
+			      <0 0x0acc3000 0 0xd000>,
+			      <0 0x0acd9000 0 0x2200>,
+			      <0 0x0acdb200 0 0x2200>;
 			reg-names = "csiphy0",
 				    "csiphy1",
 				    "csiphy2",
-- 
2.39.0

