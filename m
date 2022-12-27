Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66907656D03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiL0Qil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiL0QiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:38:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B2BE21;
        Tue, 27 Dec 2022 08:38:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so32974582ejb.13;
        Tue, 27 Dec 2022 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9x51qZM3dmw3q1Gmj+grmkRBso+ngJxYGuwVFTVUfE=;
        b=cSeg6SMXZTw2S3awu4Vd20lbxpNwB4bHMW3wYvwNbueANGWwEpNK585wCgnol7FZuA
         zw4FIbDFGON0P8U6luQq7NhhG1ZykATEyDt/FaHOC06cMI4gTxj22KBnthZ8A6teO+zE
         T9SCPbmr2z0ROEKhJG+19Km2S7KaSrW8TJoNwJHJ+IIXo1J2+ttgi6PWcJo1Y02D4If3
         qV3zTg5820caFqv2UoYIhwF3x18kDBdmJVDFEsn/oT5bPhSe9+swUi8uh4CwKp7MG82d
         4Xhu6h67IYTRrjEa08m+o8VVeFTBaFI+fSDilIB6ZiNh6LH7COfElMltRyNZrKh0rxr1
         qMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9x51qZM3dmw3q1Gmj+grmkRBso+ngJxYGuwVFTVUfE=;
        b=TO0GUDYdxo275aF8fOpLn356RVRFcHPQRk0moOm2EHVZecfx2iMKMuZ/tcChPHPk93
         ZyeplJzntJFeICqpMyJKIAWGl+uITXbFduSvsFMNEdW3vHZZ16pclyG2vXpJqF8U3eQR
         qyIS9S/GKy/EcYz5tZ2lqb38m629cmB+ilm5U1/4bCVIVuepgC7Qling9TO06V9+MHS5
         wzlMNY4jL3AQWPxaVLralrgU2SzRpORRK/p8WMiV8l9QGExxA5mZpk2zKxlAhBOwB3OJ
         e1IZfTdWMwTjwuxuZsJWMxsm40zseN8Fv1VuIcpnmR2Zpz3D0dCkqJN5Fwwv5wqaIXzF
         BuCA==
X-Gm-Message-State: AFqh2koDheiasx5Ka6OZTe9UD1SIbkUcknUkyeZhn7nGyyCf78VE3EIk
        himxhMS/RdoC/RkRqSFR4NTEXpRgaXI=
X-Google-Smtp-Source: AMrXdXsa8vWPOWBH5oCmQBKexpuvB2Q+w4KgR6qfrkcID3jSceZ3fi6PzcyeLP6zQDgRzkah0WIeDw==
X-Received: by 2002:a17:906:6a81:b0:844:9eec:f70e with SMTP id p1-20020a1709066a8100b008449eecf70emr14570847ejr.31.1672159096165;
        Tue, 27 Dec 2022 08:38:16 -0800 (PST)
Received: from localhost.localdomain ([46.216.42.4])
        by smtp.googlemail.com with ESMTPSA id t18-20020a056402021200b0048447efe3fcsm3348302edv.84.2022.12.27.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 08:38:15 -0800 (PST)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] arm64: dts: qcom: fix resin node duplication
Date:   Tue, 27 Dec 2022 19:38:10 +0300
Message-Id: <20221227163810.71121-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resin node was moved to pm8998.dtsi file, and introduced duplication
with other dts files, defining resin node.

Fixes: f86ae6f23a9e ("arm64: dts: qcom: sagit: add initial device tree for sagit")
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts       | 11 +++--------
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi        | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts     | 11 +++--------
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 11 +++--------
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts    | 11 +++--------
 7 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 310f7a2df1e8..510d12c8c512 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -364,14 +364,9 @@ cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		bias-pull-up;
-		debounce = <15625>;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &qusb2phy {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 5da87baa2b23..3bbd5df196bf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -357,14 +357,9 @@ vib_default: vib-en-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEUP>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
 };
 
 &qusb2phy {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index f41c6d600ea8..878801f540c5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -615,14 +615,9 @@ vol_up_pin_a: vol-up-active-state {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_lpg {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 1eb423e4be24..943287804e1a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -482,14 +482,9 @@ &mss_pil {
 	status = "okay";
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &sdhc_2 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index bb77ccfdc68c..e6191602c70a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -522,14 +522,9 @@ pinconf {
 	};
 };
 
-&pm8998_pon {
-	volume_down_resin: resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_lpg {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index eb6b2b676eca..1b12b1a4dcbc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -325,14 +325,9 @@ &pmi8998_wled {
 	qcom,cabc;
 };
 
-&pm8998_pon {
-	resin {
-		compatible = "qcom,pm8941-resin";
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		debounce = <15625>;
-		bias-pull-up;
-		linux,code = <KEY_VOLUMEDOWN>;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pmi8998_rradc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 38ba809a95cd..fba229d0bd10 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -530,14 +530,9 @@ pinconf {
 	};
 };
 
-&pm8998_pon {
-	resin {
-		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
-		compatible = "qcom,pm8941-resin";
-		linux,code = <KEY_VOLUMEDOWN>;
-		debounce = <15625>;
-		bias-pull-up;
-	};
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &q6afedai {
-- 
2.30.2

