Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705CB630F7F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiKSQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKSQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:33:47 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED113CD3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 08:33:43 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 039975C0049;
        Sat, 19 Nov 2022 11:33:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Nov 2022 11:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668875620; x=
        1668962020; bh=k1JAkdVKYVaYxy7kpC5w8PdLHIgc/yfPIYL5UkOFoDY=; b=U
        FfepIQkuRItQ+/RiE97orM1O6zNvi/VRaBRkKEf7rZY/eNrkBFpNjDdIeMa8resL
        voWC3eqP7CwW31vto5TEet10oPB1Lt6Y67vEe8AynLgPhIaBTzxIHTCuChFPeXdj
        OeWnoqFOwvt/uYeZWGpPuHEEnVOmqTsalJUGbRyhGqmt37jWK9ux/CE3v3rwfySN
        2POOHBjhRHSfCY5qsB3WW7SCN25M5FqkinuzfD9D+XfYoAAx37WHW9cYWQMpfD3R
        pnbNkS2s6dxTdswawuohCdzRvwzKuoJAxgEw3TVO5vFbiMZgwSU4WRNuBHjKucFr
        MuYvlHWErGT0xCGqzyIYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668875620; x=1668962020; bh=k1JAkdVKYVaYxy7kpC5w8PdLHIgc
        /yfPIYL5UkOFoDY=; b=lJcopc9Opa+b6cHyTKQiOD7+nX2mwT03Ph9BbVVZuT5I
        9VP8a5u0d3AeJOBBREXjFugQusX0JMrdM/Rt2rzsEVqWXRbmNMcoiSUZy3/Eb2tQ
        Krk1TUa95At6+S2CJ1wZJQtCffQFB1GktV2vTOvxhlCNrBmKSNwUExOaJRLMASuj
        S0NDX4atxmBdozpETZMlV7vQA5W/wWZG+Gx7zPrc2rtIab/YFP+pD1wAPcRRD359
        lWu0kzBk6NVJz/nyhFWUhrYvW2Y8zGbO4cDKQDeG/sBh1vCD7NtFv2bupzobkIK+
        teN1qvBEEDHJneZmbGkOJAjMchPfd/+BHd558a+gBQ==
X-ME-Sender: <xms:ZAV5Y-96qg0f4N_AWENtp-ksK1EpYDDaS3BXTlOiSQDwgFqRedSDvA>
    <xme:ZAV5Y-stU9oWZ-9W5yyUgpRi7FwNzMg_O_p_cyQkCu3tyzVDwcf0Wyqh1XIKSr5iE
    LBMRC_F_byrdw>
X-ME-Received: <xmr:ZAV5Y0AHsMbG_25t4-3u1r8NLbfDjYUl5x4o25EFEl4-IiOde_Zn5hH1uBmxwrMFsRm8g7V1vMKbzK4B786gSQVB8N9jgDRFSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeukeet
    teeggffgkeduheetgeeileejjeeiiefhjeegvefhtefggfetueetteeuteenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomh
X-ME-Proxy: <xmx:ZAV5Y2cCWjMhQYvDtPrdoDictb9Wt4l679Opiq0tkytljnobSHgi0Q>
    <xmx:ZAV5YzNUs4AbTHygyCv2PiD-DRmoCWk78lfIE1w6noHCLPdvQ_ZCnA>
    <xmx:ZAV5YwlI60M0UmBiSdeYD0eVeRL6szNI5SwURk2PZR7r4NgqrHUXHQ>
    <xmx:ZAV5Y4rSl3vGOJPrf2A0VNO5h5mEUL5JyyW6G6yejj8BXuwGUdThZQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Nov 2022 11:33:39 -0500 (EST)
Date:   Sat, 19 Nov 2022 17:33:36 +0100
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
Message-ID: <Y3kFYeml1CPL318u@mail-itl>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <CAKf6xpuCxftyQ+PKN_ffJ0onsSxcT8kVSwkM7Z10pfjqf0XFgA@mail.gmail.com>
 <Y3f9O0S8kVXZ+py+@mail-itl>
 <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sCWikLql3O/b4frL"
Content-Disposition: inline
In-Reply-To: <CAKf6xpvUcR=rta6SD7mw_pvgQJTxKjN5VHpC6x-zCAiaJ=pKfg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sCWikLql3O/b4frL
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Nov 2022 17:33:36 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jan Beulich <jbeulich@suse.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled

On Sat, Nov 19, 2022 at 09:36:54AM -0500, Jason Andryuk wrote:
> Hi, Marek,
>=20
> On Fri, Nov 18, 2022 at 4:46 PM Marek Marczykowski-G=C3=B3recki
> <marmarek@invisiblethingslab.com> wrote:
> >
> > On Fri, Nov 18, 2022 at 03:46:47PM -0500, Jason Andryuk wrote:
> > > I was trying to test your xen-pciback v3 patch, and I am having
> > > assignment fail consistently now.  It is actually failing to
> > > quarantine to domIO in the first place, which matches the failure from
> > > the other day (when I more carefully read through the logs).  It now
> > > consistently fails to quarantine on every boot unlike the other day
> > > where it happened once.
> >
> > Does this include the very first assignment too, or only after domain
> > reboot? If the latter, maybe some cleanup missed clearing MASKALL?
>=20
> It's the quarantine during dom0 boot that fails.  Later assignment
> during VM boot fails.  I tried warm reboots and cold boots and it
> happened both times.
>=20
> I also modified my initrd to halt in there and checked the config
> space.  MASKALL wasn't set at that time.  I need to double check -
> MASKALL may have been unset after dom0 booted in that case.
>=20
> I'll test more to figure when and how MASKALL is getting set.
>=20
> > FWIW, the patch applied to Qubes
> > (https://github.com/QubesOS/qubes-linux-kernel/pull/680) seems to work
> > fine (the full test run is still in progress, but I see some green marks
> > already).
>=20
> Does Qubes quarantine devices explicitly, or are they in dom0 and
> libvirt/libxl just assigns them when a domain boots?

We do quarantine them explicitly, still in initramfs.

> > > I added some printks and it 's getting -EBUSY from pdev_msix_assign()
> > > which means pci_reset_msix_state() is failing:
> > >     if ( pci_conf_read16(pdev->sbdf, msix_control_reg(pos)) &
> > >          PCI_MSIX_FLAGS_MASKALL )
> > >         return -EBUSY;
> > >
> > > # lspci -vv -s 14.3
> > > ...
> > >     Capabilities: [80] MSI-X: Enable- Count=3D16 Masked+
> > >         Vector table: BAR=3D0 offset=3D00002000
> > >         PBA: BAR=3D0 offset=3D00003000
> > >
> > > So it looks like MASKALL is set and prevents assignment.
> > >
> > > setpci -s 00:14.3 82.W=3Df
> > > cleared that out for me and I could assign the device.
> > >
> > > My dom0 boots, it runs flask-label-pci for a set of PCI devices
> > > (including iwlwifi), then xl pci-assignable-add for all PCI devices
> > > which will be passed through, then a little later it boots the
> > > associated domains.  Dom0 does not have a driver for iwlwifi.
> > >
> > > I'll have to investigate more to see how MASKALL is getting set.  This
> > > had not been an issue before your recent patches.
> >
> > I guess before the patches nothing set anything in MSI-X capability,
> > because it was hidden...
>=20
> Well, stubdom hasn't even booted when, so it would be the Xen or
> pciback change to modify MASKALL?

Weird...

> > Anyway, to support my cleanup hypothesis, I tried to destroy a
> > PCI-having domain, and it left MSI-X enabled (at least according to the
> > config space). MASKALL was _not_ set, but I haven't checked masking of
> > individual vectors. TBH, I'm not sure what should be responsible for the
> > MSI-X cleanup after guest destroy. Should it be Xen? Qemu? Pciback?
> > Pciback calls PHYSDEVOP_{prepare,release}_msix only when
> > binding/unbinding from the device (so - xl pci-assignable-{add,remove}),
> > so this isn't the right place.
>=20
> I need to review all this code to give a meaningful response.  Would
> xen-pciback set MASKALL when it binds a device?  That happens before
> xl pci-assignable-add tries to quarantine (assign to to domIO).

I don't see pciback doing that. And also, my patches shouldn't change
behaviour of pciback when binding to a device (so, if it would be doing
that, it would happen before my patches too).

Maybe that's an interaction with some other patches?

> > Should that be in Xen, in deassign_device() (part of
> > DOMCTL_deassign_device)?
>=20
> It seems to me that Xen needs to ultimately disable the device.

That's my intuition too.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--sCWikLql3O/b4frL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmN5BWAACgkQ24/THMrX
1yyF0Af/aYMmZvYJ1q+GwXf5MPWXWaBIlU/0TQMqLyNv6+JNpsplksGAxarsFwMr
4sXcwivdu7fslA6RfvbZ6L5hV5opwAGyg76i3PZsQo35ezsdcVIGAqNt3Uj+4LE7
rzPwn+7b6yaKLjVPybqvN6n0/sLpO7d5E4ZpPy6/Ww89DAUFwhIS5hDDnnmrc3QO
UQkQ5HpykQNx7Iq9cOdZabbSzS1ms0bS9pj8GzCPmJY3Lgu/q2aPkqMvpuJ+TwpQ
oDKPzNK/BPoAVaEWf5bzFcybMf3ZiaQS4E6sauKxausfkh4Sn+hCeoqJVKreBUvQ
8Jksic/ya73VURI5MVCfaHH33g1wTw==
=wgKy
-----END PGP SIGNATURE-----

--sCWikLql3O/b4frL--
