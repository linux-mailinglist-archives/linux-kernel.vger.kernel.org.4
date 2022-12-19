Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBB6513E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiLSU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiLSU2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:28:41 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9D8FD3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:28:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D62565C013E;
        Mon, 19 Dec 2022 15:28:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 19 Dec 2022 15:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1671481711; x=1671568111; bh=9YGbQcIciAgcxjVl1igQM+GkTZnRJT08/4M
        KvlN3dj4=; b=LnKmZ42CXh9Ua/8xfRrwvrPLd9lDh/8+TYK1M3T8fIYNafAEpX1
        IDw8s8TMxYOXFOpIRfMElX3hwZHV0ppN8y/8AUHVcZIJ9O8gFIZ5IRk0fplE5oOs
        wN5s4jAaUuevM2H9GrKhuJ+rgmOBIW80Q2ZlrrznX4CSGsp3EwYY3tnnHttNKBm3
        6GnxRkRX7EmH2xC1xXnkP8/SIYX2jwc2GzcYOMN1H8p15EB5+l48mQwP1lUx4C/G
        zeP4KY807UdmRIbL1OFCQzS5h2B6tD4RvD523yiw9NA6Ttj80xbkyGZr1N9yPFy5
        n/s333j2eWXNfnKptLXRTCCrYbgQxftjX+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671481711; x=
        1671568111; bh=9YGbQcIciAgcxjVl1igQM+GkTZnRJT08/4MKvlN3dj4=; b=o
        YoQ4uKImAqcBi74wuPLQIocfZcLBC/Q5j9TZ5pn0qUMKZNOemyltjl3z5dHHQGrT
        V0EEVjqYIaJc7vERx4UOYDAiLKRpQeqTWOSb6ptkLpDk5J7SHQvCLuW09fGXmM1B
        oekdysnIrH3s+SjwUYZTuCEZrlZFR4hAXlNldQbQxc03xmfXXPDb6HGHEDtzSJ6G
        Z9BhMirzYgLJXMfdQ6Ajr4oakiRZmWGxxzneP7gzAArCkHguZAHU0/dKkRe5v7yf
        tTXuVw7f+fPpQ1wYygLRkdx4wwFkCml/3r8Het+jOWlwwQHvHL+0konviNWrz2eJ
        dnhTbpTrdt+onieQXkoAw==
X-ME-Sender: <xms:b8mgYxpQDArISCJ0rpZpJNYiumPmSutzyr5Wu3JmJ1tVmFKbloRNiA>
    <xme:b8mgYzqTIwMSnwg8OLGV2N08bPeSLDPpILpRd2SRKvMWK3bRmjJMNbILP8CDzp01p
    NIQwSh7AIcK2CYZc_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:b8mgY-MjREkvVY33nLpZejTcPnqMTqmW-Z19CjGIhIsTo4nzteIl0A>
    <xmx:b8mgY86laJ4Z4RN2QpxUM19Q9hphyyHvk9J1e9f2I8N0cdRU7RSlpw>
    <xmx:b8mgYw5xsTFUw8u3xHkDTsYaTXk4kysURXUjKxHoTv9gtg9Sq98pOw>
    <xmx:b8mgY-RclW6DA3qxUhdSnY1BdXyvFZllWbxsPfEZooOB_ggxfyf8Gg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7CE55B60086; Mon, 19 Dec 2022 15:28:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <2e5e43ed-ad33-45f7-b270-5b4ae46a78fe@app.fastmail.com>
Date:   Mon, 19 Dec 2022 21:28:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, inux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.2-1

for you to fetch changes up to 6f85602d5fdea936077060ca6853587f01716a45:

  Merge tag 'v6.1-soc-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/fixes (2022-12-19 16:47:40 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.2

These are a couple of build fixes from randconfig testing,
plus a set of Mediatek SoC specific fixes, all trivial.

----------------------------------------------------------------
Arnd Bergmann (5):
      ARM: pxa: fix building with clang
      ARM: disallow pre-ARMv5 builds with ld.lld
      soc: tegra: fix CPU_BIG_ENDIAN dependencies
      Merge tag 'v6.1-dts64-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/fixes
      Merge tag 'v6.1-soc-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux into arm/fixes

Chen-Yu Tsai (1):
      arm64: dts: mt8183: Fix Mali GPU clock

Chun-Jie Chen (1):
      soc: mediatek: pm-domains: Fix the power glitch issue

Corentin Labbe (1):
      MAINTAINERS: add related dts to IXP4xx

Krzysztof Kozlowski (1):
      ARM: dts: spear: drop 0x from unit address

Macpaul Lin (1):
      arm64: dts: mediatek: mt8195-demo: fix the memory size of node secmon

 MAINTAINERS                                  | 1 +
 arch/arm/Kconfig                             | 2 ++
 arch/arm/boot/dts/spear300.dtsi              | 2 +-
 arch/arm/boot/dts/spear310.dtsi              | 2 +-
 arch/arm/boot/dts/spear320.dtsi              | 2 +-
 arch/arm/mach-pxa/pxa27x.c                   | 8 ++++++++
 arch/arm/mach-pxa/pxa3xx.c                   | 8 ++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi     | 2 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 4 ++--
 drivers/soc/mediatek/mtk-pm-domains.c        | 2 +-
 drivers/soc/tegra/Kconfig                    | 3 +++
 11 files changed, 29 insertions(+), 7 deletions(-)
