Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5546D4F21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDCRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjDCRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050412D59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c9so28659369lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q78NH+UaU1k2JYnzdD9GjMmztSwW1iJ5zaXHWLUjDuA=;
        b=ybQFVZ0RsGNLrEtcFRLMej0ltBxgh5FGgHmweUnYUxOBWUOojlvutDoIlFDAVUbRh1
         RDNwZyj3xOq+oj5HxK8CtIcvtyDnMJQt2T1e3zCupkPHS7wEp3CPisjDTu7CULXXr1/f
         bnztjuFospqo9Oq3+mrzpwvksskCzg226nunIiWXOSpYboFjuykg7q1TIEz4LlypLav1
         nFeJbGggCIxeGr47AkyDGELIKlO4WZHiDtz18YI7STBtaT4HpeHSr41U/lfh0mFUNlV5
         a2svZGwkz/GS0Tx+T5boBarLAMEMLGNRDKK1Oyh7MDJ2Wd7Z5WF9xMZqDrcIJ4az3046
         uBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q78NH+UaU1k2JYnzdD9GjMmztSwW1iJ5zaXHWLUjDuA=;
        b=sZ4SB/QQhA9ljs/+BLubF0vugCliouiBGy9QDRR5AVc8/LPVH5pkUzhMJ+hjSgWNlI
         NURnUANr7j9m0rJW+4jTie4L00kNayHcvkP8Cxdu5XK5ylJ1dZJ6+JV9MR17ha36Wb5C
         04u82V4rEU9WjG+T4mgBrkl66YStJ4kQYTheqXFzuTqNHqREymsz7ZVj8bS1wZVQCZia
         A5eL9yVIvh6aWHbB0QNbHCVepAiVpL0GsQ3zc6WtnbNngnQMGKIiW6ePSR1i6dB2P+n2
         yw7usewLdHnqzNviAR3TELYzsdTrhZnqOQ3iWzdzjD7aIxBTbM6aNP3WS4on3OFffS9O
         Z6rQ==
X-Gm-Message-State: AAQBX9fmyn3x/d+8+fHDuE0mMKXziglf8bI5eOHZvuEbRda5ZJoa9QlB
        TfDXrw527tXLRdV2WrzhZwDrvw==
X-Google-Smtp-Source: AKy350awaOAi96k3KdX/l/WqXuYwMB+wnrq5qkXGd2v99DEYbM0DRq9Ga93VkrDSYUgASL4UySnIJQ==
X-Received: by 2002:a05:6512:513:b0:4e8:1798:f9e1 with SMTP id o19-20020a056512051300b004e81798f9e1mr10184210lfb.57.1680543397416;
        Mon, 03 Apr 2023 10:36:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Apr 2023 19:36:06 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: qcm2290: Add WCN3990 Wi-Fi node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-topic-rb1_qcm-v1-8-ca849b62ba07@linaro.org>
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=1523;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G8+7P12a2FAQaZ56sk4Rf7dxNO+WX1mJoPvrRVY3txE=;
 b=Xa16zwCkAqGz6fJ6Roo3Zuy4oemeqRIFtsBhZtYLyfOH1c0ts1EIkB3q2ISdLOrsl3jKgbULdiTv
 bxLwMqmcD96+ByQyx85uJs9wirDbW2ddqTnSjWSHORWf4s4DHdw9
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

Add a node for the ATH10K SNoC-managed WCN3990 Wi-Fi.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 825623243787..ae5abc76bcc7 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1159,6 +1159,28 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
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
 		watchdog@f017000 {
 			compatible = "qcom,apss-wdt-qcm2290", "qcom,kpss-wdt";
 			reg = <0x0 0x0f017000 0x0 0x1000>;

-- 
2.40.0

