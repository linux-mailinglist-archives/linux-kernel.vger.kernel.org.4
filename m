Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD2469DE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjBULCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjBULB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:01:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D24233D4;
        Tue, 21 Feb 2023 03:01:56 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n5so2423434pfv.11;
        Tue, 21 Feb 2023 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOS6VgtuM5BqPENdBIhouoaipEZu9h+n3H+DKfeuN9Y=;
        b=TLxtJynMGRdzRPp/awcJXI43qNtQTH1fIdRh8AFqexUFzdqXmlvYbfoysTlU2rfyv9
         DwN089ygQIoj/PaQM5GYsFl68WWrsn6HZ4fsTUkhcn96BT2yLAdBQwMAhH3okSu3pn4H
         iG/p+oV1QjydwNcIJt+W4VxfC+2FYHkcvhAZe8iEkqnISI3hhf5zDysVDAn9yzZkqxjm
         OfrUGyiTVy+hK5DN5nQCwBBCmzjqD9XJ4sAEkBFryiHFAAzdFVu1wBAfvqKdtyKqgqkl
         cvH8KsDwpm8jhJhh6HkD2i7elYk3pU/w/F+ITIZnLo1KNovn+ZqpfvhT5ktRUP1r1x7z
         zAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOS6VgtuM5BqPENdBIhouoaipEZu9h+n3H+DKfeuN9Y=;
        b=fLquNZhITT8QA9Z6EtRLBnAbtkFqeSDKMuOLhZR5qAjuAmCNcasNCWYzPLlphLIP37
         N+tjhnFNXQzP2FH3w/EAuR1Cddw09FI8GWdfP5mzX3YEV8lPI94j+S3rFJwI9uthlabv
         W7KPOjMaevmuzT/Y9Ea2eDvG9O7UMkqzDE6kp9aO93SfORJere2jdh4VM781h1pGgNvg
         +hJudpA7YUWlpI1KUouX2HqbA3d5/OVXgWEx9aQD1NK5oOpSManHURGEZT/EROn7u6jp
         +7VP6iJfQRwGkMCBcxvZ/IspWV2hnnGMnM4fLsNynJOuIcOXRT0u5NrLgiLeMZ+aqJvM
         971A==
X-Gm-Message-State: AO0yUKXtPjgaElGFgKI2bj+DA7xN36NDnozZNOyXUI4qYON908v0xnG0
        +LvD9138l9d1nhXqlGLIZ1Y3QM6+S5O/Sg==
X-Google-Smtp-Source: AK7set9FKey3LlTtL85MrVoD7rcuTltQfF9fpUmBkVMmZK3k2fjNuqPjh42XVFU6KWI5rcaoWs4xXA==
X-Received: by 2002:a62:840e:0:b0:5a8:a467:f975 with SMTP id k14-20020a62840e000000b005a8a467f975mr3942553pfd.17.1676977315934;
        Tue, 21 Feb 2023 03:01:55 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7854d000000b005a8d396ae27sm9321034pfn.8.2023.02.21.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:01:55 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3] dt-bindings: mips: loongson: Add Loongson-1 based boards
Date:   Tue, 21 Feb 2023 19:01:42 +0800
Message-Id: <20230221110142.2121482-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add two Loongson-1 based boards: LSGZ 1B and Smartloong 1C.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Amend the vendor prefix
V1 -> V2: Add the according vendor prefix
          Change the board string to enum
          Modify the board description
---
 .../devicetree/bindings/mips/loongson/devices.yaml   | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml         |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
index f13ce386f42c..099e40e1482d 100644
--- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
@@ -37,6 +37,18 @@ properties:
         items:
           - const: loongson,loongson64v-4core-virtio
 
+      - description: LS1B based boards
+        items:
+          - enum:
+              - loongson,lsgz-1b-dev
+          - const: loongson,ls1b
+
+      - description: LS1C based boards
+        items:
+          - enum:
+              - loongmasses,smartloong-1c
+          - const: loongson,ls1c
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 0e57ae744199..5dadc7c76d92 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -757,6 +757,8 @@ patternProperties:
     description: Lontium Semiconductor Corporation
   "^loongson,.*":
     description: Loongson Technology Corporation Limited
+  "^loongmasses,.*":
+    description: Nanjing Loongmasses Ltd.
   "^lsi,.*":
     description: LSI Corp. (LSI Logic)
   "^lwn,.*":

base-commit: 39459ce717b863556d7d75466fcbd904a6fbbbd8
-- 
2.34.1

