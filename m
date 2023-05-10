Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A196FDDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbjEJMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbjEJMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:36:28 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4EA5D6;
        Wed, 10 May 2023 05:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WZc2CWWT9PY6W1Amft6ANxyKX2Ha1FRBNyCzwjZVPYg=; b=Js+NIJCG6i+ZeaI6QG27C4QooU
        wHQsJnryVS9mB/G3Q7YMnkH45yVXpMmBi5Z+dVU7WFpjqDlWCGO7cfMOqBRe3kgD0Z7r1qLo5I4Af
        dvCe4bl6PmrW2pgZqqBIoin0cUyzGetRRNWZDGe6HhU2lxWIuRZmuhlj9MP4GDiuotR8KEeKVH8zn
        i0u+Hc20/LN7dVV0IopbzkBsTiK2Wab8Qn/uVb+fEesBm5ZOsUlxeU6rlM+NKncYzkMMWeiFandkS
        IbEpx5xHjk+5iC/Y1XjKgUuTrQUjU32KVeJjYE5BuRtyUC3+/Ifp7/Qek6uKTAI8ICn55PEycgFAB
        xZPbhQAA==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pwiVR-007ueJ-Go; Wed, 10 May 2023 13:01:17 +0100
Date:   Wed, 10 May 2023 13:01:12 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding
 schema
Message-ID: <e22cd891ea966bc18411d01d5e3b0d94e7ba6869.1683719613.git.noodles@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683719613.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP209 has a 4th GPIO, so add it in preparation for support in the
driver.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
index 31906c253940..1638cfe90f1c 100644
--- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
@@ -44,6 +44,7 @@ patternProperties:
             - GPIO0
             - GPIO1
             - GPIO2
+            - GPIO3
 
       function:
         enum:
-- 
2.39.2

