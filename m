Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A280A6E4D48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjDQPb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjDQPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:31:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D2B758
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:30:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ec8143400aso1573836e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681745425; x=1684337425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I90y/7rpQhg6YUQFfZTZY2uS59Y2M6cbexfqSajHymg=;
        b=cBdpYIQkmpBvQcA19uIxq8DIzIxn/YHqxAMe1ne3kE4qr5osry4Gxa8uc/YU7f4e8H
         S3g+89G0OXAuHXlLKUiP1L8xZzouy8FdyNpZUmNgtPB8nIgLaVJCLC+KIFh+EmgUBt1N
         sgtKTVvjuTfE0WBHT13nOf7oS9lpsjQGwK5j5ELzlowcRw97jlAndrI8NM9NIrtGnpGn
         RKzilb9+cIshO0gMSlceyHLK86vpxKa53i9rpRll0DxL2IKO9ZvD3O203PX64qfMLYE+
         lfzaFStRSfG+fcSL8415DWD5SYr9shlSGKeBw1TRFUWenH2QmiaTp6o8EUmiiZh+W0WY
         x7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745425; x=1684337425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I90y/7rpQhg6YUQFfZTZY2uS59Y2M6cbexfqSajHymg=;
        b=cKtICiHdahmDOFIXT8MUiQPfLUhHRLG5sGVXM316QV5Dt4yGVHiF5sD6Q1I9HodyRH
         2nzdS4cOnVz5VmYe2bP1pT4DgrCAAJE1udVYWbjwLbr2eK6K1gwy4qU08Z5Si0XsnDGJ
         cgazF+jVgNXtSUSLJz4VP+1F3KFe8fehcB9ABDntarVtSYjNBAKptUg2KgF1bpSPV/xo
         tWfanNo8VFkM7hcYnZ1SbgzBsgrRL6DbXF5qkve3a6pGlKgg7dWzR47rXYg9jrBy+LEo
         ohE4r4MRhbSCNi+8zwjjylvDmjsoDDgbqmL31A7KMbaOUeAuKPXQ+Vym4sPzbtSngXRl
         PJWw==
X-Gm-Message-State: AAQBX9cZCreHlBfipKIqfgosu7j5EAIxpOGO31xdB8NycACIdnd8AkeP
        T40MdTZP5dyS0WU3dE0bTPe+d7J3nkaYAiem9BE=
X-Google-Smtp-Source: AKy350YrBMiWQVD3rFcIp7nOl3eyAywpZ94NVeCMQMqSAtmVv0NwGkthpYow6QZrcREILnpPqcp/7Q==
X-Received: by 2002:a19:5518:0:b0:4ec:8362:1880 with SMTP id n24-20020a195518000000b004ec83621880mr2506141lfe.48.1681745425060;
        Mon, 17 Apr 2023 08:30:25 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id b16-20020ac25e90000000b004ec8a3d4200sm2053439lfq.293.2023.04.17.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:30:24 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Apr 2023 17:30:15 +0200
Subject: [PATCH 1/5] dt-bindings: display/msm: Add reg bus interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-topic-dpu_regbus-v1-1-06fbdc1643c0@linaro.org>
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681745422; l=1021;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DgEhAwck/2UMFZpU98hoIh71vdQR9UmmeTw0XAyM3ys=;
 b=ciJNKHjiF7ITdMqgyQfJ5T8aGhSzJ7QpX1an0grzifZiCGiobk7sJ7VxHrZq7Ks1lDIevGYZ2Ppn
 gZhM6RO4AVtKPj9aTKdLen85YbNGGGyEr8b2giju+qcxUh69exFG
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

Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
another path that needs to be handled to ensure MDSS functions properly,
namely the "reg bus", a.k.a the CPU-MDSS interconnect.

Gating that path may have a variety of effects.. from none to otherwise
inexplicable DSI timeouts..

Describe it in bindings to allow for use in device trees.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/mdss-common.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index ccd7d6417523..9eb5b6d3e0b9 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -72,6 +72,7 @@ properties:
     items:
       - const: mdp0-mem
       - const: mdp1-mem
+      - const: cpu-cfg
 
   resets:
     items:

-- 
2.40.0

