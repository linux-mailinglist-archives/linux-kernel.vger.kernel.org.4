Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A297B5FF496
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiJNUcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJNUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:32:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372E41B2BBB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:32:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A23B5C0092;
        Fri, 14 Oct 2022 16:32:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 16:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1665779561; x=1665865961; bh=oEDP9aG5CrkRtLCkw8d1OJf/8pNCXIne26s
        1w7BJCHY=; b=ONe1ZQXyrWjyKLtQbEMhGqJCI/hJGl9q6xey/GyOuYbbYNZVpYS
        pb2i34uR7lytiiLijCzICcLtffQSz/04EKJ8T2eCCOc7BT9756i0JM20R9iXSc1T
        LeNJl6S+8CjKzSAKKedEurU+UcjsX7qb2y+765MY1JMUTJliFsiQ3TOh9tnNi+l4
        YjvIMC6KIbLF+OJoeV+wv+0VgIBoNPWZDYqJyz7Fol85LhlVEN59naeRMr+77JUX
        uKgYuR5idg5Qmnxa7bV1YFHuR7sDlXarMi/hktgWlU5IBBRYVMGFHGnD3+v096vO
        Igto9WtXYjJLCJB8qxz4+R/9NZx2elzn/Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665779561; x=
        1665865961; bh=oEDP9aG5CrkRtLCkw8d1OJf/8pNCXIne26s1w7BJCHY=; b=Q
        5d3K9lOndHgqUu5SAaSb+OiinV/dOUQAStfp76Q4jytRFnAxWHx0e1rSDqSEXOdz
        csPCSntckBbin2eU1J94ZrBiZhe0JhsgGlYhXG1QZYqtug7vm0j/2APKDjy8qFUZ
        J2wCOUCmDBU99sRJYRlwLefNisJQewk+lcx+3AiQ8w7YSVzHLWBsWoW6cLq6ZAyF
        hTA7NNq9LDX2Rh95Dp5jg0D7RIWTI0lxNxLNlj0FfoDBo+4bomHmEKLIctVxLAng
        Eda7Rd4QOPj7WMRUniFC9UxcOYVKIZ+CJMxznxv6WpW6uNFCZ5SPyGUguQukw7gD
        ztlAZbWwwCWGal7PUirBA==
X-ME-Sender: <xms:acdJY3xDdJk0rLbb-zgYWwtW7USZZ8lswZLItQV8F5tiNkX5gwjYUw>
    <xme:acdJY_Q_aNHoJ_QzypZLzAkjmxBr2IeJ9shsf_sE2caVSG8lWBdEz3uJFN8DkZA5a
    CFxAGEdU2mniqKb1p0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:acdJYxXLKFdKEy0jrq5pB9kHsq5i26Ug_ymOtCejbVna2hHhlv90rg>
    <xmx:acdJYxjCEnWGQRqufb7C2WthVvSdMeeE6pbGETyyhfAb0MOHv9GCJw>
    <xmx:acdJY5D4wa2dzTjn8UrZvFGc70kxcng_bUQC6KV1MhxozAqzIgtpcQ>
    <xmx:acdJY274xs5d234ODovgpMBxFlz-2q9D8zeHe21lZwmX_1UQAqpNlw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 42B05B60086; Fri, 14 Oct 2022 16:32:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <02915464-9faa-46f4-995b-d7c11638d3c1@app.fastmail.com>
Date:   Fri, 14 Oct 2022 22:32:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.1
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

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.1-1

for you to fetch changes up to bd60aafce5e1943fd395b8bf726e9824fa621eca:

  ARM: mmp: Make some symbols static (2022-10-10 10:40:10 +0200)

----------------------------------------------------------------
ARM: fixes for 6.1

These are three fixes for build warnings that came in during the
merge window.

----------------------------------------------------------------
Chen Lifu (1):
      ARM: mmp: Make some symbols static

Viresh Kumar (2):
      clk: spear: Move prototype to accessible header
      ARM: spear6xx: Staticize few definitions

 arch/arm/mach-mmp/devices.c        |  8 ++++----
 arch/arm/mach-spear/generic.h      |  3 ---
 arch/arm/mach-spear/spear3xx.c     |  1 +
 arch/arm/mach-spear/spear6xx.c     |  9 +++++----
 drivers/clk/spear/spear3xx_clock.c |  1 +
 drivers/clk/spear/spear6xx_clock.c |  1 +
 include/linux/clk/spear.h          | 14 ++++++++++++++
 7 files changed, 26 insertions(+), 11 deletions(-)
