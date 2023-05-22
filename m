Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76D70C45C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjEVReg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEVRee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:34:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CEFFF;
        Mon, 22 May 2023 10:34:33 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16D88660574E;
        Mon, 22 May 2023 18:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684776871;
        bh=ignbWH6aQx1pvgMX43Tpx1diOatQw8XwwcyX2Il9Ydc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3jpiRAHSaNIY6yvHMJYYdl7NqKevlGxcqeKQjOENHhi2amuTXzmQoc5Oh2J5iCID
         iSlHSwEIa1h5VJUiJyrUCMyvFKA4zeMEZ6df5Hus/TXzK9AJR3bUqqi5K68pimmNCD
         gAzws2AkJ9GSy8muYrqLq0nsFr8vkShKD1srG1giodQxH13tj86SnTCtARUDr6WZEc
         rijRvYxTJWq0VA/p0Tz0CeTf0InH1xNXea9g/WBQP4BPzsIiEsoJw3aHN/uNE0rcix
         SEfFcIZAiKoYmim09KV53B6mWFD7XAJ6iD6DULzCNPABanqPl8G+N60EVXtVIzCQJN
         e0e3EWQ1tFljQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8B0E64807E0; Mon, 22 May 2023 19:34:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: soc: rockchip: add rk3588 pipe-phy syscon
Date:   Mon, 22 May 2023 19:34:18 +0200
Message-Id: <20230522173423.64691-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522173423.64691-1-sebastian.reichel@collabora.com>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
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

The pipe-phy syscon is used by rockchip,rk3588-naneng-combphy,
which in turn is the PHY for USB3, PCIe and SATA.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index e8fca419cc8e..bf2370c66ed9 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -24,6 +24,7 @@ properties:
               - rockchip,rk3588-bigcore1-grf
               - rockchip,rk3588-ioc
               - rockchip,rk3588-php-grf
+              - rockchip,rk3588-pipe-phy-grf
               - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
-- 
2.39.2

