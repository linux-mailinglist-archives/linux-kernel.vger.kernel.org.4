Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AA5EDEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiI1OjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbiI1OjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:39:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A81AE9FF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 988E5B820EB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD12C433D6;
        Wed, 28 Sep 2022 14:39:06 +0000 (UTC)
Date:   Wed, 28 Sep 2022 10:40:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 2/4] trace/objtrace: Get the value of the object
Message-ID: <20220928104017.73cbe8eb@gandalf.local.home>
In-Reply-To: <CAEr6+EAHVUntQMVAC0_Rm7A2wWWC9TZsYi4PgV-tdO0bvUKguA@mail.gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
        <20220819032706.695212-3-xiehuan09@gmail.com>
        <20220924160136.5029e942@rorschach.local.home>
        <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
        <20220925115335.44b58732@rorschach.local.home>
        <CAEr6+EDft-pFrCdatd1ypWbjk9_KkMpBXcS6q4zaUgmkQuW0Eg@mail.gmail.com>
        <CAEr6+EAHVUntQMVAC0_Rm7A2wWWC9TZsYi4PgV-tdO0bvUKguA@mail.gmail.com>
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

On Wed, 28 Sep 2022 22:15:24 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> > > > > This code is available in the kprobe code that eprobes also uses:
> > > > >
> > > > > See process_fetch_insn() in kernel/trace/trace_eprobe.c
> > > > >
> > > > > and the parsing of the string is in kernel/trace/trace_probe.c:
> > > > >
> > > > >   parse_probe_arg()  
> 
> I guess I won't be able to finish it until the next merge window, I've
> been trying it for a few days

Yeah, the merge window is expected to open next week, so it likely will not
be able to make that. But hopefully the next window it will!

> In my spare time recently, with no progress, it looks like it's really
> more complicated to implement ;-)

Yeah, I was playing with it too. It is complicated, but I do not see any
show stoppers from getting it working.

-- Steve
