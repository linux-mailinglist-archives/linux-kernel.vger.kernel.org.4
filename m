Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F06269E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiKLOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiKLOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:19:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E751834F;
        Sat, 12 Nov 2022 06:19:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u24so11237386edd.13;
        Sat, 12 Nov 2022 06:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRLnk3UcVriiraB+P5IRs9+XnPrK8g6dmPwsFT/Y3Ks=;
        b=ZzjQvb6yC78EAfhunPN6d8ba3LHQwChp5KaYFkOf+9F87B/GSbqttEzVj37P+ys10Q
         a1u5dUHKaGXdQ7ROzn9Fvg/gyzxqwq0zceCu3XpjNW8fC6dC7Iyz6DubjrOxaCB3pY+P
         3Zd9FFBkVmgd26TmAzlNUGmjDq/agv5AiBe65+Mk5TyY8mkU9Y22fT+hsfFEQKTVUB8C
         RV2lC5AZc7mFYJ472qE0hzPSseBvp8FxU1ajMLjTdVC3s1mciBTImUp8irG32iZ4YaSu
         y7t+i8plDBaUjgdHNvWO4CI+8z2BqXzKp3d5hSxCv0vt65OVpu2/WafTHiwg/OGouayL
         sV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRLnk3UcVriiraB+P5IRs9+XnPrK8g6dmPwsFT/Y3Ks=;
        b=3T3TL8qrzuAqgKQQ0VplJvDHjmtKZbQxshejEmIN0DZJeywZF4K2GOI5NkTAmQndJW
         EvkinCZrbgh0kGZyyONlWlOWZx3ELZ2pDVK/7Zy8QNtjby5AMuOiczf+bnpC9KXnt7bb
         N6OjxiJpuHJszAWUM2Gz6JabGQP6fvPv6G6W5jmS2QO1Fj2pCJxzP2TEiEAipk34k2vi
         VE+RTwFFhDuIQ3BtO33JvBNr7YfOfBOFVQ6XV+PYRL2Zrynsk9vbXOb6F4BM7qkzkZo/
         TxypXkZy7hmE2/9Mei8tKRGvFwWNfk1rXvNQnnETYy49swQC7RiZl9KVVKzShdMUxE4X
         dq4w==
X-Gm-Message-State: ANoB5pmUqif6b/uQ8NyBjwOyo+3+Jh3FCMj31r+2SzisWunHaaPFpYaq
        uri/4AKLwsr0TqdlWNnoczc=
X-Google-Smtp-Source: AA0mqf68OYlc243BhIdPd4cmVHG+SNwILgvN9C8cy/jDJox8cBeKUIOu2CzFB6mCgJe6y0Bffp5SXg==
X-Received: by 2002:a05:6402:35c4:b0:462:fb18:3b45 with SMTP id z4-20020a05640235c400b00462fb183b45mr5377350edc.243.1668262741471;
        Sat, 12 Nov 2022 06:19:01 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id g21-20020a50ee15000000b004677b1b1a70sm1050148eds.61.2022.11.12.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:19:01 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: arm: rockchip: Add more RK3326 devices
Date:   Sat, 12 Nov 2022 15:18:38 +0100
Message-Id: <20221112141840.516224-3-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112141840.516224-1-maccraft123mc@gmail.com>
References: <20221112141840.516224-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/arm/rockchip.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c6c69a4e3777..d2748826cf39 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -30,6 +30,11 @@ properties:
           - const: amarula,vyasa-rk3288
           - const: rockchip,rk3288
 
+      - description: Anbernic RG351M
+        items:
+          - const: anbernic,rg351m
+          - const: rockchip,rk3326
+
       - description: Anbernic RG353P
         items:
           - const: anbernic,rg353p
@@ -468,6 +473,16 @@ properties:
           - const: hardkernel,rk3326-odroid-go2
           - const: rockchip,rk3326
 
+      - description: Hardkernel Odroid Go Advance Black Edition
+        items:
+          - const: hardkernel,rk3326-odroid-go2-v11
+          - const: rockchip,rk3326
+
+      - description: Hardkernel Odroid Go Super
+        items:
+          - const: hardkernel,rk3326-odroid-go3
+          - const: rockchip,rk3326
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.38.1

