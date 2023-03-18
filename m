Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB606BFA7A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCRNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCRNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:43:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C832E55
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:43:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id h9so7815084ljq.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679146987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSwnb94Mzw2MbHXtm3N1Had+b6g5bP1qhG7RvTv6VYM=;
        b=mp00CxlpC+bkTh9hYBnVlOXwYPkqGR9yuB8P+OvNJKo3xvEtWKUwHs4IbXFw2sX6la
         ToDNU237KBDMj6KmaIqeO9aslzfGjZ3LTNbygp4AfmbnKSJYP/59Li1NnlMKaVDCoN6o
         yuMqdUS24LTw5dsubgBUbhxgsjGZrBVBOnl+4JrLZevj8jTlfGpLWf68jaxhK9ZFWUpV
         45M2iXZ+O7ra0hU/QFhKImpMFaivn7c/Hvn2oIBOTv0aSIszNwPWp4smKIJyL2v4XgEb
         eSWP3IULXLWZR9w2Rn9g/1ZhGCgkVuwZZMGGvzkrxGKGHiGtho0t6wiTdjt9lJ0zoJM1
         QHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSwnb94Mzw2MbHXtm3N1Had+b6g5bP1qhG7RvTv6VYM=;
        b=hAPPtPcGZMwyW14EeMEngjFDGH17OoHnqaoDBzVwD5zVLnE+dP47a8guRZREw/pRXn
         bXWlmzGe4ypeRFRsPDL9W21omf7sKLfIB+pC1JyzAkXTTXcVxNYEp+eLJMlgLYrt4LIW
         dHnruCnmBi6tiUZfOYyAWEgJygoXeCOijkHGNezK3dMMcN6sETt4bLS5gMHndLhGm1Fk
         NlfA0QxeT8lTq2pTMiY52zmb9ofssu9Bxl1t7ZLIiCoVofZ0Gl2yEgFz18dsLR161nTa
         dov77Nu+pIMkjc2xH2tQosXMszxmsu78whgOJNa+ghCs1ez6jhXMIVaf+pE9DTnaxify
         gyGg==
X-Gm-Message-State: AO0yUKXR9zJWBSh1uu0bCIaBynhP/DZ7nlC4ZWhsfyi0/6lPeKcL2ruI
        YnHwDHXg6rLLip5y4k/EChd+5A==
X-Google-Smtp-Source: AK7set/4S1W5CR/JHQZnR+6Nm46fF8jPG9ALj+09ucPpRDC2nMHbjBg9W9/P6bHYNoTP678GQbmbyQ==
X-Received: by 2002:a05:651c:1a0a:b0:298:aada:99a4 with SMTP id by10-20020a05651c1a0a00b00298aada99a4mr5427625ljb.15.1679146987411;
        Sat, 18 Mar 2023 06:43:07 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id c2-20020a2e9d82000000b0029a0b50a34asm888367ljj.36.2023.03.18.06.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:43:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 18 Mar 2023 14:42:55 +0100
Subject: [PATCH v6 9/9] arm64: dts: qcom: sm6115: Use the correct DSI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v6-9-70e13b1214fa@linaro.org>
References: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v6-0-70e13b1214fa@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679146971; l=835;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TG72yG+FHoBCa8HzTOP2m4Zz/u5EM4iUM34Xg+mUMPo=;
 b=bzqbSxqJTBt3yGqTr/I3zYIXTWAXpQidX0CBQfgCGzZ+rFCB5HSPDbOq402ijR1rZFTBnYyMjPUz
 RjARwgnNAENPj7dkUeSVXV4dYPX1hCJeWkZ7aO/8yBaQyyXt59GZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the non-deprecated, SoC-specific DSI compatible.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index c56738633431..fcf7497e8a15 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1227,7 +1227,7 @@ opp-384000000 {
 			};
 
 			mdss_dsi0: dsi@5e94000 {
-				compatible = "qcom,dsi-ctrl-6g-qcm2290";
+				compatible = "qcom,sm6115-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x0 0x05e94000 0x0 0x400>;
 				reg-names = "dsi_ctrl";
 

-- 
2.39.2

