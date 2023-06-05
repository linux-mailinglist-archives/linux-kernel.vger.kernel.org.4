Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABEA722ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjFEPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjFEPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:20:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD3EE8;
        Mon,  5 Jun 2023 08:20:21 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 346E16602242;
        Mon,  5 Jun 2023 16:20:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685978420;
        bh=GfOUH1eSkfsqisstMtmMreKlJ+WCmkLmHuqV+nkGrac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIR4v7WtoEfICFCed7KdoEEZTq41M/2KUhA+MGyd1HEcucSjmi7ViIZgueiwmWMcC
         S3LWpT8pfRH1fbrClkh7zi3jDQR9x4u6s4IDIx97lyGkVKqZt0zP+AOYTp0DVWcpZf
         KxtV07VFtcwlrNuuqlpwzULApr/RiybOAw3giuuBaa9kA3O5peJb53sIOzGZmml2BL
         oOFNiBHM6UsIk0CArzKLo2cQH3dmAVqkbGPcbmDuILgDrNB38N4AoMF/Wkr6LDS3oH
         IVcwOvzZCE5Mq51VTBCLErvs7eNcX+y8PwJ8InqOEzEWAv4ExQNQZT5Jxd1JRy6HsI
         WxNmSO+hVQmzg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Detlev Casanova <detlev.casanova@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: net: phy: Document support for external PHY clk
Date:   Mon,  5 Jun 2023 11:19:52 -0400
Message-Id: <20230605151953.48539-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230605151953.48539-1-detlev.casanova@collabora.com>
References: <20230605151953.48539-1-detlev.casanova@collabora.com>
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

Ethern PHYs can have external an clock that needs to be activated before
communicating with the PHY.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 4f574532ee13..c1241c8a3b77 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -93,6 +93,12 @@ properties:
       the turn around line low at end of the control phase of the
       MDIO transaction.
 
+  clocks:
+    maxItems: 1
+    description:
+      External clock connected to the PHY. If not specified it is assumed
+      that the PHY uses a fixed crystal or an internal oscillator.
+
   enet-phy-lane-swap:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.39.3

