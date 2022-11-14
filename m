Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261F96288F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiKNTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiKNTN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:13:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8542BB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC9DB81200
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B642C433C1;
        Mon, 14 Nov 2022 19:13:54 +0000 (UTC)
Date:   Mon, 14 Nov 2022 14:14:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221114141435.46c80788@gandalf.local.home>
In-Reply-To: <87fsels6z2.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <87cz9qttdb.ffs@tglx>
        <20221113191135.0b61bb51@rorschach.local.home>
        <87pmdqs5vr.ffs@tglx>
        <20221114090818.30b292c7@gandalf.local.home>
        <87fsels6z2.ffs@tglx>
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

On Mon, 14 Nov 2022 19:53:37 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> I can see that. TBH, this was just my last line of defense to not being
> insulting, because I was seriously grumpy about this whole thing and
> even more so when I discovered that it was just hastily cobbled together
> and then sold as the panacea for solving driver teardown issues.
> 
> You surely can do better and you very well know how kernel development
> works.
> 
> I'm sorry if I offended you. I might have to adjust my expectations.

No problem. I'm also under a lot of stress lately and not getting enough
rest. Which is a reason I was a bit slack in my development.

Now that I'm back home and not working from a hotel room, I'm a bit more
focused and will not be rushing as much.

Cheers!

-- Steve
