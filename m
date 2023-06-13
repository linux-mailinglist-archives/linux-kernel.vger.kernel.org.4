Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E472ECA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjFMUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjFMULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:11:42 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A12100;
        Tue, 13 Jun 2023 13:11:23 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33dae9244a1so26220725ab.0;
        Tue, 13 Jun 2023 13:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687082; x=1689279082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMVh+zJOgPqDKyoOp2YotBxKUzQ/IGweQ3mdvJwSkLQ=;
        b=L/Qt022Yo34U4P5M0pPCBWC+a61eEm5ZaOoNYTCoLXEdZ8g1W9eZu6ph+ZoiuNz9QL
         2imWY++VVjoSF5A3MvYucIwEKESiUoogNh/QgCjm1y6lQtvC8AOSgWkNptAseGPb5/z8
         fFJmebflEuFc4QEsDBX1wtkjyxVcqwYJPvOXNvPH9m/8WYHmN6zNkziqh1Rti8zx4ubs
         BRtjusVETYAzrreGyGjxKXR9+gmevCAoBvWzHPjGtzl7NJuzuSdVSfBjOibEExvkmwoO
         pQZuhmIHBzCl8eEGZgDdf45A7CEPCrHmA0p+np6TlSgHg3cOR2U+8kN0LSp7iwfNSR5X
         Yxow==
X-Gm-Message-State: AC+VfDxArWjvl8+OfNGDZYa+tR1N4mowlxCrgD/fSqeIEUJzVSd+yJpp
        ZE+SQsHtC6qBX8NTA80mKA==
X-Google-Smtp-Source: ACHHUZ7trQEUyTsH2/4qCfXy9q8VWFel7Oj5LuNBTzxv4rqOJqvR46PwWVrn/5foWVVIHRbL3zU2DQ==
X-Received: by 2002:a05:6e02:12e2:b0:334:fa57:e670 with SMTP id l2-20020a056e0212e200b00334fa57e670mr12729137iln.0.1686687082081;
        Tue, 13 Jun 2023 13:11:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c809000000b00313ca4be5e1sm4102979iln.12.2023.06.13.13.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:11:21 -0700 (PDT)
Received: (nullmailer pid 2824760 invoked by uid 1000);
        Tue, 13 Jun 2023 20:11:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Add missing property types
Date:   Tue, 13 Jun 2023 14:11:14 -0600
Message-Id: <20230613201114.2824626-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of display bridge properties are missing a type definition. Add
the types to them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/bridge/analogix,dp.yaml          | 1 +
 .../devicetree/bindings/display/bridge/nxp,tda998x.yaml          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
index c9b06885cc63..62f0521b0924 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
@@ -26,6 +26,7 @@ properties:
     const: dp
 
   force-hpd:
+    type: boolean
     description:
       Indicate driver need force hpd when hpd detect failed, this
       is used for some eDP screen which don not have a hpd signal.
diff --git a/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml b/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
index c4bf54397473..21d995f29a1e 100644
--- a/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
@@ -20,6 +20,7 @@ properties:
     maxItems: 1
 
   video-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32
     default: 0x230145
     maximum: 0xffffff
     description:
-- 
2.39.2

