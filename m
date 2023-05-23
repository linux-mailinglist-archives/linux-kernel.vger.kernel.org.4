Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FD70D75B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjEWIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjEWIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B841E7B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:22:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1b2so1026078a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684830174; x=1687422174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7VSJ860e4Fh6HjTKl0hZQ20ZjzePmB9hlOaoC2DjYs=;
        b=AqrheRnUfrVTEhtq8rROFiX4T4egyD/vbOOpiNzm6AXJQV37ly2mH1W5jMHuQWXKNy
         1wUOa359bgg901y9fxhjIEV6VqiaPUSo+WEkmPGwK7CkK1WICl5FXtuCzBkZxherNFbF
         6vEtfpFuuw4w33vNN9JZeeS8RujXDXPvMAiazBaeUXMxIe5W3mAfuEU8eeBNdRCW9ZrE
         y2z9oAuhEfMJ+stV7MvTcxGt7I198ZOCZrVD6/plnouAMr8/icUkCqmtUVsgC7lCj+TJ
         mUX9lQ0U55zweXAsZ7Dk4oK+rflT5d16Cxa018AF2fZ3afE1/jYaiGFsTnfFOPJ7qegn
         +IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684830174; x=1687422174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7VSJ860e4Fh6HjTKl0hZQ20ZjzePmB9hlOaoC2DjYs=;
        b=baU/mBP12aX8tPaRjKSdzU8JzrYY61UjkOhKomoFkdhMR4Xfr7nrucsWl+B2ZqnB5m
         eegm3Wvwq40swafOxkiIbuEaUUaWD0/OZTJrYtsM46UOD87mcmAp+Xs3dVI0YXLJfAbX
         v4ANfMvGukL8qcB5/O87MKdj56/vJKXPLvm9rAMCXc5WZtErYfc6ATX1QeNjvERR/5c3
         QZUgF4cIvMGTj75sTmM7uGyLYCrbg6gZq83yChGcCF5yJ461i9U+k73mmvG7QBv+j1km
         se1i/LoTM4rwB6vfRrVezdd13L3R7WOiV7A0Ef3KOez3BBOT/+OIu3hmUm5vtD0GdytO
         lXgg==
X-Gm-Message-State: AC+VfDxu35A5eZs/GuEITYvvu/jdTC4C/bPzu9ldlpFHMN9dqAoomH35
        BcNJoC26sDuZqJxYhRM8e1UnQmqwHzdlFh8zHf0=
X-Google-Smtp-Source: ACHHUZ4oGEBIae4rCVIdVQNqFVVBGfjQ0jdDLbNbELtK18p4kgkGWGFnwSZMy6yGRkihBvncLHQarw==
X-Received: by 2002:a19:f610:0:b0:4f4:b3e2:ff5a with SMTP id x16-20020a19f610000000b004f4b3e2ff5amr960851lfe.50.1684828006998;
        Tue, 23 May 2023 00:46:46 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:46:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 23 May 2023 09:46:12 +0200
Subject: [PATCH v5 01/12] dt-bindings: display/msm: dsi-controller-main:
 Add SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-1-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=1129;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YH8eQbnbg0vjMQ5V3QSyUBMSn5oiwSvn85ByrDyOEfM=;
 b=iJOYYgaeSN0oSmq0j2H96FoSofQ6aG73eXrUH3db2gWxCPO3+Q2hzxrJvjTFj0XZSqpdnvZ1b
 eFNviWtWfF6ByrnsPcGQl6tIX9XWsO48jcxiKfqtGeYi79yI4815nIR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 130e16d025bc..43f801a94d79 100644
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
@@ -297,6 +298,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
     then:
       properties:
         clocks:

-- 
2.40.1

