Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882864A458
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiLLPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiLLPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:42:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9027BDEBC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:42:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E4B26112F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E8C433F0;
        Mon, 12 Dec 2022 15:42:49 +0000 (UTC)
Date:   Mon, 12 Dec 2022 10:42:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221212104246.579f9083@gandalf.local.home>
In-Reply-To: <87wn6wc2t4.ffs@tglx>
References: <20221210135750.425719934@goodmis.org>
        <20221210135825.241167123@goodmis.org>
        <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
        <20221210133425.4657985e@gandalf.local.home>
        <87359mdeg3.ffs@tglx>
        <20221210185555.7abc4de4@gandalf.local.home>
        <87wn6wc2t4.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 11:51:51 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Right, but please make that part of the series.

I just pushed out a patch to do this.

  https://lore.kernel.org/all/20221212103703.7129cc5d@gandalf.local.home/

Feel free to ack it.

Thanks,

-- Steve
