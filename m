Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1B654BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiLWDR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLWDRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:17:23 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E93137E;
        Thu, 22 Dec 2022 19:17:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn22so3766650plb.13;
        Thu, 22 Dec 2022 19:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=hCn4mJm22d3D3rll3METASgOTnhhlJ8cXe968jX0yXnrBAUhR+kbXwYcAw52wrLNaA
         CIXdS6AP1v0bQyW7Hcn6DbLdI6m3+fc8MKYxBsF30EIqkLQCYru6CfsL54czOQicEHs+
         sM+yOnXWhBfTPMwawZ/K8fI9Qm1DEHaRLkXCo69UKb6hjOjQcnnBOdJW2Rm9IjabV2x5
         e80hbT80UwR3Qx11+nf3J3KAepEqdC3QjQVxd5nNldoG5AEUGiG6z1Gytu2Qhzi+K0rW
         xjIK6pbdQ7Kqc5sfACVmQtXhyXSIs4jUqfgCSUjE7x+64SLDmjYP9Z6uzRpkutuWjob9
         nbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=r1BvlyBFPW1DDao6FcC0al/DCUafZzDogNIkqJ0DCd4L1iivMMDktt9xNnb87TVsUC
         60qfJB4fAOMUSDOSF4ibLx3nlnJSCVTGS2LShNEz0JjauJZDiGwrqW1n5wkU5O3c5IA0
         Ibx9v9yGKC8w6sjilECzwKFej7fElFEM3Sb4vh5NCc6dGbQHjlaBariCmDFm867pkSlO
         g094zk2QEDZM7giJhSfx4Ev5Q6toGgrp5B+wFknTz6apHLnzoy8QVzlb32Xa6Cmkc/F0
         VOrsNV3kR799F2oShyX3q7qpfSRG8Hn4rxbarBwTPp9dFOTDDyBXtC14b78MEheLkF7k
         XAkw==
X-Gm-Message-State: AFqh2kpdiQZtw78rTd+htqaGY3/nyul3awFeONF5g7uYy5WOqh7FAJzt
        rkHJ/nnSKKsR/CTfaBbNlZY=
X-Google-Smtp-Source: AMrXdXsgvy46fTENjvXN+XI1fTqJI+3SswcLm62Kn8LvvIzBZsAEkVpKcaVGX8T7r4QkdEh4qN9VUw==
X-Received: by 2002:a05:6a20:3d14:b0:af:b909:2b3f with SMTP id y20-20020a056a203d1400b000afb9092b3fmr12961373pzi.34.1671765442579;
        Thu, 22 Dec 2022 19:17:22 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id w2-20020a628202000000b0057ef1262347sm1454354pfd.19.2022.12.22.19.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:17:22 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:17:18 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>
Subject: [PATCH v9 2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6UdvrhLjS0/8Oic@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6UdjhBD/Xa7ALya@VM-66-53-centos>
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

