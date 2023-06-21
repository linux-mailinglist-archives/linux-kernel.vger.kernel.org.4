Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3647382A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjFULWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjFULWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:22:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9019B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b474dac685so52683931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687346530; x=1689938530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFA5rv0lr1oloQt1B0KnKq65YwKUj3TfUmZ2SAZq8Ag=;
        b=C7pIPZvmKOBlLqiDTJ2zzCYHkCEug43rr60pvbUAFvOvByzBzD9140rW89CPaZzB1s
         eOcjbC8gEI2ZEw36Hv+Hmq7FOo25LBjviY+IoBJ4dW2+wUNujIfMJw8kuV/SHuyIQfCB
         K/4jrFcPeHQ/gJuI+3E1KmaUKpPVJLvbzj8seEJJ242LdNDYYweGdrv5jiRIFbYduDWw
         ArJozkSq+gV0Ssuy3hQpUvPDMoKc8NGYtxRwSl5mKXB43//dVyo9KburBDd2YsTuSY3I
         xQCYUYblLqSQZPWpQiY0DzbgDV3kiGKmiv27AGebaKnLx2stGsgQQl3TkyLukVzv3CbO
         mNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346530; x=1689938530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFA5rv0lr1oloQt1B0KnKq65YwKUj3TfUmZ2SAZq8Ag=;
        b=AtF2692oM3dSsnAy43dEyY0aY5IYYgZTauL5orxB+cbfMwBPdY/we4c1gnVqclPRGp
         uAW05Obr+YDhiT1q7ZBKx75s8HJTAEtzJV9KVz9pZPxAa2fYC9ThLSM8F8XJWa7kfXYb
         yFvWDdFrch+1EgK9y3D3Xa2mB0/g7E4EfWgKRSuz7ggzQeiabjCQLcAWMWD7qog5aOxp
         BgGXqC//A/fdlLIPD7bsr7bIRt2uFI3rbUB3acWrBRh40fH+26x3E6qx/qrcFmGFnOIP
         kVLwX64U10th44+BvgpuAG6y9KEFJtqETaoA7G2CKPu3IcxsDS5sTF+u44tWCrY71Lej
         XhOg==
X-Gm-Message-State: AC+VfDyE1Ara5uZ5n8hpBNkRVNwRxaytIBq+jdFVJdyPWV9B84kSp+bR
        fRN+5RQrkX4Y3IcPY6Ud4eHihQ==
X-Google-Smtp-Source: ACHHUZ5tg63SuGFw6YWRj7+QnGSS/eYbaz2d4Kupt4BLDRO2cMJPBDHD4Og9UpWgfA6tU5aUJB1ZHg==
X-Received: by 2002:a2e:b0c6:0:b0:2b4:7f2e:a42b with SMTP id g6-20020a2eb0c6000000b002b47f2ea42bmr4802342ljl.37.1687346530012;
        Wed, 21 Jun 2023 04:22:10 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l4-20020a05651c10c400b002b22a1a21easm866171ljn.110.2023.06.21.04.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:22:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 13:21:55 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: qrb4210-rb2: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v2-4-0538ea1beb0b@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687346515; l=706;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JBonNiZe3CxDbV4Fmz0+WuWgEzcdGj7FHxWoDNsHw3g=;
 b=woXuVPeV9zuclKwXzqYTyZS/QW1KC/3GrnVM61nn5NoKn5A13fkVnJi5fSpcKT6+sGZ/bHorA
 bTxpSvrrZhsAonQEybyEy42H0VyvlplpFoyhW4EHUJR1u5yiF61oEki
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

Enable the A610 GPU and provide a firmware path to the ZAP blob.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index e23a0406eacc..a7278a9472ed 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -179,6 +179,14 @@ &gpi_dma0 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/qrb4210/a610_zap.mbn";
+	};
+};
+
 &i2c2 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.41.0

