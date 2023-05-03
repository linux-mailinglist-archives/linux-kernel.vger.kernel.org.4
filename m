Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120CD6F6216
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjECX3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjECX3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:29:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C6135;
        Wed,  3 May 2023 16:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3149863081;
        Wed,  3 May 2023 23:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64450C433EF;
        Wed,  3 May 2023 23:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683156584;
        bh=G16NXu/wBBa4bsjGgxXRnZLOam+KRrOeNuCf9kwuSXM=;
        h=Date:From:To:Cc:Subject:From;
        b=KX3EHcdN+oB1qYajQ8Eu182Kdp7Zt7+10ZME6heEOIMTkk59MNyRFjwux58niBj+B
         hPnI+V4CJZw47wlVYahocsIlPzpbWrBXtHgLvqMu6fbnYqUdtLhqF80G0MjRQUrOLX
         JBYzxdfadgqTMsp85xAqfEQ9f419h60sVR5fP33Y=
Date:   Wed, 3 May 2023 16:29:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.4-rc1
Message-Id: <20230503162943.f6dc961eec9488db9ae411b0@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this set of hotfixes, thanks.


The following changes since commit 22b8cc3e78f5448b4c5df00303817a9137cd663f:

  Merge tag 'x86_mm_for_6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-04-28 09:43:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-05-03-16-27

for you to fetch changes up to 6152e53d9671b0ccc21c1bca842617b32ccfc5d8:

  mm: change per-VMA lock statistics to be disabled by default (2023-05-02 17:23:28 -0700)

----------------------------------------------------------------
Five hotfixes.  Three are cc:stable, two for this -rc cycle.

----------------------------------------------------------------
Lorenzo Stoakes (1):
      mm/mempolicy: correctly update prev when policy is equal on mbind

Mark Rutland (1):
      kasan: hw_tags: avoid invalid virt_to_page()

Michal Simek (1):
      MAINTAINERS: update Michal Simek's email

Suren Baghdasaryan (1):
      mm: change per-VMA lock statistics to be disabled by default

Zhang Zhengming (1):
      relayfs: fix out-of-bounds access in relay_file_read

 .mailmap           |  1 +
 MAINTAINERS        |  4 ++--
 kernel/relay.c     |  3 ++-
 mm/Kconfig.debug   | 10 ++++++++--
 mm/kasan/hw_tags.c |  4 ++--
 mm/mempolicy.c     |  4 +++-
 6 files changed, 18 insertions(+), 8 deletions(-)

