Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66562745E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiKNB6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiKNB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:59 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13478DFA7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 17:57:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7A0BC320090D;
        Sun, 13 Nov 2022 20:57:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 20:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1668391071; x=1668477471; bh=dA3bbglhiZjYdTP+ET4rVGuGW
        cZdCaQWUzZGG9uUdbY=; b=T38uFRM5X0/bzVaKD2QyMSYq2e7pdKZWcxgcs0K5k
        4rrOO86ogLLlXxGUxxzLbGfkR1p+0q3JCj79hpL3zKyTnFotCkv3771rRrRyS8Aa
        QBQ9q7oap9whn6dVC33LIAR6H1DCTg8lM0isRK8ZqsOc3BOJi6bRXICBcNdig9Is
        +iVAAifENF7JT97kId7RZ6vfMX54THHBkz0F91W7Qjb0NdazeKVrc8TLQukssID/
        UwUJgzI3bW6gQrsXKneO8CtonYOlCK4f51Smvqksptm3l8DaZ2FzTlOMvNFQfZRj
        FxROKCnJbxepjBkHfR8cj6HBf4X+XloywZkz8+x37TdHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668391071; x=1668477471; bh=dA3bbglhiZjYdTP+ET4rVGuGWcZdCaQWUzZ
        GG9uUdbY=; b=RxMUJJj4LBOGCSqYr1EmG80Ei5VyYZyP/wOTG/7OzrvsxuGaLw8
        BcitLqqQgt3gu1Z29bcPkKSH0Tm2FURqTxhQVCKSe8eOCvkFy9UcDb0+m39KtpoE
        2X+mZJm6/TAM0wCA0fUVJ3cgok1QPZEj6KjtdXFmmVEoCn+0kcA7IwWY1bu8BtMz
        LqxILM3+tv0oYgbD2URYKf3gq7WhIVZPGRDuKDamrghdDUaftCGgyUKgAz1tKKsG
        ZYGwgIywV7f2x87isZnap+lNYdfeJJSb9KgPJtNJRiEBkFI4B7s+tMB9IJZ1o8Qu
        WuKYirZHHL/tenie6aOKo+8AY0U9bMQqBDw==
X-ME-Sender: <xms:nqBxYzAsp4Ab8QFfNd5g9Lu-rVZH-2k0kym3yEUBmBA566kwxrOrmQ>
    <xme:nqBxY5gMF51SI_iiv_Vvj1hbpejRD5Givcly8VAD_QKt5945yu3QlcehTSWXWwmYt
    g0-XehF-LaZQ4NPBg>
X-ME-Received: <xmr:nqBxY-lEofuCxbVhQwMfWUX-Wq3EQraBuHpilGiIFXy8E88JsvIBjFfouium0qpJgOxk1fck1mr6zoOnwFN5aD1Mvd2vMDSQKYZZXpd1yOVrQeexh25dmSMZuTyhFIVC-mSe5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nqBxY1wZQ-ER_cw1HyPRsJhTe0FuaOPKRGxPaO3zt_hpveBYGy0QVA>
    <xmx:nqBxY4Q4bpfSBP0XAYX26AIE70hI9XkdJ_EvtDNrKwEwK8aNdKgqZg>
    <xmx:nqBxY4ZES5P0tyy9TQ9jSoINwDwmZZHTutj7QD0kOUYQLqsxozEeKw>
    <xmx:n6BxY3H996nGxGvOm7IXSnYFx18HxQOng8BSbU-PNICTzcvwPzfVIw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/3] bus: sunxi-rsb: Fix poweroff issues
Date:   Sun, 13 Nov 2022 19:57:46 -0600
Message-Id: <20221114015749.28490-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
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

This series fixes a couple of issues that occur when powering off a
board using a PMIC attached to the RSB bus.

These issues only affected 32-bit platforms, because 64-bit platforms
use PSCI for pm_power_off(), and the PSCI firmware reinitializes the
RSB controller.

Changes in v3:
 - Adjust patch 1 commit message
 - Clear the interrupt status register after polling
 - Add a patch refactoring how the status bits are cleared

Changes in v2:
 - Add Fixes tag to patch 2
 - Only check for specific status bits when polling

Samuel Holland (3):
  bus: sunxi-rsb: Remove the shutdown callback
  bus: sunxi-rsb: Support atomic transfers
  bus: sunxi-rsb: Clear interrupt status before each transfer

 drivers/bus/sunxi-rsb.c | 56 ++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

-- 
2.37.3

