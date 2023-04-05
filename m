Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09BA6D86B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjDETTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjDETTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:19:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A67685
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:19:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so35018472pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680722361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XxX9v4o0e9A74KVKINLnIuAStvu5tpKtcGeS/xTyjw=;
        b=r1mhd2GF/+9tjdL87AbcmzOd3rkhNQV3KxOpogVAVFo6FU6ZsRwSgp8KQYMOVXLixh
         PwJw5uUAkRxgRk2gDFcm3oVKXidT+XVIVFIVDzaA0oM+Nfv5TFi9lst4S6uwuMiEaZCu
         zZeo2pIzSvAsXStGJ6aySOim5IRqZXz1wqbD4VYRdHiTUM+POVdtvj2XKeXZRtvpXrvx
         vUqy5/1BG/EnCMlDwJenhiH0HqCG59WA85iTkCDRVG7JRm+5jR6Diyfj0Thi+tbOSU2B
         cZLMx4VQ1gpiGV35Eb6OEgF2kKHdtQK7EokKWI02pWEJJW43v0D8m72a1/GjHPNdVoUo
         dPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XxX9v4o0e9A74KVKINLnIuAStvu5tpKtcGeS/xTyjw=;
        b=KO9Fe8zz/GaPGcjqjAgZKuti7cm3ei/HKeQWDougjad+8hXMJAL0PDNVv2a1WCRRhC
         hbjCvMLt4d8Se1BUugMr1Rn9aMj4V9dZH2q0Y+6evJ2kFWgAYGUatujD3Oam++1ZTSvx
         nVBs2QSilDujBK014+IyXLsfgRz0xouzs2g4iEQHufEWc5n7lyr4yALPW98R15ZD2BHm
         MOLKMUJAx/raKEW9snqBPJgbi67BBkAhOSuijQ5k/i4raLJ2bb9XiFOTE8zfoCm2NeNp
         Z9cAr8gnz6zQr10KsAWNVWXeRQs6LVz1GY+IKRhHvf99QZsoWjdwy21IPi1g3xIO46xo
         CWoQ==
X-Gm-Message-State: AAQBX9fjWD2YqQUc6X2RTBTHOeO6uXfs+MLgc7wwO6wWKHTMV0/OF7g+
        V6xOZSuxuJV34DbLnqwp+Jufxg==
X-Google-Smtp-Source: AKy350bW7kORq9ng9TSwhF++9ITY36DTz8cCbabmYwBSnB2TYNOCb94n80FxqeGGQTsYBt5H/92SPg==
X-Received: by 2002:a17:90a:3ec3:b0:23d:39e:6054 with SMTP id k61-20020a17090a3ec300b0023d039e6054mr3679223pjc.5.1680722361664;
        Wed, 05 Apr 2023 12:19:21 -0700 (PDT)
Received: from localhost.localdomain ([223.233.67.41])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902aa8900b001a1d7329235sm10478097plr.234.2023.04.05.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:19:21 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v5 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Thu,  6 Apr 2023 00:46:33 +0530
Message-Id: <20230405191633.1864671-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
References: <20230405191633.1864671-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB superspeed qmp phy node to dtsi.

Make sure that the various board dts files (which include sm4250.dtsi file)
continue to work as intended.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a1f0622db5a0..75951fd439df 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -242,6 +242,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2a51c938bbcb..b2fa565e4816 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -650,6 +650,38 @@ usb_hsphy: phy@1613000 {
 			status = "disabled";
 		};
 
+		usb_qmpphy: phy@1615000 {
+			compatible = "qcom,sm6115-qmp-usb3-phy";
+			reg = <0x0 0x01615000 0x0 0x200>;
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
+			clock-names = "cfg_ahb",
+				      "ref",
+				      "com_aux";
+			resets = <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>,
+				 <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>;
+			reset-names = "phy_phy", "phy";
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			usb_ssphy: phy@1615200 {
+				reg = <0x0 0x01615200 0x0 0x200>,
+				      <0x0 0x01615400 0x0 0x200>,
+				      <0x0 0x01615c00 0x0 0x400>,
+				      <0x0 0x01615600 0x0 0x200>,
+				      <0x0 0x01615800 0x0 0x200>,
+				      <0x0 0x01615a00 0x0 0x100>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+				clock-output-names = "usb3_phy_pipe_clk_src";
+			};
+		};
+
 		qfprom@1b40000 {
 			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b40000 0x0 0x7000>;
@@ -1100,8 +1132,8 @@ usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x04e00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_hsphy>;
-				phy-names = "usb2-phy";
+				phys = <&usb_hsphy>, <&usb_ssphy>;
+				phy-names = "usb2-phy", "usb3-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 10c9d338446c..d60cc024749b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -280,6 +280,9 @@ &usb {
 &usb_dwc3 {
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
+
+	phys = <&usb_hsphy>;
+	phy-names = "usb2-phy";
 };
 
 &usb_hsphy {
-- 
2.38.1

