Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8826163C9CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiK2Urs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbiK2UrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:19 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACD66CB2;
        Tue, 29 Nov 2022 12:47:18 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so18615786ljh.13;
        Tue, 29 Nov 2022 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM8qWhjtmVz4g8QiVLIg+Ipe0Ovs4/S9ZpUrITzygDw=;
        b=VTmPTjA0nBXjP2iGsAL/CDBkR2uVwYlxV0pZUds5sisiYqyFAWRgkaG9Hkx6pEEx9z
         sZwRG+4s4bcSz6txpufg+3mDQnt3GvuP+GrQsWt8jD6qNqa9QcSWDmrDCv961I+rUqay
         gODis7/X4F7oCOgDWpUHP0l1BbO/A0zt/mS3EqkNDjiQkexgZXAjL36U8etUSKDHyqy/
         eTQxxIvW1PWHXVPUzriUPgdiuchrtMk3ML1JrsxkQsGYcdYcy3hydV6T7Tlosmaj4MZO
         QjHa7pyf86rR5EW49I8pAxreREUgmZ+k0JFeotLL72ZjJATJWuiOey/dgzisQh4dpoTM
         UYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM8qWhjtmVz4g8QiVLIg+Ipe0Ovs4/S9ZpUrITzygDw=;
        b=RrEnw/mqyLGK74DSuA7Qa98i3jyFsuYrrjAm0Ao3nN8jnysePk+PTKYvj0RPDXOAVa
         xUFNhPeCtZi/aUS+La7T6MO4B2neeWYDEvhW6y6Ajtp2PJNJ5kjnoqVDRKjOpJ4Xzx+p
         R07SUcekgEcftSc2BCziVzcA5EqsXYSE5IOLPDSf/HS/ewH7yRtqeMGynAl0Xs+oxdHn
         fNCProYDVad1/NJFUvCmnz15t09bNLVuE7jW7EDmKZ/m0+7PyBg6VVG2dyEgPGV3Smho
         3VhkUcsOx9p5PppwAKQYo2AJtohbFPDjj3PFT0Orop/w2jexDsHlGLnhR6HuvCCvbwhs
         wi4A==
X-Gm-Message-State: ANoB5pmvnHXoiNhdEsilvr6l8exm2R8dHJU4m8Bd2G5OFb621zIz11Rd
        KFR7vHuEVKSExb1kM3y8NAH0iiKQMws=
X-Google-Smtp-Source: AA0mqf5SpcOjRARzwp1NkQxL/CovjoQTjDAIOA8/0GZqKninqGw0BWnE0/HvuzYtIY6HU70h3/QAYA==
X-Received: by 2002:a05:651c:160b:b0:276:4462:2d20 with SMTP id f11-20020a05651c160b00b0027644622d20mr11957815ljq.19.1669754837049;
        Tue, 29 Nov 2022 12:47:17 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:16 -0800 (PST)
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
Subject: [PATCH 11/12] arm64: dts: qcom: sm6115: Add WCN node.
Date:   Tue, 29 Nov 2022 21:46:15 +0100
Message-Id: <20221129204616.47006-12-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
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

Add WCN node to allow using wifi module.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index d14a4595be8a..36d1cff23d10 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1294,6 +1294,28 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0c800000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+
 		apcs_glb: mailbox@f111000 {
 			compatible = "qcom,sm6115-apcs-hmss-global";
 			reg = <0x0f111000 0x1000>;
-- 
2.25.1

