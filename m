Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165F66D4DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 04:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjAQDHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 22:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjAQDHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 22:07:36 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F81F4B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 19:07:34 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30H37PNn029709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673924847; bh=la0czL1ri2v0M9C3hHciXym3Me+R7N9RF/tlNKNq3FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EsuFtl6aHFpWBhHwwhV7hHWx1Xtd9C2Iw32g5mv5sCL2U+QEefCzmC2C+1X+uEPzd
         HCaiM68C8JtSlooN9MGv1T1YibzIt15LiAN5wiTsenSonq97+b0P+Nm7XpRsXNL8LO
         k+CLzE+LjQCF5/uPelu7pGtKe2UMdppMoJgzwnE9jLVvLYmoCCHVOdwqTwE9vUUOOa
         YSn0V59QZlp2OvmB8paYrsAv5hFhSss2bYE1FJRrq0QUNVt+w9EjmmNnqTOiI//7s/
         +WxnUEePpMWzForPpLcsmog0BgjYF26shAyxCV/t5KvdOqU4kbP7x4yipRp50c3hqP
         ePKbYRsUSALPw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C51215C3A1B; Mon, 16 Jan 2023 22:07:25 -0500 (EST)
Date:   Mon, 16 Jan 2023 22:07:25 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Kris Chaplin <kris.chaplin@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y8YQ7SIRV3bG3iw1@mit.edu>
References: <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
 <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu>
 <a1f1ad90-5f66-c73f-06ce-4ce65d079d1b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f1ad90-5f66-c73f-06ce-4ce65d079d1b@amd.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 01:16:33PM +0100, Michal Simek wrote:
> > This is probably the best reason not to preannounce when the LTS
> > release will be ahead of time --- because it can be abused by
> > developers who try to get not-ready-for-prime-time features into what
> > they think will be the LTS kernel, with the result that the last
> > release of the year could be utterly unsitable for that perpose.
> 
> None is saying that not-ready-for-prime-time feature is pushed.
> In our case all code before upstream goes to soc vendor and it stays there
> for quite a long time when developers have time to upstream it.
> I can imagine that this can happen when you use upstream first solution
> where the code is not fully tested on all configurations.

The problem is that sometimes code meant for a particular SOC could
break other users.  The most extreme versions of this was an SOC
kernel that support in for big.little ARM CPU's that created generic
kernel .c files that *would* *not* *compile* on x86.  I've seen this
personally, and it impacted the ability for me to implement ext4
encryption for Chrome and Android, in that it worked fine on the
upstream kernel (because *I* develop my featuers upstream first), but
broke when I had to adapt and make chagnes for the SOC kernel that had
changs that had not been pushed upstream.

So if it hasn't been pushed to the upstream kernel, all of the testing
in the world in the SOC kernels doesn't count.  Push to upstream
*first*, and *then* backport to the SOC kernel.  Better yet, if all of
your device drivers are developed upstream first, then you might not
need that never to be sufficiently @#$?!@? SOC kernel...

> But our customers/users are making products based on code we developed for them.
> That's why I am telling to developers to upstream code whenever it is ready
> to be upstreamed but not everybody is following recommendations . And for
> new SOCs we should be couple of months ahead for any customer that's why it
> shouldn't really matter if that feature goes to one or another kernel.

If people don't listen to you, then they deserve all the pain that
they get, and upstream should not be bending over backwards for them.
And maybe we can try to get mobile device manufacturers to choose not
to chose that SOC when making choices for their next generation
flagship devices....

						- Ted
