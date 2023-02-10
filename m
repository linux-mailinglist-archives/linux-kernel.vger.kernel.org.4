Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B2D692AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBJW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBJW7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0883721E2;
        Fri, 10 Feb 2023 14:59:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EFB7B825E3;
        Fri, 10 Feb 2023 22:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FCEC433EF;
        Fri, 10 Feb 2023 22:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676069963;
        bh=nJ9w43ZNSEdM7bB/hKQ5PLGfCPCy5lSq1hXBEIrSTBE=;
        h=From:To:Cc:Subject:Date:From;
        b=IPOekhtPUsx7HRmfJ+UgN+l7Dwzoyx23AhGLLEjeeABlZjLZB4rcBvimNf2Gk9lZN
         ErSkKt+0rWUN1EgvQtWcyHFrkkj1u/kscKvw4U4Zq4wg4LLz3fx+xiId7SH40zo0db
         bIILfp46rUvnlG/9N4Rvko9nNkrK/347e2J/Nb/HM78aKB4OSMjRZ6BTRzbkcCW+3O
         xm9VV3Eloz11d7Um8rf33YqD5DRUlrKolrDdGjpPJFHe9mIwzeQ4TP4mrm8mCTUMl0
         sx6fQSx0nKyvImyDevu8HV4E5JpFHMExl4RUiI9QmUq+hcUJ2zAnFGAqM2rf1iuynF
         VpW8bYU08rOxg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.2-rc7
Date:   Fri, 10 Feb 2023 14:59:22 -0800
Message-Id: <20230210225922.1958397-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to ecfb9f404771dde909ce7743df954370933c3be2:

  clk: ingenic: jz4760: Update M/N/OD calculation algorithm (2023-01-25 16:08:27 -0800)

----------------------------------------------------------------
Two clk driver fixes

 - Use devm_kasprintf() to avoid overflows when forming clk names
   in the Microchip PolarFire driver

 - Fix the pretty broken Ingenic JZ4760 M/N/OD calculation to actually
   work and find proper divisors

----------------------------------------------------------------
Geert Uytterhoeven (1):
      clk: microchip: mpfs-ccc: Use devm_kasprintf() for allocating formatted strings

Paul Cercueil (1):
      clk: ingenic: jz4760: Update M/N/OD calculation algorithm

Stephen Boyd (1):
      Merge tag 'clk-microchip-fixes-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into clk-fixes

 drivers/clk/ingenic/jz4760-cgu.c     | 18 ++++++++----------
 drivers/clk/microchip/clk-mpfs-ccc.c | 10 ++++------
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
