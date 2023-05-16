Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE7705550
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjEPRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjEPRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:47:34 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD353A94;
        Tue, 16 May 2023 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RzmtE/IrhQkj+5OzqaybOj2rMpDT8RzP2FqBL6Bkrjo=; b=Mi3+HppleGx9l5njtGH8PmV0lP
        DNdeRXSUOsqTh3iaEiofv6p3C/LRknDMHnKjZv6hb6z5VgodZRanPbfv4s/XChHECrlUIUg4WLFQ0
        3OgZOxAi5MH3sXcoU+/1JtVPUPaf24ulAVTu18/fl7042dRGwt+2WCUiR9ax1MMYdblcLlSEzkhy8
        FCabCJB9fpL9nTohhhLQr4KeVQdnr3DozxpWvvc+6rvaNSi7ffrppc7ms6iVzYXoZQTJGvIHey8mL
        fupGMGLd2FPL9eJzm5D/v7WX4ZFBoNKSnTDrYkEp9d4hvRG51aXvcB/BH+72TyGPKcN+Vj8nSlQhx
        FaVacZoQ==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pyylb-00GMqb-Dc; Tue, 16 May 2023 18:47:19 +0100
Date:   Tue, 16 May 2023 18:47:13 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: gpio: Add GPIO3 for AXP209 GPIO binding
 schema
Message-ID: <7691a35155cf644c2efb02c282c5ef007a6570fa.1684258957.git.noodles@earth.li>
References: <cover.1683719613.git.noodles@earth.li>
 <cover.1684258957.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684258957.git.noodles@earth.li>
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
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

