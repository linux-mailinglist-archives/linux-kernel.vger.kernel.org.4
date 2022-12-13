Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67864B4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiLMMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiLMMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:09:50 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66614D19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:09:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x28so4557578lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1CzYtgsJNMDeTo+QvpNgIebzVI6ah5DqX1yikppAWk=;
        b=gEshvOx5wEZljrnILIEojgKJxxcslI/Xevc1/weA7xprL0xIKvf5H3hNaq7n86O4sW
         o296rPP3/lsAfNJnf3XAoeG3mKMw/PH+rzURDS6SgnGn31LTk8CfiF/Y03S63CHF4+Rf
         wA2NQVYJVvQ+nlmCYZd67GKRzTlNoZq35Brfh3r4JmH/73hIRWvR/3niDeV16pfGIk26
         fRfln8evoqdP8mlter2zsa2ge3TMtYFyFbzF0961jT9oLVuSj1/0EyeRaJZdGL+fsCNN
         qdupavmp5p9ZtIXvq/lVYFD1edo7SOtZtgPUnqLHKtMltDU6DFEgaj0SximBbTiIhcu6
         SQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1CzYtgsJNMDeTo+QvpNgIebzVI6ah5DqX1yikppAWk=;
        b=1A2jkBE/BBUpBtxSjghxhSbXMFMBo4bEkVJyZ9eorBo0iG6oOzm7m5lv0y5wcs7fxn
         SJZDZYWf/7T/n76y1PwsKLh01EhmToUoPonctx45P8Z6x9Rg6I3KlLtgIoRb/WB6hJvy
         PXp5VV+6X9Z4j+EAv1r1YHzV8zEBEw9H2fA1cRt4tEbY4gV6wGV1Tgd3QVzT0/qgQR9D
         ctU50t5zGht/jdDzpYKrUtknnPtbskJ2x0SJAwmSqrFjdf/ld0FWsq0de5CSgOKZuc67
         01cn/kozRIiH43X6RayiuPhaouVlxzR48kRwKvBTQFlwYA/iYQrqUusC8n3pUN57pzZq
         PO8A==
X-Gm-Message-State: ANoB5pmkF/dJJ1a6ynQAJrtKo0fDDPo+VNdCVjz/L76Qtbbpdm8uyrGp
        YAqrwrZ7UNHh1mPlnAjl3Aw5WQ==
X-Google-Smtp-Source: AA0mqf4Yvg8WbdzlxqkRpQntyluDFtnAYh96EAhPNtSy4LV3FFMQHJG1Xx8Wbeq6/e5WehdLiide0g==
X-Received: by 2002:a05:6512:4022:b0:4a4:68b8:9c1c with SMTP id br34-20020a056512402200b004a468b89c1cmr6251530lfb.4.1670933386052;
        Tue, 13 Dec 2022 04:09:46 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b004b1756a0ae9sm343343lfr.55.2022.12.13.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:09:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Date:   Tue, 13 Dec 2022 13:09:43 +0100
Message-Id: <20221213120943.165452-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

With enough pins set properly, the hardware buttons now also work
like a charm.

Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Look at the 1 III again, realize there's a recessed button, add it
to the common DT to make it work on both devices.. (Marijn)

 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index d73e1f3fa501..2f727e4f2e57 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -49,7 +49,35 @@ framebuffer: framebuffer@e1000000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		/* For reasons still unknown, GAssist key and Camera Focus/Shutter don't work.. */
+		pinctrl-names = "default";
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8350b_gpios 8 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8350b_gpios 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+
+		key-google-assist {
+			label = "Google Assistant Key";
+			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_LEFTMETA>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
 
 		key-vol-down {
 			label = "Volume Down";
@@ -545,6 +573,32 @@ &pm8350_gpios {
 			  "NC",
 			  "G_ASSIST_N",
 			  "PM8350_OPTION"; /* GPIO_10 */
+
+	g_assist_n: g-assist-n-state {
+		pins = "gpio9";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8350b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio8";
+		function = "normal";
+		power-source = <0>;
+		input-enable;
+		bias-pull-up;
+	};
 };
 
 &pmk8350_gpios {
@@ -552,6 +606,14 @@ &pmk8350_gpios {
 			  "NC",
 			  "VOL_DOWN_N",
 			  "PMK8350_OPTION";
+
+	vol_down_n: vol-down-n-state {
+		pins = "gpio3";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
 };
 
 &pmk8350_rtc {
-- 
2.39.0

