Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0776F11A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 08:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjD1GMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1GMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 02:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D31706
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 23:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434E564112
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EFEC4339C;
        Fri, 28 Apr 2023 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682662361;
        bh=ObWw6IgeuIraZypHl9EvyinBGxIH2htI5MWlDCNmV4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXz7NlEzGaB0gJ+DYbCctzX4CkAGWTzOn5n14rVYYnzgOg33yKwB5RlT+EacLlxL+
         7MgTzJ7P/JTz3XS/RG02+JFsZ+wtIUIHugpxGf1gbDvd/Kl+UZrkGZr9exWDT5Av4y
         Mta/UuhubNTruVCulqaR//VcGkr6XJkxey0sF5qA=
Date:   Fri, 28 Apr 2023 08:12:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.4
Message-ID: <ZEtj1oWqBlmgwc2b@kroah.com>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
 <2023042544-cargo-reexamine-ed86@gregkh>
 <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305aedea-599a-48b0-e3a9-6f71b75e14d8@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 03:49:17AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> On 23. 4. 25. 22:22, Greg Kroah-Hartman wrote:
> > On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
> >> Dear Greg,
> >>
> >> Gently ping for v6.4.
> > 
> > Ouch, something went wrong with your first email and it ended up in my
> > spam folder in gmail, so sorry about that :(
> 
> I'm sorry. I'll use the @kernel.org account on next time.
> 
> 
> > 
> > Is your tree included in linux-next already?
> > 
> 
> Yes. extcon.git was included in linux-next.
> 
> And my pull request edited the 'class_create()'
> Thus, it might have a conflict as following report[1] from Stetphen Rothwell (linux-next.git).
> [1] https://lore.kernel.org/lkml/ZBhOTW9v9jzJVY7e@kroah.com/

Ok, I tried to pull this today, but I get the following error:

Commit: 40f9fc3c2b38 ("extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency")
	Fixes tag: Fixes: 19685ae43489 ("extcon: usbc-tusb320: add usb_role_switch support")
	Has these problem(s):
		- Target SHA1 does not exist

Are you sure that linux-next actually passed this tree?

All of these were added to your tree only 12 days ago.  Perhaps we should just
wait until 6.5-rc1 for the new features, and take the bug fixes now?  Can you
redo this to make it so I can take the bugfixes after 6.4-rc1 is out, and throw
away this tree for now?

thanks,

greg k-h
