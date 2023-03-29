Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA66CF369
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjC2TnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjC2Tm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:42:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDE6E9D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y20so21688828lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680118896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoOd+U1Vnod8w61xeHS5daG+82mqAqim0JIX10yOYbE=;
        b=qrxTbeXaNejCw05f80MhPPTqgP9xg3w/ngbanNIGEExxljc9G81Ss24aMelZSyRiK7
         En0pi02ofPIsOJA6Nj7oykClDfXg5VvWyh3znXbTEwPNivuHlF5CCkJ689ByQefg1By6
         BhmkHNxqVqs90UaZ68RrTmeQW8VdjqBgkn1XOVkpqSpP4sxRt+j4IxfssT3KDj/Shzmn
         m8bBT1zGhXVFFHAtvQbZdRcnoqV45FVHjfW5dK+7YeWCVzMnRA7n3PPZ1ZOi5yS4uycn
         fzSZr+h1oCXFSvOi/MmFXXQManP9QtqnK1jMOnVORruXjtsLKtuBo2KmmpE9KwGFzkUq
         v2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoOd+U1Vnod8w61xeHS5daG+82mqAqim0JIX10yOYbE=;
        b=qZiYXUWB220SlpHoaV0PRrEtzdhmzPfzUAmi2AFRWMPkzDA9/+/Yz8V2WYJqVYoof4
         DKWiAiqQEvyJ80GAwLI/4JAtx1xsfwLQHeFwkl7Dv0DeysfnYsRypgwndLLVZEtDG6kV
         UsxXarZJoZp+S0idAz1Ub2etQYjkiQAvU146I62UIyuQgZrBvfgI6NEBsUIj38zmLjQB
         CumXbQQzleg4bxnece/H2GQKd/UhUn4ZVUJV6GZvumddd4qqacI61aDK/cbjHEUpPWDi
         bQu7GSq85c6utdAxrBvqsVM+lZe+4xrpep7r42KQ+Lskx/aodW5oiwWl4eiCJx/sO75t
         fKIg==
X-Gm-Message-State: AAQBX9cifBjvtBgkgsENMiAUV8WaiagI6tiF8h1wJSTQio6hB9h0H8Hq
        A9yDpoAi64Ej6NOwd0vb8hGZSw==
X-Google-Smtp-Source: AKy350ZOIqhChJeHbre7LCxZ4XhUlzWlnGO7rGw684OFWj0jIvaiWTtt6lY+YO+Ju5W8rrEetvRt1w==
X-Received: by 2002:ac2:4884:0:b0:4ea:e628:356f with SMTP id x4-20020ac24884000000b004eae628356fmr6313819lfc.48.1680118896446;
        Wed, 29 Mar 2023 12:41:36 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004eae672e96bsm3955048lfm.255.2023.03.29.12.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:41:23 +0200
Subject: [PATCH v3 6/6] arm64: dts: qcom: sdm845-tama: Enable GPI_DMA0/1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v3-6-2b1567c039d7@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680118888; l=728;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=58eaqsVsaQNX+LDPe2xQAD3dX825ROO6GCnfX9zNSQw=;
 b=ZnyuLFOGLb23C+WDrAPS7HPoY+m2HlNaJlhdQgZNPAxji2Psk3F8DUJNHOb47oAqJ74yCVGjI+oc
 ROrTbHQCBML0EFG5Fs7fMtXX5FYmPET2iD47WcK217wqsckoyaNd
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

Enable both GPI DMAs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index df8dd6e45a38..420ffede3e80 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -417,6 +417,14 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 

-- 
2.40.0

