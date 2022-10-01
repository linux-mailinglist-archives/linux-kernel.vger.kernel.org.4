Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A75F188A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiJABxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiJABxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2B163CD3;
        Fri, 30 Sep 2022 18:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D9A623C1;
        Sat,  1 Oct 2022 01:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805EFC433C1;
        Sat,  1 Oct 2022 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664589178;
        bh=jEWH0Jk4vnsPs5ftOVCLOYw9fboTZd0tYzu/sl5zb4g=;
        h=Date:From:To:Cc:Subject:From;
        b=HxS6kCAgLnNR0b4qz93wT86iKI6j2So6TgqtFSnr5IXLTSCXoIrwBP7LEBGvQWloC
         ZJJuVPsGzmife29rWrDKd+KWcEi7777ea7PokwmcMRgoH1FJvlJSqAOau7VpYmazTH
         43qbn1hMhAfkxCUGsrGWHBLcNKjEaQMfar8TqiMU=
Date:   Fri, 30 Sep 2022 18:52:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.0
Message-Id: <20220930185257.d02c928a322dfa727bed4cb3@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge these three hotfixes.

The following changes since commit 59298997df89e19aad426d4ae0a7e5037074da5a:

  x86/uaccess: avoid check_object_size() in copy_from_user_nmi() (2022-09-26 12:14:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-30

for you to fetch changes up to 1c8e2349f2d033f634d046063b704b2ca6c46972:

  damon/sysfs: fix possible memleak on damon_sysfs_add_target (2022-09-30 18:46:31 -0700)

----------------------------------------------------------------
One MAINTAINERS update, two MM fixes, both cc:stable

----------------------------------------------------------------
Florian Westphal (1):
      mm: fix BUG splat with kvmalloc + GFP_ATOMIC

Levi Yun (1):
      damon/sysfs: fix possible memleak on damon_sysfs_add_target

Lukas Bulwahn (1):
      MAINTAINERS: drop entry to removed file in ARM/RISCPC ARCHITECTURE

 MAINTAINERS      | 1 -
 mm/damon/sysfs.c | 2 +-
 mm/util.c        | 4 ++++
 3 files changed, 5 insertions(+), 2 deletions(-)

