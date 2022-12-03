Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C206412F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiLCBPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiLCBPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:15:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF5D4ACB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:15:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E780DB8231F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 01:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5514C433C1;
        Sat,  3 Dec 2022 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670030149;
        bh=TRcH6r0ZvWPyD0PB6QrSEPFY4RlrbNOpiT7cI6Uxofs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ttW46MylOV7nC9m6Pt32kwhijnKMdMrJQ5I2Wix/XtPfMi1ueyNy3HY634f76EDLQ
         N5XKU5iftTUAQVWB5SxVzLVMNP4jh3h+PoC3yvBrzyIsZs8N/rQbHv1WNYbV7WNIiV
         USnbCX8C/jMdVHcWqMDDnlL6+eJYR/hsovssW2ubjYTEWRz06GVDsKiBMXn2QSzGzu
         BSV7qC1q2yIAolknW5T4LPmCCq0dWOrXhyggIv1L3IfK2dL1kwd0EnKYLy32pLnAjN
         9Q8dlig+QwLIb9+4iaiAj4RzT4lJhJZlXLPtjbgPQc4HEm8bAlGJcuxgUm5MaEbj4N
         6PfhIH8nJWrDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 538E35C095D; Fri,  2 Dec 2022 17:15:49 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:15:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     stern@rowland.harvard.edu, paul.heidekrueger@in.tum.de,
        sj@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [GIT PULL] LKMM changes for v6.2
Message-ID: <20221203011549.GA1815917@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest LKMM changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2022.12.02a
  # HEAD: ee5a86f451f7cc8a904fcbc4f3dece023d36d6e5: docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency barrier' (2022-10-18 15:14:52 -0700)

----------------------------------------------------------------
LKMM updates for v6.2

This series updates LKMM documentation, both in English and in Korean.

----------------------------------------------------------------
Paul Heidekrüger (1):
      tools/memory-model: Weaken ctrl dependency definition in explanation.txt

SeongJae Park (4):
      docs/memory-barriers.txt: Add a missed closing parenthesis
      docs/memory-barriers.txt/kokr: introduce io_stop_wc() and add implementation for ARM64
      docs/memory-barriers.txt/kokr: Add memory barrier dma_mb()
      docs/memory-barriers.txt/kokr: Fix confusing name of 'data dependency barrier'

 Documentation/memory-barriers.txt                  |   2 +-
 .../translations/ko_KR/memory-barriers.txt         | 149 ++++++++++++---------
 tools/memory-model/Documentation/explanation.txt   |   7 +-
 3 files changed, 90 insertions(+), 68 deletions(-)
