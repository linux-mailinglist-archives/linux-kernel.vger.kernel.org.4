Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEAD6BCDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCPLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCPLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:17:16 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76D0C488E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z5so1251242ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678965430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CX609/y3ZMkfT05ayA/5Q69Y3P8LNbyWbrmOTe8ZxUo=;
        b=Ryk34bDdyJYhygLhjFEr+Dj9d7j8cWlUtGgk9RYVCTv6DLWeqSIW/3bdpDLHBLzBa1
         W+/A8HoltYTfudBarinSztwoaPleEb5LT3F5hTbyCRYaxI1OuvGEoJojrGQuQGslVyNg
         wF/dXwI4dfIRHvrNjLWTQ+JaYdvosMFGukbkVZhy3ZahIEt98S0baysRam0OPQeywNzj
         8QRC1Cm9UqBFj2GmrsLiRMXpPKoib08aufDGW0gTvabeONAaXZ/AeDZq1/hTvCyO5RwF
         yTnFBR1x+tIhpvqOXSndUguaFgqc13q2D4ynqMhFCF10hJscqhNSrMWsdXcAmYqLMsHN
         b6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678965430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX609/y3ZMkfT05ayA/5Q69Y3P8LNbyWbrmOTe8ZxUo=;
        b=v+Fad2ygWJpxupoMJVlajDenZCVmyeTpOhpY4sb89ku5jak7/eP2mROfoEpHJSRD+A
         Q2E30EY3aVwp909gXoYd/Jkyk09w9rGnfOs8g+aLIVLpHUkJfFt3Z1tU/Ay6GVIa0LP9
         CtaoJiUZ5EiKlIl3dePVzZhE61cFErHSaO1WsIxlUTiUoZeFcMz/ClvIK/00/xUgqIw6
         hEsJmAkQJQ3WYgwdBD0CwVcxWR9EjnXJp6c5jur0H5CIhglThRHXK0IT70ea7X4Byimr
         6MqW5HDG36yEahZ7PxjBK0QhcgdBU/0vB3BFx9ggjTHwbWqmCDy10XbiGcnlE4DXIsb+
         ro8A==
X-Gm-Message-State: AO0yUKW/VM+INDWj9s6Wz4gmkOegIVH/UhC+uGGLMphZl1XqW+NfozHO
        ONi6NQQ5RiNeS97T+/rijqHOUA==
X-Google-Smtp-Source: AK7set+74ng3jBsGZayyXIkiWPEaGWY7zE+MTbP6o0ASvTK0ca+iZdBMiTEaAe5PYIVdSIva7eFvyQ==
X-Received: by 2002:a2e:2284:0:b0:298:aaf4:238e with SMTP id i126-20020a2e2284000000b00298aaf4238emr1870219lji.37.1678965430567;
        Thu, 16 Mar 2023 04:17:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b004db2978e330sm1194222lfl.258.2023.03.16.04.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:17:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 12:16:57 +0100
Subject: [PATCH 2/5] arm64: dts: qcom: sm6350: Add GPUCC node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v1-2-a74cbec4ecfc@linaro.org>
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678965426; l=1355;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T20D47wMamblhuymG4piRjU7EdKqlSdzz5tYbFiNa2w=;
 b=qHCpq8IzdrchOe9Nka2ARSw2XI8dsUnV0vG4qZ9B79vhLm1Y2OdA9GLcppgj/Ea2IjD8mSL68RjO
 NGIm8Kc7DgxE3QNAfwdeVvpcUpRPCVwsth7JCOHBK1UYKKIjtmry
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

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add and configure a node for the GPU clock controller.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c46bb6dab6a1..523c7edfa4b3 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
+#include <dt-bindings/clock/qcom,gpucc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sm6350-camcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -1125,6 +1126,20 @@ compute-cb@5 {
 			};
 		};
 
+		gpucc: clock-controller@3d90000 {
+			compatible = "qcom,sm6350-gpucc";
+			reg = <0 0x03d90000 0 0x9000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_GPU_GPLL0_CLK>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK>;
+			clock-names = "bi_tcxo",
+				      "gcc_gpu_gpll0_clk",
+				      "gcc_gpu_gpll0_div_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm6350-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;

-- 
2.39.2

