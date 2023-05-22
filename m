Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9570C366
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjEVQaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjEVQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:29:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93225FA;
        Mon, 22 May 2023 09:29:42 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1957F660574E;
        Mon, 22 May 2023 17:29:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684772981;
        bh=j75Fix14GedNdNrwK2bcD4ZQfvMbaum/N3+IZtFmhEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OX6aF2uih1iaaBUnPEMBC08XwCCSTO6pSkKXqT0+iZlpjCL89pXmHK0OyBqwdW0wy
         NmzFFcSzWZ1KGLWpAO5ZvZ6cYtK814Mq3I/GW2mL2P3zrJ0u/kdfo6GSL0NsTa/8rr
         O+xR6KC6DazP8IV8fSXNa4AHClCDw6sdMyB2oAdocBRXX+FJi1Gekn6gS5dObKYyZZ
         oimyBbb+wlB2n7QG3ht4h78F0u5F67xzyMVV7zVF5GNJFctJ7rzrBoxm6rzH/QH0+C
         vo34kUVpfHo0F2eI+lhNiLgFPUGeRVTU+D6AKs7869tI4/gRosaM0gZ/9TBRtyvgoJ
         9SNfA8lQJX5uQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id F11254807E0; Mon, 22 May 2023 18:29:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: usb: Add RK3588 OHCI
Date:   Mon, 22 May 2023 18:29:35 +0200
Message-Id: <20230522162937.53190-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522162937.53190-1-sebastian.reichel@collabora.com>
References: <20230522162937.53190-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for RK3588 OHCI. As far as I know it's fully
compatible with generic-ohci.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/usb/generic-ohci.yaml   | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index d06d1e7d8876..be268e23ca79 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -44,6 +44,7 @@ properties:
               - hpe,gxp-ohci
               - ibm,476gtr-ohci
               - ingenic,jz4740-ohci
+              - rockchip,rk3588-ohci
               - snps,hsdk-v1.0-ohci
           - const: generic-ohci
       - enum:
@@ -69,7 +70,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 4
     description: |
       In case the Renesas R-Car Gen3 SoCs:
         - if a host only channel: first clock should be host.
@@ -147,6 +148,20 @@ allOf:
     then:
       properties:
         transceiver: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-ohci
+    then:
+      properties:
+        clocks:
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 3
 
 unevaluatedProperties: false
 
-- 
2.39.2

