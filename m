Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086363D75E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiK3N6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3N6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:58:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3F2124F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:58:34 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j4so27111635lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/IkgJhGlC2jakl2mEql5tWtZmP6qrQiICZlujfOmWc=;
        b=qeI5DGC7HVu7dL1ljYAK70PykFG9IlTdEiF+RN4EhqN+g45Vwfb0ZYUgY30IcuUq1v
         IV1dR+9CViyrU70Ec/JtxkG8vbmJ9DUibs57hRzRMWRhm+b+BWeQqtMAlNk3vcj5vFiG
         dNVaLLdvj6Hx3mzzDZszjzXd06PV4+zwPffdOIlaYUjPb1fdyVTsbB8OcGz6YK70hPFP
         ZfJIWvXt8VFoqdXTPOKHzktLJCAu5zw/lWf4s38du6xHZA6/sbhephVAediUlGN+PIwP
         fwvmp8iMn7N/u3w9zv7nl6VgkDr03TsXtZnrPjhtdBZMbefGO0ouDX9wYea6vX/QqU9Z
         bsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/IkgJhGlC2jakl2mEql5tWtZmP6qrQiICZlujfOmWc=;
        b=ygGXqzcXdPYeiBIIPCsUoIaaarcmu6202uwxylZqZ/3GYcG+l3GulUqYEuvWmoCnkT
         YxO5TyOXxsGx3DD9Lk7uuP4muUgotNXGCXEfyOjQ9OtUPkU6ahbTTrMrFrzXyKMSm1qs
         zMQwVAOVLjHih1H1ALXVB91vbld3FzEwjmIwhwBiCUBvYUPGEADOBK/2l7oxxbCO3aO7
         85HzbxHDto8xUvFpaDEVNH+JiOWuOKpBzX19qjMF5YRFYhRChvcuKzvwFbTp6rP/KYpv
         pB3yQ94G7UhYSD4CAJWUcqMBloM4cI2NDhN7HdsAPrvJ57CfnfDT46A+p05Hp145BHNN
         5V0A==
X-Gm-Message-State: ANoB5pn/vLauHz8wtVM9Jq1UUVqwx55Eq/XFuG2zXIixEGBFuhLBRGsO
        1Nkwbd/fHXF18cIL6W2BpX426w==
X-Google-Smtp-Source: AA0mqf4mhUxGdxDyd1aKC1Sf0nP8jRR+iC9NP6I0ui600XlVx0c7uo//PmdFxfl+aNiow/+mVRXJDA==
X-Received: by 2002:a05:6512:3153:b0:4a2:da6:d969 with SMTP id s19-20020a056512315300b004a20da6d969mr17496716lfi.671.1669816712596;
        Wed, 30 Nov 2022 05:58:32 -0800 (PST)
Received: from localhost.localdomain (95.49.125.236.neoplus.adsl.tpnet.pl. [95.49.125.236])
        by smtp.gmail.com with ESMTPSA id 6-20020ac25f06000000b00498fbec3f8asm269889lfq.129.2022.11.30.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:58:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: msm/dsi: Don't require vcca-supply on 14nm PHY
Date:   Wed, 30 Nov 2022 14:58:07 +0100
Message-Id: <20221130135807.45028-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (hello SM6115) vcca-supply is not wired to any smd-rpm
or rpmh regulator, but instead powered by the VDD_MX line, which is
voted for in the DSI ctrl node.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
index 819de5ce0bc9..a43e11d3b00d 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
@@ -39,7 +39,6 @@ required:
   - compatible
   - reg
   - reg-names
-  - vcca-supply
 
 unevaluatedProperties: false
 
-- 
2.38.1

