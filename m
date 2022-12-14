Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA864D154
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiLNUgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLNUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:35:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CB3137B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x2so3283364plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfisaX1yRNC7eLaChTG8lYX6QtvwXvGxy+CVBHfkvYY=;
        b=iXwjzWxm8czKkuv24mdSFWh1miR+KRa+tM7sG71WvNRjMJsKUYbqluXDfKVle+Yra5
         alPu5buTji1JguvriqfWjHTI7PE2qaYG5MK1py017BGe7E4lg4y9Jcuk91iVj1rLCzDJ
         xQune/lj6T2xB3yQ1GI6aoXukCBiVmohQuu7DHtU/ArKIFxlxNJve/EOfzSMNJHRyUK9
         F1cfn/y4P6+g/96uaNZHDD0k3NlcUqt7zAgc76DZ2ttFTVbW2xvTa2YWx298HJz4MHTd
         +WllCDUW2O/HWSfNWp1WJLCKzYChvSOAqYZ16mLdan8LgrOA1vb0wlkQ1raKqC2pgNRN
         xiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfisaX1yRNC7eLaChTG8lYX6QtvwXvGxy+CVBHfkvYY=;
        b=s9xYgzLL7B7t2/FFADTRbiciGZN4BYjDDwb0S78pECKc5nlHuusH5DoQxYcPbB95aS
         EeFzSqxPWTrXsze/wsZj0QxbCPQHWeel7YbVQQfTgq0Xe6GnU0riSIpU6SI6ffhJWA4S
         K46JoX+4l23xXAMCvqQ8/u3NHv9baPKcsfJHexeY4nUmz7ZtNjHjMYumOhO4gGRaYrDJ
         VfvrhO0c6tw1BBBYd9QsM9wdXC00OBHMmlgQe3flyFz4mf34koifHMeriECcZsxsau4X
         xBwOmb3m02xaO1HQsZccPnz8SOcOrLhxMgU/FaOO1wOH8jys4sezbWyi2g9NeI4pvfWx
         Ya6g==
X-Gm-Message-State: ANoB5pkeRgK5OGGVamep85iTmZsYstdwxfU/uj+MSxhDz2MK4XamHENt
        vD471N1aDFF6bopsFEPZKEqTlpHRr4mZSkTmfpQ=
X-Google-Smtp-Source: AA0mqf4IoGccZZP7169MteNGpn2PFmUOvL3DOXR55Lib2aZ7FjigSY7EK8yOhRrrZpc//QLEPCNBAg==
X-Received: by 2002:a17:90a:710b:b0:21f:e5c:9852 with SMTP id h11-20020a17090a710b00b0021f0e5c9852mr21559709pjk.1.1671049908588;
        Wed, 14 Dec 2022 12:31:48 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b00219e38b42f5sm1812238pjb.26.2022.12.14.12.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:31:48 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm6115: Cleanup USB node's label
Date:   Thu, 15 Dec 2022 02:01:22 +0530
Message-Id: <20221214203124.564537-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
References: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
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

There is only one USB controller present on SM6115 / SM4250
Qualcomm SoC, so drop the numbering used with USB node's label
names in the dtsi and the related sm4250-oneplus-billie2.dts.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 4 ++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index a3f1c7c41fd73..fa57f4bf58256 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -225,11 +225,11 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
-&usb_1 {
+&usb {
 	status = "okay";
 };
 
-&usb_1_hsphy {
+&usb_hsphy {
 	vdd-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l12a>;
 	vdda-phy-dpdm-supply = <&vreg_l15a>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 572bf04adf906..b5f7480c2e713 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -565,7 +565,7 @@ gcc: clock-controller@1400000 {
 			#power-domain-cells = <1>;
 		};
 
-		usb_1_hsphy: phy@1613000 {
+		usb_hsphy: phy@1613000 {
 			compatible = "qcom,sm6115-qusb2-phy";
 			reg = <0x01613000 0x180>;
 			#phy-cells = <0>;
@@ -991,7 +991,7 @@ spi5: spi@4a94000 {
 			};
 		};
 
-		usb_1: usb@4ef8800 {
+		usb: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
 			#address-cells = <1>;
@@ -1019,11 +1019,11 @@ usb_1: usb@4ef8800 {
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
 
-			usb_1_dwc3: usb@4e00000 {
+			usb_dwc3: usb@4e00000 {
 				compatible = "snps,dwc3";
 				reg = <0x04e00000 0xcd00>;
 				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
-				phys = <&usb_1_hsphy>;
+				phys = <&usb_hsphy>;
 				phy-names = "usb2-phy";
 				iommus = <&apps_smmu 0x120 0x0>;
 				snps,dis_u2_susphy_quirk;
-- 
2.38.1

