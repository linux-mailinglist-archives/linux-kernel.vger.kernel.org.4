Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076AF632933
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiKUQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiKUQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:16:50 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76726D39D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:16:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EFBE5C01EE;
        Mon, 21 Nov 2022 11:16:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Nov 2022 11:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1669047403; x=
        1669133803; bh=8u8BK+CFOK6Os3q3JXi2LJOFdVIbcEqAq43H0giut5I=; b=a
        1AsJBgHv/PWsYOqBDV6KWtZK9U51frFcUYVVexL9W99wdVN/wA7niic6xoagcZ9m
        jLckeRlhfPDolwITvqk3EuBat+8GbmVsJULLtxajVFlqJFZWfW4AWvUZm1jtYwia
        jGvPjTq0uwHiytaAeKg/BboxsD5N4V+3aW906md+G3/TC36s08eRp2i7LL2w2aul
        ldd1T8S4iU+aG8ggEJPxWy294S1avVisBcHTGGLVc+zF/8WXtHH2OVKZU4r5M9oz
        WXBXPXlpx6BZq0Lte6IcPQa1LDPxir3yT60prg5EzJc3HE+gHe86u6P1L4IO1M7s
        5WWjlZ+3pBKvtLNgNXWaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669047403; x=1669133803; bh=8u8BK+CFOK6Os3q3JXi2LJOFdVIb
        cEqAq43H0giut5I=; b=P6gIsGnHA8cbrAgjOHVE6p1MLiEV0C55j+cYjEvhl/RP
        sY+rA9V49gRUZF1rTWAxLN4jqlfLofdrMHw9n//8hrjGTFOnnE3V5r/A2v3voZ6d
        E/G6GBSLHIMZcwAXZTUPC1qj8QqUzweSXTmP7NQW3af8OXQE6M48WPDCFSjlE12S
        EwIbG/2xV5Kr0nBOAwri+P/FqeXN3hWZRo+meSvxBRd8FAITRN2UJRLBWGiguevH
        gfQwWAD8mP2PsxDDesccivP7ARMIHUdwDbY/ReG9QHDs04E3UiyeN83sKbwbv+3r
        2smN+20GvljOIYu51qASdrw0CvUOvzSCTHM1tSrrTQ==
X-ME-Sender: <xms:aqR7Yxz8zcyXKYj0AkfCTySjeXFK3zJ4MxV_XEUAv6enR4ldX7_gYA>
    <xme:aqR7YxSc-z2YGoBPYqqzkANgGEQNP3lKlsFiAJyHFt-0RLX82ra5g6T9IgV0cwo50
    RlUgEBejasIVQ>
X-ME-Received: <xmr:aqR7Y7XEK6S8SkVnsXYL7IwpaB9X8QAHc1Jihlweeg81bo5RNjXDq5w6FO3T-RRNVIQTPjFaMCVI4Qu8R0iqAKsLyPuQZBsXlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefgudel
    teefvefhfeehieetleeihfejhfeludevteetkeevtedtvdegueetfeejudenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:aqR7YzjLHMs95Gjl7dNK4APG1Y5M-KQaBRPQEM6owWBmX18RCgtC8Q>
    <xmx:aqR7YzCbun1HxF0ZNI_HecV4XxGlmedNOOifhOtvEuyBWzawS8ylOA>
    <xmx:aqR7Y8LPB2HusT5B5zFGbIvNAlW3JBvSKISOGo0ZA-we9seB-JOfzQ>
    <xmx:a6R7Y-8lznO4BTfy7voYnwmmhjLUjiRaxTHEbmkE6Fy_fNfprxPTHA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 11:16:40 -0500 (EST)
Date:   Mon, 21 Nov 2022 17:16:37 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <Y3ukZqLaTqzjY/ro@mail-itl>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
 <Y3f9O0S8kVXZ+py+@mail-itl>
 <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
 <Y3kFYeml1CPL318u@mail-itl>
 <CAKf6xpts-u_JUtTGnzhxmRHZYVFnVMksTERZWS8EC+7BGsoViw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zq9ZSVbg9oNu91zv"
Content-Disposition: inline
In-Reply-To: <CAKf6xpts-u_JUtTGnzhxmRHZYVFnVMksTERZWS8EC+7BGsoViw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zq9ZSVbg9oNu91zv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Nov 2022 17:16:37 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Mon, Nov 21, 2022 at 10:41:34AM -0500, Jason Andryuk wrote:
> On Sat, Nov 19, 2022 at 11:33 AM Marek Marczykowski-G=C3=B3recki
> <marmarek@invisiblethingslab.com> wrote:
> >
> > On Sat, Nov 19, 2022 at 09:36:54AM -0500, Jason Andryuk wrote:
> > > Hi, Marek,
> > >
> > > On Fri, Nov 18, 2022 at 4:46 PM Marek Marczykowski-G=C3=B3recki
> > > <marmarek@invisiblethingslab.com> wrote:
> > > >
> > > > On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> > > > > I was trying to test your xen-pciback v3 patch, and I am having
> > > > > assignment fail consistently now.  It is actually failing to
> > > > > quarantine to domIO in the first place, which matches the failure=
 from
> > > > > the other day (when I more carefully read through the logs).  It =
now
> > > > > consistently fails to quarantine on every boot unlike the other d=
ay
> > > > > where it happened once.
> > > >
> > > > Does this include the very first assignment too, or only after doma=
in
> > > > reboot? If the latter, maybe some cleanup missed clearing MASKALL?
> > >
> > > It's the quarantine during dom0 boot that fails.  Later assignment
> > > during VM boot fails.  I tried warm reboots and cold boots and it
> > > happened both times.
> > >
> > > I also modified my initrd to halt in there and checked the config
> > > space.  MASKALL wasn't set at that time.  I need to double check -
> > > MASKALL may have been unset after dom0 booted in that case.
> > >
> > > I'll test more to figure when and how MASKALL is getting set.
>=20
> I'm testing with a laptop without a battery.  It seems MASKALL remains
> set when rebooting or when left plugged in.
>=20
> From unplugged, a cold boot doesn't have MASKALL set and the network vm b=
oots.
>=20
> After that, rebooting the laptop leaves MASKALL set on the NIC when
> the laptop reboots.   NIC assignment fails.
>=20
> Shutdown and later boot while left plugged in keeps MASKALL set.  NIC
> assignment fails.  I have only tested this scenario for short periods
> of time, so I don't know if it would eventually clear after a longer
> time.

That's interesting, seems like firmware is not resetting the device
properly. Maybe related to enabled wake on lan?

Anyway, resetting the device at domain create/destroy is AFAIR normally
done by pciback (at the instruction by the toolstack). Should it maybe
be done when assigning to pciback initially too? Or maybe in this
specific case, device reset doesn't properly clear MASKALL, so pciback
should clear it explicitly (after ensuring the MSI-X enable is cleared
too)?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--Zq9ZSVbg9oNu91zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN7pGYACgkQ24/THMrX
1yxERQf9H+wGG9EoUn9lEqAbJsW6Pe0L4+RgIEU63aMDb1AWJH8jNYkUWaNM5X6A
goktstxeX/Y3luFyhQujlu4+SyqVZdouIzyB2Y6LUf+GVo9a2uKVVYR1OpFAcoEM
w4vCPhDx4T6IE1iAWxLmLJzRz5c1BOEp7srCrDMCCShggoiKpgGrOeXaKuu1rzPU
sSj+BTJcnR/TT+REL1HQkClQIzA4+bfjQyfU3uBKcMzS3IEJdb5BEu/ApHcWO/i7
k0ciDq9j3iBxBZ7tE7CbsY3eM8mYuQUnF8PjA2T/9R3gge0P2pogZmYGxfHsfjbA
7arbj3nv9o75HQoDNWT+a10mfYgsDw==
=haAo
-----END PGP SIGNATURE-----

--Zq9ZSVbg9oNu91zv--
