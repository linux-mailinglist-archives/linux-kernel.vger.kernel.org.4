Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DA5F8575
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJHNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJHNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1225C356C4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 06:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C3F60B26
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 13:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22DC433C1;
        Sat,  8 Oct 2022 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665235371;
        bh=RA3wGfkQ5LumalmiGF3/+Hm7cmVXiiLKYa/T/zOtJPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuxCsrE2qd4j08cI/Bwjzirjw4BXGsA6x2LbLyKVDPWNXGIIQ0lvEwvO0oRx1/s94
         k86PoYd124hPRQuzZF0STmfzR0Nlz1bl68rrQyy4f7SD5aF7QFZ4KJdGCtlnEWy7XM
         Z7lLRk0UTQQhUSjHcjXjBlCdhT4abHmtf1Iy8pPhZ+epuia+/Z05pvmVW6sJZLLJLt
         1BU6Bm0Ese3O02JUwg815N7+kdy2/EkiXvuwnRgh1/WEZEOYahNsE4V0flkXSnRoMl
         vwXTlegyMLaN6f0LrIYE13gh0k8rbm4dEiXC84azqLTSvcOORCj/9FwG9FoIWuLUS9
         yKsmakMQwOyAQ==
Date:   Sat, 8 Oct 2022 18:52:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: SoundWire subsystem updates for v6.1-rc1
Message-ID: <Y0F5poxlesoIMa/+@matsya>
References: <Y0AnSpbH3B9U0H8I@matsya>
 <CAHk-=wjeQyCx-FGSaBckR+HgrMPYoHY2jwRq4J4JzpOczc+3fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeQyCx-FGSaBckR+HgrMPYoHY2jwRq4J4JzpOczc+3fQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-10-22, 16:22, Linus Torvalds wrote:
> On Fri, Oct 7, 2022 at 6:19 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > soundwire updates for 6.1-rc1
> >
> >  - Pierre-Louis Bossart did another round of Intel driver cleanup to prepare
> >    for future code reorg which is expected in next cycle
> >  - Richard Fitzgerald provided bus unattach notifications processing during
> >    re-enumeration along with Cadence driver updates for this.
> >  - Srinivas Kandagatla added  Qualcomm driver updates to handle device0 status
> 
> So one of the things I do for merge messages is I try to make them all
> _somewhat_ consistent.
> 
> That means that I now ended up editing all your explanations to match
> the more common pattern, where when people credit the person doing the
> work they put the name in parentheses after the explanation.

Sorry I missed that.

> Partly that is just for consistency so that our logs read more like a
> uniform body of work, but it also means that you don't need to add
> pointless filler words to the explanations ("did", "provided",
> "added").
> 
> So if you really want to mention peoples names (and it's ok, but it
> does show up in the individual commits, so I'm not convinced it's
> necessary in the merge commit overview of "what happened"), please try
> to use that model.
> 
> And no, we're not really all _that_ consistent, and there's really a
> few different merge commit patterns that we have.
> 
> Generally I try to make my editing fairly lightweight, but this was
> just _so_ different from the normal merge commit log pattern that I
> felt I needed to just edit a lot more than usual.
> 
> So a gentle query to maybe try to make them more in line with the
> other patterns in the future to avoid extra work?

Thanks for letting me know. Sorry for the trouble this caused. Will
update my template to use the edited format you have applied.

-- 
~Vinod
