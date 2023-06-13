Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333A172EA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjFMSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjFMSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:09:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22F19A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:09:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f6170b1486so7120108e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686679746; x=1689271746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEVb9IU/qLN25isZtE62j5+X+b1dacmJcTX7I3nYwwo=;
        b=jMYpcRoe2VA1OzbxShNcKcjRqDuFHxYqSWYKbv0bQUgDmAvOIeQcVsq7xrDOW7sWYz
         4Kn39Czmrx5xvHyOSOLDINxyKGy/2P80piuCDUkfx4tzfWku4ULcCQvEdZFTMzjvzJx2
         XbxKXrVbtPVSTtTRaIr/fEhYaresDQQZ/y1CijE8D1OK8PpJiqNlHS316vi5sSNSIDNv
         nX669Qkp3h67TNGI0a0OCO8pqLRXdhGeULu2lxxg1m3JrFzFrPX//8Y0q0o45KqHUnX7
         dferSCjen1bXnndvLANifVpew8Ul1eK2UrRPQ1fsgt2vTZl1IGA06p6yQNojtqFYPX1v
         tOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679746; x=1689271746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEVb9IU/qLN25isZtE62j5+X+b1dacmJcTX7I3nYwwo=;
        b=E6XgzIdP60BZ/bzEOLk/7glH9ERHqoQ0xdNRInx2wR+MrqAq3LQPkKAJhieUTleXgI
         471BVE9pz8/TLLL/k7eY+qbTMiE54u8x1v1DzkLRGS2C6xHEwuR0D+rV6eXdzGYrrJ+x
         FwtQjvsuiriQmJ0eFukLqn1bKd+GMDe/iYRLugfTiWnw0gu2ZCxqP7LeG2ROLmNHmMck
         jltgX2l087PvTuL3NL7lgxzpUubp6XeKxeUsbGv+N9tTu6EsSItpLYZGg5lU1Uq1O4aA
         nbhbFJ/g7ZSiwW7jvs31PgrKoUQl0NeZJqmA1A9DjT4NTfNsoWRKBPip1a4kD00M03b2
         PZ4Q==
X-Gm-Message-State: AC+VfDxsOufHy3Mfdk6uazJ3c+QenSle3s02OucQVQq/FwA0BdLdnR8Q
        vNPtbw+zZi8InHvaeyiORvh1BJLCsd24YhYNqvg=
X-Google-Smtp-Source: ACHHUZ4Txu8rmkV8rAox0K2Jc9y2jvZqt1cpxRVy8Q++mlVFHUoK9t8ymQBvu5/3rvE/UoNnd6FGHA==
X-Received: by 2002:a19:770e:0:b0:4eb:e8e:4139 with SMTP id s14-20020a19770e000000b004eb0e8e4139mr4117966lfc.2.1686679745827;
        Tue, 13 Jun 2023 11:09:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b004efe8991806sm1842899lfe.6.2023.06.13.11.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 11:09:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 13 Jun 2023 20:09:00 +0200
Subject: [PATCH] arm64: dts: qcom: qrb4210-rb2: Enable on-board buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-topic-rb2_-v1-1-696cd7dbda28@linaro.org>
X-B4-Tracking: v=1; b=H4sIALuwiGQC/x2N0QqDMAwAf0XyvIBt1Yf9yhijjdkMSJV0ilD8d
 4OPd3BchcIqXODZVFDepciSDdyjAZpi/jHKaAy+9aEdXMD/sgqhJv/BfiR2PQWXugEsSLEwJo2
 ZJkvyNs8mV+WvHPfh9T7PC1dpEGxxAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686679744; l=1716;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/X0tAGEydFCfBkn2TuDyVWHG8ilu9psIXgXCnXJLL14=;
 b=hhTmXGpcfJqAOkPldbPkbIpOLeq3jmpYU8AhaQpOrw279OvsgxGLUaetpPkrUGMpapw11Oj6o
 1v8esRZNCusCUE5YfBakoUvRleHt/2TWYuLjGWRVBQdlOkOQBqFsT5z
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PMIC GPIO- and RESIN-connected buttons on the board.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 39597277343c..e23a0406eacc 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/leds/common.h>
 #include "sm4250.dtsi"
+#include "pm6125.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
@@ -28,6 +29,23 @@ clk40M: can-clk {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&kypd_vol_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm6125_gpios 5 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -219,6 +237,25 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&pm6125_gpios {
+	kypd_vol_up_n: kypd-vol-up-n-state {
+		pins = "gpio5";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
change-id: 20230613-topic-rb2_-5dce15c31b46

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

