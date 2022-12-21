Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C58653367
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiLUPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiLUPcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:32:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918727CF3;
        Wed, 21 Dec 2022 07:29:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso3599948pjb.1;
        Wed, 21 Dec 2022 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=ddULDEk4aFIBRpVQGJf/LiUqsqilBAOqohYWi5YH9liOMfvZAEDwd7V+igocRJbBZQ
         2bkO6suNIZ81FH87TNvaCnGt1fB6ExalhtQQGMy68agNX4YfubxzhIlslG58YCTRFsMP
         TASlmvsNnK0n4B0CII7PcaxXng2ZccWiIyGIi53A90YlqpAQUXEHq3qIfRXysxoImvtx
         cKcsbojt12+xce/qKy2B4QZf75Oxb5vSjIwt0niKgAnQEozpYaqTtZjGHGEmScHfcxRl
         ol+F7F9C+v2lST7hFNs38tLZ3Q0i3VlOUEmOaTUSPXMGCnMng/vIW4rCaCU8U1dd8JCL
         euWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=mh5Jsu3zZLZaTDwkqjuS9kGLOYRFB2D8ROH1q30YYjfW/6i0YP8awqzoT/QWSnAxl6
         a2m8e+PJ++LFNPb4clZq11nQ+6Xlr1r+taXLoOLVVMibbSPmhEoT4EJbiErSERyXixt8
         kg3BUQ7leaGgoTE6lNoyhaHn7g6Ym4fO2DTGzbSEUONPC/QpP7Qm4vUNtjfiquybuzLV
         IOXqQbFTohW0BW8l3GqDAne5agQ5Xj5ZXvTQOxbXZmuJZCCQGD3vWVm6VM8N/Ap6/slC
         WBqGRonoQQ62iwgnHOaVT0A6meX45dGlBzhVFVOxpyiXVBJ9oS60Xl1+t6OW4z8N87Fs
         HgVA==
X-Gm-Message-State: AFqh2kppa2yPDcloadjItabqRQ8UDZOLIii9vw7hZmUWTccrw76W5QGj
        jJeTYKCImzHGKRiHA4OcX8PTd1d/e0EeKJ5wQA0=
X-Google-Smtp-Source: AMrXdXuacBsZ/+BjXRVU1Pqg+B3KRM9iYoWZonRqGmi5+ayp1KDsY51OG8dwkITMV5kMONbCZ5hqbw==
X-Received: by 2002:a17:902:c401:b0:189:ba1f:b168 with SMTP id k1-20020a170902c40100b00189ba1fb168mr3376489plk.1.1671636498117;
        Wed, 21 Dec 2022 07:28:18 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b00189bf5deda3sm11630438plf.133.2022.12.21.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:28:17 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:28:14 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>
Subject: [PATCH v7 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6MmDmbCDGtl3xQd@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6MlrbGKiIVc6tXt@VM-66-53-centos>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenhao Cui <lasstp5011@gmail.com>

Add devicetree binding documentation for the EmbedFire LubanCat 1.

Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 88ff4422a8c1..058ed707f3cd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -95,6 +95,11 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: EmbedFire LubanCat 1
+        items:
+          - const: embedfire,lubancat-1
+          - const: rockchip,rk3566
+
       - description: Engicam PX30.Core C.TOUCH 2.0
         items:
           - const: engicam,px30-core-ctouch2
-- 
2.27.0

