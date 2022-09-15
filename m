Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E65B91AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIOAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiIOAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:32:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D589829
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so6528279pjo.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wgA0pQDx3veU9g0AoVu5wc85WYVoT5GTHjt98pcKj9k=;
        b=mobLF2m/Bm7QflNMvTf+auy6gLr0+oTzSWRF5VlrT7aEbDZmRcWt9teXqQi2jq2qkY
         EEp2VqygMUUR9p8KdUkOcbIzGlaLM2bpGmJw3zft6RxbmRykjjJVdYeHoaQ6WbS2y0J/
         JU/DOwPF8/xYnMuYalPu99y65ebSYiGGOFxdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wgA0pQDx3veU9g0AoVu5wc85WYVoT5GTHjt98pcKj9k=;
        b=Fuxxi4SHnK17OaZBZKZCebw3hLo8SRLVbITgtkRpXDrm9Ee92PBYi/dDxXI+UKLItc
         JkF6mZCWOeP5RiIlCwjS/oaTJKvypnazEnl828tEKbN5wwY12iwsf4a7sbX1LmiLVpiu
         If1YPh1R8+5KShqmPF651/j977KXTWdhnSoZkT3ZCTxUMNUq3yQZQUCPDQyQMDPi68pP
         Yr7grXkk/JP/sENzDxTh4CxnCOdMnSGBN7Asbq89/KbFr8pz4LPSbcckazBQUYQUag2b
         RvaA2UlCvDxud2RyNpV6Z6+9B2PxmiNgvPG2EdfNWAJ/nWg0v/Imk/Xkojzfqr/zUBaV
         DV9A==
X-Gm-Message-State: ACrzQf09SPuDWN4XreOj0eSIXc3xqbknfPBkjJPNfrwGA9AjwopEQbH7
        XTPcYN3wo7dS+EtxYkfnoPFsEQ==
X-Google-Smtp-Source: AMsMyM4w69T/vqw4XP1OMabuKOrP+WlzN90PH8kVL60I39PX3eLtYbvrXFzq8OJAQLplRPaFbu7p6g==
X-Received: by 2002:a17:902:a418:b0:174:6711:92c1 with SMTP id p24-20020a170902a41800b00174671192c1mr1609699plq.146.1663201953163;
        Wed, 14 Sep 2022 17:32:33 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:347e:2a81:558b:d912])
        by smtp.gmail.com with ESMTPSA id 199-20020a6214d0000000b0053e22c7f135sm10991202pfu.141.2022.09.14.17.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:32 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/4 v4] dt-bindings: memory: Add numeric LPDDR compatible string variant
Date:   Wed, 14 Sep 2022 17:32:20 -0700
Message-Id: <20220915003222.1296421-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915003222.1296421-1-jwerner@chromium.org>
References: <20220915003222.1296421-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

