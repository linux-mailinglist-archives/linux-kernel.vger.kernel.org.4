Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDA6E60DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjDRMMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDRMLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:11:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629DF4EC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ec817060cdso2169778e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681819859; x=1684411859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fftkJp3Coct54pcoJxqOJznZa4eb2ZsBLmF7Bh2NPzw=;
        b=yT/BiOHJ+Wb2Fowb5VKhN9CkH2wqsNJE9NMZRSDGk4DXvenGL6eOdB8DlC/etQesDw
         dtOy68VZtrLhULwcn9/Mi9WT7Y8P3NAvFpLgTBxc+8AIDLGEScilP24Dh3AA/nx4wMOD
         j3Z9Q7BlS2bnKN139hMOkzsDLGoMk0fPulZVUEm5TosYsVVqzQMizwSXVbX72TBmvagL
         looqHnRRbrN27J2r3pebd4DSAIVDVFu/Et035MPmkDkjTuMHAluOrpHYbTTgAUgD0AYe
         dP3Kq03ixRHzCPq7IzoNQ3erAJ/HIQVJ4AfwP3pg49snXLAoXuIq8GSkth6QU20GOrmB
         YCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819859; x=1684411859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fftkJp3Coct54pcoJxqOJznZa4eb2ZsBLmF7Bh2NPzw=;
        b=SYRSqmmp/AtcwSugP90SDPd6oQR1rbN6n/tNimJJJUB4O4hsb8KzMYoQSLb+zl5X3d
         OWhz+SeocOzndNXl7SVW+pUyYPMVtg/gXFPpr/Vj8jJh/WRgDqdJsfKQEJ5dc7uHaQ4M
         filqNva7TsviCU1TWCSZuUcw/oQ0AYBi9VQVXjXxRiNw7bF5PCqvbPzVWgKjSnF+6sch
         GYVtUwztM3Ua5sv6x3dvOGNTqkdSn8lMG7RKOjq7fWu8xrKXDjj0hR8d8rlTtgWXPbHv
         TlozP9t/byZNJyMn8+j5hl9WlC14zcReZ9oKcc7nko3FNZEtDlkOHT/EOHJ5wGEMSg0S
         DnSQ==
X-Gm-Message-State: AAQBX9cFjM5ZyG57wRwVy3dG02bBd3AlOmzH7M4cF014/a+28tymLFfS
        EBeJSc16vyBfqgDACoZksAVf+A==
X-Google-Smtp-Source: AKy350ZPb2pcudeOWD4NUzexqOVtDM0ulgBKkxy07npJmGB5XjCQyP1ClBYjw6LCleNLEPUOy8LFOw==
X-Received: by 2002:a19:f70b:0:b0:4ed:cb37:7d95 with SMTP id z11-20020a19f70b000000b004edcb377d95mr897901lfe.44.1681819859602;
        Tue, 18 Apr 2023 05:10:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004d86808fd33sm2365895lfc.15.2023.04.18.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:10:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Apr 2023 14:10:56 +0200
Subject: [PATCH v2 1/5] dt-bindings: display/msm: Add reg bus interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v2-1-91a66d04898e@linaro.org>
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681819856; l=1310;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9eGzIhdzE/kh12Ssb8zLi8BB+5t4kj0lnuayorvjl54=;
 b=6fysWEnV+Y3QmSTMiVPNmoQ9u0QIAaEjvJEkX1mj0vdB2azvjMKBFTXFeb43KILmDBjB8FFs4iVp
 BB/S89PrA4Ytu9jBc2Dfi9OeeG/7wbARaGTUTtuRCJrQlU8X+ytt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
another path that needs to be handled to ensure MDSS functions properly,
namely the "reg bus", a.k.a the CPU-MDSS interconnect.

Gating that path may have a variety of effects.. from none to otherwise
inexplicable DSI timeouts..

Describe it in bindings to allow for use in device trees.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/mdss-common.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index ccd7d6417523..30a8aed4289a 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -66,12 +66,14 @@ properties:
     items:
       - description: Interconnect path from mdp0 (or a single mdp) port to the data bus
       - description: Interconnect path from mdp1 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
     minItems: 1
     items:
       - const: mdp0-mem
       - const: mdp1-mem
+      - const: cpu-cfg
 
   resets:
     items:

-- 
2.40.0

