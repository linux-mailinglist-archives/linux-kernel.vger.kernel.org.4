Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8C65C249
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbjACOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:51:29 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D1EE1E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:51:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D69785C008E;
        Tue,  3 Jan 2023 09:51:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 03 Jan 2023 09:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1672757485; x=1672843885; bh=rKKF4pyesR
        /u1WYNk8McfGW3/FiMIIo4fxZlRkxOFw8=; b=t8QeHA+cqNDLXfsO4EqgHufSz1
        W1fuCLgncTKZSFtJa1Fp7+0sLrb63PhgTsLZmYf9/ASkKWuvnfH+7JRaVZP8gKns
        O3QNAy/Z6tew4Ie2Sc1XXKiuv7LYBZzcNGSUR/oP3iYLnDTaNLBUqT/NHTat5WvS
        MlfDXEdkfvLsYnDhxGkv+qsTxtRukOL9JUB5zX98W0Y+BkbAYie6wF0KIsbXgd61
        qXoR61XTqppV56QavdzzrSBGjFlTy4jwyOqLVSBTev8fFLBoRbpWAPdmb2Niog6y
        wLCteMPG6PLYzyWnlPmz3+i/StuDuRpfU9a8NBKsDD5tlBRRdhpje+cKjlKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672757485; x=1672843885; bh=rKKF4pyesR/u1WYNk8McfGW3/FiM
        IIo4fxZlRkxOFw8=; b=S5LUXTaaHwhYpV8i9Aw+4m5awhzByHcndFKDbT3M2jtY
        1GGyylcThrSdJTrbrnh7jC3AouMt3g/qOFtTHOGLu1jpoU62EPloM+dzsvxLL8Pd
        a6z7iI+v6SS9ewpp3CkD2A8hwU+3Q00HgoJyjvSdrjJRyc4wW8nIM3zpvqYe35TZ
        lwkDKNxgEWsY3oBQ0sBEt1wRmdujiYIqvQ7rZ/0gPaG5yUqVQ/QTPuyRlIpTK3T3
        ImdApsh5VvuwbElm/su3nlplfHXE95fxnfZtx8jn1AnrkSsfd+5wbny2CxN0sp3K
        loPKFTnAs5HO3vncECxi9l0EVdcnrO8j/L4ImxXBNA==
X-ME-Sender: <xms:7UC0Y0ZfhJK4EMM6kOrUHrQpYaBp_EWbGFHs2LhuFA2N9bPaXcdhIQ>
    <xme:7UC0Y_aQcyD7T9kwM_vllLBlADF5uSDW6SwhW66TVW1lNXWdTgRb9WZl9T_P0OREw
    uja8E68UJEDq7tA2mk>
X-ME-Received: <xmr:7UC0Y-8UmpPwKL6cHd32pD8vX-nEdEmyFPTi-7UblP78JniDWlMC9dLYkBbPuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:7UC0Y-oPoRpUNJTValC-d3v3WzmV0HEaHcniE03Gfb6wR9TDVi4sNg>
    <xmx:7UC0Y_rG296YSL_pD7HdZkcYlApMD2hLJm9cuEFwraJfvrQfFCpcSQ>
    <xmx:7UC0Y8TwthOTtIidb0jHvbg0dHq_OQXbjJ_XIGxq1BP0KgFtXUfnWw>
    <xmx:7UC0Y-UqG5jUDyuJBwBgp4kdF4gGVv9ICOuJdIVsqeddvYvqHXNTrA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jan 2023 09:51:23 -0500 (EST)
Date:   Tue, 3 Jan 2023 07:51:22 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <Y7RA6pzP82mNWxOQ@tycho.pizza>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza>
 <Y4TNI8+QVHFuzeZC@tycho.pizza>
 <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
 <Y5IjpyLHIF8PgQ6l@tycho.pizza>
 <Y6C4ni3wpkaYxmLw@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6C4ni3wpkaYxmLw@tycho.pizza>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 12:16:50PM -0700, Tycho Andersen wrote:
> On Thu, Dec 08, 2022 at 10:49:30AM -0700, Tycho Andersen wrote:
> > On Thu, Dec 08, 2022 at 03:26:19PM +0100, Miklos Szeredi wrote:
> > > On Mon, 28 Nov 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > > >
> > > > Hi Milkos,
> > > >
> > > > On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> > > > > v3: use schedule_work() to avoid other sleeps in inode_write_now() and
> > > > >     fuse_sync_writes(). Fix a UAF of the stack-based inarg.
> > > >
> > > > Thoughts on this version?
> > > 
> > > Skipping attr invalidation on success is wrong.
> > 
> > Agreed, that looks like my mistake.
> > 
> > > How about the attached (untested) patch?
> > 
> > It passes my reproducer with no warnings or anything. Feel free to
> > add:
> > 
> > Tested-by: Tycho Andersen <tycho@tycho.pizza>
> > 
> > if you want to commit it.
> 
> Ping, thoughts on landing this?

Happy new year all. Any update here?

Thanks,

Tycho
