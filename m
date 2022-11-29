Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF563C6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiK2Rtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbiK2RtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:49:21 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB302697FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:49:19 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k7so14140827pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=70/eD63Y0IWUOAJT90ZgbeWA+KDFcK6DEdj8lIs5MAg=;
        b=rQaHWhcip1/xyHCotaGLRwF25yKo8TFHi9SEEUV427xcEckhP0gJHXTSQvWF2dV+ml
         ZL0FtTFWyPNXMsefQSzmEj4p56pxvDb+0cTBu5IQnD3QFMkKyqYtItaZjaKHdND/DirZ
         kGq7qPM30uCsPFLxQbw+kXffbVOpPal9IYwtTcE94iu0aP11dzInOH13gMQRbXUfvmga
         4CKVhYkKRJ0LfOrDYJhTlbO1KVHGENc9rzsXCW8qkdz9ljtTghwgOBlRiJcZiG+8z3b/
         9zLRTSKJBbKXvnYSb+0x+8J7Ig4HrTiAVn0YBWPpeayvVjyUr9LBSXV+Vfsi0OOkaToA
         t42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70/eD63Y0IWUOAJT90ZgbeWA+KDFcK6DEdj8lIs5MAg=;
        b=RQIT10FI7h+e2B6Wv8eIBhPQ+uorH9INSMLMFR4gfl6Dic/8QTMzS/+X+4YqxtY76K
         ja6tcKZZtt7wxfQzi02kqq5duK3iP6supCZGN0Kqx1T21jmqcPmOEXjtGkMo6uOfIKlm
         1Yo6dfBZ3Bi0ZD6SezZtzCbcLRLaiuyB0cZeV+mwX160DKmO3XXFCHHj5C157422yW91
         6iOyAoRN9Ga/IlgomOYZ1bFumFniE8kU2khYX/uJmk+qLDfk/KZcda5cPZPLCn3wCSVr
         JRWc8Z9ZRGf4KXpHaJgMpkxIhUePyMboM9m8RrEgd3VkCcXsQPCIljjQyndbQb6ZuHKM
         2FOg==
X-Gm-Message-State: ANoB5plsC2ospm5EV0FdxhV3Bq2bFPrTwS312EpiYevB8oxwcjEZpg2r
        /zBj3jjENDhgP35YJDRoI2ah
X-Google-Smtp-Source: AA0mqf5SwjQeTa2dWnKTNHmaU1s3XfC5hwfF4g4aDmQFAllp89FcBTKVsFagRH08lOFJwwfoy3snOQ==
X-Received: by 2002:a17:903:2112:b0:186:cf82:91d5 with SMTP id o18-20020a170903211200b00186cf8291d5mr51332655ple.87.1669744159116;
        Tue, 29 Nov 2022 09:49:19 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.207])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0016d9b101413sm11176333plk.200.2022.11.29.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 09:49:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
Date:   Tue, 29 Nov 2022 23:19:06 +0530
Message-Id: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
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

Document the commonly used LED triggers by the SoCs. Not all triggers
are documented as some of them are very application specific. Most of the
triggers documented here are currently used in devicetrees of many SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v4:

* Removed the sorting of triggers
* Removed the "items" as they were not needed
* Reworded the description
* Dropped Zhen Lei's tested-by tag as the patch has changed
* Added kbd-capslock trigger

Changes in v3:

* Rebased on top of v6.1-rc1
* Added WLAN Rx trigger
* Added tested tag from Zhen Lei

Changes in v2:

* Added more triggers, fixed the regex
* Sorted triggers in ascending order

 .../devicetree/bindings/leds/common.yaml      | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 3c14a98430e1..68da651f29a8 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -98,8 +98,44 @@ properties:
             # LED alters the brightness for the specified duration with one software
             # timer (requires "led-pattern" property)
           - pattern
-        # LED is triggered by SD/MMC activity
-      - pattern: "^mmc[0-9]+$"
+            # LED indicates mic mute state
+          - audio-micmute
+            # LED indicates audio mute state
+          - audio-mute
+            # LED indicates bluetooth power state
+          - bluetooth-power
+            # LED indicates activity of all CPUs
+          - cpu
+            # LED indicates disk read activity
+          - disk-read
+            # LED indicates disk write activity
+          - disk-write
+            # LED indicates camera flash state
+          - flash
+            # LED indicated keyboard capslock
+          - kbd-capslock
+            # LED indicates MTD memory activity
+          - mtd
+            # LED indicates NAND memory activity (deprecated),
+            # in new implementations use "mtd"
+          - nand-disk
+            # No trigger assigned to the LED. This is the default mode
+            # if trigger is absent
+          - none
+            # LED indicates camera torch state
+          - torch
+            # LED indicates USB gadget activity
+          - usb-gadget
+            # LED indicates USB host activity
+          - usb-host
+        # LED indicates [N]th MMC storage activity
+      - pattern: "^mmc[0-9]{1,2}$"
+        # LED indicates activity of [N]th CPU
+      - pattern: "^cpu[0-9]{1,2}$"
+        # LED indicates power status of [N]th Bluetooth HCI device
+      - pattern: "^hci[0-9]{1,2}-power$"
+        # LED indicates [N]th WLAN Tx/Rx activity
+      - pattern: "^phy[0-9]{1,2}(tx|rx)$"
 
   led-pattern:
     description: |
-- 
2.25.1

