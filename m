Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480C5F7236
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiJGASy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJGASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:18:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A615E0E5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=y7q8z+gAQ4AacYDHG/hNzgpPqU8tnPULnTP0RVAwnZ4=; b=iCLUTYzPRvNTYdeBKMw9YX6AAa
        cyeSvhNyxF2x674Ishjoiqzycc+VK74AJ1x1i+Vl3Vrc+ZYO9RAp9rFgIzf6O5O0B+1UOnZJJDkwg
        e9F550NNfWaaR91AjCGRL7wiGbwpk+qBIZ6PYhQpLdzVhmqJ4jjZsI4KLcXWD/btgmrSlIuO4KqjF
        K0COq2EesfJTUKleP1I1IBzkROOjDsxv4HrMoJoavrxipDvV5BzvIXxjvgKjs6WaMSrmkCMlvZ3/6
        R/sc0x7gwu6chWNEsVsHDb+137U5z6tCt+h0BUvgcbX8LFaZ7X3EpTo12yK6gLwNBGdhhLR6bOO2N
        cnl8k2Fw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogb4a-006AiU-Ll; Fri, 07 Oct 2022 00:18:40 +0000
Date:   Thu, 6 Oct 2022 17:18:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     liushixin2@huawei.com, chuanjian@nfschina.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v6.1-rc1
Message-ID: <Yz9wYMDqTBeHi66p@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.1-rc1

for you to fetch changes up to c06a17fe056b84f5784b2f13753870eb65edc9ed:

  kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED} instead of i_{zero/one_hundred} (2022-09-08 16:56:45 -0700)

----------------------------------------------------------------
sysctl changes for v6.1-rc1

Just some boring cleanups on the sysctl front for this release.
This has been on linux-next for at least 4 weeks now.

----------------------------------------------------------------
Dong Chuanjian (1):
      kernel/sysctl.c: remove unnecessary (void*) conversions

Li zeming (1):
      proc: remove initialization assignment

Liu Shixin (3):
      sysctl: remove max_extfrag_threshold
      kernel/sysctl.c: move sysctl_vals and sysctl_long_vals to sysctl.c
      kernel/sysctl-test: use SYSCTL_{ZERO/ONE_HUNDRED} instead of i_{zero/one_hundred}

 fs/proc/proc_sysctl.c |  9 +--------
 kernel/sysctl-test.c  | 43 ++++++++++++++++++++-----------------------
 kernel/sysctl.c       | 22 ++++++++++++----------
 3 files changed, 33 insertions(+), 41 deletions(-)
