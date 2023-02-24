Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD26A16E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXHEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:04:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B467DA5;
        Thu, 23 Feb 2023 23:04:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E665161839;
        Fri, 24 Feb 2023 07:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04D1C433EF;
        Fri, 24 Feb 2023 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677222286;
        bh=XUj+75eA3j7r49T0Z9h2/EjhfJ6I49HtdQ/pt8I1QrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=crLo2/suq8g0cfLp0PgWOCkp+OqPBxNCAmeaTSRfvJrMGiJ4LC+esWLn5+3VhIyoC
         oPLzZ4C19uSHPRBliXPtB85wOfSQMpEFiC0uCha+y12aiJad0tkPg48mhQ9jxZxMTF
         4zi8C77ap+2pFkeWFULq3l4KQhpCJ6ttTpqgtXtEXOsfU2vE9+MJJmMbj57FlwwGwa
         TD5uCsXEV/LqWPiSs8PRgA8bivODerYQ5kOJM5jrsLiq4S67HVjhZa1Fl9g02iN0Nk
         T9p8DcnmVg1VeVYJJyi/2wyOZJ9hDnlaRcBRE7s+xZbM4qdQKVqll40fkimGTT2ofY
         ChsTa3MHH0R8Q==
Date:   Fri, 24 Feb 2023 16:04:41 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Donglin Peng <dolinux.peng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the ftrace tree
Message-Id: <20230224160441.98341704b2aee13d6316af12@kernel.org>
In-Reply-To: <20230224163426.7e4d956b@canb.auug.org.au>
References: <20230224163426.7e4d956b@canb.auug.org.au>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 16:34:26 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   2740abcc36cb ("Allow forcing unconditional bootconfig processing")
>   d3a1913404bf ("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED")
>   9739868a6e5b ("bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support")
>   9f58b99c9c40 ("tracing/probe: add a char type to show the character value of traced arguments")
> 
> These are commits
> 
>   b743852ccc1d ("Allow forcing unconditional bootconfig processing")
>   6ded8a28ed80 ("bootconfig: Default BOOT_CONFIG_FORCE to y if BOOT_CONFIG_EMBED")
>   6c40624930c5 ("bootconfig: Increase max nodes of bootconfig from 1024 to 8192 for DCC support")
>   8478cca1e3ab ("tracing/probe: add a char type to show the character value of traced arguments")

Oops, that may be my mistake. I've update bootconfig/for-next which only has the
commits went to the Linus tree. I think linux-trace/for-next is an old set.
Steve, can you update the for-next branch?

Thank you,

> 
> in Linus' tree.
> 
> -- 
> Cheers,
> Stephen Rothwell


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
