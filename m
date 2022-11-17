Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0D62E799
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiKQWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiKQWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:00:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9D38A7;
        Thu, 17 Nov 2022 14:00:08 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g12so5121312lfh.3;
        Thu, 17 Nov 2022 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W6/23FsquU43CNgCohStnpDl0ZJOS5ZXPq3VPn16G4=;
        b=lIYxKyjH9QJR9a0slXCDFwZajAAiEGGepJMZnbUGqeyakq1mOa06y9QNy07SddhEmT
         Z9/C4CP13pWM0WyicplirIkI5dHu417IP/O6gZtXUoby0XBAT9j5UkvwUeOyVY0Z7og2
         fFcuh72KIsx4nQsxG+WeYtukzvdZsnfEJ8gP0c0i8wo0p6oT0KzJVcucV3SRQjKRH81G
         DCByJegEV33z2/lN53S4f6nZ6ne9t19SZV7VkTznD+bCCLc48AYxZWM62rDTax+WXi5N
         g3H02KEncVWIcq6PDYjwYu8+5jllixalDmFutOedcLAF2D3AVAdn7eDUu8Z7Cuf0p90B
         Sqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W6/23FsquU43CNgCohStnpDl0ZJOS5ZXPq3VPn16G4=;
        b=8EWHOyYV7A06ScOxczCAISNrYIeOe8GriHyHq05JGbxAHAxqFRnHKaitroPUJYClkS
         iFaouxeTzI3fBW4rUgtM1nmyLmQdrNkCGqR+Ns6tvrRTeFUSKWvrUxuZwklzw4nDFlbL
         9wrpErBEqiJk4y+A4s0q+NxI+Q9xALCf+Us8mYBGb6OuzPZLZ+kNfBPbe10vpYYIK2hd
         8eLwGNYEZxalsJPq5R/tEYpZPtWBGtYZh6CHSsBztxi5UvWhAQCS/xHP605zW9Wga7xU
         m30fAQi5WVUbObH+OVgZJh7SEHroix/XDj1srnSqrBp+Dv7PsWKX5sURoW2qQ6LF0zWs
         KMCQ==
X-Gm-Message-State: ANoB5pn+hbBU9CidK4M5x8L1W46Yw9YQBPnz/ga5MUex3kH3QHdgJbhO
        7vZ4ZE8tj8eB07sFJ52EO2c=
X-Google-Smtp-Source: AA0mqf5ZcmtMpufHGsV3EL3jrTeOjZv/6OV19dYExWwwJTEoH6MndYU+EkYDUZ7wCA8d023V/JbaEw==
X-Received: by 2002:a19:ca08:0:b0:4a2:4eaa:9276 with SMTP id a8-20020a19ca08000000b004a24eaa9276mr1493468lfg.97.1668722407134;
        Thu, 17 Nov 2022 14:00:07 -0800 (PST)
Received: from localhost.localdomain (79.191.9.185.ipv4.supernova.orange.pl. [79.191.9.185])
        by smtp.gmail.com with ESMTPSA id q29-20020ac25a1d000000b00497aa190523sm342985lfn.248.2022.11.17.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:00:06 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] dt-bindings: arm: rockchip: Add more RK3326 devices
Date:   Thu, 17 Nov 2022 22:59:51 +0100
Message-Id: <20221117215954.4114202-3-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117215954.4114202-1-maccraft123mc@gmail.com>
References: <20221117215954.4114202-1-maccraft123mc@gmail.com>
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

This patch adds Anbernic RG351M, Odroid Go Advance Black Edition and
Odroid Go Super into dt bindings.

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

