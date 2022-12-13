Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64E64ACDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiLMBLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiLMBLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:11:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D41BE9A;
        Mon, 12 Dec 2022 17:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C161B81037;
        Tue, 13 Dec 2022 01:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BF9C433D2;
        Tue, 13 Dec 2022 01:11:49 +0000 (UTC)
Date:   Mon, 12 Dec 2022 20:11:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ftrace tree
Message-ID: <20221212201146.08c32b28@gandalf.local.home>
In-Reply-To: <20221213114249.1bac79ce@canb.auug.org.au>
References: <20221213085200.772ddd94@canb.auug.org.au>
        <20221212175642.77cba577@gandalf.local.home>
        <20221213114249.1bac79ce@canb.auug.org.au>
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

On Tue, 13 Dec 2022 11:42:49 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Steven,
> 
> On Mon, 12 Dec 2022 17:56:42 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Bah, not sure how this happened. I thought I pulled these patches directly
> > from Masami. Does a rebase change the committer tags? As I probably rebased
> > them on top of my branch.  
> 
> From "git help rebase"
> 
>        --signoff
>            Add a Signed-off-by trailer to all the rebased commits. Note that
>            if --interactive is given then only commits marked to be picked,
>            edited or reworded will have the trailer added.
> 
> So this is not done by default.  Yet another reason to avoid rebasing
> others work unless absolutely necessary.
> 

Yeah, this is temporary, as Masami is still setting up his test
environment, he just asked me to pull his changes on top of mine so that I
can run them.

Now I know what not to do ;-)

-- Steve
