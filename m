Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9855C6CF368
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjC2Tm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC2TmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:42:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF561AB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id br6so21615948lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680118895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykHu1N0QA0KbQgqKmp4iYs60SgO58M86USHwgilqjAU=;
        b=zXKVvzm7+gptevuGO6qYwmOY4seMNTQV3+uKlb0CTKR+sHqFoWJC9NQmQejRWqZr2N
         dJAutTnIOdi4WsEhAc2v6x8exXeKRNl05ywZmM5eZaeTu2bvlFvODxIDOou6ND1lj52d
         FtzmJlL8t/K3s4Q8WJsDAxA5y6o2OYImK/WNMohQJN9lEPlbmKzmkkrnbhqzjCx/uc7c
         FgFcw1W03hV5OxRsjUkbuk9BhQOQS8VIpR5rtuWynG+gYXG6WK6DLwTcTuPBDhbDBb++
         8Ho6OrP2r424V1NeswL4gxOI8VIwchCWD4MIsw9sOghmkv4afNeB7nuHvj8U9FvmDXPj
         wu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykHu1N0QA0KbQgqKmp4iYs60SgO58M86USHwgilqjAU=;
        b=GLUhJgo1xL8h21r1ritppNnCHmbxwmuwPfIpCnl6Np0R+NqGfumXRwlp3b7P6yRllr
         gGLJps2kCx9ytElFlopJlG7ZRU06o9OHtCsckjiiGrZfhsQkmFNcYfKVZUJc1D8CvXLb
         l7WtcMo9ZV2VUv4haYzcoZTBI8nax35WgBA3vrLZ7gCOalquVDASITACmoqs2Tiu9IaP
         vTqSPimYANQxluKWK5MPtxjnTwOLvenCRywjAY+BxYVTkrmRxM1VCxcIvHmC1XDN7oi2
         6/Lqsqf3Bryepw4RA40MMfLCnHTn9Olz8eUkEzansfvX52JqhyFGpb2Eu63f6fPY6d/2
         LH4g==
X-Gm-Message-State: AAQBX9dr85VioDlLuVvXQGBNhhSyoIThuhAYbfqmPKT3Q0+NsGFoVivn
        oE9Dl9ivujWEeVH89P+O/gwLkBXP1kFUMpGEXqE=
X-Google-Smtp-Source: AKy350Zs+fpCyauDjpA0d7UdnA8149+V0M6WzzJq0t3ODHhQN0hSeTShjXCCqEs0AG5ic9PhtN/LCA==
X-Received: by 2002:a05:6512:38d1:b0:4ea:f632:17 with SMTP id p17-20020a05651238d100b004eaf6320017mr5758257lft.51.1680118895313;
        Wed, 29 Mar 2023 12:41:35 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004eae672e96bsm3955048lfm.255.2023.03.29.12.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:41:22 +0200
Subject: [PATCH v3 5/6] arm64: dts: qcom: sdm845-tama: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v3-5-2b1567c039d7@linaro.org>
References: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680118888; l=887;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EFNtHZmvMdC4ApZTEPrYLo5YnWmwoerL6XLOxqQ6yh0=;
 b=3D5ayg1/ZL1GgMBC/Z/7C1rCO4woFMKdEAbVJMWXJuXLk8mLkFsWK2y6mZtFf4/jyvoNBNOTSZ90
 y6SBeGV6CoPEBXInFa1KJ+s2Ju1BZOIbWycuJID3kh7DJN6QVIJi
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Enable the A630 GPU and its GMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 48916a3216e5..df8dd6e45a38 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -413,6 +413,19 @@ &gcc {
 			<GCC_LPASS_SWAY_CLK>;
 };
 
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/Sony/tama/a630_zap.mbn";
+	};
+};
+
 &i2c5 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.40.0

