Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2673EB79
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFZUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFZUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:00:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015041722
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso1432604e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687809642; x=1690401642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZhC2Qk4+yJVkkmC8iX7qYnuk5bnEQ8L34QUHmXs8vw=;
        b=U2aWaZtOHvhc/tKfTB+0SlQRqDY5QHhWsCbw2kMbONbX0OX8Gvpy7vNrcukYX3evN9
         /N09KCeZaXV/iSnpawCT6lv6Mv45BnlEx2dkHVUjt0c6FxfLQlB9ysli1awgPAwOMRfZ
         ttBzGhpIOW9XOoZGu4zq0MDqNSO81EC4GkTz2FmOG8hvgZE1dEEFTSolPFiHwKZPVJ1V
         e7sZeKMrkWUlPTAneMAUTCq5E35LW1SKeYqz1UHdaa9lmskLDeLkhjLVNniIc+70phXx
         hkcqZMPL7NibAdnP9m11jHH+cnCUAbt/tUYg7AvcWa5EllOs9ILwxpmrR0+3YOwJGH8G
         lmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687809642; x=1690401642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZhC2Qk4+yJVkkmC8iX7qYnuk5bnEQ8L34QUHmXs8vw=;
        b=EqFB6+fNx9wQiQii8+tL3bAujsVQ7PDnxc/5yReD3AuSkmcYjUaM5w3Sii0e4IoJl6
         dy2PB2xiadumWs6SDRkpKFNWKhaeBNj7y2TlyHRcm2V3CD54jmwvf1XBHV3YhyNJzp2W
         mj1UkVK3hQSVGLm6SJw8ErjWY0Fh1Z+MlIN5SzqVikeCjXEe7Lv7ECJMvE2IBFZdPuyw
         uu810ryWSe6HF+h28sp2PP6cxYjjmFx7BH9M5u5xUpp82Uukt86VlA532ex7+bQwgO2K
         g/iosy30B5WGLg6wQkO/3BrP8nPznXAEIhoYO8NF0unhX/aIHkk2WdDF3u1uAWe1GAf4
         bZdg==
X-Gm-Message-State: AC+VfDx+jjgppAetVVpixQupwv1McJOG/BehGwkbgemOsk6NXlEYAuGI
        5bWsV/F6vadEsINEIRvLkFe/fA==
X-Google-Smtp-Source: ACHHUZ6b2hQMNtTLi1F+9X3vOIZprHgCOQOLawP7qUc5CtwhNvkTYGBI63YfknDA9064/FJoU2QL+g==
X-Received: by 2002:a19:ab11:0:b0:4f8:75ac:c4e8 with SMTP id u17-20020a19ab11000000b004f875acc4e8mr6484561lfe.43.1687809642027;
        Mon, 26 Jun 2023 13:00:42 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b004fb74cb9670sm628082lfi.125.2023.06.26.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:00:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 22:00:24 +0200
Subject: [PATCH 2/7] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Fix
 8996 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230626-topic-bindingsfixups-v1-2-254ae8642e69@linaro.org>
References: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
In-Reply-To: <20230626-topic-bindingsfixups-v1-0-254ae8642e69@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687809636; l=1513;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nOsZ7J30rWic3dHnzSrrbrvLqXr5jRF6S1BliJFP7HM=;
 b=xXNJCYMVsUEMs8T/YRxPTYogaCoAaGuG3UV4Oy/qRyyaaZBJ9v4crXyNyHdsJERbS2rDBIjMb
 UUAjZ7jB5QjC0M6yU/NbsUPgqyRiUcMXXmEdYthuNgQHllHIKmAy4Lo
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

Change RPMH to RPM (as RPMh was introduced 2 generations later) and drop
the prng reference, which made ARRAY_SIZE(clocks) !=
ARRAY_SIZE(clock-names).

Fixes: bdea142295ff ("dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml       | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index c1ac6ca1e759..4e2358fea49e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -215,13 +215,12 @@ allOf:
             - description: GCC MSS IFACE clock
             - description: GCC MSS BUS clock
             - description: GCC MSS MEM clock
-            - description: RPMH XO clock
+            - description: RPM XO clock
             - description: GCC MSS GPLL0 clock
             - description: GCC MSS SNOC_AXI clock
             - description: GCC MSS MNOC_AXI clock
-            - description: RPMH PNOC clock
-            - description: GCC MSS PRNG clock
-            - description: RPMH QDSS clock
+            - description: RPM PNOC clock
+            - description: RPM QDSS clock
         clock-names:
           items:
             - const: iface

-- 
2.41.0

