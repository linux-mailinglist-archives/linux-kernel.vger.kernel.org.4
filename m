Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215E76D326E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDAPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDAPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:49:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B93124AE5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 08:49:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so23472314pjd.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680364184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XxX9v4o0e9A74KVKINLnIuAStvu5tpKtcGeS/xTyjw=;
        b=jwCIYHio2McD+8FXZ6aibHPMSWP88pY8QBlEyDOCcDHMAb2TtaArVkFKtHMdv+ft1x
         09BmXEvC256DiBUubxpE+HDUq/uPAZarxS2HgII2R9vdQ66g+G467w86LpSBw2zqinmK
         LuyN0U2eNbkUVcrGpdxF/NAKqhzsIT+qLSZzNfMSh2nnPnfX4Q752LXtmWKRWf6Lld+D
         eD/4yrZ378Oqj3UP3CIl2buoa0GO8XssGdgrSF61rhsHBvzTzbxj0kD8FOHPyBQvqJ3E
         i6VP8GmkOxvU64IqmUFJwvn1foNoKtR9FBB3WqeBwLqGrK2+/097rYoT5UKViOoI5Jgm
         /uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680364184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XxX9v4o0e9A74KVKINLnIuAStvu5tpKtcGeS/xTyjw=;
        b=jgbeVJkqj5WKdBBAoIiAD9UddVW8S7Sa5VhnNNDd0L5eLMCkUht7kEkT0MhdaXE3P4
         LucsqIoyzAkQrM/iYUVhuo8muQMkMVG/3mDo2OBDt8P4cmtS7KzQy0r397KT694XeAsB
         yVNNuIAI7/a7IHvQOJm0Om7c7rdF8IZ9dVQpZ3MuCMG9+KL+k5oTWcdobVsOnFqRiX4D
         QgHVyfdsB86QvJjRCGnT39ARHMXo/riHaRHuOoiWsTEY/4c1m/m1Gh4BpAJE7of4LWIY
         fdBCEHioYW2z/0mHej+HYTYcvIXoP4eL3Iw4XOq9j/EY5Y9YOcZ1RKCC9nwfVQdM/6n1
         nfUQ==
X-Gm-Message-State: AAQBX9eEFJasda5MEWJy/oPy8T8Lq1ovSiXk7j8JkQ39ZZaFChnWXURR
        SmBD9l+1IDVtNo1AHKzJuR45hw==
X-Google-Smtp-Source: AKy350awvfGT7Nqv73PoQZ7BRCcmmbD6AC4VvpCw4O2VXwKQumhywOswA1HdtnFQOi9jNQenyVGgcQ==
X-Received: by 2002:a05:6a20:1610:b0:e4:83b4:bb9d with SMTP id l16-20020a056a20161000b000e483b4bb9dmr6369178pzj.29.1680364183964;
        Sat, 01 Apr 2023 08:49:43 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id 65-20020a630444000000b0050fb4181e8bsm3385367pge.40.2023.04.01.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:49:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Date:   Sat,  1 Apr 2023 21:17:25 +0530
Message-Id: <20230401154725.1059563-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230401154725.1059563-1-bhupesh.sharma@linaro.org>
References: <20230401154725.1059563-1-bhupesh.sharma@linaro.org>
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

