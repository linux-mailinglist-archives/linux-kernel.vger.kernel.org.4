Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719D472FC93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjFNLgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbjFNLf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:35:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F91BF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f122ff663eso8379081e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686742553; x=1689334553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbHzuVw9djUb2dacqpTuChV+YchmANRy5455/F4AJp0=;
        b=hEudXtbM1Xo4XzWv1z7MyF9xYSMji7u4xEYfRPu5GR0wTH9rs51Q9yuKQq35iwFxcj
         73la0nxq5ikY9Y3UvLzihT386Lc6JUJnCndhTddBtiTZ8e5DP29IK8TadpedbH1tN4Ej
         PtKxxbZiSTxH2+nKJLiByE1VyHrySrnAR8W0IgY9TTtkCQgHMwTYQhYAVPzVShVOx3Oi
         8GkX6sE9mktM2Nv8zPs0zTNj/7oz3HUv6oJDofHjB9E8owHPTJQr09n7juaBxDX6PrF4
         41V3c3zIp9cSp/ku/uYeV2Onu97dJ0rrCnJCTqmvFljBrdTQ8EgHh4tfAtgijSlKdwVy
         37bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742553; x=1689334553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbHzuVw9djUb2dacqpTuChV+YchmANRy5455/F4AJp0=;
        b=TD5IHBYUiGxjp/UCrzMqrd/o1SUkrDpkp4sJd1UNxNetzOhCJvSBUjVDsrNDORKQ4b
         GOem4PaKYXgfL+z8Uq2cL2guliV9JoffTpOSyVB26h3OcqKIYc8/STe4cOCQ4y9NzcgH
         hEzkugFqXuPoBV5r1jgh79jp/s6hYy1/z/af9HTO1ti5C/19z8tA3uweSEdT09FIFx+j
         GHOZKynXtPCI1UhxeExTHiGyBJeOpC+w7ejxoRMIPa0YrMg6IM3oApIn742NQiY7m1Sf
         wVcDPrVR83imjOt9dkyrunAJAg9UmVw0XH0BJOYiBmH8cB+d8yuB73o7Gf1TqJdK0yAc
         57LA==
X-Gm-Message-State: AC+VfDxurPv42hxmEdZ7dxIbAwJkbwfvwWv21VKyS2NnFwiOCAi3q8vC
        wO3Lb/mON3JHC1fNTH8W6oq8yA==
X-Google-Smtp-Source: ACHHUZ4+vaLtAihNVuosK3H1gbrAOEACwkJ9nMi9/2tAJspUX+ZYen/zFcnjt7IZgjHS+iQNSeaCEw==
X-Received: by 2002:a19:ab01:0:b0:4f1:3bd7:e53a with SMTP id u1-20020a19ab01000000b004f13bd7e53amr7569927lfe.49.1686742553068;
        Wed, 14 Jun 2023 04:35:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id x1-20020ac25dc1000000b004f64b8eee61sm2088406lfq.97.2023.06.14.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:35:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 13:35:34 +0200
Subject: [PATCH v2 3/7] arm64: dts: qcom: sm6350: Add GPUCC node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v2-3-afcdfb18bb13@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686742545; l=1415;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gsjvRRutg0p4O5/y2LMtWAUeMOWVStHD9z6YTRu1r8w=;
 b=ci/KzkaFWmBtpokctHZ0kQ1lRBx7DZqVYmrgzDc9/fI22dpniJyL96eFOt8B1wrTgBrY6DuQ4
 TshDj9C0V5nDHLSxV12rpBEq6e+82I1p5hR0QeK08Hr8LJZx6qX4F1n
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add and configure a node for the GPU clock controller.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 30e77010aed5..fd35810bcfb5 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
+#include <dt-bindings/clock/qcom,gpucc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sm6350-camcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -1308,6 +1309,20 @@ compute-cb@5 {
 			};
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sm6350-gpucc";
+			reg = <0 0x03d90000 0 0x9000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk_src",
+				      "gcc_gpu_gpll0_div_clk_src";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm6350-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;

-- 
2.41.0

