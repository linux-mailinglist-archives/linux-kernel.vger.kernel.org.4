Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA72637BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKXOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKXOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:49:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21BFAE95;
        Thu, 24 Nov 2022 06:49:33 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-156-095.ewe-ip-backbone.de [95.33.156.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D231B6602B38;
        Thu, 24 Nov 2022 14:49:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669301372;
        bh=BwmqDVmneQkkaygfHpODIHLm/OqVPN1VU3hBQxXJHgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CurWl86nsdpqAjqN2KLzx1vWbtdIxXNFn+sW8lb41EOAZfa9rvJXSH+grjQEy7+Et
         vXe+95jtFvoUhJbjRjmKNaIQOR8/h5m8byRXVdR1EKo9FUXqKeTS1q8vHdI80CRrlq
         dLIR1gIZa4KuimjPBr9FkA7YYW4/UqQrF8WVRixB/jBbBUyNSJmaY1Oh1He/Virmsy
         3pS231S53sMiGjbOlJ0ANahz0Hbv6fs25HEoGUQ38M+F6l108h3JidrMBnAgHOHrb7
         G3qDOqD3yAnQ8e1Lvr3OQXH6/TlO1rgGmfEOunL8NpXXp1zxRVs45iKJaeU97ullpK
         s8JN4EC0oRnQw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 62B5648011D; Thu, 24 Nov 2022 15:49:29 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCHv4 4/7] dt-bindings: arm: rockchip: add initial rk3588 boards
Date:   Thu, 24 Nov 2022 15:49:25 +0100
Message-Id: <20221124144928.35381-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124144928.35381-1-sebastian.reichel@collabora.com>
References: <20221124144928.35381-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Rockchip RK3588 EVB1,
Radxa Rock 5 Model A and B.

Co-Developed-by: Christopher Obbard <chris.obbard@collabora.com>
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/arm/rockchip.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index c6c69a4e3777..49d442afe67f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -620,6 +620,16 @@ properties:
           - const: radxa,rock3a
           - const: rockchip,rk3568
 
+      - description: Radxa Rock 5 Model A
+        items:
+          - const: radxa,rock-5a
+          - const: rockchip,rk3588s
+
+      - description: Radxa Rock 5 Model B
+        items:
+          - const: radxa,rock-5b
+          - const: rockchip,rk3588
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
@@ -704,6 +714,11 @@ properties:
           - const: rockchip,rk3399-sapphire-excavator
           - const: rockchip,rk3399
 
+      - description: Rockchip RK3588 Evaluation board
+        items:
+          - const: rockchip,rk3588-evb1-v10
+          - const: rockchip,rk3588
+
       - description: Rockchip RV1108 Evaluation board
         items:
           - const: rockchip,rv1108-evb
-- 
2.38.1

