Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2A5F5F62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJFDQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:16:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849084E64;
        Wed,  5 Oct 2022 20:16:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 70so610960pjo.4;
        Wed, 05 Oct 2022 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DUlRTZoc0RsOVgncUU5yNWbhwIH4A9T/yMlQroW7MfM=;
        b=ajpXiYgRrfUQXqf10Z4yXhIhgkM5OgpSvRkNqSSlbbcQVxJ+6lmZApC9oSSkcDkkmL
         g1+eeR3+AAoSzE3lrDOfdPzQDRVjv/932eDrszmqUwrO+jVk9vJ1XaRxo7CuhUAiJVnT
         hXz/1E+z7tDRbyE0oWKH62uLXVq+eSVhlC1lM+UTBGPissWuRfie/cRtCFnlgt5pU2MI
         FYwSVO3ee/JtwlqGoUfDHIEhU4xCGfT6swT0TIYaaZBSniPc58ZtMg15d1Zyg8pve4Dg
         4vRMmSF3VWfaWCzDlrmO7/FSTeftat7Z4BcN/QOR+SDlTXODVP6nMds3GApgKwEDyMFy
         96cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DUlRTZoc0RsOVgncUU5yNWbhwIH4A9T/yMlQroW7MfM=;
        b=e4JhE2fBTMdrar+CSGfMjnrFSfgz2XH+qRPIVO2QS8CkDq71NYtcPIsaOyUhYGWX6L
         w/K9cuLH8DS5ymxdFkXa1MwRtTjZjrRLP5kpA9kehRIRH+f8dCD1pSzngxM12xgF/XvP
         ck8xA2gRlGGc1vx75OnStPifK3Tv1cYI1rJM8RMu5/7d92lZ6cTgLVpmu45pNftN6QYx
         qBUU3cDupZeQ7UiLnvKQQZwvtxQLipeZzBLH7l6sbMRP2vtfbWzZxlapbYCEAlNhNcuA
         AZMd+wCBwgLjQGJBEJFo7UfYLWECBpz3bnEhNXlYlOg0MxuJUcoCk5y2Co6bOWSjFzWG
         exGg==
X-Gm-Message-State: ACrzQf2qezG/C5qGY4/3/4JVUNsL6ROVW4zq3GwNpc+2oKoE9A4pg6Tb
        z4Zx3Tf2d7ebKFBmmEnduls=
X-Google-Smtp-Source: AMsMyM42CpmEbZ0U5PH0pjz2YSckOJEDaZkrTyt+ASfGGUdLYK62t3yn9YxQjblaItO8hZ1HRa+kmg==
X-Received: by 2002:a17:90b:4d0e:b0:1f7:ae99:4d7f with SMTP id mw14-20020a17090b4d0e00b001f7ae994d7fmr8201587pjb.200.1665026211601;
        Wed, 05 Oct 2022 20:16:51 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-236-88.emome-ip.hinet.net. [42.73.236.88])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001783f964fe3sm8911166plh.113.2022.10.05.20.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 20:16:51 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: mt6370: Fix MT6370 LED indicator DT warning
Date:   Thu,  6 Oct 2022 11:16:13 +0800
Message-Id: <435f6888ebc20c5abae63eb9cb3a055b60db2ed1.1665050503.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add '$ref' and 'unevaluatedProperties: false' in 'multi-led', and remove
unused 'allOf' property.

Fixes: 440c57dabb45 ("dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator")
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../devicetree/bindings/leds/mediatek,mt6370-indicator.yaml          | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
index 204b103..16b3abc 100644
--- a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
@@ -13,9 +13,6 @@ description: |
   This module is part of the MT6370 MFD device.
   Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
 
-allOf:
-  - $ref: leds-class-multicolor.yaml#
-
 properties:
   compatible:
     const: mediatek,mt6370-indicator
@@ -29,6 +26,8 @@ properties:
 patternProperties:
   "^multi-led@[0-3]$":
     type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
-- 
2.7.4

