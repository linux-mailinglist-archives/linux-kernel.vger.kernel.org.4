Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8B665A53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjAKLh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjAKLh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:37:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531421DF1B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:34:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACC2BB819EF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75FC433D2;
        Wed, 11 Jan 2023 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436821;
        bh=HQIgtanyEm2Ah0TbVzmva7KtFo9tPgB6bRUi+i9nPaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzX8hsx45PDeJ/LEssi9cY2EPWGp9ZkyJu+CEWtrh/kss+LxLuHHGI+HkNUM7Nd2Y
         ttTXaUttdFn49UoFYEIF4tJ6yuSHJyXseWjW7bM4XdtYWSeJ8ESNc4mq0yZqHERL58
         axb4BQhco6ebbrWlJg8yrbjvNvBdGVyVeRnMF5vo=
Date:   Wed, 11 Jan 2023 12:33:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y76eklrASMczPLY0@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <Y75wGwt2r8iWlCYf@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y75wGwt2r8iWlCYf@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 08:15:23AM +0000, Conor Dooley wrote:
> Hey Greg,
> 
> You didn't ask me specifically, but if it helps...

It really really does, thank you!

> On Sat, Dec 17, 2022 at 02:18:30PM +0100, Greg KH wrote:
> > On Sat, Dec 17, 2022 at 06:32:48PM +0530, Kaiwan N Billimoria wrote:
> > > Hi,
> > > Any update on 6.1 being set as the next LTS release?
> > 
> > You tell me please.  How has your testing gone for 6.1 so far?
> > Does it work properly for you?
> 
> AFIACT, it does. We had some issues, but they've since been resolved.

Great!

> > Are you and/or your company willing to test out
> > the -rc releases and provide feedback if it works or not for your
> > systems?
> 
> Already do! Although so far I've just been reporting breakages rather
> than providing tested-bys.

Feel free to submit a tested-by if you want credit for doing the work
(and so that I know it still is working), I'm more than glad to collect
them all as they end up in the release commit message in the kernel log.
One example can be seen here:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.1.y&id=2cb8e624295ffa0c4d659fcec7d9e7a6c48de156

> > Do you have problems with 6.1.y vs. older kernels?
> 
> Nope, anything that needed fixing that was on my radar has already made
> it into 6.1.y.
> 
> > Is there
> > anything missing in it that you feel needs to be addressed with a newer
> > kernel instead?
> 
> Anything missing on the RISC-V side of things, that we would want, is
> still a work in progress for kernels later than 6.2 anyway.

that's great to hear, thanks for letting me know and for testing.

greg k-h
