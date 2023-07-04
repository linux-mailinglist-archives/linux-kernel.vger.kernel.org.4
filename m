Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82A74701C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjGDLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGDLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:43:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724C119
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:43:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4BCDB3200A5D;
        Tue,  4 Jul 2023 07:43:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 04 Jul 2023 07:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688471030; x=1688557430; bh=DXvLHS+0i7KcpP91tmBqUwtDBGkK3GQmg1d
        L9ga2TME=; b=tCAVBdS90txzFAY/kbvh0fqlDpF54OjKwYSWGZXBvpmjlN60j/N
        ZxBE4ZebnUhndB1F376MCXu80BXumESmISrYvSjincFvsy+GT/BsKhy/xaLr29EJ
        sHHDqcqUId9mTks0hfL7pZC31e87WVA1uYtEb23l/pUxDSFtSQuMC/QWOM3QgQ61
        VHuO+rT1bEo8xRxcSsASkTl7jOJpQFz6Qy8gcKWoFFl/jdOmu58fBmra9LU2Mj0a
        Obp7OaVD7TXceIr4zirkdJlp0ffgPaoOoNYNyqJr1i+KOz1LdK7FZCQesg8fs9Mw
        AUejzM/dsYowgIsu3SeqlxkJn8ggBMXIJtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688471030; x=1688557430; bh=DXvLHS+0i7Kcp
        P91tmBqUwtDBGkK3GQmg1dL9ga2TME=; b=Q88FLDWj9kdQwqhgo7RWJg/1w2ncw
        bkXNzTgHQTui4qr91NZmc/YT+FMOFOMGHsU35rGQvEPOrtaFmqkr7qCehqm3MwVF
        HAG3vK/30B0yjlUfedtsdZnrZFpM+6QKkkV/XrszRq3cFuwUztmdd98zncwrO7VR
        du6hl+t2XmNmcEsIYNECs3FSlLe3tJR+8bxI7Q5IS9BRAGa1rWEjRZ9QMqo4rlP7
        lT9tTyOUhiD4jNLe/oy2JwbpN0zTkIdhzuwCwJjdZAcQEZCju2wrbpNgFTMC2GpD
        W2IC9VZd4RI0gfdoh8nkWU5jTyBur6blENG5p5Le4A5/exLr6Z1frgXDw==
X-ME-Sender: <xms:9gWkZFb7d2DcwO0TcRnX8aiae5E_ThiLGtYQ7Xan7nmgN4xszI9mbg>
    <xme:9gWkZMZjI25uS0vMX_Hsy32Ok5XFkkL350uRvB9HCLyPkd6gxO5lEKSkVvfoncP0I
    xVivAvJ3sbpgw>
X-ME-Received: <xmr:9gWkZH-3nVZYsreqTeIEzPSCWJNHN_k7dkoGY2MDgQhAFeLbxHkSOUpXqXc-qGbYhYPP4UuRf9oWrlRCrFwuKDUH9LjOHDrCSBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeeiheff
    iefgteetveeviefhhfelleevgfevvefgtdetteejheeigefhtedvtdevieenucffohhmrg
    hinhepohgrshhishdqohhpvghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhih
    hnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:9gWkZDqn-iNBkAiMUbJhz0QSeD4EYXZ5tA-Zkm2--80m3br__yse0Q>
    <xmx:9gWkZAoUszWDFlcjGIF-VdDA0VRm9xPwbN65CMPVf8gHPVh2kiYWSg>
    <xmx:9gWkZJQgX2cJQdlgw8_aEbKcjniOGe8jHzWUtZc_OQDKme7f-yq6OQ>
    <xmx:9gWkZFCTIMmfD98ST-RPlQpe_WaYhmCcavPKdwqL408Wo8bCcWsOiA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 07:43:49 -0400 (EDT)
Date:   Tue, 4 Jul 2023 13:43:46 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Message-ID: <ZKQF8qq8Oh5E+Fxx@mail-itl>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
 <alpine.DEB.2.22.394.2306281745010.3936094@ubuntu-linux-20-04-desktop>
 <b21398eb-2fb2-4fca-dd90-d2c81d8df1c4@epam.com>
 <alpine.DEB.2.22.394.2306291502150.3936094@ubuntu-linux-20-04-desktop>
 <ZKPO5WbFGblXU5hX@MacBook-Air-de-Roger.local>
 <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bKEul5l8IcOXfCYH"
Content-Disposition: inline
In-Reply-To: <e5eda26f-9a31-dc3a-d97f-33d2efa20efa@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKEul5l8IcOXfCYH
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 4 Jul 2023 13:43:46 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Juergen Gross <jgross@suse.com>
Cc: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	vikram.garhwal@amd.com
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0

Hi,

FWIW, I have ran into this issue some time ago too. I run Xen on top of
KVM and then passthrough some of the virtio devices (network one
specifically) into a (PV) guest. So, I hit both cases, the dom0 one and
domU one. As a temporary workaround I needed to disable
CONFIG_XEN_VIRTIO completely (just disabling
CONFIG_XEN_VIRTIO_FORCE_GRANT was not enough to fix it).
With that context in place, the actual response below.

On Tue, Jul 04, 2023 at 12:39:40PM +0200, Juergen Gross wrote:
> On 04.07.23 09:48, Roger Pau Monn=C3=A9 wrote:
> > On Thu, Jun 29, 2023 at 03:44:04PM -0700, Stefano Stabellini wrote:
> > > On Thu, 29 Jun 2023, Oleksandr Tyshchenko wrote:
> > > > On 29.06.23 04:00, Stefano Stabellini wrote:
> > > > > I think we need to add a second way? It could be anything that ca=
n help
> > > > > us distinguish between a non-grants-capable virtio backend and a
> > > > > grants-capable virtio backend, such as:
> > > > > - a string on xenstore
> > > > > - a xen param
> > > > > - a special PCI configuration register value
> > > > > - something in the ACPI tables
> > > > > - the QEMU machine type
> > > >=20
> > > >=20
> > > > Yes, I remember there was a discussion regarding that. The point is=
 to
> > > > choose a solution to be functional for both PV and HVM *and* to be =
able
> > > > to support a hotplug. IIRC, the xenstore could be a possible candid=
ate.
> > >=20
> > > xenstore would be among the easiest to make work. The only downside is
> > > the dependency on xenstore which otherwise virtio+grants doesn't have.
> >=20
> > I would avoid introducing a dependency on xenstore, if nothing else we
> > know it's a performance bottleneck.
> >=20
> > We would also need to map the virtio device topology into xenstore, so
> > that we can pass different options for each device.
>=20
> This aspect (different options) is important. How do you want to pass vir=
tio
> device configuration parameters from dom0 to the virtio backend domain? Y=
ou
> probably need something like Xenstore (a virtio based alternative like vi=
rtiofs
> would work, too) for that purpose.
>=20
> Mapping the topology should be rather easy via the PCI-Id, e.g.:
>=20
> /local/domain/42/device/virtio/0000:00:1c.0/backend

While I agree this would probably be the simplest to implement, I don't
like introducing xenstore dependency into virtio frontend either.
Toolstack -> backend communication is probably easier to solve, as it's
much more flexible (could use qemu cmdline, QMP, other similar
mechanisms for non-qemu backends etc).

> > > Vikram is working on virtio with grants support in QEMU as we speak.
> > > Maybe we could find a way to add a flag in QEMU so that we can detect=
 at
> > > runtime if a given virtio device support grants or not.
> >=20
> > Isn't there a way for the device to expose capabilities already?  For
> > example how does a virtio-blk backend expose support for indirect
> > descriptors?
>=20
> Those capabilities are defined in the virtio spec [1]. Adding the backend
> domid would be possible, but it probably wouldn't be that easy (requires
> changing the virtio spec by either expanding an existing config area or by
> adding a new one). I'm not sure handling in the specific frontends is
> generic enough for being able to have a central place where the backend
> domid could be retrieved, without requiring any change of the frontends.

IMHO the proper solution is to extend the spec. I don't have much
experience with virtio code, but reading the spec it looks like new
config area will be better for compatibility/uniform handling in a
frontent-agnostic way. Since it will definitely take time, some
transitional solution (maybe even xenstore...) might be warranted.

> Juergen
>=20
> [1]: http://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html






--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--bKEul5l8IcOXfCYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmSkBfIACgkQ24/THMrX
1yyXUgf+N/PLUJAoNhlNjh4kow5XxRzM4Afaw1bwhZYI6546o2bL/yRgGWcBqNue
nNZzUUmNMsNvEi0zy/1rWQppCaDZKPhgtb33Ty9oC9iSBeziB9LQk8A8yOMiQ0st
hazKZOfD2GBRpfULOfUCOj6+9AQWadmnHAbKT0gJMSARp3shkfN7kZoL4xczD9tn
2JKsIIBERXc/MpMh7gQwM0F6EBf00Zqi6Qvss8/IKtNuUSI9u7xQLOWrxscUXKCc
OoDe7b4jhgRpRR3BZoiON6khBEKBt59UcZR+mQll0h9XeTH7n0MyaZO5SASVdD3m
L1RNV4X+MQ8fUplS1LMJtKBg3j9pBA==
=CQd8
-----END PGP SIGNATURE-----

--bKEul5l8IcOXfCYH--
