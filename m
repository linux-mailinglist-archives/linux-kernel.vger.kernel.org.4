Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D336D65D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjDDOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjDDOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:53:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F519E58;
        Tue,  4 Apr 2023 07:53:55 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-190-097.ewe-ip-backbone.de [91.248.190.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1293660316A;
        Tue,  4 Apr 2023 15:53:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680620033;
        bh=IZgsXXkUIeK+MqZv4Hy7oH9grr/jB03TfUzCnGkU6tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFX5Z5MtuoVFp1ihqnPYgnJvFgAOTjQWXVieK/Fgma1T+WTM0T6VFJoZjIx2k442z
         qNTBdZHzLeDihhnHvIoQceO8HCmRQ5oXzk/5jFS6bPkBw7jHeVa44EZgP8yqwQ9lmA
         s1+tFZpfjF4sg1kTh4Qf+KhvhckGAJ6v2lvQ6DekPgznPIwmM9XdTfdRVOnDakfUvU
         GC5F8khxJj05l38j4uJ6Yfdx641hQdWw8yJBdlXqG4cE5LeuO3vjWGAab3nFanLfUP
         E20H7YS0+G3Yvt3ulwWisNBBIH6Gnhdzpiz23fSeaZgwpmp6ODTo61iP4qHpUyq2PP
         f3w42dcYo0DWg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id BAD2F4807E0; Tue,  4 Apr 2023 16:53:51 +0200 (CEST)
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
Date:   Tue,  4 Apr 2023 16:53:48 +0200
Message-Id: <20230404145350.45388-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404145350.45388-1-sebastian.reichel@collabora.com>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
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
 .../devicetree/bindings/usb/generic-ohci.yaml  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index a9ba7257b884..d84732a100ba 100644
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
@@ -68,8 +69,6 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 1
-    maxItems: 3
     description: |
       In case the Renesas R-Car Gen3 SoCs:
         - if a host only channel: first clock should be host.
@@ -147,6 +146,21 @@ allOf:
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

