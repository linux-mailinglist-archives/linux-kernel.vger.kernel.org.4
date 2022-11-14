Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46B627488
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbiKNCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiKNCVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:32 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE4513EB6;
        Sun, 13 Nov 2022 18:21:27 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 086A432007F0;
        Sun, 13 Nov 2022 21:21:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 21:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392485; x=1668478885; bh=da
        qMpdoSZQlwwcrabmEMNr70r6TIeuLcvfWltwDoDCA=; b=aHsKz5oLBXQXNp4Ik/
        LHdfX5xdZ+wXnD/gJ8FSjzMetjo6UEgpsI/ka5HFNrkJEJzILCoTyjsPhLMSzljD
        pLq6gL3ZQHNAnnio+mO4I0FgJ9NeG7i+oqyVsEvvbouRoAsjiA+bVVJx2p1JJI+L
        0nuiULWnpWo061fxYQ4TQK+7KY0GeqpPHCdnniUKcHfVu3rcNZLjPLXPkvaqVhAa
        CJA6ykKNmdu/I+fNA/woPUdRUMaOQ/5+is5Q/j3p1mixfMo5+5Zr3dNzZeS/1t4g
        4pIOTiYIb8jQ7grT9aiRG2jznaMStD6WKdMWmW4HP+sR+WH2gunAj1ofo0TyLRAD
        zvjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392485; x=1668478885; bh=daqMpdoSZQlww
        crabmEMNr70r6TIeuLcvfWltwDoDCA=; b=CBKjR40vwDu3SJKzMaLzmu/kI5izn
        ZU6eqN8OIeyMs6DHWaDYBzSGGVN58Xe51Lznxw8pILX3IaX/yKUdZAUluOOuh0IH
        n/dNo7HCscYi/KdFg1MNQyXX8d/QCF5wuprn9TRbeKxvKTu4R9BL8t+iQ+jpIOpw
        cS6qg7YnTsTs3Ec2zOrhebdwaqMPaFKJeuEKffdrdvGINy2s4a/f5K2okIoH6PKs
        Wl3a0ooeNX0LbpqV8YluBJR3t72+2yXX743tAbLDI6H1xEA7z5/+u+N//So2InV3
        GY6ohHK6YfbIz1Ta9jJN1SRQAf6S6QZ01YbV4v0+IrpzOkbVQfgZLtBhA==
X-ME-Sender: <xms:JaZxY7Tr81pnDJTjF4SgojCGW2sUPSZQ7ZrImgdvmXouSRQK2bD5BQ>
    <xme:JaZxY8wvhYk11Z3GF6wD2SGwY3TsrHmHxeVjCEn_7Jml5U0hltRE423XvxaWyVmuI
    NCXR2vAgDK1dirDJg>
X-ME-Received: <xmr:JaZxYw36FiZW5MyQDvsbu6baCQqs0MHBDzMXqQFf7dSnzZ75GtryCfnqSCunBtx0ZMDkb6BFm7q4vK24wEJxg5wQwaqnnYUySeVZLg2DUp35KD5d5Di0n5Qovy6ZW0tqyOCJFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:JaZxY7CRT-vdFRXV4eRm2P12RKc-RddHUQ4GFb2itNLkucmgXHdcTA>
    <xmx:JaZxY0jsSNgqQM5Ir8Nw4oyyacv-YANKqTZrjaP88J96F7O8eUpVwQ>
    <xmx:JaZxY_rmm16o1o-dtJ7e0F_9kVy9ZQM1XsiSu-fSQvRviD1F56YzDQ>
    <xmx:JaZxYzTIegTaaqdX7YoB8sZkoflMln2a65dLHpFzqw4XSFY7yY92-g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:24 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/8] dt-bindings: sun6i-a31-mipi-dphy: Add the A100 DPHY variant
Date:   Sun, 13 Nov 2022 20:21:09 -0600
Message-Id: <20221114022113.31694-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114022113.31694-1-samuel@sholland.org>
References: <20221114022113.31694-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A100 features an updated DPHY, which moves PLL control inside the DPHY
register space. (Previously PLL-MIPI was controlled from the CCU. This
does not affect the "clocks" property because the link between PLL-MIPI
and the DPHY was never represented in the devicetree.) It also requires
a modified analog power-on sequence. Finally, the new DPHY adds support
for operating as an LVDS PHY. D1 uses this same variant.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml           | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index 4c45d7fcc853..fe9702e7bdd8 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -17,9 +17,13 @@ properties:
   compatible:
     oneOf:
       - const: allwinner,sun6i-a31-mipi-dphy
+      - const: allwinner,sun50i-a100-mipi-dphy
       - items:
           - const: allwinner,sun50i-a64-mipi-dphy
           - const: allwinner,sun6i-a31-mipi-dphy
+      - items:
+          - const: allwinner,sun20i-d1-mipi-dphy
+          - const: allwinner,sun50i-a100-mipi-dphy
 
   reg:
     maxItems: 1
-- 
2.37.3

