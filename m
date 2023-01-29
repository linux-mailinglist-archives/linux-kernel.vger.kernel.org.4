Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E117568023B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjA2WVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjA2WVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:21:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1995A1E1CC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:21:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB3A60C44
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 22:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D499BC433EF;
        Sun, 29 Jan 2023 22:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675030885;
        bh=S9aCTJdiJ4J3W8rm2jH3gyQONdwwQxdeCBG4z3DUEkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5i/ZpDKq48vHy3l892jwIGQo+lfAN7vrNXpufDb37TM+NzvZ7igFP9poV4vEHGYm
         486aydmq1pg8GDvyb5v2YzGxQ568dmAeNEM6kVuMQ3i4uxU9dLjbsBms9GmVjc30YK
         UxLQV2lT5ANIfVqz+U69w4QQ5gkqb28fXKvj7z7QeeyobUM3CmD6eEhwiV0y/ZrZcK
         fyyDqLwKAX/KeFwoTCDzlcHbDOOS6KGIXdbaxVg+H6MUz1Su1ia3piPO+LaUw8AY1q
         yjk+Sx++oETjOOyTeRcM9o+lE71BSYDplvyg3ctiMjveESupv1sMq2vC6qBw5UFURy
         zAfoBY+JFkxrg==
Received: by pali.im (Postfix)
        id 5784B976; Sun, 29 Jan 2023 23:21:21 +0100 (CET)
Date:   Sun, 29 Jan 2023 23:21:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pktcdvd
Message-ID: <20230129222121.tjfxgzfqvwj3sotp@pali>
References: <20230105174210.jbjoqelllcrd57q6@pali>
 <58d3649f-3c8c-8b12-1930-f06f59837ad5@kernel.dk>
 <CAHk-=wiKUWm3VoYHK-oKixc9nF5Qdwp598MPSoh=jdxKAU1bOw@mail.gmail.com>
 <1933bddd-42d7-d92b-974f-f26c46c01547@kernel.dk>
 <CAHk-=wjJ=wD5D80hkWNCjJqS+djckAL+nXhXaHaiFzMAMve3rA@mail.gmail.com>
 <182bc0ee-51e3-b8c4-59f7-dcf702865a95@kernel.dk>
 <20230106165809.vkz7lr7gi3xce22e@pali>
 <fd143218-d8ba-e6c5-9225-b8e2aee09979@kernel.dk>
 <20230128193458.ukl35ev4mwbjmu6b@pali>
 <8a22d187-57b4-7a2a-b564-f88bde4ac7ce@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a22d187-57b4-7a2a-b564-f88bde4ac7ce@kernel.dk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 January 2023 14:55:27 Jens Axboe wrote:
> This does not look like a new issue (eg related to this series), and
> this is exactly one of the reasons we wanted to get rid of this code -
> basically nobody tests it, as nobody has the ability to. That means it's
> very time consuming to debug issues with it.

I understand. I could try to look at it. The main issue for me is that I
have not looked at this low level block device kernel area and I do not
understand what is the code around doing...

> What is the newest kernel you've run the pktcdvd driver on?

4.19 from Debian 10. I'm not sure if I used newer version as most stuff
is still on Debian 10 as I have not find a time to do upgrade of
everything.
