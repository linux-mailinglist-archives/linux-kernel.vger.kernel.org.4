Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E18653319
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiLUPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:22:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83C1DA46;
        Wed, 21 Dec 2022 07:22:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so2608614pjr.3;
        Wed, 21 Dec 2022 07:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwvyNFcm0dI6zV7MUfVY3A713zgzqWHPPc2e25ZpgGw=;
        b=E0MbKWldQ0EFSy7QTA1GSAtiN4RAYci/lnJt/H3APj6U54J0wxzc69vApKxvS8jZRl
         BbsIjLuItGm9wMgQ2OGfg6lldXUInL85G12fXFHb11M+XR/fIDHOO/P9nMBqXSmywnQB
         DhwGXY1EKXEbHTnIKB+DDOGtaFReDefM4PQGHbsJf0zC8PsI2z1hec1kLUFutGc3vAA8
         NbnbnvypJUHiGXhrSHPJlo0J5O09NvzQRcUtznKSO8xX2jz4znAHe3igfBhNwq8JJvzJ
         ItKr5QdgxJ7sEgFnIUoe1sLFDXZinCxkhebtl8tIb94X/+Ds6PrKKiqYIYF7FjnwIxNJ
         5tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwvyNFcm0dI6zV7MUfVY3A713zgzqWHPPc2e25ZpgGw=;
        b=7frtkMixz9DO2z1Gcr/J+pK1t4PY5ENEzdO4ZOJh4YCfHzIjzgfzAUpITKQuW5pOXI
         +Q7yTt/+Iubkj8VUyaKT/83Fb93G2TKgFYRtTSl05yLW6lTbCdma9bLEWpWqRzyr6SrW
         Yyle6ON/4T7bLeS4lQIclmGNn3dPWQ/m1VXS+G7HKoZPOcA/+7etsEVBdJPN6EMe3r3Q
         1cF6JWzn77ohRrPT37W1qxKOnAaX/ZV72WCipn2Q44TtkOpXguKvLGQ/BrKkQpG0yGwv
         UWaMpb1s7anqxu8/I9C5LsrFyT6mDYN4BbSqfyRs9pi21MvUoQWI1y/PjsUBSNG9Vcjh
         6K6w==
X-Gm-Message-State: AFqh2krC7WsEikYHXT8bTjzh83PzrtwfApItu4Mxj+Hf7mPQ8SAf94zT
        fuX0M4u964eponIZrCkZRtI=
X-Google-Smtp-Source: AMrXdXsCxgI7fsXuBw0msYMSYi44KDcI9/3VNVjscO4DO5/EWZrIajQwA+Xhhmbr2zkWy+t41He6Kw==
X-Received: by 2002:a17:903:130d:b0:192:490b:a207 with SMTP id iy13-20020a170903130d00b00192490ba207mr1621232plb.33.1671636148615;
        Wed, 21 Dec 2022 07:22:28 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.4])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00186b6a04636sm11586833plk.255.2022.12.21.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:22:28 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:22:24 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        DHDAXCW <lasstp5011@gmail.com>
Subject: [PATCH v6 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6MksLH9POLt6UTI@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6MkcVIpEaWrTrsS@VM-66-53-centos>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: DHDAXCW <lasstp5011@gmail.com>

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

