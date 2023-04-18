Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3F6E67CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDRPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDRPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:07:27 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC010E6;
        Tue, 18 Apr 2023 08:07:26 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-38c35975545so448264b6e.1;
        Tue, 18 Apr 2023 08:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830445; x=1684422445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcqBimFCHj3MmeRz1Cnp48tZO7IirUdvbf3eVDP9RoM=;
        b=ZaCQZ5shw4fjL9v2H7uvi1oHpxPnHh6DvtqHjvDTnNa/0UkAG2UbBkSvTWTIc48LN1
         Z330zm2eHG+W0Vu+B1IdhweoBb9ZyxwEpkVMc3fAAnXtCPmj+1X5rPmpXEYO7Dv25CGc
         NoKPRRHGvkwcgO66vzHDodS6IGD0YmTCIAe49I6QOz0U/yOZB34mzNRHy0Jymb1df0br
         4YEWFR4iPnZX5DmeZhLaa0do9S9iaV1TBe5jPrX04bKtQpWJ689vTQwQc0Kyp3vi9m9Q
         n3hCac+21DWLPYcSEgHtEDD+b7+zk8IGUpUS8vxUJrt6xzQUmmSMPo9wHt17aY9cQrGF
         y9Aw==
X-Gm-Message-State: AAQBX9fbpVE2OI8datnRj1t9nt5bsHGAMKKN9lWNkO04oPPm/W/dUoQj
        E3/sVcDUqsVZ99wuiFbduw==
X-Google-Smtp-Source: AKy350aQFH3SOS8eGc5PQFYBNOKHnYlUX5aaxmlfxu9uN9d7QhO70k6+CIhwuq6LQRIL6vGeIxIbfg==
X-Received: by 2002:a05:6808:f12:b0:38c:5287:7c6d with SMTP id m18-20020a0568080f1200b0038c52877c6dmr1364330oiw.39.1681830445397;
        Tue, 18 Apr 2023 08:07:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z12-20020a056808064c00b0038cabdbe3a7sm3516244oih.3.2023.04.18.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:07:24 -0700 (PDT)
Received: (nullmailer pid 1536183 invoked by uid 1000);
        Tue, 18 Apr 2023 15:07:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Fix lvds.yaml references
Date:   Tue, 18 Apr 2023 10:06:57 -0500
Message-Id: <20230418150658.1535120-1-robh@kernel.org>
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

The trailing "/" in "lvds.yaml/#" is not a valid JSON pointer. The existing
jsonschema package allows it, but coming changes make allowed "$ref" URIs
stricter.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/panel/advantech,idk-1110wr.yaml | 2 +-
 .../devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml  | 2 +-
 .../devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml | 2 +-
 .../devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml | 2 +-
 Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 +-
 .../devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
index 3a8c2c11f9bd..f6fea9085aab 100644
--- a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
index 566e11f6bfc0..ab6b7be88341 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
index 5cf3c588f46d..3623ffa6518d 100644
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
index 54750cc5440d..37f01d847aac 100644
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index c77ee034310a..929fe046d1e7 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
index 2e75e3738ff0..e32d9188a3e0 100644
--- a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
@@ -12,7 +12,7 @@ maintainers:
 
 allOf:
   - $ref: panel-common.yaml#
-  - $ref: /schemas/display/lvds.yaml/#
+  - $ref: /schemas/display/lvds.yaml#
 
 select:
   properties:
-- 
2.39.2

