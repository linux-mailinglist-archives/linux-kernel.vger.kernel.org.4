Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B2B66052D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAFQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjAFQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:58:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4D78A7C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 799A661A27
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8ABC433D2;
        Fri,  6 Jan 2023 16:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673024292;
        bh=JyZGOJP4/NukyFMmeiyPZ3FypoTBSgJYWood3uwdP/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUBAlr3x4lJ3uy9sOag15lwabM6XKtfLJ3HLpNQCS/nwXIk+k4aodoUJ83gS26k3j
         e3PaHgEaEqeo1s0rVBLAaB5p0JGp8O8e44DMR4viYFYbLSVHt5D+VEr43EsdrHdg1P
         k4IPdC6L5FkW19EtG0JeZGeBaEbmC7dLo1+W5foM9QLSAWesLrit4zyxz71xTdD6u7
         2YgYm6M+EeOVjfU65CwWgwEvG6L45ReT8l4xGFqEE+8DPize4l9lODOI7tUedKXfmP
         5zhqnjkarid5GFKp3O8qZ5lODYBc4JRGPN5czk87QLZUXxSjjA01Cyv4KPDPixq63w
         B7rlz6WT7y0fA==
Received: by pali.im (Postfix)
        id 09722A3A; Fri,  6 Jan 2023 17:58:09 +0100 (CET)
Date:   Fri, 6 Jan 2023 17:58:09 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20230106165809.vkz7lr7gi3xce22e@pali>
References: <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk>
 <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2023 13:33:11 Jens Axboe wrote:
> On 1/5/23 1:03?PM, Linus Torvalds wrote:
> > So nobody is going to be motivated to do any development in this area,
> > and the best we can do is probably to just keep it limping along.
> 
> Indeed...
...
> > There's probably other cruft in pktcdvd that could be removed without
> > removing the whole driver, but I do get the feeling that it's just
> > less pain to keep the status quo, and that there isn't really much
> > motivation for anybody to do anything else.
> 
> I'm reluctant to touch it outside of changes that are driven by core
> changes, and of course the motivation to remove it was driven by not
> wanting to do that either. Any kind of re-architecting of how it works I
> would not advocate for. It supposedly works well enough that none of the
> (few) users are reporting issues with it, best to just let it remain
> like that imho.

Yea, I agree. This code is in state when it is _used_ and not developed
anymore. Nobody is really motivated to re-architecture or rewrite this
code. Such work has big probability to break something which currently
works fine. And because lot of users are on stable/LTS kernel versions,
it is possible that we would not notice breakage earlier than (lets say)
in 5 years.
