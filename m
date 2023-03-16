Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301436BD200
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCPONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCPONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B7B1EE0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z42so1812198ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vqopDs853OIz7wr3B+Xdv3eU9ExHJXccftgDO6ekVc=;
        b=yCQR3osMTJ6h42DloZHw7hvR8IiOa/B1l7UrhvUqmhpbLDTdGc8RI6r+dBVR1qFqub
         QueyNwawWv9ScOqMQuD/29Sr8maAftaQFe8EXsg9bGiuoxD/HJi+eMsjVUgf84TFklhh
         YdvwtFnwUAgDXPl56akEORHH4G3gHTjbFzLItKjoGPm6DLVl5EOUsy38cFcr6eS8xk6w
         3bdHPLaVag/CjllrEndTs/8RimMENESWzt5TTymb0+UDAXUR4WWdTGSUiLKeyrYPPPMY
         Ie6Iw/GhHxp/owyc2hxhkuqS/d5Nd7BWbDr0amgXdOe27ae8YG/Y0spDNj4OMUBoAhtt
         rgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vqopDs853OIz7wr3B+Xdv3eU9ExHJXccftgDO6ekVc=;
        b=1vB/LEUJdlKo1LCUliSOKksUIVAEQdKcSYAU/cbfGbwigsk6c13rmzyyXEVmt3hv29
         neuorwzxbZPnlj+eQ4V/VZho9jk9HSSjOBHGixogVIRcqdsH6n2T2zrBJqVI2Rhlc6DA
         bN/xV7J/51houQOKxeMd7hWwhAIkHUfv2hF3kAbYwSDwhYad2w7SUxhEwhM0R4d5L083
         LvblknWBBfpYcWU7wxBtcKc6F4LvC+Zt1z/V6mllSUzx2+lGMFuyyPa6Mfj5xnruVdFG
         FYgd8Wu/WOLST72hRqSgiODHtx3wn0XFnaNtX02DzpfiB4GGzARwoMKGQYgwslqV1cOU
         T/Lg==
X-Gm-Message-State: AO0yUKXEBvnp+Xo8B44MElS+alLeF3u/XBywW9BBsqabcKarvNmNfZjM
        QtJHur+fwHYCeS+FovT9bL3ZNA==
X-Google-Smtp-Source: AK7set+hJK23nmyJ+qegwF3sPqZTklmmdr1DOxmq/W0AB0URDrUzgjjMEvp39AIIE85+kaa5a01nOw==
X-Received: by 2002:a2e:be8d:0:b0:295:ba1d:c2bc with SMTP id a13-20020a2ebe8d000000b00295ba1dc2bcmr2975492ljr.45.1678975991845;
        Thu, 16 Mar 2023 07:13:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:56 +0100
Subject: [PATCH v2 07/14] arm64: dts: qcom: sm6375: Add wifi node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-7-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=1484;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+otj1Pk8eMle5AYQIbjERaviQEzSMjyG5K7Qicq4ass=;
 b=v2EQnTrGNPBuNI+AxHu/Y188twk1jFdXe+qthOVwuKFebklp76Q92+GnsXf/llpo9O4Pw03MDi7M
 ENLdI51qC/eFDQ3R421FxjoMW1VFwWELIiOyAQjyDjv7QkRWH6A5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for ATH10K_SNoC wifi on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 2cdd000a4e2b..e473a90f3dea 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1333,6 +1333,28 @@ apps_smmu: iommu@c600000 {
 			#iommu-cells = <2>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0 0x0c800000 0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&pil_wlan_mem>;
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
+			iommus = <&apps_smmu 0x80 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x0f200000 0x0 0x10000>,  /* GICD */

-- 
2.39.2

