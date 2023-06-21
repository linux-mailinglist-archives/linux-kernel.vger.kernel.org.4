Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA973789C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjFUBOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFUBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:14:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B915110D0;
        Tue, 20 Jun 2023 18:14:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F6485C01D6;
        Tue, 20 Jun 2023 21:14:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 20 Jun 2023 21:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687310070; x=1687396470; bh=dPRbCORYEFTE+ch7t5Frfs0gTZw5KkU2Q52
        rHQ69CxE=; b=oBgdoIBx8xuWQHDp4VfPXBn9ugYH4T7kItmONRxGNwWMf+LX3rt
        pOVRob5mcAgf1ofrNP3977yO+/VausExD6ZSqrAyFpJFS8/7zWfORXHU6efApbro
        HTGr2yGE+ZDIsN+D3UbSnmpi3kETm9kFA2utntJp49dgxgNI9iGx7unZdCu3269G
        fophTM3D05qi2PbZCWg/d7DdQrn6DTv7S+sHHDRN6N2mYIYHITdbvHR3zR/4Q3fM
        ovgkRt4KuVIo94Jghz31Qm1y4EvthTCIl1g2x5erCHoaA9HHLUKnLPbxa3HqTogM
        u6quDpw/I4rEbRqOTqHPs9Fq0EJag5FJK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687310070; x=1687396470; bh=dPRbCORYEFTE+
        ch7t5Frfs0gTZw5KkU2Q52rHQ69CxE=; b=Nwalsytq7cEIDGE5W9gQd/QS/5G+B
        7VlxvquaHO17AsUiKjSDKy1tvgoxRscuy5Bk/XEs6t17i3OTa1gCted+ZNsnOP2N
        o+Q9qProSVVvCtdv9ONJ5DGqHozqBbu3CG5vTbZyS1xpWjxM0oTojWprwAN8DxEu
        HSnchKM9cjPpKCCSyS/Cih8Z+y1xBli/eOQWrL1OlR8Jh7uHF3dThURme3LElVeP
        YiDmByF+fSwsex0NvB4AWiEKOTRsxzT2MOviR8YO55iC4cT9fY0oA50n8tPPdb4i
        u54xs+ZyU6ncxjxiDFYLRicAsXQqMmPsP9msnhoMmkwnqoCKOEfGrNHdQ==
X-ME-Sender: <xms:9U6SZIsyFpg2KEEno_iJ4qjfx7Y_WsMQvKoz88O0r2TiRLCQ_H7Wgg>
    <xme:9U6SZFeD9hxKNpGffeF4twztXeYWA8y8lV5p-o9v7Qvqq4HbHAfd9_kx4ivxo4wUT
    OUQ7l32NUS472o>
X-ME-Received: <xmr:9U6SZDxuikwZSFJbMhIdZ4Sym-vVh04Tno5dh5onRX_SiYvYuCg-61vyLIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefiedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:9U6SZLNDLuJ4TWBoGFKM6zdTVJ9NISjCkJ10pToVLuMxvIfahRkkFw>
    <xmx:9U6SZI9pzb3JVGrr_mXKhOBxxRSCcjRwt9cAUhaV6iGOW8TwbEZy7A>
    <xmx:9U6SZDUIBzD8t_oDQl_ZBBxDTJ6gj2fYUsN0kzODyEBnswsxgLfRmA>
    <xmx:9k6SZIxQcXzvxYTyhhB8ZjgRiouUFgOz7bXfT8w0AI-KJpu4zI3s1g>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jun 2023 21:14:29 -0400 (EDT)
Date:   Tue, 20 Jun 2023 21:14:25 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZJJO8zUBhd8QrQYL@itl-email>
References: <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
 <ZIH0yQCICZRpliSc@itl-email>
 <ZINBqToBZVdfmr0e@Air-de-Roger>
 <ZINZj8ubQj7yFxdR@itl-email>
 <ZIbSw44a8Te27BP3@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f7JHV1ieZVTEUWoW"
Content-Disposition: inline
In-Reply-To: <ZIbSw44a8Te27BP3@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f7JHV1ieZVTEUWoW
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Jun 2023 21:14:25 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks

On Mon, Jun 12, 2023 at 10:09:39AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Fri, Jun 09, 2023 at 12:55:39PM -0400, Demi Marie Obenour wrote:
> > On Fri, Jun 09, 2023 at 05:13:45PM +0200, Roger Pau Monn=C3=A9 wrote:
> > > On Thu, Jun 08, 2023 at 11:33:26AM -0400, Demi Marie Obenour wrote:
> > > > On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monn=C3=A9 wrot=
e:
> > > > > On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrot=
e:
> > > > > > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monn=C3=A9 =
wrote:
> > > > > > > Can you fetch a disk using a diskseq identifier?
> > > > > >=20
> > > > > > Not yet, although I have considered adding this ability.  It wo=
uld be
> > > > > > one step towards a =E2=80=9Cdiskseqfs=E2=80=9D that userspace c=
ould use to open a device
> > > > > > by diskseq.
> > > > > >=20
> > > > > > > Why I understand that this is an extra safety check in order =
to assert
> > > > > > > blkback is opening the intended device, is this attempting to=
 fix some
> > > > > > > existing issue?
> > > > > >=20
> > > > > > Yes, it is.  I have a block script (written in C) that validate=
s the
> > > > > > device it has opened before passing the information to blkback.=
  It uses
> > > > > > the diskseq to do this, but for that protection to be complete,=
 blkback
> > > > > > must also be aware of it.
> > > > >=20
> > > > > But if your block script opens the device, and keeps it open until
> > > > > blkback has also taken a reference to it, there's no way such dev=
ice
> > > > > could be removed and recreated in the window you point out above,=
 as
> > > > > there's always a reference on it taken?
> > > >=20
> > > > This assumes that the block script is not killed in the meantime,
> > > > which is not a safe assumption due to timeouts and the OOM killer.
> > >=20
> > > Doesn't seem very reliable to use with delete-on-close either then.
> >=20
> > That=E2=80=99s actually the purpose of delete-on-close!  It ensures tha=
t if the
> > block script gets killed, the device is automatically cleaned up.
>=20
> Block script attach getting killed shouldn't prevent the toolstack
> from performing domain destruction, and thus removing the stale block
> device.
>=20
> OTOH if your toolstack gets killed then there's not much that can be
> done, and the system will need intervention in order to get back into
> a sane state.
>=20
> Hitting OOM in your control domain however is unlikely to be handled
> gracefully, even with delete-on-close.

I agree, _but_ we should not make it any harder than necessary.

> > > > > Then the block script will open the device by diskseq and pass the
> > > > > major:minor numbers to blkback.
> > > >=20
> > > > Alternatively, the toolstack could write both the diskseq and
> > > > major:minor numbers and be confident that it is referring to the
> > > > correct device, no matter how long ago it got that information.
> > > > This could be quite useful for e.g. one VM exporting a device to
> > > > another VM by calling losetup(8) and expecting a human to make a
> > > > decision based on various properties about the device.  In this
> > > > case there is no upper bound on the race window.
> > >=20
> > > Instead of playing with xenstore nodes, it might be better to simply
> > > have blkback export on sysfs the diskseq of the opened device, and let
> > > the block script check whether that's correct or not.  That implies
> > > less code in the kernel side, and doesn't pollute xenstore.
> >=20
> > This would require that blkback delay exposing the device to the
> > frontend until the block script has checked that the diskseq is correct.
>=20
> This depends on your toolstack implementation.  libxl won't start the
> domain until block scripts have finished execution, and hence the
> block script waiting for the sysfs node to appear and check it against
> the expected value would be enough.

True, but we cannot assume that everyone is using libxl.

> > Much simpler for the block script to provide the diskseq in xenstore.
> > If you want to avoid an extra xenstore node, I can make the diskseq part
> > of the physical-device node.
>=20
> I'm thinking that we might want to introduce a "physical-device-uuid"
> node and use that to provide the diskseq to the backened.  Toolstacks
> (or block scripts) would need to be sure the "physical-device-uuid"
> node is populated before setting "physical-device", as writes to
> that node would still trigger blkback watch.  I think using two
> distinct watches would just make the logic in blkback too
> complicated.
>=20
> My preference would be for the kernel to have a function for opening a
> device identified by a diskseq (as fetched from
> "physical-device-uuid"), so that we don't have to open using
> major:minor and then check the diskseq.

In theory I agree, but in practice it would be a significantly more
complex patch and given that it does not impact the uAPI I would prefer
the less-invasive option.  Is there anything more that needs to be done
here, other than replacing the "diskseq" name?  I prefer
"physical-device-luid" because the ID is only valid in one particular
VM.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--f7JHV1ieZVTEUWoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSSTvMACgkQsoi1X/+c
IsG1jg//X0K5T/56coLUBbOrGxUQ3U0P0C4lX+QfQYyfRFk8ADIg9VQmbCK2f8xA
spUPvMYuy7ysKkFKRjl7A3xzCudfUOQcUXNSWNcDUFAKR3bNajNHkg9tBA1UcLHu
vnjI6hUF2DyWRAf3dfVPljl9B32XhRoLg18sirIulLFV3Uo0cUSxqiJw7KzDPzaj
lgi99ljjbZwxRmjg2mkCqhM0Nlfix7n3a3GDNOfsBAPnQkddiO2MBNvuf0pBDf5g
8mWXzq4hYQrL2N3M85BE7MRETGfCpSK/Rwu6Yt1fc2gAZCE6DzPaVBa+YYhJZUML
DpviuehprwPCWnT5tgjUZScHsuxAhHMRFTlzZkdLWutEsJgiSh5odM7ApMwRxpSi
lBX2sxLlehyipONgHSWscDpC0RmV2v/YLG3erzttCGeJ2UvhORN2lNK4s8xpI6Ud
TPc3/u02cu7Bs6X4BQrJtIm/MCmmlyjftn7G7RuRIW6hl8k4RP4hurQluKGvS3To
4JnleIjEGMQTRnh1cJzWfKfJ+gjGqCOIGjIcO7Ix/v/mSNu88ZsKMdQXMag1akj5
MnJa16unxL6tsMxXs047rM/TDQXSiUaTWMO1DvGAd8HiN6+8FtgEGi0jF2Q/NXxT
CIDR3AT4cy4sSd2Hv5/uQFllJk4qkF0GlFbAlNWfTcimHWatOeM=
=brAf
-----END PGP SIGNATURE-----

--f7JHV1ieZVTEUWoW--
