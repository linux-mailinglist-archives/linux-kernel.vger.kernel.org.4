Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4F70D87E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjEWJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjEWJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE826120;
        Tue, 23 May 2023 02:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5331362BF2;
        Tue, 23 May 2023 09:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48429C4339B;
        Tue, 23 May 2023 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684833069;
        bh=LVlyfbZgn2iRIn7ZSmKBGZ/2rCC3V2amYXZSr84oCz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPtP1zCk8CmhETypy8iYRyYRfU79FzLtG2pmJqob2qH5ldUo3dc9adrGMiqIcfy0O
         8ttGKgazrJToMkzwCcMbLbEvslL7CxkqLsYJ4eh5LyNqKJUVta/hwZjGRIIr/89S85
         AkXdCMqYz+32wtJnpLXz7v32bDKzeuYmD9KzILgqf2o3nwTw0BqTYADofWvFi5qmi+
         EQb4jER6gfGFV3LwnTxUAhKQbZwHtB0FsYn5fBp0Xo0FXtB/fgoMgM9Txh1TiIf1iu
         n37ei6bvN1v1bTk/Vk9LO+x+guUR9xlRI7A8KJbhTu89ETSbZS6zuxmWhDbcUETuAW
         Xao0wVHFYR54w==
Date:   Tue, 23 May 2023 10:11:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.15.104
Message-ID: <20230523091105.GE2174496@google.com>
References: <1679511203203220@kroah.com>
 <20230522102355.GA2009088@google.com>
 <2023052236-passivism-equate-5cb8@gregkh>
 <20230522162812.GQ404509@google.com>
 <2023052236-clear-although-6495@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023052236-clear-although-6495@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Greg Kroah-Hartman wrote:

> On Mon, May 22, 2023 at 05:28:12PM +0100, Lee Jones wrote:
> > On Mon, 22 May 2023, Greg Kroah-Hartman wrote:
> > 
> > > On Mon, May 22, 2023 at 11:23:55AM +0100, Lee Jones wrote:
> > > > On Wed, 22 Mar 2023, Greg Kroah-Hartman wrote:
> > > > 
> > > > > I'm announcing the release of the 5.15.104 kernel.
> > > > > 
> > > > > All users of the 5.15 kernel series must upgrade.
> > > > > 
> > > > > The updated 5.15.y git tree can be found at:
> > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > > > > and can be browsed at the normal kernel.org git web browser:
> > > > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > > ------------
> > > > 
> > > > [...]
> > > > 
> > > > > Budimir Markovic (1):
> > > > >       perf: Fix check before add_event_to_groups() in perf_group_detach()
> > > > 
> > > > Anyone know why this didn't make it into v5.10 with it's friends?
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=80102f2ee715ab07be476df443bba388d5458fd1
> > > 
> > > That's a merge point, how can that go into stable kernels?
> >  
> >  There are only 3 commits in the merge.
> > 
> > > What specific commits are you thinking were missed?
> > 
> > The one I quoted above:
> > 
> >   perf: Fix check before add_event_to_groups() in perf_group_detach()
> > 
> > The other two applied successfully to v5.10.y:
> > 
> >   perf: fix perf_event_context->time
> >   perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output
> 
> Do you have git ids for these?

These are the v5.10.y commits (no further action required).

  18dd825b86511 perf: fix perf_event_context->time
  ddcf832000363 perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output

This one needs backporting from Mainline (please):

  fd0815f632c24 perf: Fix check before add_event_to_groups() in perf_group_detach()

-- 
Lee Jones [李琼斯]
