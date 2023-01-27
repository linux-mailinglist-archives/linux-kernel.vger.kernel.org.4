Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E1D67F0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjA0WFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjA0WFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:05:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254717CEE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:04:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E20B821E7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E6AC433D2;
        Fri, 27 Jan 2023 22:04:55 +0000 (UTC)
Date:   Fri, 27 Jan 2023 17:04:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chuang Wang <nashuiliang@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Natalia Petrova <n.petrova@fintech.ru>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [GIT PULL] tracing: Updates for 6.2
Message-ID: <20230127170454.0231bc43@gandalf.local.home>
In-Reply-To: <CAHk-=wh5o7ZcRdpN0ch8iSFX4g73EXK=RHb6yDmHxneCZ44Org@mail.gmail.com>
References: <20230126193518.53da979d@gandalf.local.home>
        <CAHk-=wh5o7ZcRdpN0ch8iSFX4g73EXK=RHb6yDmHxneCZ44Org@mail.gmail.com>
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

On Fri, 27 Jan 2023 12:48:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 26, 2023 at 4:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Please pull the latest trace-v6.2-rc5 tree, which can be found at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.2-rc5  
> 
> -ENOSUCHTAG.
> 
> I do find the commit SHA in the 'trace/urgent' branch, but you
> apparently never pushed out the tag.
> 
>

Bah, I forgot that step.

Fixed. Thanks!

-- Steve
