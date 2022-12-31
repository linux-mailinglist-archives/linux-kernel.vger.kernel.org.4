Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5EF65A5C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiLaQqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:46:33 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF072CB;
        Sat, 31 Dec 2022 08:46:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E9F6B5C009F;
        Sat, 31 Dec 2022 11:46:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 11:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672505190; x=1672591590; bh=IPRSVAlAA4D6HDvNWgLVkLiHQ
        Bz7BJqcTy8N5hQX4yE=; b=IOjIQ46SoPZa4vkAaoxXi8FLpSzKMEv0GvyCfxttY
        uXLvl8/ko1QT8vXUHgi2I2FTP+nHhdOWYCsLe2XxzPuzWNDR2B2MlG5w4FixZ6Rr
        0gVDT2bjrGtXIZl3PVmi5TIpKoNCP7XhiGfOuo1JEwUvsdopfe6iVpfBbr8zwedG
        eyO1vVFxdZa4iw4qmckC4MM5tho00q7X0dzcSOvDbpnVQ79gpwJ7D48BMoVRrfsD
        jK1w5YMH91pgxG54lq2b9X9r+oFqdkfEcM7shrEIP8oAoRUJTx2DXOzGt2hYYk6O
        KwAcyBs/UNk0/+r+ykgMYZ3oCi5tCFYmMmk+2kX0lIUKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672505190; x=1672591590; bh=IPRSVAlAA4D6HDvNWgLVkLiHQBz7BJqcTy8
        N5hQX4yE=; b=X4sdFJUvDr8NMUsMd3IzTLkUDUtLV0+w4ipujJE78crDQ18stYm
        BFRoY3S/lbDaFFUbr/YhGGVNbPsFhaz5KjXedOIkWgF/pE6StKyY0URONg3Ll/ad
        zNnqOLhmFCDY8nLbreHEvEZar8DZk+2dNnnKn/p3+O725QOErDlhn8TdIBXHoATt
        NAg0KzasRB5N4Nys6iV3ZlNqZ3RrJknMQmJZ5Hc1I4cGgs98/fIuTVS40eRQbQ3D
        iWgyFx8IyXu21GcgRgPgvcy2YQy6Y4FvqqVusXNyl4rFHytPCl5LX41X/Qd+AW0h
        /ppdaTbhNXIx8uIgjuccsnoDvQDDrllK01Q==
X-ME-Sender: <xms:ZWewY75369dzlXIfAHhvDGNrmFzj0pT17PrrQ_9GXEXBPM6QchhMEg>
    <xme:ZWewYw7M9OtC4dTbUucBBIF1Gy7JDrgxGdxwR65bi5vnyrnch9QN7YysJmzzW4aFk
    u3s31nzTYCoA66ZHg>
X-ME-Received: <xmr:ZWewYyfO155MICpCKvnm_a0orWEOf3FTgtbNwiVrG8Vf1WuXv2jOtSsrwBUe3lS6SDEFdB2_05ENWddL7dXca_0ACG285KjXI5lRAirkYbySmx9f1BFczlt2SwWd-pNkmdm0PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ZWewY8I88adz0HUqOWw9yKn_XeICq5lRjhc2E2-iEJcY7L5yLZQE5w>
    <xmx:ZWewY_LuaLmQPSrCmN_kUIirZ1xHGzsQM4-zn9vMZAoGh5GFuYThog>
    <xmx:ZWewY1zFWdx9eepJBcNa6DzxkuC9YG-vatsq6myWtDXOlt9YbSsq1Q>
    <xmx:ZmewY0CLMJMVCej659_Tm_1qBPM7xY45PD__soSDEHKWZtA4L_QjZA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:46:28 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 0/4] Allwinner D1 video engine support
Date:   Sat, 31 Dec 2022 10:46:23 -0600
Message-Id: <20221231164628.19688-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series finishes adding Cedrus support for Allwinner D1. I had
tested the hardware and documented the compatible string a while back,
but at the time I had a dummy SRAM section in the devicetree. Further
testing shows that there is no switchable SRAM section -- there is no
need for it, I was unable to guess the address, and the usual bits in
the SRAM controller register have no effect on the video engine. So that
needs to be made optional in the binding and driver.

With that done, the node can be added to the devicetree.


Samuel Holland (4):
  media: dt-bindings: cedrus: Allow power domain references
  media: dt-bindings: cedrus: Make allwinner,sram optional
  media: cedrus: Make SRAM section claiming optional
  riscv: dts: allwinner: d1: Add video engine node

 .../media/allwinner,sun4i-a10-video-engine.yaml       |  4 +++-
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi     | 11 +++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c        |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.37.4

