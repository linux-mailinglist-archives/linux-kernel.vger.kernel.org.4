Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D16CAB48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjC0RCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjC0RB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:58 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F943AB1;
        Mon, 27 Mar 2023 10:01:53 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so4879203oti.13;
        Mon, 27 Mar 2023 10:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8thxkCxhQ4w8ZrYXYbphu5VfpY+v0rzWJw1ucTh4OsQ=;
        b=zoDosFcpOM60/el5avPquThfFfwZ8AanqRZo/rCqWri0JCx+JaDEnMPAOTCIjJnkoE
         IpRF4cbVi5YW31WsutfKomGHzbletvxhMFhsH5NdzSm72AhVhAlbSejAyTPfuPwYEkVf
         z2PoFj7OAts/cQ4ZXHtNjUAfrYr4V186ZVsWD0xx4bcNGzKxuimbhGyIyUyatLBcJ0l/
         gAAR8/0wmFUAWJHr83iJSoNH3yt2yKSgDo1nN0LEaR46mAGaiWmndAXhKyRwSrrLXUJZ
         BJEw1FyxRE4ihEiTOdRtUrRCNAZe2r7xx88H6YGCZdbiLju1WQLUZck/vpVT9a9+CnQ/
         2ACA==
X-Gm-Message-State: AO0yUKWhkZ/ReL0joqFw+JDjQh9tbeNhFvWDPqyCDwvzCwvsprvDqW6o
        Ny1js0vct1VNrTY4h6Pj6R3OeAAmng==
X-Google-Smtp-Source: AK7set/6iTCH/LyMo818dTIV9VQpMfn/2XvqF8VH4quka+5tgnEXKlN4nsdlcLJqh8EaxCScKx17zg==
X-Received: by 2002:a05:6830:1044:b0:684:e788:eca9 with SMTP id b4-20020a056830104400b00684e788eca9mr6237557otp.17.1679936512455;
        Mon, 27 Mar 2023 10:01:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a056830130e00b006a14579a8besm892360otq.43.2023.03.27.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:51 -0700 (PDT)
Received: (nullmailer pid 4105557 invoked by uid 1000);
        Mon, 27 Mar 2023 17:01:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:01:45 -0500
Message-Id: <20230327170146.4104556-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml        | 2 +-
 Documentation/devicetree/bindings/timer/cdns,ttc.yaml         | 2 +-
 .../devicetree/bindings/timer/intel,ixp4xx-timer.yaml         | 4 ++--
 .../devicetree/bindings/timer/nvidia,tegra-timer.yaml         | 4 ++--
 .../devicetree/bindings/timer/nvidia,tegra186-timer.yaml      | 4 ++--
 Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml   | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
index f6efa48c4256..7a4a6ab85970 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
@@ -66,7 +66,7 @@ patternProperties:
     description: A timer node has up to 8 frame sub-nodes, each with the following properties.
     properties:
       frame-number:
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 7
 
diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index 7d821fd480f6..bc5e6f226295 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -28,7 +28,7 @@ properties:
     maxItems: 1
 
   timer-width:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Bit width of the timer, necessary if not 16.
 
diff --git a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
index f32575d4b5aa..526b8db4d575 100644
--- a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
@@ -2,8 +2,8 @@
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/timer/intel,ixp4xx-timer.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/timer/intel,ixp4xx-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel IXP4xx XScale Networking Processors Timers
 
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
index b78209cd0f28..9ea2ea3a7599 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra timer
 
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
index db8b5595540f..76516e18e042 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra186 timer
 
diff --git a/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
index 901848d298ec..fa65878b3571 100644
--- a/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
+++ b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
@@ -2,8 +2,8 @@
 # Copyright 2022 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/timer/st,nomadik-mtu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/timer/st,nomadik-mtu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ST Microelectronics Nomadik Multi-Timer Unit MTU Timer
 
-- 
2.39.2

