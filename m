Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913736AAAFD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCDPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCDPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:55:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3CE1EFE9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:55:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j11so7271823lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677945346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0Z7PCtKUkVqJsivDDGD4tHBvmMLAeq4ZfR9VxFnexc=;
        b=NeIS309oRrzfgN4mcRpjduIs0ET1CsXpx7F6fk9c4qTkRUxXkwIAgBjxR9Y24NA+em
         Id0bIt3Y5P4pUDCjh5FcwPZhIP7Z5mPuOvO+nfRbUESV6+Jg1JUf/+fVYPr3GGWbl53b
         ZEHOKfXgea1Pu5aKgm0bOHCi3csUk4/tIqN6mnYh2fEPhCAL2gGLC6p4ASn7ycwGJ0VC
         kSawh9xsfTcVOKwPdUnmKM40crzSlk/NTkV9P3WCUvGUClE0nu0FcG5PFNjoSEyIoh6A
         azixturFbvDwFXnJV+O5iJO2XQlS0I1K8U3TWe1C00W3oKuN6IKn9bE9dQ7bAKfVODHZ
         Lfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677945346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0Z7PCtKUkVqJsivDDGD4tHBvmMLAeq4ZfR9VxFnexc=;
        b=MYD/xrntlK1/HYSI6+xMqUdvKbs26NdfhElao7M9JIWCMsn8EqmxeR9aeRm5BLMytz
         froTy9rAR4e5G9S9uUwbsgL7YjFwQj4l2x8u4XOLC038+ToQBmguHRNyy6k8s8xDf+lL
         mWrKWPzzqNk5pJe9o8PTxzqAjeuAHxhYH0fCp18DJuLnHx9ESqnW9FEfoaYKpVeJNyDu
         lAD8PUy2Ba89065ZUHsIUY/gmE0CO9i1X0c39ddFBHsV4/wsuWA0YFpkKZjchjI6yj3k
         aO4VQyQw5Sxhhc4T27DSTH+WMiFCIbcGC+WnFK/J4jVwMwZeHUj40gq3u+7k8W63jTNL
         PX/w==
X-Gm-Message-State: AO0yUKXNSWiZuyiXcBhluC4XyoE9go8s4e5w43r2b0Tw9HfW2Nb96pXu
        m0bXS18nh0wrCH5VMVvQS7zdnA==
X-Google-Smtp-Source: AK7set/y8YiW4dmjB5HIHYzfGSUEp60S4ncz2/1dxkl1a9e85GDK8H1qoZ4fCSD2H0mcQi3JvK7NfQ==
X-Received: by 2002:a05:6512:50e:b0:4d1:3d1d:4914 with SMTP id o14-20020a056512050e00b004d13d1d4914mr1705736lfb.33.1677945346240;
        Sat, 04 Mar 2023 07:55:46 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id n10-20020a19550a000000b004b40c2fccfdsm864128lfe.59.2023.03.04.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:55:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 04 Mar 2023 16:55:34 +0100
Subject: [PATCH v3 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
In-Reply-To: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677945343; l=1144;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5kzj2YWxyC8wUuhDCqozlnQie7hmtcE8bSzx7ndtKT4=;
 b=olX0NwynmYUDEuRLxQzz5x+tMQUX0Hk65zsshFPLVTSumrfcaOfAj0K/vUwUoug6uYb6Jh7ADOy+
 SZb+1LQvAIb7B91UXDsBmx1I1PihC85gXkyLh20jXAsMg46ih3lx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
alone. This however didn't quite work out and the property became
undocumented instead of deprecated. Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index f195530ae964..d534451c8f7f 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -35,7 +35,7 @@ properties:
       - items:
           - enum:
               - qcom,dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+              - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
         deprecated: true
 
   reg:

-- 
2.39.2

