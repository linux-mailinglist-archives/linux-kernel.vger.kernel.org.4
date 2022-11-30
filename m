Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA3963E181
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiK3UMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiK3ULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:52 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268764E699;
        Wed, 30 Nov 2022 12:10:27 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn5so22182943ljb.2;
        Wed, 30 Nov 2022 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeKUFuMBGeOpjtNWu+0ecey1vuODCAFUa80H0ilPD38=;
        b=m5Ymrb6lcOlQCFUPyS5dDFiWk7h0coEC1hEjEdmkCwdJNcaKdcG8E+ngDKWyXDm3jR
         y5C5dH8/GkOIPG12tjyl1Tk96HFLmLmoVOQjhQVBTHMb7i0MY/vJjLCN1y8mYIbjsKXF
         uZciS35mrj85YYytZiW4tnAS/pFj/vFUDYGAQI8MZhV6xtTnQESTp2d9dnIOHLk3/vDy
         dtfyIqbC56gZJVf18ARwejyPuN3kqr6r38CkH/+4K1yXqpcYBnDvXJwvQHs1auRYnAsF
         feY2fPm9uO3YsBlsuBDlF8sozflt0fJ6rs/+fmfb5s7Y9OgoU3DxPWjN2dSOX0PBCk7Z
         YWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeKUFuMBGeOpjtNWu+0ecey1vuODCAFUa80H0ilPD38=;
        b=3PsNvgXQibIvbq5zyrFjNSDkiYx6xEazaSdnehHTLcFMl6Y49YyATeMfd06lFnL7ZL
         KblsJnGPea8Zx2Yb8Xp8O+ngbK6yP2dqQra1PSVXdlbzcQCw+X3b4Au+d9O584Ab0YZV
         rxVchkeNkFg42tyYHKzwmXJKIgPI6v72mzNFmQdpvpxfW9JkUKmLVvrCi7yphb9mnkCC
         5N63Joltc7qYwEi6ygHheQwFskAa2bJACFnSsyLW1XEPjgpHJ/xpixn9SUOjzVGeT0T6
         LWPmaQTm6dzNIZtvzNdR79mVIR8rV5mfjaz421BEERl54FdWu6T+uDBSVZT7WChXWa95
         hHVA==
X-Gm-Message-State: ANoB5pmZvH+MQS+ctCHvkdpoT3r0R6Q5yDu+PjkUT0lpVxgduj1WD7Y7
        rcRRdsI1R35mV18ffpipSZml/Z13Sz4=
X-Google-Smtp-Source: AA0mqf7EL8CUTw6gdGplX8YzU89iQEAEQ3gnLjh5BmUir1uGwe/Ke0v01HN+zvn9r7ueoZc51+RHBQ==
X-Received: by 2002:a05:651c:503:b0:277:dba:2f65 with SMTP id o3-20020a05651c050300b002770dba2f65mr15966645ljp.201.1669839016715;
        Wed, 30 Nov 2022 12:10:16 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:16 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 09/12] arm64: dts: qcom: sm6115: Add GPI DMA
Date:   Wed, 30 Nov 2022 21:09:47 +0100
Message-Id: <20221130200950.144618-10-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPI DMA node which will be wired to i2c/spi/uart.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c476b5ecb62b..b30a5485671d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -681,6 +681,26 @@ ufs_mem_phy_lanes: phy@4807400 {
 			};
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,sm6115-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x04a00000 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =  <10>;
+			dma-channel-mask = <0xf>;
+			iommus = <&apps_smmu 0xf6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.25.1

