Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CF735872
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFSNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFSNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:23:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D5AA;
        Mon, 19 Jun 2023 06:23:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C23375C0223;
        Mon, 19 Jun 2023 09:23:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Jun 2023 09:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687180994; x=1687267394; bh=ASPRc812BqeG3IP2gOvPXV96skEUS/n5Qf0
        rjro4vAs=; b=cIXuO0NivKdu3dZltGFduow/h3a1BhzFNX9L8BToqBYSW09jkc4
        VjCG4/YgXSjK0ll6hWzk97FmO8HJfIUh5uV2B1xg6/DQzIpQggPx4iQ7aaRMYKnY
        UZ6GAuNMOv0nVGNDrGpIVgOV827zFH0uHBPq8Mgmyr8T4Bid6/l+QuBuInnOvqnX
        cx1Rx9Pfx8SJI+679YakyBXX+hc2yIe+ctl8oUoYlEn6aqnPSNwcvkF1niJo3scs
        xjz3iVCGzo44bC1CbGtJrrrNBwsH7KlOmZUkCX0v/uUH0Z81HNl5zKl48M7/iQEd
        8gpx/mVneG5+dot4dpW4xi69l7Np51H8bNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687180994; x=1687267394; bh=ASPRc812BqeG3
        IP2gOvPXV96skEUS/n5Qf0rjro4vAs=; b=feWosbWJs2yEObUFFmxbxCkEmBlLR
        8w+YwJJUg3vIRs96ut6UsOVXEBicuo13LjcGFUePYcRfkYBZhFqLVvK0LAe2oAh0
        Q57ODyt1xwNHjtt4t9B3iWDx6YEBZ98vooMq5J7/cXxuJamJ7bsn3L4weJ+r7fXy
        VzyifQPw3XPjGqv5ExTvwMwrikjnFH4UV2XWvL+VS8ikJVFG92Xrkqs04ql9zHJB
        KyICrrLu49oMyrMXuD/Z9MEbihVRmbDH6ioK0i3TZ56yjIAZ0ZDLtSDNBd0NuBnV
        7KflO0CiK3tYeYgIUjY4wd9M6/Ur6LlEDQK0/4dmaBJukZal6W7RnxRtQ==
X-ME-Sender: <xms:wlaQZOJ7csfISJBJYkNV1HQVzj6FoK3oqNHoi4gJkX8Clfb_HLypWQ>
    <xme:wlaQZGLnWT8FeAZTidgJxE215Md2PVirGoVABCMlg4BaopMinuJjRVWAGpsADLf01
    c3q1OE2cyKVrw>
X-ME-Received: <xmr:wlaQZOvo4QAtr99KG68a31mFsgiXcCyDUtPjXe4UDGAXhuNu5VgNtYC9vqjZMsos55XuCnrjjNFp4iAY8G1bzLfSQpPY5Ab2ht8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefvddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdu
    leetfeevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:wlaQZDa6-h6t6S7YEj_zXPPfyvQ49mFoTjASN6FX0icDarjF4yFPWA>
    <xmx:wlaQZFaRGS7NOvGdUKGHAtOtUQqEeGLZRR7OOfQwMyO0ImylgVDWVw>
    <xmx:wlaQZPDBpKnCnoIo2dt_yol4IJb0-xta2elZMcnMG0xWJ8UpC5jGhg>
    <xmx:wlaQZKOd3hYPL0GAQZGKY3O9Jxh6p5E1MUQQ8vFCHxgRPxqua0e7yw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 09:23:12 -0400 (EDT)
Date:   Mon, 19 Jun 2023 15:23:10 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <JBeulich@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] xen: speed up grant-table reclaim
Message-ID: <ZJBWvpt3UAxeIC13@mail-itl>
References: <20230610153232.1859-1-demi@invisiblethingslab.com>
 <85275900-6b6a-5391-a2a0-16704df3f00f@suse.com>
 <ZId7ixbqlCSygtvb@itl-email>
 <1150fd9c-25c8-c91c-4ca2-2c587e3fbb43@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oN+TsMtwsmB08J9P"
Content-Disposition: inline
In-Reply-To: <1150fd9c-25c8-c91c-4ca2-2c587e3fbb43@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oN+TsMtwsmB08J9P
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Jun 2023 15:23:10 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <JBeulich@suse.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Xen developer discussion <xen-devel@lists.xenproject.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xen: speed up grant-table reclaim

On Tue, Jun 13, 2023 at 08:45:31AM +0200, Juergen Gross wrote:
> On 12.06.23 22:09, Demi Marie Obenour wrote:
> > On Mon, Jun 12, 2023 at 08:27:59AM +0200, Juergen Gross wrote:
> > > On 10.06.23 17:32, Demi Marie Obenour wrote:
> > > > When a grant entry is still in use by the remote domain, Linux must=
 put
> > > > it on a deferred list.
> > >=20
> > > This lacks quite some context.
> > >=20
> > > The main problem is related to the grant not having been unmapped aft=
er
> > > the end of a request, but the side granting the access is assuming th=
is
> > > should be the case.
> >=20
> > The GUI agent has relied on deferred grant reclaim for as long as it has
> > existed.  One could argue that doing so means that the agent is misusing
> > gntalloc, but this is not documented anywhere.  A better fix would be to
> > use IOCTL_GNTDEV_SET_UNMAP_NOTIFY in the GUI daemon.
>=20
> I don't think this is a gntalloc specific problem. You could create the s=
ame
> problem with a kernel implementation.
>=20
> And yes, using IOCTL_GNTDEV_SET_UNMAP_NOTIFY might be a good idea.

Just a comment to this one: while in practice it might work most of the
time, in theory there could be hundreds or even thousands of mappings at
the same time and event channels seems to be too scarce resource to get
unmap notification for all of those (even if you'd use an event channel
per grant area, not individual page).
As said to Demi elsewhere, our GUI protocol might have a way to signal
when unmapping happened, but the backend (the side mapping the grants)
would need to know when they actually were unmapped by another process
(in some configurations, like Wayland mentioned below, the process
itself doesn't give us this info). Ideally, for this we'd need something
similar to IOCTL_GNTDEV_SET_UNMAP_NOTIFY that notifies the mapping side, not
the other domain. I have no idea how such API should look (just
poll()/read() on the gntdev FD used for that IOCTL?) or whether it's
really worth adding such API.
Or maybe something like this already exists? In worst case, even polling
for this info (so - a way to check if process P has grant G from domain
D still mapped) would do, although that wouldn't be ideal.

> > > In general this means that the two sides implementing the protocol do=
n't
> > > agree how it should work, or that the protocol itself has a flaw.
> >=20
> > What would a better solution be?  This is going to be particularly
> > tricky with Wayland, as the wl_shm protocol makes absolutely no
> > guarantees that compositors will promptly release the mapping and
> > provides no way whatsoever for Wayland clients to know when this has
> > happened.  Relying on an LD_PRELOAD hack is not sustainable.


Anyway, besides trying to fix our usage of grant tables, I think it's
still worthwhile to improve deferred reclaim, either by making the limit
per iteration configurable (sysfs node / writable module parameter is
fine) or by making the limit not needed by using workqueue. The former
sounds like a smaller code change.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--oN+TsMtwsmB08J9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmSQVr4ACgkQ24/THMrX
1yyh2gf+NouvKQSmSXw0WMD1FLa4ZACvsVdcsJy7Prup6EjdKYT/5hicLhNOM7Os
0ctvuvVYt1gEUrJu/BsWgCd2u55yYEe4VH2oeqiDJF3kqhUFOTRCzpWzr3+3COzf
e4gzlHfhwc82S9VrvhwGsCOiWRv+BduUa3x/AlWufrDjloIOYZ4tWuaCptYh/vnP
9khLdrg7gWDFXbslRW21rrPkuQDKqLe9E4q4bgBlgjKMQd9Qyw6KxyF+gd5I0WDl
BPWJnIqX7ps4bnxNQw7r6VvIjkd9UhMG9pryM4mYSC5/+oO86TOwuboBqWw+SvHJ
OXhGeB0gN1QZxMuvnp9ipUIci3NIcw==
=7szl
-----END PGP SIGNATURE-----

--oN+TsMtwsmB08J9P--
