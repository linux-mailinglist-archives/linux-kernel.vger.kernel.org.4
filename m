Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00702602D73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJRNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiJRNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89785CF1BF;
        Tue, 18 Oct 2022 06:53:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 894CD3200990;
        Tue, 18 Oct 2022 09:52:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 09:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666101179; x=1666187579; bh=y1RDrGYs9H
        UnA1yVzl1mHHm++7oqqakHHWPZuH5zwSg=; b=wHmQChrvpEt1boK7HsJw72s9DV
        J+WpzM4xZ6IMFDxIHCtOsvKZ+D3pxugApUF2Nk/w3iyqy9O7ozrtf7eJuFRTMmXM
        ZWaG4g+o7eli10sa9bSnUq25UrgeeFqKzI+6LD2621E/tqUjSqIsGNfqMbf46LUM
        TR0Yik9cv7zFRBpFRN1K0+8MprUQqzetTRsMClogUnwQ57/hLx/1J9g53IxrtVQI
        xJSiUrbzhitWCSBbn85PNGqRPJ4Oe3Hjl0vBRxaVj8ROxYkoV6iDeZ0ALBhVEvWi
        oAHHqi83Rxwp9X5+gMn0KVfbZLMeU7D3QSmiJulNICsKTiJyhGx0JatiLQ6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666101179; x=1666187579; bh=y1RDrGYs9HUnA
        1yVzl1mHHm++7oqqakHHWPZuH5zwSg=; b=oKBiuT30EhRlVZaP+PQjRAkaoBjr5
        nvgkZDxHfSmxEzJDraO2j2CW0KzT70j3xQbJlh6uHUiR1n9YUg7/vOfNDOk4oA+k
        TzJW0ZWInTwop1XR66UmRJtOiDYL9wzOVEdzzf08c1oeoGRjBIx+0e+vK/ZLzect
        s2T931Cp2lG4j/3rhNH0pXCzYzb6b5nRCAIyUz8T51zE/ARoVpHOrVsjT3szGCLB
        WQrtBqheZv6P2McIIfHmSCW01NLOHrVJ6bXSZF45PI3578KAvWlkEQ/dXfNrL5vF
        Ya4jkLx2vzk3nOrmkh3xUYvE1ZkfToaIYDuQUp4EaYnThmjHveF1i/ApA==
X-ME-Sender: <xms:uq9OY96dAbiHS7le6d21RvgBNiDDIqYN_Bmr1Ns2NoMVz-Dh8PvT8g>
    <xme:uq9OY67HIyE4k5TI0t9ALBLjHT9urVyNL9abJTlatMJNKtdX1bJPwpHoXY0imgd_j
    Jri8UFkMZQNZ8TibY4>
X-ME-Received: <xmr:uq9OY0exajE8f4YbtIktT13mUrD0kmYiIiDfVkv_AMl7JiugQGNOf3wMdb6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepufggtgfghfffkffvvefosehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdehfeejtefhgeegudegveejieetfeeugeehveffteejkedufeeltedutdeu
    geehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uq9OY2KxCiol22qOa7eFD6lgdNweCFU8APDZ87ML15AfXKXcnH9OhQ>
    <xmx:uq9OYxJXh0BkN25ECB7dSppi1kBvoKQ63DAJv6GuiejZFM16LmbTAw>
    <xmx:uq9OY_zaWHP5dbRC19J2u5je3O5crEgjJcIINtSH1bDHuM7IZ2FiZQ>
    <xmx:u69OY-ENAE160bT30sorIRm_QRfuQww9g0ctAyBAQ0pedp6ojmHh3g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:52:58 -0400 (EDT)
Subject: [PATCH 0/4] clk: Rate range improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIALevTmMC/x2L0QqDMAwAf0XyvECbOtD9jca4BksHDcpA/HeDj8fdnWDSVAw+3QlNDjX9VYf46o
 DzVL+CujgDBaIY4oBcNmyP4Cy8Ga76F0MKaVzTmxL1AXyeJxOcPeTse91Lua4bmy3g+20AAAA=
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:52:55 +0200
Message-Id: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=ER4lhQAig9sBx9CAnoLtTYEmj2SMtCeNYjxq2yxnBx4=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+63e6Zmf5rzG7sPtL2UdXt/uG9U/fF096sWJe357uWkHv
 IzuEOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCR1YcYGa5zf2kOmW24vqJ3U7TWUu
 uTJxa/bl76OSyE+yBX+veXm28yMvSbh6VObJthdurH85/nbvetElu9+nZaSpmCpo3Cs2+JmzkB
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a bunch of patches for issues I came across while debugging the bug
reported by Angelo.

The most important one is the first one. Even though it looks innoculous, it
fixes the bug in question for some reason.

Let me know what you think,
Maxime

To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>

---
Maxime Ripard (4):
      clk: Remove WARN_ON NULL parent in clk_core_init_rate_req()
      clk: Initialize the clk_rate_request even if clk_core is NULL
      clk: Initialize max_rate in struct clk_rate_request
      clk: Warn if we register a mux without determine_rate

 drivers/clk/clk.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 56e8142dda103af35e1a47e560517dce355ac001
change-id: 20221018-clk-range-checks-fixes-2039f3523240

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
