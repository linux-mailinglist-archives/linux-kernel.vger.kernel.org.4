Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF76F27FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjD3IAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3IAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 04:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDFE213F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 01:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB03560BA4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 08:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888A4C433D2;
        Sun, 30 Apr 2023 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682841616;
        bh=hgWYPAAMrj+NdXuh/X/WWhB3PROtLAZduyMznGtaGrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWjSDGP6Miyq3S9kgYJvmUPfivQ/xHYnshfNWgwRK4CKkHyLxXIt3fZhyoZ8jcOU1
         6gQTzob+nsRPoSSp09TfnlmzCRSotPMpHUHiv3+DtcjIjW7CmmPwEGznx2seo//gc4
         TRE0jzEVipRkAcpZnQ0hVzdmBfwV9u6CAhB39XjA=
Date:   Sun, 30 Apr 2023 10:00:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.4
Message-ID: <2023043019-speak-rover-8042@gregkh>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
 <2023042544-cargo-reexamine-ed86@gregkh>
 <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
 <ZEtj1oWqBlmgwc2b@kroah.com>
 <1d060b2a-84b5-a3e7-c97d-ac656f244811@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d060b2a-84b5-a3e7-c97d-ac656f244811@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 09:29:39AM +0900, Chanwoo Choi wrote:
> On 23. 4. 28. 15:12, Greg Kroah-Hartman wrote:
> > On Wed, Apr 26, 2023 at 03:49:17AM +0900, Chanwoo Choi wrote:
> >> Dear Greg,
> >>
> >> On 23. 4. 25. 22:22, Greg Kroah-Hartman wrote:
> >>> On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
> >>>> Dear Greg,
> >>>>
> >>>> Gently ping for v6.4.
> >>>
> >>> Ouch, something went wrong with your first email and it ended up in my
> >>> spam folder in gmail, so sorry about that :(
> >>
> >> I'm sorry. I'll use the @kernel.org account on next time.
> >>
> >>
> >>>
> >>> Is your tree included in linux-next already?
> >>>
> >>
> >> Yes. extcon.git was included in linux-next.
> >>
> >> And my pull request edited the 'class_create()'
> >> Thus, it might have a conflict as following report[1] from Stetphen Rothwell (linux-next.git).
> >> [1] https://lore.kernel.org/lkml/ZBhOTW9v9jzJVY7e@kroah.com/
> > 
> > Ok, I tried to pull this today, but I get the following error:
> > 
> > Commit: 40f9fc3c2b38 ("extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency")
> > 	Fixes tag: Fixes: 19685ae43489 ("extcon: usbc-tusb320: add usb_role_switch support")
> > 	Has these problem(s):
> > 		- Target SHA1 does not exist
> > 
> > Are you sure that linux-next actually passed this tree?
> > 
> > All of these were added to your tree only 12 days ago.  Perhaps we should just
> > wait until 6.5-rc1 for the new features, and take the bug fixes now?  Can you
> > redo this to make it so I can take the bugfixes after 6.4-rc1 is out, and throw
> > away this tree for now?
> 
> Dear Greg,
> 
> I'm so sorry for my fault. I rebased extcon-next tree based on char-misc.git(v6.3-rc6)
> right before sending the pull request. It it the reason to be changed of the commit id.

Please don't rebase unless you really really have a good reason to.
It's almost never needed.

> I'll fix issue and then send the pull request for 6.5-rc1 on later. I'll not rebase
> the extcon branch before sending the pull request and use the kernel.org email.

Great, that should work, thanks.

greg k-h
