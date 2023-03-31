Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD16D25DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCaQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:41:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908E2783B;
        Fri, 31 Mar 2023 09:38:18 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A20BB660319B;
        Fri, 31 Mar 2023 17:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280696;
        bh=Ang+ol8X8tHG4i9x5VTtRkot6uyY/w6cOxfWi5Scm1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwU6206cSlpL33GuYUrw1iMgQBkFj8NHBmYX6f+w1cGMY1chSiqS60D5K+k1BRqIa
         W9YBEJLyHflYZpD8ZxqbM2i1J6++vG8F36EeFC0pguWuPU9MATZIZV8nvzmAyFnz0Z
         qjwuDtj5PChcV4wzSClIkSbQNPKmDLM3lI+/EQURXnuUKioSYsvrMecDO9xCFwzQCO
         CsinIMQTAVv/cic/R86I9X5WqzGH6wjzQ3RHLyHL8dUkxGsOTxx5ebm7PTexNRQBws
         gHge9bLXo0vozsFKbD0d46WbtbgR7rNYqh56e9Ik97PtG0Q1/axq2PnM6oDh5HItIS
         /lxAPLkR7Bu5A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E8E3C4807E2; Fri, 31 Mar 2023 18:38:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 1/3] dt-bindings: soc: rockchip: add rk3588 usb2phy syscon
Date:   Fri, 31 Mar 2023 18:38:10 +0200
Message-Id: <20230331163812.6124-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331163812.6124-1-sebastian.reichel@collabora.com>
References: <20230331163812.6124-1-sebastian.reichel@collabora.com>
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

The usb2phy is accessible via a syscon registers on RK3588, similar
to rk3399.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
That diff is quite hard to read :/ The first line adds the compatible
to the list of allowed compatible values. The second line specifies
that this node may have /schemas/phy/rockchip,inno-usb2phy.yaml subnodes.
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index e697c928900d..a873f74564f2 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -52,6 +52,7 @@ properties:
               - rockchip,rk3399-pmugrf
               - rockchip,rk3568-grf
               - rockchip,rk3568-pmugrf
+              - rockchip,rk3588-usb2phy-grf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
               - rockchip,rv1126-grf
@@ -195,6 +196,7 @@ allOf:
               - rockchip,rk3308-usb2phy-grf
               - rockchip,rk3328-usb2phy-grf
               - rockchip,rk3399-grf
+              - rockchip,rk3588-usb2phy-grf
               - rockchip,rv1108-grf
 
     then:
-- 
2.39.2

