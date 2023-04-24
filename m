Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573846ECBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjDXM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjDXM2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:28:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC044A6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:28:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48F1521AA0;
        Mon, 24 Apr 2023 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682339301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jkPIhTh1cmYKLm8cKroPX+TOo98xDmZ0EVYC1fxhUc0=;
        b=Op1/ILWRrYMhTgi6867QH0mzkRs6l0M9Hvrn8P330GMFzASx+2aJ6B7kKV7y4BGY8sXECT
        Ip7NByqaC38ak6iTn3fGZI5gqec+nqtld8dAg7gX5EfkGD7EJ57f3Sy8G/dc4SfGiUXA/0
        qFKDXX2WvjJhdbnVcVzf08wF4QvOiWU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9BDC32C141;
        Mon, 24 Apr 2023 12:28:20 +0000 (UTC)
Date:   Mon, 24 Apr 2023 14:28:20 +0200
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
Subject: [GIT PULL] printk for 6.4
Message-ID: <ZEZ15NNm3gAIfML3@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

==================================

- Code cleanup and dead code removal,

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/vsprintf: Use isodigit() for the octal number check

Marc Aurèle La France (1):
      Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT

Stanislav Kinsburskii (1):
      printk: Remove obsoleted check for non-existent "user" object

 arch/powerpc/configs/microwatt_defconfig       |  1 -
 arch/riscv/configs/nommu_k210_defconfig        |  1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig |  1 -
 arch/riscv/configs/nommu_virt_defconfig        |  1 -
 init/Kconfig                                   | 24 ------------------------
 kernel/printk/printk.c                         | 13 +------------
 lib/vsprintf.c                                 |  2 +-
 7 files changed, 2 insertions(+), 41 deletions(-)
