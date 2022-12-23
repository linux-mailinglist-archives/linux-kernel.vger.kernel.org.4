Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38E654B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLWCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiLWCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:51:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C63A20BD9;
        Thu, 22 Dec 2022 18:51:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so7585030pjj.2;
        Thu, 22 Dec 2022 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvI3blinvaCjUYpwPXTVf3onR897jbDV84x4cQn3O60=;
        b=Do1QvfnwIcT8hHAyZETGPNy9FuDlbFdcTAZrC5hnphKnWybtcsnnTSg9KL52GnF0nN
         pIXVLqYAmL6y560Nb8s5A4ClCjuI0B7p+vJTTP6jF673ssztlyBxbS/AoM9oOKeyhOrg
         j8lOaqGTOArRAogD7mYzZhWx9QONVpTWTDiGb7GFltRLrbKGzNSO5RiBie+FYMJn51bY
         OJvxmxUpdhENfLnDIsIZoguRKdW7OijxsEFXfCHDfpP+0dzJRJccIY49tudP9WRDQWKk
         NOHptOrSkjtybQjBPrOfEQv6iX9QfejdpFjhwweCVorHp45kQQcV0qqklF+XqB5QrHyZ
         4Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvI3blinvaCjUYpwPXTVf3onR897jbDV84x4cQn3O60=;
        b=QLXxtro5jPCavcxPzRi1KLQFxMsuREMSpArtcSFfT/TnB4NYcoAQxY5eg9QHYTQzzi
         yiAx0s6TIkCG/GFB8CSDVb1PuEkLFsHnyExhlrYrCPvN4OwmRHXMPcD0t9/ocNh9vsIx
         jFh+7QrHacoXoWEXnkxFXCigmf6Svh6LJJ2/ZWo1T9Wmex6zhhKTbEUC/w6S3n8o2FZL
         xjGEQDC5A1biD9VUxMsPRaVAxYSLzrx2BCtPi3CJc7SyKQLZhsrMsbc3JIuWbxNaDag8
         aYPKVbROuhJ3EFL1mvPF57JjdWIJdPhHUw+yjz8KH0IJ1JPs4xOFNaFtdnSYNxPrI7n5
         tVAA==
X-Gm-Message-State: AFqh2krO65jjr1z2YGly2VXp95GaY/Zu6pYqhKqBhjNOsffOl85fRfJx
        wMUVP99WowipIrXbuGL1/Kct+1R3IsXkNoWpvOM=
X-Google-Smtp-Source: AMrXdXsQiEhl7zXPKFqOSu8j3jDMEEBsHFkfMleAHZnaxS6CJp7sq4hIxuDG8v+6wqeNjfNCfcoexg==
X-Received: by 2002:a17:902:7e01:b0:192:569c:e557 with SMTP id b1-20020a1709027e0100b00192569ce557mr3295133plm.61.1671763916833;
        Thu, 22 Dec 2022 18:51:56 -0800 (PST)
Received: from VM-66-53-centos ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172fad607b3sm1170243plf.207.2022.12.22.18.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:51:56 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:51:52 +0800
From:   Yuteng Zhong <zonyitoo@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Wenhao Cui <lasstp5011@gmail.com>
Subject: [PATCH v8 3/3] dt-bindings: vendor-prefixes: Document EmbedFire
Message-ID: <Y6UXyMVDu8ZRFvJ5@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6UXjiQpMFHQkXJ1@VM-66-53-centos>
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

