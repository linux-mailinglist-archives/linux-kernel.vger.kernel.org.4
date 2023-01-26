Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BECB67D413
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAZSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjAZSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:24:54 -0500
Received: from out-106.mta0.migadu.com (out-106.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692595A350
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:24:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Rayyan Ansari <rayyan@ansari.sh>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 2/2] dt-bindings: display: simple-framebuffer: Document the panel node
Date:   Thu, 26 Jan 2023 18:24:35 +0000
Message-Id: <20230126182435.70544-3-rayyan@ansari.sh>
In-Reply-To: <20230126182435.70544-1-rayyan@ansari.sh>
References: <20230126182435.70544-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new panel node and what it is used for.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 .../devicetree/bindings/display/simple-framebuffer.yaml  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index dd64f70b5014..4e10a100b6c8 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -26,6 +26,11 @@ description: |+
   over control to a driver for the real hardware. The bindings for the
   hw nodes must specify which node is considered the primary node.
 
+  If a panel node is given, then the driver uses this to configure the
+  physical width and height of the display. If no panel node is given,
+  then the driver uses the width and height properties of the simplefb
+  node to estimate it.
+
   It is advised to add display# aliases to help the OS determine how
   to number things. If display# aliases are used, then if the simplefb
   node contains a display property then the /aliases/display# path
@@ -110,6 +115,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: Primary display hardware node
 
+  panel:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Display panel node
+
   allwinner,pipeline:
     description: Pipeline used by the framebuffer on Allwinner SoCs
     enum:
-- 
2.39.1

