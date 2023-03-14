Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479816B939C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCNMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjCNMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:19:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077DBA101D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so19695892lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678796066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeylFVo7UbFotxXKN5Jk9AW63WMsXe+ARjqLamdFW7w=;
        b=nlnvdtT0jYFDekSBiKe7kjUgKmeWkEU7n0KtJb+UJLMZg1jzoGWP3xgtTelAmnACbh
         AA/ExRjWQucoaj8aSZF2s0Csf1EoU2R1WE/e958Uj2/o+Mz4eEucxi8rxcCUljmRLhoZ
         F1HDrxg7hUqEUYLPhNivl5i1idRb+Qlxeh3HIahd8uQKoKq/Toz+sWV6UuEJxZg3E1nc
         N9aaFO48cremURTz8R2Fm7ffMf//BthoMS2ObeHCSOy3O8dakc4RXC5mBOP/bkBldHrB
         crA1RnK7faaSzYwIjcOOcEco4q8JmHmX6ajsWPtbuvh5ku9HjIr3+bkM0nE4MeuLFBEJ
         DT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678796066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeylFVo7UbFotxXKN5Jk9AW63WMsXe+ARjqLamdFW7w=;
        b=mq8XfcHS26wHD0F87vfi5pcsoRs2kiorqYhOv9e7AZZW300/S9WPaPT83ts6JyHfHg
         rzWMzn3hYsr2O5KrNzGTZsk24peXlD12ZSPDzFBFzjTuXPU/oG1I4+OIk3ui6hjtcMHI
         p+u7RPMiIR4wuSDMxWdx2Jv20upE/7zzVgMQ2OKpmgh1h93QbbnFpYLD63PlrPso/zBQ
         htS5gGJGQ5xvxzmiokIzTYC0pyQ1lI28qy7+jveM5hGADzHZ2p4zIwkQugM7MqTvbE7a
         ggdxvgp2xn7R5uVS8A3g61ogaBAQg/ziek+w7B2kBbJ4QNl8aZFuZrLCOb4EEzSnAfte
         0efw==
X-Gm-Message-State: AO0yUKVHho3LD+u/fHFoGT4kzyRRlsSLPflE6ydS++lQ2D3u7tnfqjsI
        gSJG0yEK8zOovZrSHVXwmh871Q==
X-Google-Smtp-Source: AK7set83jGmoRhPfkqMbcEJHHm7krfEcVsYNn3fRI8hjQUMi1nyZZcK+S70SwgroH8ClftZB5Jk5Hg==
X-Received: by 2002:ac2:446d:0:b0:4e4:b9b4:bf25 with SMTP id y13-20020ac2446d000000b004e4b9b4bf25mr748332lfl.68.1678796066123;
        Tue, 14 Mar 2023 05:14:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s4-20020a19ad44000000b004dda87ecae3sm379058lfd.246.2023.03.14.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:14:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:13:48 +0100
Subject: [PATCH v4 10/10] arm64: dts: qcom: sm6115: Use the correct DSI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v4-10-54b4898189cb@linaro.org>
References: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678796043; l=835;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fTDJ/Pk/K83TEsz8nt+gatYoQ7InKrC5bjtKXy4Z9Sw=;
 b=HhZ4vHeSq1k1zTiLWtKr3SD+hh+THRKo/3SDYCP8seyGUW6Irn5LUOqcX+223SewxioRXEQR3Uzk
 jQn7R0qWCdG+pjWnvGDWgOMp24G1gVyrZyKTgLB39uI8m2Ev/nR7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
index fbd67d2c8d78..18c7eedff300 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1219,7 +1219,7 @@ opp-384000000 {
 			};
 
 			mdss_dsi0: dsi@5e94000 {
-				compatible = "qcom,dsi-ctrl-6g-qcm2290";
+				compatible = "qcom,sm6115-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x0 0x05e94000 0x0 0x400>;
 				reg-names = "dsi_ctrl";
 

-- 
2.39.2

