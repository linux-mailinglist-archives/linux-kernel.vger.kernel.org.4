Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4E659299
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiL2Wp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiL2Wpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:45:54 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC5DBB;
        Thu, 29 Dec 2022 14:45:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 690F132003AC;
        Thu, 29 Dec 2022 17:45:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 17:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672353952; x=1672440352; bh=Ym
        jToE1+XYFIi0UjMxTH93OBLpP2WDsF0OjgxtqSxP4=; b=pS8P2fjwYSIOAdGwIi
        LI08Fu1Jn4OnEfyONDK5ReMLNzzsUdAqRSlmFjlZQ1Rx4uTcuRhQ+ZQIs/vlGQpu
        xKYX2v/0y1UTCoRGfMCBHSXLgg+rPGLZNSrv9dgEJt17UAEy4//pLj9n++JAhA2b
        4QDY0ejXS+MK066uScPsGl1clR4hmt0Gw9u+PJ6ME90XhpxqEB1zuwnKQAZivZWB
        phpkpiVGuNoj1cJjORf4xjQvmk6GxYgMJPTmMhPnklkkfJeJrqBWYrt4Ml4/azie
        LyTu2D8lSKqjzPc8DoO8z73gdZVwYnUbjN/osvHQ9vDrHdpo1s8/nVS+h3mVtRjO
        6L0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672353952; x=1672440352; bh=YmjToE1+XYFIi
        0UjMxTH93OBLpP2WDsF0OjgxtqSxP4=; b=Hs2elMxnfAcyPigkUsVbm8XG+8G4r
        J/W4DLjAHa4A3mRG/MNEUqXDibWqQuaDdvkfGsd+uw/8ZkiEtji0xYja/lX7KCxx
        4tO0xD7p3QZJtWbd2sPDB4xKNSB9odFEApmo8Ts6l93ZgGSXzkl9i08A3E9YoOdb
        fMywjS8E3facpKZEh5rupYFmh5aJaDgNO5oqdkk2rbfAIdJPPr1tIblVtxoKRjFy
        AW9IJbXvf7g8d3nJugg0mZwfTZcU1H1bRxSVZnPutr01upINfcYvYDC1I/HzAKza
        rzrOU2zz0S+w0eVpT5jBm60syND63NJIYZ2hlpIqP6mCxTP6/2klAFl1A==
X-ME-Sender: <xms:nxiuY3nHKKA0oTb7IjZFhmjGmbUobtstgnulf8FRoCpK-AjdnUes9g>
    <xme:nxiuY63AFe4tkmNlw9rIU1BgUYkWObyH8LwJHfo8MlD2SuRZ3AIq6o6pozwjBntNv
    WUjT2HmL8IcSlClKg>
X-ME-Received: <xmr:nxiuY9rPOof4DwFumowlVaNUOgTfXfCNwPQSKBy_xsv1wQcYlBg03XXtioF3CCYwQ4VKm2iaPpz1A2apvsMe5XA_23kWyRyuTAsOZlw4WvGm45ZzeJx0Ouw30Fx1f-VnGOAR1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nxiuY_nHo1iPk3bxPhDvMu4Lu7g5pmF4oRYsT04D2x4Q4McJlFGrIw>
    <xmx:nxiuY12fNWeyEKmCRae2YY9waXXPgq3hi5BBbn3KhGMHu6GJ89tjIg>
    <xmx:nxiuY-sEpS-MrVj5NNRr7QpUWZJ3ustjqYO4y5Aru80Jvf2LVNsOtg>
    <xmx:oBiuYynQ1L9IMv-6J4beqCi966z1Bs0-Vv20JL1RnAuC2wOsaQhF9A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 17:45:51 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add iNet U70B Rev 01 Tablet
Date:   Thu, 29 Dec 2022 16:45:46 -0600
Message-Id: <20221229224547.25225-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221229224547.25225-1-samuel@sholland.org>
References: <20221229224547.25225-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a white-label 7" tablet board based on the A33 SoC. It is found
in products such as the "Nimbus 17 V1" tablet.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 3ad1cd50e3fe..8150ae307c1a 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -346,6 +346,11 @@ properties:
           - const: inet-tek,inet-q972
           - const: allwinner,sun6i-a31s
 
+      - description: iNet U70B Rev 01 Tablet
+        items:
+          - const: inet-tek,inet-u70b-rev01
+          - const: allwinner,sun8i-a33
+
       - description: Itead Ibox A20
         items:
           - const: itead,itead-ibox-a20
-- 
2.37.4

