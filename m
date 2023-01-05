Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89165F30A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjAERmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjAERmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:42:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E663DBEC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1599B61BB0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEBEC433D2;
        Thu,  5 Jan 2023 17:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672940533;
        bh=a61KkIePdXlYGDag8VaLi1SSd+gN9exN7x8rEnDhhZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXjGS9OtwvQcP9O3OIa0l9g8LrBaQy+nYS688Qah1j7pLXN16gaaJ5SNSaLuG3syy
         l8ZggK2srDEWdrLV9puJtd9h649v2AVocniXs5RRQbHe/o5Shba8P3HVj8eB6QjnXm
         bPzOs9FknSzvjjPwyjOR7Zwcy0ftiyRRyxOirgzhF0A72AYK3JQs7COrcpxZVKFFTo
         0M9WlKIWkfb1pchUktEo3RNrRsPDPZVa26vCrw/ArMR4H3JRT52Bawu/ijZJ/M1MxE
         KKTUL41pp3e5LKQY1tlgDrgKIpDkb1HbgBAT8y2gUvCNI4l041WVLO4rHGZCLfEeB3
         UMTD3DgWYXpFA==
Received: by pali.im (Postfix)
        id 5A6DAAC9; Thu,  5 Jan 2023 18:42:10 +0100 (CET)
Date:   Thu, 5 Jan 2023 18:42:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20230105174210.jbjoqelllcrd57q6@pali>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2023 14:43:16 Jens Axboe wrote:
> On 1/4/23 2:32?PM, Linus Torvalds wrote:
> >> But here it is CD-RW media in read-write mode with kernel udf
> >> filesystem driver without any userspace involved (after proper
> >> formatting).
> > 
> > ... but I'm not sure about direct writeable mount support.
> > 
> > That may indeed be an area that only pktcdvd ended up doing. I've
> > never used it myself, even historically.
> > 
> > Let's bring in more people. Because they may not have thought about
> > some RW UDF case.
> 
> We did think about it, since that's the only reason for pktcdvd to
> exist. Basically what the driver does is ensure that any write is 32K in
> size, which is the size which can be written to media. It'll gather data
> as needed to make that happen. Thats it. Outside of that, it's just some
> setup and closing code.
> 
> This obviously would be better to handle in userspace, all of it. Back
> when I wrote this driver, we didn't have a lot of the fancier stuff we
> have today. It could be done via ublk, for example, or something like
> that.
> 
> The surprising bit here is:
> 
> 1) Someone is still using this driver, and
> 2) It actually works!

Yes, there are still users and userspace tools (cdrwtool / pktsetup) are
still receiving either small patches or issue reports. I think that it
was two years ago when cdrwtool received big fixups to support
formatting CD-RW discs on new CD/DVD drives.

> While I'd love to nudge folks in other directions for this use case, and
> I strongly think that we should, it also doesn't seem fair to just yank
> it while folks are using it... But I'd like to VERY strongly encourage
> folks to come up with a new solution for this use case. It really isn't
> a solution that belongs in the kernel today.

Linus in previous email wrote that he did "make SCSI commands generic"
work in past so direct usage of /dev/cdrom device works for CD-R burning
and read-only mounting.

So could not be (for example sr.c) driver extended to directly do
pktcdvd's work? So when somebody opens /dev/cdrom device in O_RDWR mode
and CD-RW medium is present then it would behave like pktcdvd device...
To have /dev/cdrom generic also for CD-RW write access.

> > The removal seems to revert cleanly, although it does require
> > reverting a few subsequent commits too (that removed code that only
> > pktcdvd used):
> > 
> >     git revert db1c7d779767 85d6ce58e493 f40eb99897af
> > 
> > where we have
> > 
> >     db1c7d779767 block: bio_copy_data_iter
> >     85d6ce58e493 block: remove devnode callback from struct
> > block_device_operations
> >     f40eb99897af pktcdvd: remove driver.
> 
> I'll queue this up - and unless I hear valid complaints to why we should
> not just reinstate the driver for now, it'll go out with the next pull
> request.
> 
> -- 
> Jens Axboe
> 
