Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106106C64DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCWKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCWKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:25:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC081ADC5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so11545931wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679567129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpNLyip69wJmwS3OqBQsHCVctKdhVF4LiqZDmDMUITQ=;
        b=ksoJnpaK/Zy6H22m19pDj2+MsjnTWx5V52xHiYII2sZY3NnOGH/VCPayWVplJI49n4
         ND5pCgxvdcpo2zY5ivvI+6PaEQb3RUIrHghG0fXowpUPDaiRdFNFFoaptC6atp2LFDu4
         /7l8Ft9XzQI/dgI2u5Kwjzjf3EGfetJ/nD19W1xeFExSOR/0ZrGeJgeovF+mJ5cIQcS6
         IIUH+yBHXb4uTAbLYXpoijgnFWQYeSiSA6Q4cZyNbB1P4/nuqF4+tRfG4scuPUaaB4PZ
         oy7rac3DSmLy92YeMtCqS/0R/2asitjiEoWzOpdqfo6qh7rO6b/GqtLVjy5psj/Std9W
         pipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpNLyip69wJmwS3OqBQsHCVctKdhVF4LiqZDmDMUITQ=;
        b=RA6v9KFHBR0IW6i3ssQaQ6tQnQSfub22DLRWxKwAFIyQ1WG3wivaXV2yV3sKVcoEO4
         FIKjYvAPHI3I9fGhC7EikRSWSo0BngDEfQbZ0sfM/5FeM/BH5nlLuLoUi/5+iwXziqrd
         zDpqThpFoXv+HjvAn8BEDIH0pwH07IOU7iKqXs2q6Wnbmge503kirocvu313DlxUk1Q6
         +t/H9BXSKIU2ocjlpTS6rPXwR9dcio7q/Kub9APaxClZomB71bsZ9Bp4wQ9ZKUPmNf4H
         /o2wX7bfLQ/SCh27Yt0BEPqBJ8hxLkDHfIfGyqwLA4DX7IvmqOxCDsTSlXPps+XdOk9/
         8Rnw==
X-Gm-Message-State: AAQBX9dAB2UdYw1pltlhXc2+A3lT5adXV0iPjgkaLpheuml02ic1Knb1
        534RflYcVnFXAj6DFi/VkFe2PA==
X-Google-Smtp-Source: AKy350aWTw8oMw5mfdjhhl2Uko+aQ7QMPlClfObRzjyqr46IHBi4Ee5GKUOe7E4wHzsM5OQklZnfuQ==
X-Received: by 2002:a5d:6187:0:b0:2ce:adbf:cb14 with SMTP id j7-20020a5d6187000000b002ceadbfcb14mr1824465wru.28.1679567129412;
        Thu, 23 Mar 2023 03:25:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e23-20020a5d5957000000b002cfefa50a8esm15753530wri.98.2023.03.23.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:25:29 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 23 Mar 2023 11:25:18 +0100
Subject: [PATCH 3/8] dt-bindings: ufs: qcom: document the fact the UFS
 controller can have an ICE core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-3-3ead1e418fe4@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the qcom,sm8450-ufshc to the right allOf:if allowing the ICE clocks
and registers to be specified.

Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index c5a06c048389..4527bcb949b7 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -108,7 +108,6 @@ allOf:
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-              - qcom,sm8450-ufshc
               - qcom,sm8550-ufshc
     then:
       properties:
@@ -137,6 +136,7 @@ allOf:
               - qcom,sdm845-ufshc
               - qcom,sm6350-ufshc
               - qcom,sm8150-ufshc
+              - qcom,sm8450-ufshc
     then:
       properties:
         clocks:

-- 
2.34.1

