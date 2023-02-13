Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A110694FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBMStF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBMSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:48:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27E1CAED;
        Mon, 13 Feb 2023 10:48:36 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONKjRgJE+o9rzyn6Dg12SGG+ABcAw6wFpORVDpPQAKc=;
        b=RROm1Kc8lB8WKompL/Milko3aDDuOus9weut27IfifFpvRSBWPe83IENDzfD6YVevoiFAB
        DT5N/UkEyz22dvq25/Cu4G9yLcKTlb0xM05zFFCe47t5Nd5NX3qj5HRK9UVpH47sSO+nI+
        BBtVkSGs52OOCN8OglljG4EB4OV0GWiSgKtma0kD3R5r9SREnUKQLcpNPVA5IrgNKVyoJE
        iMNuYB9Fvlek+xqgcQ0mAy7wqXddl0w0xsIrfxUdTGGXuXFMWG4KkotTUeCjZ50hZQWylp
        eJJzLh075mHes5xCCG77ucTJExiSh5RrLtEczCknuZcrvSoe/Eo4nCxxd4aCcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676314114;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONKjRgJE+o9rzyn6Dg12SGG+ABcAw6wFpORVDpPQAKc=;
        b=e1PHhhnVejQPbbWIqgVVMGmobTQ67d/3l0YeWohSyccNIpOnW00zlSNN/e8LQQsUk9QRSw
        3ywLsUnKEYEC4LBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'clocksource.2023.02.06b' of
 git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into
 timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230210193640.GA3325193@paulmck-ThinkPad-P17-Gen-1>
References: <20230210193640.GA3325193@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Message-ID: <167631411455.4906.2066008474842808379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ab407a1919d2676ddc5761ed459d4cc5c7be18ed
Gitweb:        https://git.kernel.org/tip/ab407a1919d2676ddc5761ed459d4cc5c7be18ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 Feb 2023 19:28:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Feb 2023 19:28:48 +01:00

Merge tag 'clocksource.2023.02.06b' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into timers/core

Pull clocksource watchdog changes from Paul McKenney:

     o	Improvements to clocksource-watchdog console messages.

     o	Loosening of the clocksource-watchdog skew criteria to match
     	those of NTP (500 parts per million, relaxed from 400 parts
     	per million).  If it is good enough for NTP, it is good enough
     	for the clocksource watchdog.

     o	Suspend clocksource-watchdog checking temporarily when high
     	memory latencies are detected.	This avoids the false-positive
     	clock-skew events that have been seen on production systems
     	running memory-intensive workloads.

     o	On systems where the TSC is deemed trustworthy, use it as the
     	watchdog timesource, but only when specifically requested using
     	the tsc=watchdog kernel boot parameter.  This permits clock-skew
     	events to be detected, but avoids forcing workloads to use the
     	slow HPET and ACPI PM timers.  These last two timers are slow
     	enough to cause systems to be needlessly marked bad on the one
     	hand, and real skew does sometimes happen on production systems
     	running production workloads on the other.  And sometimes it is
     	the fault of the TSC, or at least of the firmware that told the
     	kernel to program the TSC with the wrong frequency.

     o	Add a tsc=revalidate kernel boot parameter to allow the kernel
     	to diagnose cases where the TSC hardware works fine, but was told
     	by firmware to tick at the wrong frequency.  Such cases are rare,
     	but they really have happened on production systems.

Link: https://lore.kernel.org/r/20230210193640.GA3325193@paulmck-ThinkPad-P17-Gen-1
---
