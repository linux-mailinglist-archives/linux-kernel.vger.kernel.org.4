Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1F164751F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiLHRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLHRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:49:34 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375059B2A9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:49:33 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 091315C00DD;
        Thu,  8 Dec 2022 12:49:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Dec 2022 12:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670521770; x=1670608170; bh=C8TXy9Fk8+
        /VGu61vKrcCcU3jfSCcH0UL/PnmjTog/Q=; b=Ndnm5x+y48/6cXmUhP1+nDdC5i
        lNJHYEPZWgRBW1PdJNVR3wjlmNy+XFBovGBYHpqoKQ25dkUCoJXSkpX9ozd6UVRf
        pq2LfTp1YFmR2NNIFXeJx+BEM9ajCozSxXl5JueOZOlG3QbnGoE2EhMsYFPvogdr
        gUQ2hIu1BEDUGAYZQhScWg+3CDG4TgwiwMXbEgQRhFcKBJ97lczllSPUV15lzkWF
        c0JPaVhalfpXTh8ESVvY58Izii9eXt8fl3IJPibt1yrmvujwafEbsxoE1gf39JLy
        lwnocGQUZbasVZMuYw1XHoorPwsvEjY2X4Cg/CNsCVF31U/QxOyimXjP5iiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670521770; x=1670608170; bh=C8TXy9Fk8+/VGu61vKrcCcU3jfSC
        cH0UL/PnmjTog/Q=; b=Rm8PX8MvBTjvGl6e464tif7hA3DfX/zV1jczJm7KnnKD
        R9XH9TybUEctphXVuh7IiH8LH3uQJKQUoaUDc/qAihbX6ewfalg1X2gHFg5QsTmR
        D2BNOXvcvLlIrrJMoHKMg9taJkbqq6YKs6+cH3BfL5cfSFPSk8d6H89ocENpopvq
        whvvxUfBZOq9AhpsoLuL2IOlLw7szYguht/fm90sVV6VAlQOiMA3fbtakFnkZGP8
        YxKg18azrPb3XvSNSSenOGOxNIGrWO39sAcQNTPpx8S+GaDlmqEeJ8aDxG5w6ZNi
        4RqC2YpoBZ/0m0Jlp4EAF7FHXitA2CkzzVs33M+q4w==
X-ME-Sender: <xms:qSOSY46Xfppjxhqb2fytVl1dqeBQWHbhnb9dzkoXsznn4CcqfJmuTw>
    <xme:qSOSY5437qZMOzRB-dmA8gVqgz1MXuoellqP2q4s4RLjn9P3RLXyQ-Jx_Mb1CzLKB
    ID4guJyGnW8pFiUOQ8>
X-ME-Received: <xmr:qSOSY3f6bVpJP6B9_Z2G8cyAbnAJLAKVc1U0Q4mjOr5s_JOiUWg1ApQUAgQVMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:qSOSY9L6cayahyEnFTkWcILhnLcnjAzxDBrPXjmNhVwJ394DlUxe9w>
    <xmx:qSOSY8I7vGWMcj-IhHLyiAFSq25UHyZUqOqNBZjm-988pNxglwn-3g>
    <xmx:qSOSY-xZlELmoy_nNlOdbrGW_NAvmEhRtAwUUg5CjqdfmVYIebuXoQ>
    <xmx:qiOSYw2RvTHuSlYti-OkkDV8BcCIF2SlgJhRFveQZ_DFFG906veFjA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Dec 2022 12:49:28 -0500 (EST)
Date:   Thu, 8 Dec 2022 10:49:27 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <Y5IjpyLHIF8PgQ6l@tycho.pizza>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza>
 <Y4TNI8+QVHFuzeZC@tycho.pizza>
 <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 03:26:19PM +0100, Miklos Szeredi wrote:
> On Mon, 28 Nov 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> >
> > Hi Milkos,
> >
> > On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> > > v3: use schedule_work() to avoid other sleeps in inode_write_now() and
> > >     fuse_sync_writes(). Fix a UAF of the stack-based inarg.
> >
> > Thoughts on this version?
> 
> Skipping attr invalidation on success is wrong.

Agreed, that looks like my mistake.

> How about the attached (untested) patch?

It passes my reproducer with no warnings or anything. Feel free to
add:

Tested-by: Tycho Andersen <tycho@tycho.pizza>

if you want to commit it.

Tycho
