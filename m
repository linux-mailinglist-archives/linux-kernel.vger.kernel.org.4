Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B070C337
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjEVQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjEVQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290C118;
        Mon, 22 May 2023 09:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 640EE619E8;
        Mon, 22 May 2023 16:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74063C4339C;
        Mon, 22 May 2023 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684772584;
        bh=4ZQoYM8yOdUqpgNVxYSW1ecgtq+i1gpKnrInGGzPzb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2UFJDXXI1xmnAPSsSzAetLHDhc6l5HGs9PMj9mUwimk+dEIh8FuOL9hXc5PAkqaXV
         OUnjKKUjX1FNae9kidGbHZVXmZdWQvWvLBrNRBSGrSxPWAOeqHzj10tGABr+NNbiP8
         Q/TvNLDgnwXCuQ9nEfmyOTWDyi+5YTuJqphKVNDo=
Date:   Mon, 22 May 2023 17:23:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.15.104
Message-ID: <2023052236-passivism-equate-5cb8@gregkh>
References: <1679511203203220@kroah.com>
 <20230522102355.GA2009088@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522102355.GA2009088@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:23:55AM +0100, Lee Jones wrote:
> On Wed, 22 Mar 2023, Greg Kroah-Hartman wrote:
> 
> > I'm announcing the release of the 5.15.104 kernel.
> > 
> > All users of the 5.15 kernel series must upgrade.
> > 
> > The updated 5.15.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> 
> [...]
> 
> > Budimir Markovic (1):
> >       perf: Fix check before add_event_to_groups() in perf_group_detach()
> 
> Anyone know why this didn't make it into v5.10 with it's friends?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=80102f2ee715ab07be476df443bba388d5458fd1

That's a merge point, how can that go into stable kernels?

What specific commits are you thinking were missed?

thanks,

greg k-h
