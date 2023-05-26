Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E931712ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjEZQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjEZQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE5DF;
        Fri, 26 May 2023 09:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62EC265150;
        Fri, 26 May 2023 16:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F24EC433EF;
        Fri, 26 May 2023 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685119248;
        bh=t93pbrYm8876e2ZzCcWOn/DaROcwou/wyCtlhCi2DrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgQnPqZmoD+bHCn+EvLKPoPqcepWVbj1947EaciDPadsE6CD+fz6nJl7XQT26SIWp
         tY0DSs8KnwhZQvp8vW3hDuWUMI5tq2QF1Dac8MJMcVWJGm4wkZda+C5HS/5nln7hpB
         dJtfUMiIfkdJrHi/Phia4SyLf0AYMVaSWf+XmQlU=
Date:   Fri, 26 May 2023 17:40:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.15.104
Message-ID: <2023052614-routing-jarring-50b6@gregkh>
References: <1679511203203220@kroah.com>
 <20230522102355.GA2009088@google.com>
 <2023052236-passivism-equate-5cb8@gregkh>
 <20230522162812.GQ404509@google.com>
 <2023052236-clear-although-6495@gregkh>
 <20230523091105.GE2174496@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523091105.GE2174496@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:11:05AM +0100, Lee Jones wrote:
> On Mon, 22 May 2023, Greg Kroah-Hartman wrote:
> 
> > On Mon, May 22, 2023 at 05:28:12PM +0100, Lee Jones wrote:
> > > On Mon, 22 May 2023, Greg Kroah-Hartman wrote:
> > > 
> > > > On Mon, May 22, 2023 at 11:23:55AM +0100, Lee Jones wrote:
> > > > > On Wed, 22 Mar 2023, Greg Kroah-Hartman wrote:
> > > > > 
> > > > > > I'm announcing the release of the 5.15.104 kernel.
> > > > > > 
> > > > > > All users of the 5.15 kernel series must upgrade.
> > > > > > 
> > > > > > The updated 5.15.y git tree can be found at:
> > > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > > > > > and can be browsed at the normal kernel.org git web browser:
> > > > > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > > 
> > > > > > ------------
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > Budimir Markovic (1):
> > > > > >       perf: Fix check before add_event_to_groups() in perf_group_detach()
> > > > > 
> > > > > Anyone know why this didn't make it into v5.10 with it's friends?
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=80102f2ee715ab07be476df443bba388d5458fd1
> > > > 
> > > > That's a merge point, how can that go into stable kernels?
> > >  
> > >  There are only 3 commits in the merge.
> > > 
> > > > What specific commits are you thinking were missed?
> > > 
> > > The one I quoted above:
> > > 
> > >   perf: Fix check before add_event_to_groups() in perf_group_detach()
> > > 
> > > The other two applied successfully to v5.10.y:
> > > 
> > >   perf: fix perf_event_context->time
> > >   perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output
> > 
> > Do you have git ids for these?
> 
> These are the v5.10.y commits (no further action required).
> 
>   18dd825b86511 perf: fix perf_event_context->time
>   ddcf832000363 perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output
> 
> This one needs backporting from Mainline (please):
> 
>   fd0815f632c24 perf: Fix check before add_event_to_groups() in perf_group_detach()

Are you sure?  The commit it claims to fix is NOT in 5.10.y.

Can you test it and submit the working backport if it really is needed
in 5.10.y please?

thanks,

greg k-h
