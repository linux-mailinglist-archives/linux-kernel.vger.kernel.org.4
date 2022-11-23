Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3A6351FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiKWILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiKWILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:11:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA18EA12B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:11:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id k15so16674268pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NTCDnzWfKnUH4xHEjqzAK0T2MTpEXrV37vZtrLItqWs=;
        b=nRzoejAKVDLAwaO9LdIS5khO8+7zffW/9x99UrgnvAUgQIsX8FgLOrLMVOgIY9Blt8
         /kFL8n9zrMakBMhDmOVLLrjQTQxj/wkqKyocO1I1qtqXmlWWFbh1Gwd0JvadFXjsfhze
         CmvhtyJtxoxmGvREJck3IcacUG3sh59lCjS4Qo/vefG71yL2TNgbu6qJoNmZc6cNKwNO
         DBu+/oYEWF8zW6mhlDgvXXTcUnkkubjqzjTvYNimpQ63JONWB9e9OxJ1cQjHVExKfdhU
         +QgdZf6XyyjvBjHcSjAbpqxv7cDVoDYy5UP0liTnWl9DUvw2b1SYPlvRFzwwxSoRdPKw
         5kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTCDnzWfKnUH4xHEjqzAK0T2MTpEXrV37vZtrLItqWs=;
        b=fXL+s4kM0Nc2seS76ciLlQhhUfprGWOlHOv1JMPfM5IsWD+d93jitHrexixcn1R4ZO
         5TSnEi/7wAMYg7ZO9Fuj6srmRPqlBes1GTcRNYWYfpnDysl1etCyyOYMZKJ/6LVemIWG
         Y9tby2SX+1QngDQpdjUHUhQdGdCmDDsd6LYVV5VU4D9QVtx0fMQD0R/hG9wQB/bT37Kc
         QzoBkQBRO7+gH/Dhp1FSdsHFt0SIBXt3nLxrmKZB5Vfvm6bKAJb9vmcbN+7pnxNAJV6c
         1r2vCjXddwlA1eziAjbKvMpKC4aNKIfr0ECa6Z7gXA9/cLX/vK/Cf+2zIqehheVHPtHs
         XPXQ==
X-Gm-Message-State: ANoB5pkuqyLd6rG5LLLTN9Umqh9yuBWTRDtu0ny4OH0KFkPJhdl5mF+W
        cuxCxjUJmU0P2ZrxagGXvk8RBQuXbWjK
X-Google-Smtp-Source: AA0mqf4BXuHa+N5rUQuKScaj5YnLWOOi4fnx2R1HRVYFr4XJE7e5Ln9rR1xeDGmEcQk/OGAOsvxf6g==
X-Received: by 2002:aa7:93c2:0:b0:56d:8145:3faa with SMTP id y2-20020aa793c2000000b0056d81453faamr7943384pff.75.1669191088650;
        Wed, 23 Nov 2022 00:11:28 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00186c3af9644sm13496840plg.273.2022.11.23.00.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:11:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3] dt-bindings: leds: Document commonly used LED triggers
Date:   Wed, 23 Nov 2022 13:41:12 +0530
Message-Id: <20221123081112.97150-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit documents the LED triggers used commonly in the SoCs. Not
all triggers are documented as some of them are very application specific.
Most of the triggers documented here are currently used in devicetrees
of many SoCs.

While at it, let's also sort the triggers in ascending order.

Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v3:

* Rebased on top of v6.1-rc1
* Added WLAN Rx trigger
* Added tested tag from Zhen Lei

Changes in v2:

* Added more triggers, fixed the regex
* Sorted triggers in ascending order

 .../devicetree/bindings/leds/common.yaml      | 79 ++++++++++++++-----
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 3c14a98430e1..0ffed6bcbefd 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -80,26 +80,65 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string
 
     oneOf:
-      - enum:
-            # LED will act as a back-light, controlled by the framebuffer system
-          - backlight
-            # LED will turn on (but for leds-gpio see "default-state" property in
-            # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
-          - default-on
-            # LED "double" flashes at a load average based rate
-          - heartbeat
-            # LED indicates disk activity
-          - disk-activity
-            # LED indicates IDE disk activity (deprecated), in new implementations
-            # use "disk-activity"
-          - ide-disk
-            # LED flashes at a fixed, configurable rate
-          - timer
-            # LED alters the brightness for the specified duration with one software
-            # timer (requires "led-pattern" property)
-          - pattern
-        # LED is triggered by SD/MMC activity
-      - pattern: "^mmc[0-9]+$"
+      - items:
+          - enum:
+                # LED indicates mic mute state
+              - audio-micmute
+                # LED indicates audio mute state
+              - audio-mute
+                # LED will act as a back-light, controlled by the framebuffer system
+              - backlight
+                # LED indicates bluetooth power state
+              - bluetooth-power
+                # LED indicates activity of all CPUs
+              - cpu
+                # LED will turn on (but for leds-gpio see "default-state" property in
+                # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
+              - default-on
+                # LED indicates disk activity
+              - disk-activity
+                # LED indicates disk read activity
+              - disk-read
+                # LED indicates disk write activity
+              - disk-write
+                # LED indicates camera flash state
+              - flash
+                # LED "double" flashes at a load average based rate
+              - heartbeat
+                # LED indicates IDE disk activity (deprecated), in new implementations
+                # use "disk-activity"
+              - ide-disk
+                # LED indicates MTD memory activity
+              - mtd
+                # LED indicates NAND memory activity (deprecated),
+                # in new implementations use "mtd"
+              - nand-disk
+                # No trigger assigned to the LED. This is the default mode
+                # if trigger is absent
+              - none
+                # LED alters the brightness for the specified duration with one software
+                # timer (requires "led-pattern" property)
+              - pattern
+                # LED flashes at a fixed, configurable rate
+              - timer
+                # LED indicates camera torch state
+              - torch
+                # LED indicates USB gadget activity
+              - usb-gadget
+                # LED indicates USB host activity
+              - usb-host
+      - items:
+            # LED indicates activity of [N]th CPU
+          - pattern: "^cpu[0-9]{1,2}$"
+      - items:
+            # LED indicates power status of [N]th Bluetooth HCI device
+          - pattern: "^hci[0-9]{1,2}-power$"
+      - items:
+            # LED indicates [N]th MMC storage activity
+          - pattern: "^mmc[0-9]{1,2}$"
+      - items:
+            # LED indicates [N]th WLAN Tx/Rx activity
+          - pattern: "^phy[0-9]{1,2}(tx|rx)$"
 
   led-pattern:
     description: |
-- 
2.25.1

