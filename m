Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249C3654BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiLWDSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiLWDSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:18:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CFB2098D;
        Thu, 22 Dec 2022 19:18:17 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 7so2563449pga.1;
        Thu, 22 Dec 2022 19:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvI3blinvaCjUYpwPXTVf3onR897jbDV84x4cQn3O60=;
        b=Oc19VAEwOXUtxxtdKwHQqNGtQUP76Yf3FUW92uqTquY/TovWt5Tm3B57RyYb5bEhXk
         NNqXzye01SuzGI3YviT/y5bf7uD/6bVA3Zd6OLIlDwXnIjXaodegdnJRKf3ot4qO5DIU
         aM1HyhMD0QBOZT4l7gVjpw7sr5H2R0gvD0xm+NTNLvSZdC+Nm7uqKJ+4IIzF2KD+uVDl
         zp4zwYvekI2aPz7dReOnZW7+hmIZkgEbfKHsP5tNm3NwyiwZEsSGi+r8z30Rcu6VlUzl
         pOH46skNXMpcGaD/NLQlYMYPl56wWyVvoU0uqR4VhO6CHJlEu/kLihD/NO2CQpuJE4XT
         kWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvI3blinvaCjUYpwPXTVf3onR897jbDV84x4cQn3O60=;
        b=4w5HJIiPGJFed/hGYWn1gF8NjQv9wklmy0RnOM53+5jSXnbEyK9f+WQijSlUsPcTNS
         xvcCTSD07qUEc5QFHXULZgKgcZwzGm7cL4aT7n5sPO1lgbvk0k7maU7d65H/oG7nA4KY
         lCJ/1iUFYUVNxa4gld3r3HnaGMcIohXq3H9iPSjLYvZkC23gttfABorUqcs+hxyVAcHf
         lwbj/4qDR+TEfwvka6Q/8/3BzUuIKPK3Wjk7J5ERzF2PlhClRYfwSO5BuoSBhGxHRgbW
         zZB1GqBK9M20mdPokXnoTsclkskH2tNVW50Exbixi0gtiFp/pYcVpR91Cs/HGkjG13Qc
         na+A==
X-Gm-Message-State: AFqh2ko/e56azH34OW4PS6LbU8EpGpQn4r8rQHqnunf8Ykmk2sJyUuoF
        qeuCX7BI+OQTcjG6rQFhbgg=
X-Google-Smtp-Source: AMrXdXsPfVNkPFXAkqMaVrtsalGBoW5UqG9NuVGNJ1jY8X6HR3rNhraFmr4D2g6g0ZZeGHRgLWYbOg==
X-Received: by 2002:a62:6102:0:b0:578:3bc0:57d7 with SMTP id v2-20020a626102000000b005783bc057d7mr8071802pfb.13.1671765497089;
        Thu, 22 Dec 2022 19:18:17 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id m27-20020a62a21b000000b0057fdaff3fa0sm1457473pff.15.2022.12.22.19.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:18:16 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:18:12 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>
Subject: [PATCH v9 3/3] dt-bindings: vendor-prefixes: Document EmbedFire
Message-ID: <Y6Ud9MhRjCVAYMCj@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6UdvrhLjS0/8Oic@VM-66-53-centos>
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

EmbedFire is a manufacturer of embed computers and education platform for
embed devices from Dongguan.

Add vendor prefix for it.

Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 00493b962bd7..0f04ee30bdc2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -396,6 +396,8 @@ patternProperties:
     description: Elimo Engineering Ltd.
   "^elpida,.*":
     description: Elpida Memory, Inc.
+  "^embedfire,.*":
+    description: Dongguan EmbedFire Electronic Technology Co., Ltd.
   "^embest,.*":
     description: Shenzhen Embest Technology Co., Ltd.
   "^emlid,.*":
-- 
2.27.0

