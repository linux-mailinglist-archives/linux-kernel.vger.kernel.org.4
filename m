Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A16D98B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbjDFN4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbjDFNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:55:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD297DB6;
        Thu,  6 Apr 2023 06:55:57 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA08F66031C6;
        Thu,  6 Apr 2023 14:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680789355;
        bh=W4pm7BiBZzCNtmBw7yfWi0gmijbJLmhZ0zJHi7gtiZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4jqqxFFCSN9jI5by86a3XBG0nvryawKyqbVhlA1I3wXYNx1nbY4x0IBNvyYuZ2Zm
         GoDEvtydi+xPYNqSFBHa1bveCRN4TpafOEwSFKN8u4+m4BuBLo54NrTle58HU7rzfD
         Iw5ypr+NbLWrgaDw1EhCd7miLY92LoyxG4iLV+auZv/0YdegvrFjj3J4UeCZo/Dq9v
         5h+wMQYLS4ar8V2urjGvmoUaxEpgJx4q8whNRNkWaiGOWVz2TdzFeAhaq1cVQS1EKH
         I/gnZXP2kGP4WuX1zuLgyfvciGf9kW6KZ1fytxEtKTWu63Ij/8bQclOsRZq/ASDkv3
         HEkSBWZUyg5bA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E7C8A4807E0; Thu,  6 Apr 2023 15:55:52 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Date:   Thu,  6 Apr 2023 15:55:50 +0200
Message-Id: <20230406135552.23980-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406135552.23980-1-sebastian.reichel@collabora.com>
References: <20230406135552.23980-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for RK3588 OHCI. As far as I know it's fully
compatible with generic-ohci.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/usb/generic-ohci.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index a9ba7257b884..e116ed90471e 100644
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
@@ -147,6 +148,21 @@ allOf:
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
+          maxItems: 4
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 3
 
 additionalProperties: false
 
-- 
2.39.2

