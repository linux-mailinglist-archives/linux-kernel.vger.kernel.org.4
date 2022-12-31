Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1794465A80E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiLaXOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiLaXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D824CF9;
        Sat, 31 Dec 2022 15:14:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 16F435C00B4;
        Sat, 31 Dec 2022 18:14:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1672528471; x=1672614871; bh=CLyRJuU5Gp
        42q8xKUuOHFJyhAzWE0gbLmmfwQ+yR6RM=; b=sND/yvJN90kEWak4oJKkGgYl+6
        1M8k31rA6aBsLQzt+QO+WBqpol4njSNBAbgwX+Bbnk9vmIQLz1WC4iKBuPWfbukO
        rBI6YqV2OHJkUuxn8RL1AeG2RAAr3dnN/uuPK5GBMIDk18Ke95LjYx/lsCacDeGN
        PBvy0VmNoxw9jXzKiLCc7DkY4v/HScgTKtmRvyBm/TUZ8W7ioVPxHrxtuuQp450k
        xdcPIaBlILMioDmy2Y1mvRVO0LCZzlsLxYTcTeTkzYK1rhH872JLfgwaRh4H1JDk
        uthbRI2BUJAkAdAB8zrbqepaQSkfiD7b4SI8YNiFzO8aJ1Rp16UKy37HXmkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528471; x=1672614871; bh=CLyRJuU5Gp42q
        8xKUuOHFJyhAzWE0gbLmmfwQ+yR6RM=; b=CwmaOVuDAxje46IPRtmGqnCNeVpij
        1V2xBgx6sadZZciNP5AZbCnCzjMutysvahJXOz7V2UKZG9m3g+U8hbVltJGBEofE
        e7Nj8omH2hVnwSL+YkN955ZusXxBu/LGoilUaJ4Rs0FPUra7T9+ko/KApoAkFsv4
        t9mi6wHBE92NsEa/8iR1oMgDp02x389nxcB02H+uwhyb/i1ok9uIZ2YW6ZYCWUHs
        p34b7b8awAOakqVW4cI6dRpykICCL4eC+77bmEvSmUMC5XXb9qGHxz9GJc1i9Hpp
        DyahcES8r8O7CyJcgM0ZWrGzfjFWxFPDZHWXIuNPFXxbS3a/PqllzolDg==
X-ME-Sender: <xms:VsKwY2CEebTacyCxkyiApgYo9TiwS0lkrTBl1wQ_ockyy56ACbqaaw>
    <xme:VsKwYwi5IZVw04wRjfrVRlZWhr_ADxfUlBWtz4uq26AXCXvOdLUh7W2iyVsRTGoNC
    fZQkHeX6XjSYh2TdA>
X-ME-Received: <xmr:VsKwY5lQWUYrXzDFIqWpNvs8cWkITLtrD24msoUFPHUFr8b8REHtPF_3VpPTa0vmCpkWCaOjkbdvivP6ElJ5oAmqi8FZrHR-MLIoC-pKFhfn_fSmJWcyIOPav6mJmuhLhRaY4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepueevhfevkeeiffevieelhedtudelffevhefgudfgtdekheetfffflefh
    feetvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:VsKwY0wzYHJA_6CiHYEjdXdmc0JvA62iuwIygHOmRMhvRZwUVQ_Rcw>
    <xmx:VsKwY7TjX4_KrQ4PDQC_nMuBOas97R27aCH6qjZ_C88otSXULnZyFA>
    <xmx:VsKwY_ZHPrV2EGTgsJv6bKIaKZOqs70rViHY50ALDG6BZLBAOaVsmg>
    <xmx:V8KwY8iF5VSXS85weF33WvOoQMtovtaG02aPEMa7zuyJUNJy05_PPA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:29 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/6] clk: sunxi-ng: Allwinner R528/T113 clock support
Date:   Sat, 31 Dec 2022 17:14:23 -0600
Message-Id: <20221231231429.18357-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

R528 and T113 are SoCs based on the same design as D1/D1s, but with ARM
CPUs instead of RISC-V. They use the same CCU implementation, meaning
the CCU has gates/resets for all peripherals present on any SoC in this
family. I verified the CAN bus bits are also present on D1/D1s.

Patches 1-2 clean up the Kconfig in preparation for patch 3, which
allows building the driver. Patches 4-6 add the missing binding header
and driver bits.

Changes in v2:
 - Expand commit message
 - Move dt-bindings header changes to a separate patch

András Szemző (1):
  clk: sunxi-ng: d1: Mark cpux clock as critical

Fabien Poussin (1):
  clk: sunxi-ng: d1: Add CAN bus gates and resets

Samuel Holland (4):
  clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
  clk: sunxi-ng: Move SoC driver conditions to dependencies
  clk: sunxi-ng: d1: Allow building for R528/T113
  dt-bindings: clock: Add D1 CAN bus gates and resets

 drivers/clk/sunxi-ng/Kconfig              | 71 ++++++++++++-----------
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c      | 13 ++++-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h      |  2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h |  2 +
 include/dt-bindings/reset/sun20i-d1-ccu.h |  2 +
 5 files changed, 53 insertions(+), 37 deletions(-)

-- 
2.37.4

