Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3565321C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLUN5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLUN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:57:50 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BD16488;
        Wed, 21 Dec 2022 05:57:50 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 65so10725191pfx.9;
        Wed, 21 Dec 2022 05:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E16eg81y/3TQQu4tmwjH3Mb5kYfTWeAmEOxBvMsrRfI=;
        b=h46rfwZg578R5lfJQjxGyI4ACtLaDJEtVMY+ePsm9cCgqueg/CiA8SmQ1BJvIxVIFg
         vzyX7OF8Nqtxik5ilAB1s1HZiVSr1cEEWVMWDEun+On+zLocD6rux9V4qcaXtpMQPyAV
         xT9weNj6t3bOoPFAhw2tB5p9QlrrjMNCYDvKpkdW3SPHikLmDsYXQ8TPtkY46QFkkKnS
         I5JYZSse9Qf4qJOYLOI1DVkJMj+eDMUGri/XcggqqtR21VEqBltowzYzf13lozAwfQcx
         aY2Q4XQ4Ipq5lc1VJTiv6yZJzLdN1YL3weDGqDsB7V3zLXuz8WPLtzWW8McqDrX4gwj+
         FS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E16eg81y/3TQQu4tmwjH3Mb5kYfTWeAmEOxBvMsrRfI=;
        b=GpOamV0aoXskxzcGagJhFPplz6PBjQJ2XpA5XjKwjKNDN7+5EXuNI+UwCtjle2c3Zb
         b9bahSiXe90nTOorq/8RZ7E7xAB3DUq+LLeKw21sSSx/Y7opCqFoHl7U9lYgCPn70vu4
         zufEAV6y9UYtzNTHCzAn+QYK4BZ/hTGguxUeHak1Ur7VFN2yQ/aJoo4h+erxE53FtEDX
         8kMxGfi9rpzXW7VNLwGy6tYP/EmA51zRxwhczV+f+1r2HQ2JWotucvoKvOgJzKp+YqDY
         4SGLbgrzMPru08yEZnvQY2o2kfnEI50tvlziCpIZDoRn9MkFxrzKw66xTNVV+J8o9qSJ
         SBlA==
X-Gm-Message-State: AFqh2kqxSQvgp5icX2YmxdItbJXtJk8cYsPt5t9iycidJeqeurZHZbFW
        U7tmvp2vgMEE7rF+XbaagrI=
X-Google-Smtp-Source: AMrXdXuC8f7v7qZeunwUnRD8pcfO8e7Ddu1MOHAZ9RXSbPfNOt/3N07oAezsB8sDciGHEPIShb3/Vg==
X-Received: by 2002:a62:1902:0:b0:578:3592:6eb7 with SMTP id 2-20020a621902000000b0057835926eb7mr2271755pfz.25.1671631069632;
        Wed, 21 Dec 2022 05:57:49 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 127-20020a621785000000b0056da073b2b7sm10616974pfx.210.2022.12.21.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:57:48 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:57:45 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        DHDAXCW <lasstp5011@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6MQ2b8JyST6fPVE@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6MP74TUp50yt6wZ@VM-66-53-centos>
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

Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
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

