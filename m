Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E2654B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiLWCvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWCu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:50:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66731262F;
        Thu, 22 Dec 2022 18:50:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p4so3755160pjk.2;
        Thu, 22 Dec 2022 18:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=NdXB+Xl+3wbOb73Wwwc2ndRLqB6vDaTUECRUs3bIQUGA/Up3lvB2SgI0N0sbx7DZVn
         76JJRDi8jRx7WLo8H2Z3W4saGgzqDS00G5gIulI9qwwNDtgZVbLUBA10vtANToQeYodn
         5ohs0uUfFyAQnpd/CqHUHOx+8VIRT0M2Ts7kseEP+gf8lgEPIyDm2lxm/lxzeb4k49PF
         7e88U5zz58hqHBJ22cU/MauScHLuoOkHDcm1qQWqEI2pli9iVSTiv+6iCZ+ycL30fVja
         du7JKP0vWzOiyaaLJMYWbAYRiNVPocBQ3O8XD2V+GgAM+eQ1PkTEYd5CUcrMvIVs/kEW
         Q1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYiGrmsD33kbnsC1ctFQkhOOqCnqOHmLKFShgn5msm0=;
        b=cfxdrX8YMXESVylggjVBIN9QyMz/eQfLhKpOlwqPhHqkfmX/MbHw+Y5XeV4DOJmxoZ
         VbA1p1MHW2MpSHEoF8gRlfB5D+ar2mTDUyF17GBcwJNzZ/hh1PwvL3C+B6a0FXZkY3Bg
         8mNJFou/Wm9+PxGfawMGhTIzHU8sGOHVkoX2mhOIaE6VzTPk+SLc+HN5yPptiPFksM9+
         m5kGsUaM+H/nzvAkH7s+N0ZZUHXZg+ru8XaujiifZPqaMGWQ1Gp2akvzD6VG2Bq7nyvA
         9WPS8+ZW0DVRF6z85XbnZy0RuflddTbSurRa6WE4L6EQaJh0fEESUC5vCcsbkQ5CYezV
         u9kA==
X-Gm-Message-State: AFqh2krPO9pRao47Uf3bsncZKgI5QPV3ZnK34IbTMBLdMUG+oJcHeGnc
        C9FzC4Q5lUGI/V2NzVXMSa4=
X-Google-Smtp-Source: AMrXdXsgcOCY8RZvmXL3mUE/EvSSID/1bmnt8f9VYa/QVhUrWMfnckFolxaCdsyWh1oaTXOEgYckdw==
X-Received: by 2002:a17:902:a98a:b0:189:cef2:88e3 with SMTP id bh10-20020a170902a98a00b00189cef288e3mr8586191plb.57.1671763858384;
        Thu, 22 Dec 2022 18:50:58 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902c64b00b00186a6b63525sm1186310pls.120.2022.12.22.18.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:50:58 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:50:54 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>
Subject: [PATCH v8 2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
Message-ID: <Y6UXjiQpMFHQkXJ1@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6UXS8snpRqIk+0U@VM-66-53-centos>
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

