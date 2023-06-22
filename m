Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98973A031
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFVL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjFVL5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:57:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775101731
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f954d7309fso692364e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435070; x=1690027070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOFjCTMIWVV57v3lgExuuj9IKwurSwMHmR2BddX7Xl0=;
        b=zdL+qDXUcDjdC0PSF6r7Rsicvd/Fc/8yvM/7vxhrWzOV/ymDBW61CL2naugt+DwzJ0
         +9u44BaEzuvcjcVLZaz2cN4ThVQGSSsPGBD2K06vD6PVBg1RWRTHgTvx/AfZyiXcwe1g
         +gcj0xV5Sqv8tq12mArpSqXTWzrczfyaN42xqdkHeRf4tdFgiQK9Ua/B+OgN13CzoW2N
         /5WXoHtfN+TzJ6tv4ETQKjLJY5+Tup7SCmQs6W7M3dh9vgHY4xw2GiTaMW+mL8D1hubO
         oGe1ttmA8wsKknixyQL9r/ws9y2JtLkrc3PkB8tSa2mSereG/KXiE51YUHT2kFkn0DZh
         qCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435070; x=1690027070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOFjCTMIWVV57v3lgExuuj9IKwurSwMHmR2BddX7Xl0=;
        b=IsPgfIJhn9yWhV+rWUXl7u+epuZTTDmfftrUoDjgV8kQpAvTi7zKg1kVQ2AQSuBS9k
         dPajX67jxmcPguX9AnCSQ4y84+geL+MMCTkojVq9oQWDnYgISv+j4Sl+qN6gM6Ay1izn
         byHjsIukLI5SITB2dOxu3L2vhPCOqd5J25xUc/jABNAVrISKHFckLx/8AgrDxLiZUvQI
         d3NcT+myUKfCsQBfTZCrqCNVgAE0c8Sl8dDD9chUCcKTABKZm7XHxqKtUHLnkKXpX0I8
         kppETHWUaL1sECz1egonYkKAbpmXepYn5DHruVLTWDT4VrNPtTUikmOdAVfl24Ux7xme
         j+1g==
X-Gm-Message-State: AC+VfDzyr3ezJOLHs7Xy5CNaaByPpQFTjXxZsw2U+NT3OfvaeXLRBVul
        SoRHdVociHeVptzeZoaQgCwPAA==
X-Google-Smtp-Source: ACHHUZ47V7HYoR3vRiQZsvQ4bX5v4tgYPUECWWaiyng942itPTwfssDUTlh8Jlm+7FzRebxpjU87Rg==
X-Received: by 2002:a05:6512:454:b0:4f8:565f:8ec7 with SMTP id y20-20020a056512045400b004f8565f8ec7mr6250699lfk.27.1687435069750;
        Thu, 22 Jun 2023 04:57:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 22 Jun 2023 13:57:41 +0200
Subject: [PATCH 1/9] dt-bindings: clk: qcom,gcc-msm8998: Add missing
 GPU/MMSS GPLL0 legs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v1-1-5b7a0d6e98b1@linaro.org>
References: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=894;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=F8sCo+8Xd5XxI+0cPZIVX8PD/zdBEi1oKdosoXzGPrA=;
 b=A04xy8EGlHpSd10ms85yXgvIRB3fkqXy2CskjHYT7oJEcGjyDh3UOhwLi28idwcWGR5jAsHCa
 6mNhZkxGrU+CerQACv/uqDtp1BYXsaK6ozrjnN0/9idcqx71HY2n+iI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL0 has two separate outputs to both GPUSS and MMSS: one that's
2-divided and one that runs at the same rate as the GPLL0 itself.

Add the missing ones to the binding.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-msm8998.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 1badb4f9c58f..b5456a64d421 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -190,6 +190,9 @@
 #define AGGRE2_SNOC_NORTH_AXI					181
 #define SSC_XO							182
 #define SSC_CNOC_AHBS_CLK					183
+#define GCC_MMSS_GPLL0_DIV_CLK					184
+#define GCC_GPU_GPLL0_DIV_CLK					185
+#define GCC_GPU_GPLL0_CLK					186
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1

-- 
2.41.0

