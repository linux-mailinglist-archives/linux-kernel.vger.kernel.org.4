Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA71672FCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243813AbjFNLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbjFNLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:36:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCFC1FC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:36:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso8304186e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742558; x=1689334558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNN4HzJSmgavBIHI0plvMVbIrL+556xUON6ADbBGUhk=;
        b=Z2PVN5BVnoLd9XTDhEq3Y6g9MOPqC1I+9E1d5PXisVQhlGAtCFoWDhUiGmM8XHL8Hj
         v4IFDWNGFgNvCSk5ei6lhH2n4FTHwVjUJjXLdrqU+8oCz7jY9zS5lHU6wrXh0j9ApbbP
         Nn77vAgHagA2GDb10t832BSbPRzuDMgf27+e9yZm8jPsOqqkH3uDQaLqJ0cGUrpRM+bG
         M6sYJmgNSEbrK/n1lIQN0jGuAdeSMieBUM9NYlXXv5V4eYs9O87a0efl8bUoGUKOivgk
         anB+7ZlQVOtGoS1EwHxvL0x4iIRExxfPs4FDNoxTyfVeTO9K2h2VxStCbn5hYhpTowL7
         DFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742558; x=1689334558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNN4HzJSmgavBIHI0plvMVbIrL+556xUON6ADbBGUhk=;
        b=MXjcnP4tDNNwlGF8QbyzMalCrjY1Ct1NHrG+NNU65aUm+AVKe/6YX4DPVTbU6nKZ4s
         DDThnn2UVuAH90X3VtHJ0ofeTELFZdIUtGm0P66VBZaUvgeDTzAehiyVgM5d5nETi1uG
         LsWtrz1GilvizQS8DfkbdWggSWO2u8ZlN9utwOHK6OCr3hR8NS3kdBDKtP/VxMfQtS6C
         AVGdaDFY7gHEXTwJtTXVq773bVYHa+6HEi9hHL3omqLpePrWNS5mJTB9H0E3D4M4Vo2m
         ekU3tp/X4fEEldjyn3s7aCTZNusrW1zWKgpXUnVjxxvSbVC4Or3sXPiXCYMTs1Nnevmc
         Jcrg==
X-Gm-Message-State: AC+VfDxcfVbfEc+wNn03rYuCNSuaJqoCXLlwUni8fLvpUtpU3FhSY0Kd
        wJTmmWZDXvNDpSjq9WSXsbLb9Q==
X-Google-Smtp-Source: ACHHUZ5qx0kzgAtjvyiwAlwS2+iJyeFlZN04AeEpxLcGWwRzFInsKqFAK4v3IysbOYtsQVykIoAd/w==
X-Received: by 2002:a05:6512:21cd:b0:4ef:f09c:c505 with SMTP id d13-20020a05651221cd00b004eff09cc505mr6447602lft.37.1686742558753;
        Wed, 14 Jun 2023 04:35:58 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:35:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 13:35:37 +0200
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm6350: Fix ZAP region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v2-6-afcdfb18bb13@linaro.org>
References: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=1250;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wA9dheoyA1ln4NvQBVP3cvzvxEDd9mOV0aNi6Nn+GZc=;
 b=jpOGbEnm0du6ha9Dcj9SzfnJzFLTmhh2bU0tQrKoZpzbTa8fxnpwnKcaeYhjNrLL1MxllBZxs
 I+/waT1dv17BdkxDs6nu341aPbP793c+5b2GtbPrSYjqkseyh55ky7G
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

The previous ZAP region definition was wrong. Fix it.
Note this is not a device-specific fixup, but a fixup to the generic
PIL load address.

Fixes: 5f82b9cda61e ("arm64: dts: qcom: Add SM6350 device tree")
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d928e64e33ae..cc72c4b4e7c0 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -634,11 +634,6 @@ pil_ipa_gsi_mem: memory@8b710000 {
 			no-map;
 		};
 
-		pil_gpu_mem: memory@8b715400 {
-			reg = <0 0x8b715400 0 0x2000>;
-			no-map;
-		};
-
 		pil_modem_mem: memory@8b800000 {
 			reg = <0 0x8b800000 0 0xf800000>;
 			no-map;
@@ -659,6 +654,11 @@ removed_region: memory@c0000000 {
 			no-map;
 		};
 
+		pil_gpu_mem: memory@f0d00000 {
+			reg = <0 0xf0d00000 0 0x1000>;
+			no-map;
+		};
+
 		debug_region: memory@ffb00000 {
 			reg = <0 0xffb00000 0 0xc0000>;
 			no-map;

-- 
2.41.0

