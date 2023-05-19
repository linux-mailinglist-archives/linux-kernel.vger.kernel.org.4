Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D6709D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjESRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjESRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:05:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099C10FD
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4effb818c37so3982792e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684515874; x=1687107874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1+Xx964Do5+Dd75p0npXtM1tzzF2n1YUbY/5ffcryg=;
        b=thfkMJlDBO8wgthYMNMUetBmtETMvJPAsYrmS0DzsUWpmfaib4gkM6txQeuc6e4vvv
         GyytH2+nPXZg2cxeG4fm49g+VOthlvEgjSWV8yeBcWmv9ge/km0/ZRMyeWQzjSLHk4yj
         QPp+ecXf101QRtMFP39n9kSmcBcLXE3eM+tUHwQrPYdlWPpgccVRQTJO7E1fKQmdFXhz
         eQBZncbZPwGULUtgUf8FU6OKp3JaTMxGryRy+9d/lMXmuA6HT9u5f1EMfbT2UhGkR7K0
         CKkxDT0Qam3x47K4ccxbeLbsyGDOr0MA52V6Ujd70UdmJIaCSiO/jKM6C33b1Cxl6J8Y
         yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515874; x=1687107874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1+Xx964Do5+Dd75p0npXtM1tzzF2n1YUbY/5ffcryg=;
        b=XF74NClrBD1nzKGh33RH5HaVaoBd8/s/nQlY49NxPqm/Gv7EWz3c/ebIlLfnG9RSlM
         yyc28vV3lseIzknodZ2xIXtag/VyzhYScJcByL0OfRXQ24HrpH283XWyhlFyZd/b3fHa
         8wWvuW5jHrJojfokabWRxpTXbYlAwhcZgF0TM1308dJStbr0R0eiWOzJPtTstP8ZdHHj
         vZCfv3bBA/Emcoy8Z+8iBZ4rHBrZWzr4eVcA9tPmNHjyArWKu48+fK0fCwI2fZv7qc5P
         GHS/BDkxl8LaVG28dZtRa7iwWZINDWHLRy8AcMnQTAHb+4FOHNC5IZskkO5Z2e5dO0Ld
         EiZA==
X-Gm-Message-State: AC+VfDw0nFfPjgILaBoL4N50JagwhqewNXBhgYpiFfNW03xIV2jSktOh
        DWAAwYugYVEzJUbLBSFgrOrX1g==
X-Google-Smtp-Source: ACHHUZ4mELS3YoypykXV8iWIlO0eUJnwCCZDBcvHgkxqQ8EOSkqseL8HgLFIlG4jNk1ozEpcxJvN/A==
X-Received: by 2002:ac2:5298:0:b0:4ef:eb50:4d3d with SMTP id q24-20020ac25298000000b004efeb504d3dmr1036530lfm.18.1684515874534;
        Fri, 19 May 2023 10:04:34 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004f38260f196sm654478lff.218.2023.05.19.10.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 19 May 2023 19:04:22 +0200
Subject: [PATCH v4 01/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v4-1-68e7e25d70e1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684515870; l=1129;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+O75/n498bCPQBt/QSpDKi1r6jFyvKeD8W9H7IyUIm4=;
 b=VMrSRiQHHy1IfOFNgIhJBuew4aa+bzoYEQiURFvzfuY35jhC8ZmvzP63uqDyObnTEPw1tPlJK
 NjlOaMqNxplC8il/61Rj/Lc3mhX2uSte/tj0u4ArOzMhKezg3GsCLCm
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

Add the DSI host found on SM6350.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e6c1ebfe8a32..6f367a1fabf8 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -285,6 +286,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

