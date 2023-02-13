Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2722693EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBMHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBMHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:08:42 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90C5EC7B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:08:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id o8so10192800pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWV82DuffbkA0r5SzgnRHGJAxs9Uwsl2YwXW0fT+d6A=;
        b=lc0mtwktj97AGn6slIN6qa4ekwhfOSJOQz1xrvCLNdqmifyDg6ccIbdrSRMHZJ2N4y
         GgNyvvpP/MLpR9aHTuWsM5kVFRQ41KVWZDIrB+T7N4lNAX0q2tZC+3WIcopUPmnbKNQS
         //5zkBpFNA8sBxa9f2MbH1vHtqMiqhl+LJXvwwFqdzAV2HwX4paawmnw9iFCAofl+A2C
         zzR1G3NyCojdvCIPGnRaIX1MnI/rRza6a0GU5wvVDYm5PMuefjD6ykp2/MsDq/yp7KkI
         E/OpjFkTTi7miqWnDbV132A7mzZ/iQNgp3pOBXKDTIuXNOtSdDqg+7uykmJUqPNg3E7z
         El/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWV82DuffbkA0r5SzgnRHGJAxs9Uwsl2YwXW0fT+d6A=;
        b=a8xd0u+KNujG8WmU4USQg3vKnTM+vtdMB+GZgNZgIWajEmi/zwG/IbHeGRvrqzk879
         sKg1ILAwZHSC9KjYycaDjc5HxFCrRQPU8bZ4a/BoDCIlGzlCGm5uqV50hLd6QXP46b5d
         WGLLf3WS5Nr+5jn+r+I+MLJgpCR0CxdXRvjPtf4cPTVxer4ushERF9FVy18QClCBN6UF
         SrdbLbp5MgqwZVo445S8Cat723euCyz9nN6KULsvUTowzYBSrDwF5FUd7WgT94uluDmY
         PMPy0grBWnvtriZ2WVLnsvyC30QLCuexFcB+Q+pTw4veApIfQRivaH8LAF6bI4JBqduP
         Y0qg==
X-Gm-Message-State: AO0yUKVzluyTehQL/gahhel9ZUJGpnK6ImSjm6FC5emNAnLPlUXT4kzR
        DPWquedinsDr+DI3RKrYJQYrhoKw7vmJF9c=
X-Google-Smtp-Source: AK7set9xE1GSDfppqMxOGUxzD8jTRdTKOx+EBwnuawNQ/I0UUpOwkbs79SdmOQPsW6ClvlF6K7Rz2g==
X-Received: by 2002:a17:90b:4c4d:b0:22c:9217:68b6 with SMTP id np13-20020a17090b4c4d00b0022c921768b6mr25368845pjb.14.1676272120356;
        Sun, 12 Feb 2023 23:08:40 -0800 (PST)
Received: from localhost.localdomain ([117.217.182.252])
        by smtp.gmail.com with ESMTPSA id w63-20020a17090a6bc500b00230e41e98desm2956183pjj.32.2023.02.12.23.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 23:08:39 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, thunder.leizhen@huawei.com,
        festevam@gmail.com, lee@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5] dt-bindings: leds: Document commonly used LED triggers
Date:   Mon, 13 Feb 2023 12:38:27 +0530
Message-Id: <20230213070827.5085-1-manivannan.sadhasivam@linaro.org>
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

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

 .../devicetree/bindings/leds/common.yaml      | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index f5c57a580078..d01a52e9e982 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -98,9 +98,44 @@ properties:
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
         # LED is triggered by SD/MMC activity
       - pattern: "^mmc[0-9]+$"
+        # LED is triggered by CPU activity
       - pattern: "^cpu[0-9]*$"
+        # LED indicates power status of [N]th Bluetooth HCI device
+      - pattern: "^hci[0-9]{1,2}-power$"
+        # LED indicates [N]th WLAN Tx/Rx activity
+      - pattern: "^phy[0-9]{1,2}(tx|rx)$"
 
   led-pattern:
     description: |
-- 
2.25.1

