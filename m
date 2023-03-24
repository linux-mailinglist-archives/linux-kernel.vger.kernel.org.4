Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29446C7B62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCXJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjCXJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:28:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A21546BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so1043655wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679650131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YClmJDKz6cZns1Ia5c/sLtO34LHFlQQl6zHxRMVgDX8=;
        b=mr6ClSCp6Tr1hWXkuQ+WvJcUgf8qbHXaE6mQqhEasdKrCz/keIHhDzxYvqHBKKjZGE
         WmzNct1x11dzJMvPVuGjXkHyA2g2wVnTMH8bZITHLp6EDB6HsiaAhOHkGuBaWvEpCXgC
         8a/73zAqmcAo8Jq44FpiAPL2hXvBp777qRpMasj4dOSz0eMHTYSras+6/MALwDFhib0a
         bkuWyakWMjpD05mlRHr/9oJgW44oIDJvnKaYD+glDArKfsrDbtmS4j0BFC+bCb4Olu+i
         kuPtTBEE/xP1dtHkkQvvQic4fOFxw/C8a4iEekioF0f0WU3h69lhmOcI2pNEd4z4bZ9t
         qc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YClmJDKz6cZns1Ia5c/sLtO34LHFlQQl6zHxRMVgDX8=;
        b=zASZNWOaML4b3X/J/auuZwB/ISzJd2jIsyb5VVnsGxygwxt7Ce5iOl2DIdy9IaRkHY
         qw9s8dgaQx+c7KKez2Bg+FYJQ9jrwrX7gn+im/LeFtKtnomBtGyXHvl4rqSCaDt1slpr
         rxTBcp1JCFoVqoVSuezbjMmQ+3Fld7ky7ZTxCGELtiY2GOuPjTmBy6FLh5dzHNd1A1vX
         73o5FDfV7e3e+9KI9mr4tel9TMehXX9JpZs5ffwCAwup7kQmYjXwPTiknS8IDZh6NZc4
         2mzH5iAayyBSjKtaw9vPqD5YxCsP715ntyt8zao4jfizP5BTkoET76McZA1P0+kE5g6n
         Z5Ng==
X-Gm-Message-State: AAQBX9eExXbr2pusC45wcRF/klYesMFeYKD0e1MY+wRBfWCPZxeSFVpj
        2hdrxDzfM/4NFZmXOXgvyJfh5iUHj6a50ogdVtk7MQ==
X-Google-Smtp-Source: AKy350YPqtf7wMdZLg60x7SHKleSr8f4qz+JIvgKdsMXSPhn/X6wC4nfLVIdzdPM+av+LAOKJUEokQ==
X-Received: by 2002:a5d:570b:0:b0:2dc:d670:5351 with SMTP id a11-20020a5d570b000000b002dcd6705351mr1690298wrv.62.1679650130755;
        Fri, 24 Mar 2023 02:28:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b002c5a790e959sm18029980wri.19.2023.03.24.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:28:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Mar 2023 10:28:46 +0100
Subject: [PATCH v2 1/4] dt-bindings: display: msm: sm8450-mdss: Fix DSI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-1-0ca1bea1a843@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

The DSI compatible changed between patchset revisions, but that wasn't
reflected in the bindings. Fix it.

Fixes: 0eda3c6cb1c5 ("dt-bindings: display/msm: add support for the display on SM8450")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
index 4c6929e2534c..f26eb5643aed 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml
@@ -54,7 +54,7 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: qcom,dsi-phy-5nm-8450
+        const: qcom,sm8450-dsi-phy-5nm
 
 required:
   - compatible
@@ -254,7 +254,7 @@ examples:
         };
 
         dsi0_phy: phy@ae94400 {
-            compatible = "qcom,dsi-phy-5nm-8450";
+            compatible = "qcom,sm8450-dsi-phy-5nm";
             reg = <0x0ae94400 0x200>,
                   <0x0ae94600 0x280>,
                   <0x0ae94900 0x260>;
@@ -325,7 +325,7 @@ examples:
         };
 
         dsi1_phy: phy@ae96400 {
-            compatible = "qcom,dsi-phy-5nm-8450";
+            compatible = "qcom,sm8450-dsi-phy-5nm";
             reg = <0x0ae96400 0x200>,
                   <0x0ae96600 0x280>,
                   <0x0ae96900 0x260>;

-- 
2.34.1

