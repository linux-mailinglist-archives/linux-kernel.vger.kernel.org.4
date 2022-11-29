Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723463C527
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiK2QaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbiK2QaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:30:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2BF5A6EE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:30:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEDC4617F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61941C433D6;
        Tue, 29 Nov 2022 16:30:08 +0000 (UTC)
Date:   Tue, 29 Nov 2022 11:30:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20221129113006.0d745fae@gandalf.local.home>
In-Reply-To: <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
        <20221017154057.78babf40@gandalf.local.home>
        <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
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

On Wed, 30 Nov 2022 00:09:51 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> > Now instead of searching the function arguments for "obj", we should just
> > read the obj value at every function and report when it changed, as well as
> > the last function it was still the same. The report will be like the
> > "func_repeats" entry. And instead we can print when the object changes,
> > something like this:
> >
> >               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)  
> 
> 
> I'm just curious if we'll see this rewritten version in the next merge
> window  ;-)

Unfortunately, this ended up getting dropped in priority, as my workload
increased internally. :-/

-- Steve
