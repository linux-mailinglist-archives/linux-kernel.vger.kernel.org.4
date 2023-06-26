Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFE73E6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjFZRsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFZRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:48:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E94130
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:48:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b44eddb52dso54690291fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687801694; x=1690393694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ey3TT56D7TOnshO37QOzn3UmtILaaCUtqSKom6l4lsA=;
        b=J3WpbqT3MEHTakXCntiUvKft7PywhEPtdQ3oK7QbwO8UYEbrqWopwpi7bObbDRdOSt
         YrPyflm1HMfvuEc2fj8WC0F7FlqYJFfrLWx0lBTOSrvschmR6u1Y0nC4qhnY9GIFzCeB
         m2VKUdUiEecOtMOc8Ad5HjAsLAUPmvm8ItyE4/Yd3QW9wuiU+/snA3ijSTPVCOrIFHIo
         oA8FOuCLi7vNNG/Iid9AOKic+C8mYDHs78GnanPqdUqPr8eJoID3t3Y3rJYUR5uLxrYF
         D7LmlbDz1xIaAt2MYlqH3qU6hLQawbmNkn0+bj0k9vfGOUDibhsbGG1xAKpN7GtqrFeV
         IyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687801694; x=1690393694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ey3TT56D7TOnshO37QOzn3UmtILaaCUtqSKom6l4lsA=;
        b=U+jidcszgJeie6B4kwlKDpu3vSj7j9GOOuQeuMj8JahW2RQOAQ8QXfDrB73rJkOmbz
         IZjhsJTnth5QrYwClRAanUOtIilQa11BDVP8xnPgvt8+AjFrcyHHaDdhFL6Y2y+fn8UL
         Ak4tcnT0jBSSP4oYdcXIbUm2/uMh1fQOBDbXGeSKiQXLcMCzyeahX5G9CzBSNNSMNtVQ
         7blbluz5vMIck0vZpPGTiFx8sPYMTvRgUF4Z+bjSPzld7bxjf77g9yNxCwrA8lwrOVbn
         DGMJstv8nuHfSJmP4Gr8maUW5Cagn04XEIyBI1abcMe7UGaRAPyLTL4dTqXGM5Uu6GWa
         xQWA==
X-Gm-Message-State: AC+VfDwoEQo4+/p6mTipXLHTrrANlAm/LDLnBfwTOZWWFqMaWo5q/pD6
        JQv1OcCmbnMI64/9fGAwLZOs3Q==
X-Google-Smtp-Source: ACHHUZ4bMLzp4bRrhmxTVvdWyMw7HhO2pCXzIjTkIsBKAE8BlrnT3bYRdlnWGPR6t39ep8mR0WAb5w==
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79bd with SMTP id r3-20020a2e9943000000b002b6990979bdmr3030141ljj.24.1687801694764;
        Mon, 26 Jun 2023 10:48:14 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id h19-20020a2eb0f3000000b002b470afec39sm1337076ljl.48.2023.06.26.10.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:48:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 19:48:07 +0200
Subject: [PATCH v2 2/3] dt-bindings: clock: qcom,gcc-sc8280xp: Add missing
 GDSCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sc8280_gccgdsc-v2-2-562c1428c10d@linaro.org>
References: <20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org>
In-Reply-To: <20230620-topic-sc8280_gccgdsc-v2-0-562c1428c10d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687801690; l=1262;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vvmSSYXwEUfFE3PIiMEYxzSbvpVMApP//l/3QIj4wbc=;
 b=4DN2KtHgln3hQJ0K1JgGA5RIYmkHUKVab/GsMopeQ9XynPGFWrx1gF9Ic85IN6FJCejTCfOzt
 yiT/vjDyafaB/4qbVJ6IR/F8K3oNRw/Bjv/Vqpqn+mzsZJVk6IShMEg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 10 more GDSCs that we've not been caring about, and by extension
(and perhaps even more importantly), not putting to sleep. Add them.

Fixes: a66a82f2a55e ("dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
index 721105ea4fad..845491591784 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8280xp.h
@@ -494,5 +494,15 @@
 #define USB30_SEC_GDSC					11
 #define EMAC_0_GDSC					12
 #define EMAC_1_GDSC					13
+#define USB4_1_GDSC					14
+#define USB4_GDSC					15
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC		16
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC		17
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC		18
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF1_GDSC		19
+#define HLOS1_VOTE_TURING_MMU_TBU0_GDSC			20
+#define HLOS1_VOTE_TURING_MMU_TBU1_GDSC			21
+#define HLOS1_VOTE_TURING_MMU_TBU2_GDSC			22
+#define HLOS1_VOTE_TURING_MMU_TBU3_GDSC			23
 
 #endif

-- 
2.41.0

