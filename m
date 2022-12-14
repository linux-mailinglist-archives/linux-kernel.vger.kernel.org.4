Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823164CF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiLNSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLNSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:22:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B118B2F;
        Wed, 14 Dec 2022 10:22:53 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-169-234.ewe-ip-backbone.de [95.33.169.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B08C16602C05;
        Wed, 14 Dec 2022 18:22:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671042171;
        bh=km48d5+uuKrtU+jKn1qKtyEltR/pLoMVSjioNlT7fVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=li/kTdDTTPbK0eOsl2Iqdv7GTq09aGgSF4+eXv1lY7D35/u4LLATtIBJMdy91C/Jr
         2sCZqRDzxItTHa8x8+Xc1Z6Yn7bCiaaPC6puw0lnO4+7tjoh5y6tn3g5vLRqN+Ob/a
         nCnSh9TifWpMtP0G8Uyz/Q+MQG9A42McYkCyub8ka35/wnIKzuEh0YKuAJNSEaXsuE
         cscfqoY75JhcnKH/DWmyo1r6q6oTAomBBlofh/p+dbwYQRe4F44E0ac1uOmGShG0LU
         1wtxqT5gb1tm2V+C4hAZliegyXB6V/IQchqChjlp8WMvOO16Vfga1ddOjRfturcDXD
         lgGGSKIp5u7/A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id B72F5480117; Wed, 14 Dec 2022 19:22:48 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCHv6 1/7] dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
Date:   Wed, 14 Dec 2022 19:22:41 +0100
Message-Id: <20221214182247.79824-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214182247.79824-1-sebastian.reichel@collabora.com>
References: <20221214182247.79824-1-sebastian.reichel@collabora.com>
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

Add IOC and PHP GRF syscon compatibles for RK3588.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 2ed8cca79b59..e682b407a383 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -20,6 +20,11 @@ properties:
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-bigcore0-grf
+              - rockchip,rk3588-bigcore1-grf
+              - rockchip,rk3588-ioc
+              - rockchip,rk3588-php-grf
+              - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rv1108-usbgrf
-- 
2.39.0

