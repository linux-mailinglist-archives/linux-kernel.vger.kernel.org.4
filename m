Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3495648F83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLJPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLJPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:41:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BF1408C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:41:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h10so7983225wrx.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3CkQrIxpcKZmpNzno1f/XqJw/g2MsuKc2yDZ3HQ1+Q=;
        b=W227L6KzcAYmrjGuU4Ve0Ec0FdrlLVq4GdTMmyDQacgEpLQqgpYOZq/3GB7AqNNjZV
         hT9CPQ77bnb+Yoa+jI1ox0OhGjhinY3XR4Eb00gtcXc0ZEIrsiDCQGKsqUDD4iUAHH6P
         rx26ML5w70ZqmAgb6XNPIdmk1RJPnpTVv410WWtJYQG/mU9mdQ+8Ojm08XJPerTY4VHy
         TbunGmTuPae+E67rvJRFLjZCaD4Wr2Rnu9LsKtjPk/FQupuxbz5Y+SS7MhMVmYpE0s7e
         V/w2Kfo75QRHHtOshdsoWzObO1ZEdnKTSs63DkvgMnT0vrLLFGpxl0w0WQLdjqR1zSUl
         Cv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3CkQrIxpcKZmpNzno1f/XqJw/g2MsuKc2yDZ3HQ1+Q=;
        b=XxdO/+LCkOudjiTulyrUVHmh6R5X1fYAYxuIW185OZI8NKbrJSDn8gkPjLX4Mxaa7a
         3LS27YoQk3XagaR93+W03i0/MIYFKUd32O1ZfNeaKV9dc1zY5CssAQS011WL22OyqUkS
         bf57g67mkizP5Pl7w4OG1iZGfUyWaM3UI9koHueYRTZLPRBtuY8rE/kd3hPTx227XZdt
         UuwixMPICMlOnU/URD4kt44IhGx9Pjc3n3m6ZfZ/XlnA5Z63f9IFJg9sNkSlqvJAI+Fm
         zqFnWCX/QhLUKAinENtBpKpvskKQvPxM++J8fEZ9COlSvImfnzfPt+1o5R+aslaJMfDu
         1idw==
X-Gm-Message-State: ANoB5pnY63xQAmJs7XdSmcJsV1cM+W6U/mXoRC0gGRY8IEX/wzn5/2LZ
        C7v8NaYkV6MjUd+0dzHl3fL0lKFXxwYRXlla
X-Google-Smtp-Source: AA0mqf7tgUvEUG2vCMK38KjGFgMT6DDo+K4JgmplI2XtNPVkh9E6U28H7mgimecBcPqhfng4BsXrKQ==
X-Received: by 2002:a05:6512:3050:b0:4b5:1545:222b with SMTP id b16-20020a056512305000b004b51545222bmr3368018lfb.47.1670681404294;
        Sat, 10 Dec 2022 06:10:04 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id bf38-20020a05651225a600b004b5901b8011sm734857lfb.105.2022.12.10.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 06:10:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: msm8996-tone: Enable SDHCI1
Date:   Sat, 10 Dec 2022 15:09:59 +0100
Message-Id: <20221210141000.14344-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent patch that allowed us to reset the SDHCI controller from
Linux, things started working properly. Enable SDHCI1, and by extension
eMMC. Also, remove the now-useless cmdline SDHCI quirks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index dec361b93cce..c9be32b81d36 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -24,11 +24,7 @@ / {
 	qcom,board-id = <8 0>;
 
 	chosen {
-		/*
-		 * Due to an unknown-for-a-few-years regression,
-		 * SDHCI only works on MSM8996 in PIO (lame) mode.
-		 */
-		bootargs = "sdhci.debug_quirks=0x40 sdhci.debug_quirks2=0x4 maxcpus=2";
+		bootargs = "maxcpus=2";
 	};
 
 	reserved-memory {
@@ -825,8 +821,7 @@ pm8994_l32: l32 {
 };
 
 &sdhc1 {
-	/* eMMC doesn't seem to cooperate even in PIO mode.. */
-	status = "disabled";
+	status = "okay";
 
 	vmmc-supply = <&pm8994_l20>;
 	vqmmc-supply = <&pm8994_s4>;
-- 
2.38.1

