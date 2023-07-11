Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EF74EEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjGKM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGKM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:27:27 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E3A8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:27:00 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b703caf344so85773971fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077968; x=1691669968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQLBnYw5pfVzQylFNgskr7H7oEW4uSiPIu84jcjkQCk=;
        b=VuL7tBUVpKwm0E8VYa3YxI4GLD3j9N+kI7pdvvPJj/+jxXvrfTFuxOy12F2CaBz/HF
         sN0z5yMN9SQ4RLjBjiJSK+RP2jDbcXKyWpDyVprDeiCicPUtkP28bTHnoH/6GIaElnvk
         l1MazyYCLLnZXkMfyxUQOCYkQMmByamThDVsRvQ342OHg7hWo8PsAPc4cVWFhv6RgRjS
         Vk62VuCZ7XvPZYsAsX8G0sBw387elQNYidznrlY96WT16f8qQ/PK4mEqopOqM3OCb9tO
         BLT/9Bf6DG2IJzr9obCW5Bqqnm2swgLDHQHUcHWvdtXP8jq3vM1e9/fbTkwVRdk6iLty
         dhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077968; x=1691669968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQLBnYw5pfVzQylFNgskr7H7oEW4uSiPIu84jcjkQCk=;
        b=MonHmauGSuQjjL6+sfNV0jZZPZAcvvtGPUQjhGp9EWMcFjSZX7F0sjHIeO1h5YJCjz
         iAhYLpQfOc40C8Q7CmQslstx3h8sUhK36AO/6DCXck6h151utoJdVL4hvAoOzVT63pvf
         GbaFsr236zPCaFKrlbCgbEIpJOT+fa6YJblsO5nWaF+drB3QR9pOil+AxWkt+CuXru+8
         c1rjOPgDFemje0JJCRkIEEnlBfcR1Z5obR0s8WGqvKPgFTzVFbJJNz2hllwm2sBa586E
         CSBmWWWg9PkGH7SCtnpQ+XZFe2H9bRYQTUj7IS/SF523FGX7bzVL2cRD40EeHKykmEAL
         mGZg==
X-Gm-Message-State: ABy/qLYMNu3PaQiLHWXUouw0TEGAvKLLKsXshOR0nHkOQtwno1u5eNQL
        66+3Hs2hep4AQG+yJ9LLNwCtAg==
X-Google-Smtp-Source: APBJJlH5jgTV6clHkuAbdLyaxwSZbX0NQWlWbozqxx3ivhQVSBF6LhXWQmS5O3CgizbKk35ErOwtyA==
X-Received: by 2002:a2e:6a04:0:b0:2b7:14d4:ce6d with SMTP id f4-20020a2e6a04000000b002b714d4ce6dmr7721930ljc.48.1689077968298;
        Tue, 11 Jul 2023 05:19:28 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:27 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:46 +0200
Subject: [PATCH 47/53] arm64: dts: qcom: sm8550: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-47-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2n73VwmB8gd6z5jxJWL0kWv1/JV05PWG3zpj6M//Tvs=;
 b=6cAucdktEPv499aSOqbmljlM2KKvs2eSJ07hrXrAq/GVNAj6ilgikTUSIcX93dYozWDDDBb7g
 UwYMsvaySf6AKgM7Tyt09TTWQN7rdv3hVkop9AW3R7L1dPXgX0KPAkN
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6e8aba256931..d54b0ac6d0a3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -3714,6 +3715,7 @@ apps_rsc: rsc@17a00000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

