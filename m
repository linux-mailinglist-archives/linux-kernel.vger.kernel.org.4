Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1196C64AF47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 06:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiLMFWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 00:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLMFWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:22:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFEFCB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sZPQ3spBdxnXS/pJhPHx16e4yKZseMO1oagGTXQ1r3w=; b=IEyZ43f8OVy6cHkWQldumvUl1Z
        TvUVnEdtJmY16qbOrFZdbMhfC/uXzZo/8oEjaFv19P9QBTxR310FWoZ8ZnyffYhqjEAW3c3Jv+kCY
        6N3CisOVWA+oOoUE027AL2TJe1UYxY8MFYWBJg8KXRu0MkJC0SxUvvU0nrNgD040aso/sddkNncC+
        +d9Hhu4YqPm7HItsborNfF7TM4bxovKTSnr8jkfD3plNhdFzyjEbpsKEBsFBKPiUgQO/gV6tu/CEd
        WKeil2c/lSWs5McnZLirDjmRHWKVE9C+sAfv70SvV5DkXRiEZz/MvdXiFVBfknkVrImwm0eLX5wTB
        89K//qyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4xkY-00BBi0-Ug; Tue, 13 Dec 2022 05:22:42 +0000
Date:   Mon, 12 Dec 2022 21:22:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        peterz@infradead.org
Subject: [GIT PULL] sysctl changes for v6.2-rc1
Message-ID: <Y5gMIvLH0KKJgTY0@bombadil.infradead.org>
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

The following changes since commit 81e7cfa3a9eb4ba6993a9c71772fdab21bc5d870:

  Merge tag 'erofs-for-6.1-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2022-11-15 10:30:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.2-rc1

for you to fetch changes up to 0dff89c4488f90c01807d9c12023433703206523:

  sched: Move numa_balancing sysctls to its own file (2022-11-20 20:55:26 -0800)

----------------------------------------------------------------
sysctl changes for v6.2-rc1

Only step forward on the sysctl cleanups for this cycle. This
has been on linux-next since September and this time it goes
with a "Yeah, think so, it just moves stuff around a bit" from
Peter Zijlstra.

----------------------------------------------------------------
Kefeng Wang (1):
      sched: Move numa_balancing sysctls to its own file

 include/linux/sched/sysctl.h |  6 ------
 kernel/sched/core.c          | 13 ++++++++++++-
 kernel/sched/fair.c          | 18 +++++++++++++++---
 kernel/sysctl.c              | 19 -------------------
 4 files changed, 27 insertions(+), 29 deletions(-)

