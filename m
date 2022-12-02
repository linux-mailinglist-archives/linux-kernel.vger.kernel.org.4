Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453B6406A8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiLBMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiLBMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:20:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65D9B0A0D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69976B82157
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 12:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134B8C433B5;
        Fri,  2 Dec 2022 12:20:29 +0000 (UTC)
Date:   Fri, 2 Dec 2022 07:20:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Karol Herbst <kherbst@redhat.com>
Subject: Re: [BUG] lockdep splat using mmio tracer
Message-ID: <20221202072028.40b62728@gandalf.local.home>
In-Reply-To: <20221202104334.649dacdf@eldfell>
References: <20221201213126.620b7dd3@gandalf.local.home>
        <20221202104334.649dacdf@eldfell>
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

On Fri, 2 Dec 2022 10:43:34 +0200
Pekka Paalanen <ppaalanen@gmail.com> wrote:

> On Thu, 1 Dec 2022 21:31:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I hit this while testing ftrace on an x86 32 bit VM (I've just started
> > converting my tests to run on a VM, which is find new found bugs).  
> 
> Hi Steven,
> 
> sorry, I don't think I know anymore how mmiotrace works. Surely the
> kernel has changed in those more than 10 years since I last looked at
> it. If I'm still listed as a contact for mmiotrace somewhere, maybe it
> would be best to drop me?

You're still listed as a Reviewer in the MAINTAINERS file. Which means you
only want to see patches (and possibly review them), but doesn't mean you
have to fix them ;-)

> 
> I don't mind the emails, it's nice to see people hit or touch it, but
> I'm afraid I can't help.
> 

Nice hearing from you too :-) I'll only drop you if you ask.

For now, I just don't test mmiotrace with lockdep on. But if I get some
cycles, I may try to figure out what's going on.

Cheers,

-- Steve
