Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856E67C47B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjAZGeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZGeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:34:22 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E146145;
        Wed, 25 Jan 2023 22:34:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 65C9C320092E;
        Thu, 26 Jan 2023 01:34:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 26 Jan 2023 01:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1674714859; x=1674801259; bh=pM4BStLL1Skg7XYi8QBrjhe75
        9beNnudPI+N5t2B+7k=; b=fcdfsYfbNuArt6RiTqBpWcKepcfZaPq1wXfDbqwCq
        x8fAjOwldYSJf9R4aZJoyJOoUzewDtDjLiS8fl2AgEMT3zhco/MMZUmz3Los98rE
        FfoxySb8yolewD6x3dQQVo2OxWv1MbQOuoAtQik3uedkMvG4k289uYFjDA9q0in3
        BQrPxq3MO7qu2HDPEvUe6kYggu5Iy55niel/LyWmaTTptMhNoVj3lE5ytOu2FkZU
        K1zQiSjhfXTM0qnRN+5FwKpNVEmtQI54uXeRyqEY7BL6jNB4W40RMIv/7ok59rgo
        2Pr7LyOhiLNYVrK/9cUPc9CIwOr7QGNutCm8wJtiecYkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674714859; x=1674801259; bh=pM4BStLL1Skg7XYi8QBrjhe759beNnudPI+
        N5t2B+7k=; b=Z2tV6s0/t1DitCs9Q/rJfW9tb4dNUdqfCmI3qnROFrMxY9Ch4+6
        do+HlGjSdH8B7uWL6bWnIxxWA5T36WRgo7dQkewuIkb6n/m5jvup0tM5naeWzcWd
        cu51hnyoSqhMFT/ylZcXpjzgUX+L+thuB3Fijku8P+UDAfdlb89K0B0EAq7c2AQK
        E1wy0d8sqBH5X1TPWqJy+sCmVFfkLCAXrRpUxR1K2jbldwtEZbMlYr4fPQo/eEnN
        +dI8RmXat/s6RGq0H9p35PgRvFtD2tfgt7lRbGX1OHu0DwkOAkzg2UVwWk38U3O/
        M1BBti3djo89xgGINTZgUa2/m/tAVXcG/tA==
X-ME-Sender: <xms:6h7SY41wiFkNZXhR-rcMMy_ydx5D9SlyZa_5zwe3pHhrhIBbuEaN_w>
    <xme:6h7SYzG2KARsiy_joUPRqd_HG26HjzzIL-BCra36ZFW73Oz4O13UXTBu-LyXJ-xhG
    n5XoqB6GHO-1QQeXA>
X-ME-Received: <xmr:6h7SYw7xkcPwDdGGq10ES-71fehaOKH-uMyxrho5SPxgUpTs7cZoHigf6XG2jgV1J8JkiAXe8Y_5ZCOJylY_QlxHv1jL0FEOSie7h89V423QA78erd-wo0Dm0GxBSulKz6GuZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepvddtleeugeefjeetudejvddujeetteehveelkedvgfetgedtvdeikedu
    hfelgeevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:6h7SYx2jgQWeAgkktSiNLoWATqc5HVM5awBfnJjzW75iLnjmUk-nYQ>
    <xmx:6h7SY7FFvpHvNkjZxI7jp0nsY8bv-da4GGgIw3sZmHGOxFm8yjr88Q>
    <xmx:6h7SY69Osz6m0B9IX4gDi1IECGPY64CYrxkaR5G66fXBLC8x9agKhw>
    <xmx:6x7SY7GsgiaYtpvbd4AVkjnK3y9hLZXARYD915kqu7PQKoPG2jTPSQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 01:34:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] Allwinner D1 power domain support
Date:   Thu, 26 Jan 2023 00:34:16 -0600
Message-Id: <20230126063419.15971-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the power controller found in D1 and other
recent Allwinner SoCs. There is no first-party documentation, but there
are a couple of vendor drivers for different hardware revisions[1][2],
and the register definitions were easy to verify empirically.

I have tested this driver on D1 with the video engine.

[1]: https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/gpu_domain.c
[2]: https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/pm_domains.c

Changes in v2:
 - Removed quotes from "PPU"
 - Fixed indentation in binding example
 - Removed possibly misleading comment from the Kconfig description
 - Include a patch adding the device tree node

Samuel Holland (3):
  dt-bindings: power: Add Allwinner D1 PPU
  soc: sunxi: Add Allwinner D1 PPU driver
  riscv: dts: allwinner: d1: Add power controller node

 .../power/allwinner,sun20i-d1-ppu.yaml        |  54 +++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |   8 +
 drivers/soc/sunxi/Kconfig                     |   8 +
 drivers/soc/sunxi/Makefile                    |   1 +
 drivers/soc/sunxi/sun20i-ppu.c                | 207 ++++++++++++++++++
 .../power/allwinner,sun20i-d1-ppu.h           |  10 +
 6 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
 create mode 100644 drivers/soc/sunxi/sun20i-ppu.c
 create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h

-- 
2.37.4

