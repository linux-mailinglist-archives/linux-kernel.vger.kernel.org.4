Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EE5E941B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIYPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiIYPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:53:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96D92C11F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D109B81259
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 15:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624BDC433C1;
        Sun, 25 Sep 2022 15:53:36 +0000 (UTC)
Date:   Sun, 25 Sep 2022 11:53:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 2/4] trace/objtrace: Get the value of the object
Message-ID: <20220925115335.44b58732@rorschach.local.home>
In-Reply-To: <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
        <20220819032706.695212-3-xiehuan09@gmail.com>
        <20220924160136.5029e942@rorschach.local.home>
        <CAEr6+ECbocOnr_fSp_rwnu7ugg_q0wrYWShYsW3XOJffqwSOYA@mail.gmail.com>
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

On Sun, 25 Sep 2022 13:27:10 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> 
> It also looks like the "add" command field has been removed,
> Masami previously suggested I to add a reserved command field for the
> future (see [1] and [2]):
> 
> [1]:
> https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edbc@kernel.org/
> 
> [2]:
> https://lore.kernel.org/lkml/20211105004704.3f4aa456c2c537a56f64e65a@kernel.org/

Ah, I see. add means enable the tracing and del means disable.

Masami, perhaps we should call it "enable/disable" instead? Because, to
me "del" means to remove it (permanently), where as "enable/disable"
matches other triggers like the "enable/disable event" that starts and
stops another event.

> 
> 
> > This code is available in the kprobe code that eprobes also uses:
> >
> > See process_fetch_insn() in kernel/trace/trace_eprobe.c
> >
> > and the parsing of the string is in kernel/trace/trace_probe.c:
> >
> >   parse_probe_arg()
> >  
> 
> Thanks for your guidance, but the next merge window is coming soon,
> and since I'm not doing full-time kernel development,
> I can't guarantee that the development and testing of this change will
> be completed before the next window merge.
> 
>  Anyone familiar with this code providing a patch is welcome ;-)

If I get a chance, I may see if I can quickly implement it.

> 
> >
> > I think doing this will make it much more extensive, not to mention it
> > will match the syntax of other code in the tracing infrastructure.  
> 
> I super agree.

Thanks for you patience, and I'm sorry it took so long for me to review
it.

-- Steve
