Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E85F15C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiI3WG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiI3WGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:06:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2BDED58
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c198so5351185pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=iCjsg2P6rP+EOnKp8OLBU0BfWRzD3b14JMZ4HtOWs24=;
        b=cbu4jNnEDv+apb4pzraryzWuGPoblZA4nu2doYnYqBmJF2boRTZ3jrDqL+d+9gIt+4
         wyUKfWG2bCf0HiC15XlguZFHOVznni6Nlr2AC64gRfR6dYPNa06ez1ePfpWsWJT7osUW
         jtKO5EROjwFHJ3mDwgrrepc3o+ZZaBcCleirE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iCjsg2P6rP+EOnKp8OLBU0BfWRzD3b14JMZ4HtOWs24=;
        b=nH84HegQN/ytru9A3ssUTzjuDS+gMSGcQcxNVF/FBgUSTzZml/6nzdJrfFC9W4EPeo
         maV6yMdv14z9LWRvRCiaiBGU0tanw9Vq6Kc6I2InGSxG/lNBiPaDPb/81I2YYmzsIitN
         xZGgNiAf+lQCtGDU3efuYvUJVIp/PP/A0IzinWd9cD9oxSjn9PhXL42owvE90xOJeFJr
         FTXEHyU3VnoxvHKTMFvInYJAgVZr6uTl2mx0syQal2zuZVSagvfBw0mP0jf8HfxwVfNv
         Nf8LmTv6TEMqhg66FlsSsGE0yBPosUxdm95MhD6t+nnVJDatwWcH4a9moLR8wLkCzdKE
         IJ7g==
X-Gm-Message-State: ACrzQf0kk3Lu3/CXSdYQB9T6dncPC30PTxljxAUjlR3Qlke8y5Ax7nlN
        msx/96+S+ULIkVFeMfhtYSUIjg==
X-Google-Smtp-Source: AMsMyM5Q18jDBYh5fuJNE0t4W0Z/I5EiMvVgT02Yd9F+BoG2hc0teb8si7tQgz5S5gHcQkBUC72u9A==
X-Received: by 2002:a62:1e83:0:b0:545:6896:188 with SMTP id e125-20020a621e83000000b0054568960188mr11120425pfe.51.1664575574662;
        Fri, 30 Sep 2022 15:06:14 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:9d:2:ab9d:610e:ee54:d4ca])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b001facf455c91sm5769364pjk.21.2022.09.30.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:06:14 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/4 v5] dt-bindings: memory: Add numeric LPDDR compatible string variant
Date:   Fri, 30 Sep 2022 15:06:04 -0700
Message-Id: <20220930220606.303395-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930220606.303395-1-jwerner@chromium.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows a new kind of compatible string for LPDDR parts in the
device tree bindings, in addition to the existing hardcoded
<vendor>,<part-number> strings. The new format contains manufacturer and
part (revision) information in numerical form, such as lpddr3-ff,0201
for an LPDDR3 part with manufacturer ID ff and revision ID 0201. This
helps cases where LPDDR parts are probed at runtime by boot firmware and
cannot be matched to hardcoded part numbers, such as the firmware on the
qcom/sc7280-herobrine boards does (which supports 4 different memory
configurations at the moment, and more are expected to be added later at
a point where the boot firmware can no longer be updated to specifically
accomodate them).

Signed-off-by: Julius Werner <jwerner@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../memory-controllers/ddr/jedec,lpddr-props.yaml    | 10 ++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml         |  8 +++++---
 .../memory-controllers/ddr/jedec,lpddr3.yaml         | 12 ++++++++----
 3 files changed, 23 insertions(+), 7 deletions(-)

Changelog:

- v2
  - Updated commit message to describe intended use case as an example
- v3
  - no changes
- v4
  - no changes
- v5
  - updated acked-by list

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 02700ac3c387ec..4114cfa8de67f1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -15,6 +15,16 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
+  compatible:
+    description:
+      Compatible strings can be either explicit vendor names and part numbers
+      (e.g. elpida,ECB240ABACN), or generated strings of the form
+      lpddrX-YY,ZZZZ where X is the LPDDR version, YY is the manufacturer ID
+      (from MR5) and ZZZZ is the revision ID (from MR6 and MR7). Both IDs are
+      formatted in lower case hexadecimal representation with leading zeroes.
+      The latter form can be useful when LPDDR nodes are created at runtime by
+      boot firmware that doesn't have access to static part number information.
+
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index e5e15d288d89b2..a237bc259273bf 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -20,13 +20,15 @@ properties:
               - elpida,ECB240ABACN
               - elpida,B8132B2PB-6D-F
           - enum:
-              - jedec,lpddr2-s4
-      - items:
-          - enum:
+              - jedec,lpddr2-nvm
               - jedec,lpddr2-s2
+              - jedec,lpddr2-s4
       - items:
+          - pattern: "^lpddr2-[0-9a-f]{2},[0-9a-f]{4}$"
           - enum:
               - jedec,lpddr2-nvm
+              - jedec,lpddr2-s2
+              - jedec,lpddr2-s4
 
   revision-id1:
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 0f7ab51842ae09..e328a1195ba646 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -14,10 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - samsung,K3QF2F20DB
-      - const: jedec,lpddr3
+    oneOf:
+      - items:
+          - enum:
+              - samsung,K3QF2F20DB
+          - const: jedec,lpddr3
+      - items:
+          - pattern: "^lpddr3-[0-9a-f]{2},[0-9a-f]{4}$"
+          - const: jedec,lpddr3
 
   '#address-cells':
     const: 1
-- 
2.31.0

