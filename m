Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD862F31C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiKRLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiKRLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:00:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A3922F7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 708EEB82301
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76BAC433C1;
        Fri, 18 Nov 2022 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668769217;
        bh=sbvFiU3WT//xFRXS5d8RwEjf6Y/qYJbitoZ5MmHfsiA=;
        h=Date:From:To:Cc:Subject:From;
        b=D3YnRyycT9G+lqQCJCiTEJnAjYOislwYmFFhD7cu+BMnBfXGBnjCZ73y3MMtz4XEw
         Z4ijorD3PWEZ4YhCD+RjOiMcQyb5MiiQ6PmF+nRrfPY7n/44i8Jr2DkDgR5ijF+JCN
         ceAdIhZfikDzIho3u90T31+vdbPYBFdhKSQ1EC8Y=
Date:   Fri, 18 Nov 2022 10:28:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.1-rc6
Message-ID: <Y3dQPc4c0pOW6KfG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc6

for you to fetch changes up to 1edfe4ea16ca2c9e91ec6cecd446b13636724e4f:

  kernfs: Fix spurious lockdep warning in kernfs_find_and_get_node_by_id() (2022-11-10 19:03:42 +0100)

----------------------------------------------------------------
Driver core fixes for 6.1-rc6

Here are 2 small driver core fixes for 6.1-rc6:
	- utsname fix, this one should already be in your tree as it
	  came from a different tree earlier.
	- kernfs bugfix for a much reported syzbot report that seems to
	  keep getting triggered.

Both of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Petr Vorel (1):
      kernel/utsname_sysctl.c: Add missing enum uts_proc value

Tejun Heo (1):
      kernfs: Fix spurious lockdep warning in kernfs_find_and_get_node_by_id()

 fs/kernfs/dir.c         | 14 ++++++++++++--
 include/linux/utsname.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)
