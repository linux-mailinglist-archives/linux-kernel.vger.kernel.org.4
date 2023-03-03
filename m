Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EBA6A973F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCCM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:29:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621634F7C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:29:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h8so2463280plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K67aK8Ab6zSc42er2APhm2wp24bW0xcr3MHHlTQF0Aw=;
        b=FWDRYekAJW0YOPHVCThvG+gS40Y/L7MmBGpsAFTvA86lKGRbhz5cuk10cQlWAEmU4a
         5qjnVvsNAgO201ARVXF58stdH+7rMGc1gVHltnfmp8XUIlpOhfALuClnQx4bFNl+5pry
         eMHaGFx8RRTR/yyyzl+K7ljCsKDplEnBNsNClamWViNp/7eZJyZ/jyaJT6sOuoBf0mid
         KxVgUw+afQEtCmuVzTAcsmtUVj1FxRs3TmzMFX8s2uHhj994a4URVvs5xAXntnI+im/N
         rF4rXVBiWMSwrm6gMfMVmcCCQBhChdEIp037ZBa3HOoTCzXgQmwTxq7suYEnLII5UxF9
         AHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K67aK8Ab6zSc42er2APhm2wp24bW0xcr3MHHlTQF0Aw=;
        b=OkAhiQicDNG5weMhOJ7usx4sylE+DBLBp5sfZcb7xRq0h0KwILN3P9cjtTQoFkYeTe
         lTVpQhrd6Dcv+dTL8UZd0YcnjTvP/K4yZe9Amj+6vzEBoMXzJwvvsmewp+xbcidyVvEc
         UY3zsJmNt3N2MWiklSBT9TDL0rtj152i3ynBWbR4Bich9WnjZsl4p/4VIowgRL3yXB8a
         DH9iBaockK2eXc/VwqXFbozaSMfwQ03DSH4zbl2HJSp/BWft/d/cffC8z/Vn3pOGwpey
         a2XhqdVWSZT3qW3736a/Bh3l2Lc9cW6aVF3UfteQT+WCY0+K4bXVNX2bQcLS2KIns/kq
         Ys4A==
X-Gm-Message-State: AO0yUKU1HWbWN4nDJF4lQ+/VtLhfgT0pGkMYF89dlJ4hG20UaYi9Sxdo
        o8XpdS5jLO4fimPztUwAj+Ph+i7naKb1VDM=
X-Google-Smtp-Source: AK7set8JZfJlqAxDs/MQ62UW2V/JqCm8gY0xitDzP+jEIKi/vPCiManpejAsTuviiRQtvZZymT98DA==
X-Received: by 2002:a17:90b:4c10:b0:229:2427:532f with SMTP id na16-20020a17090b4c1000b002292427532fmr1427272pjb.40.1677846577309;
        Fri, 03 Mar 2023 04:29:37 -0800 (PST)
Received: from localhost.localdomain ([117.207.30.104])
        by smtp.gmail.com with ESMTPSA id m20-20020a17090a859400b002342ccc8280sm1448325pjn.6.2023.03.03.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:29:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lee@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7] dt-bindings: leds: Document commonly used LED triggers
Date:   Fri,  3 Mar 2023 17:59:25 +0530
Message-Id: <20230303122925.6610-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the commonly used LED triggers by the SoCs. Not all triggers
are documented as some of them are very application specific. Most of the
triggers documented here are currently used in devicetrees of many SoCs.

While at it, add missing comments and also place the comment above the
triggers (hci, mmc, wlan) to match the rest of the binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v7:

* Rebased on top of next/master

Changes in v6:

* Rebased on top of lee/for-leds-next branch
* Fixed the comment location for few triggers

Changes in v5:

* Rebased on top of v6.2-rc1

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

 .../devicetree/bindings/leds/common.yaml      | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 15e3f6645682..61e63ed81ced 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -90,22 +90,49 @@ properties:
           - heartbeat
             # LED indicates disk activity
           - disk-activity
+            # LED indicates disk read activity
           - disk-read
+            # LED indicates disk write activity
           - disk-write
             # LED flashes at a fixed, configurable rate
           - timer
             # LED alters the brightness for the specified duration with one software
             # timer (requires "led-pattern" property)
           - pattern
+            # LED indicates mic mute state
+          - audio-micmute
+            # LED indicates audio mute state
+          - audio-mute
+            # LED indicates bluetooth power state
+          - bluetooth-power
+            # LED indicates activity of all CPUs
+          - cpu
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
           - usb-gadget
+            # LED indicates USB host activity
           - usb-host
+        # LED is triggered by CPU activity
       - pattern: "^cpu[0-9]*$"
-      - pattern: "^hci[0-9]+-power$"
         # LED is triggered by Bluetooth activity
-      - pattern: "^mmc[0-9]+$"
+      - pattern: "^hci[0-9]+-power$"
         # LED is triggered by SD/MMC activity
-      - pattern: "^phy[0-9]+tx$"
+      - pattern: "^mmc[0-9]+$"
         # LED is triggered by WLAN activity
+      - pattern: "^phy[0-9]+tx$"
 
   led-pattern:
     description: |
-- 
2.25.1

