Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9146ED1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjDXQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:04:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE465FF6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:04:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BDE6E1FD92;
        Mon, 24 Apr 2023 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682352270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=difMHsyYlqAmJntOICtsX2iI1pl+Tr7Pfv512jkID6E=;
        b=LSSfogFeFpMXR+cf4e4MV2SS23DEV/yB8ZuQsMH0eIvS4qMo7drvT4XA29RMTz8azsAYrE
        Q3kBatI/OdKNYEYhx7OFzmF4CjfNQb/5jFav8WEEEkbpzyacK6M9/4IhpYzmrrKKekSe+2
        rJ4eFl/76MqNdqgdnv2zFSuk2OLNiY4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 299BB2C141;
        Mon, 24 Apr 2023 16:04:30 +0000 (UTC)
Date:   Mon, 24 Apr 2023 18:04:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.4
Message-ID: <ZEaojWvka0SeXv3B@alley>
References: <ZEZ15NNm3gAIfML3@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEZ15NNm3gAIfML3@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-04-24 14:28:21, Petr Mladek wrote:
> Hi Linus,
> 
> please pull the latest printk changes from

git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.4

> ==================================
> 
> - Code cleanup and dead code removal,
> 
> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       lib/vsprintf: Use isodigit() for the octal number check
> 
> Marc Aurèle La France (1):
>       Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
> 
> Stanislav Kinsburskii (1):
>       printk: Remove obsoleted check for non-existent "user" object
> 
>  arch/powerpc/configs/microwatt_defconfig       |  1 -
>  arch/riscv/configs/nommu_k210_defconfig        |  1 -
>  arch/riscv/configs/nommu_k210_sdcard_defconfig |  1 -
>  arch/riscv/configs/nommu_virt_defconfig        |  1 -
>  init/Kconfig                                   | 24 ------------------------
>  kernel/printk/printk.c                         | 13 +------------
>  lib/vsprintf.c                                 |  2 +-
>  7 files changed, 2 insertions(+), 41 deletions(-)

I am sorry I was too eager with deleting.

Best Regards,
Petr
