Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33577283C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjFHPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbjFHPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:33:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4BF1734;
        Thu,  8 Jun 2023 08:33:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B39A65C00E4;
        Thu,  8 Jun 2023 11:33:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Jun 2023 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686238411; x=1686324811; bh=bk7X7cG0vAXQHVnw4CA+kDw3ByHbOWHJInS
        wfkkzHY8=; b=GBD0CSjijdigVUsvpDPVSARqWo7A/3D/qG+ji6CJ8nkz9tWCs7w
        zl2Uuan4dpswf7TkqNwGmREgHmoZjfqWmDkFHet/tmyIYm8h4WlpNXbsC9PyzbG+
        1F4uo8CkdvAcxL2MK6DoaPIgDgm6Mf9GIbtruQyT5aX8xLxlN+3Fzib5BXnGFtDy
        2XtQB5lL+GcqvflWDaKw3Lf9DagabGt0/EboBfDTRuJwhGVCDXHCKn9LvS7FvGiR
        aLHcgE1nH7RLX3PF9rF0YR8QjQq7D8z20woWsrd97LPk1Tf5nySZ67V2M4odgMp8
        EQn26MbnsKJKE1sfp9qtocbi5jOVZZNCz8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686238411; x=1686324811; bh=bk7X7cG0vAXQH
        Vnw4CA+kDw3ByHbOWHJInSwfkkzHY8=; b=BcCHXL7O/AS+XCPF4rcyZ3lxI2UJ6
        wO4Hg/SDkzmMPw/NFljpJ/N4DKuLTe59gczbSSgHWl2yFucjtYVFAQBIpPAtmN4k
        jC5jC+HHF4mYmXEa1OmZDgFm6ylnsPdyF3mktGwKjK4w4YmeYBn6wlmAYw11u/h7
        Dgd8GNHoYlh19kT3jiHH8QAWxAF5a5rP8t0O0SvwV0EiWifVdLkfADEvHCXLW8wQ
        bbcUShcMnzSLHkiYILmwFmdTRXVscfEsuDXvY8Vxk7f6Ek5DKYnCDOf4+xsfkZKB
        79pnyvKnIpq/FtatVgXMslaH/E/JTn7ed1ue+XWEWo3nBllRtNh0v9gNg==
X-ME-Sender: <xms:y_SBZKoyNgkvu_49gCTyqEsEfd5RnM0FGYHHVxCq01vyk060pQsWZA>
    <xme:y_SBZIpqRgb2evEMIwxmXhsnZZAzsnMbaAh6KLbdrmaUA6_fb14gCyqGPrvKWCB4X
    uQ-053Jw8nv5cQ>
X-ME-Received: <xmr:y_SBZPOwS8pInKm3zZWJMP8CVpMEKFz44rK4GKZzWmorOTYrKyxt7tQAopA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:y_SBZJ4VHEJ6IODRlrD0AdCfRASzR991CxSln8nwuQWPGat8wLEIRg>
    <xmx:y_SBZJ7sTI9LkWma72gNsSJJWq6NNL7qF2F0YqaJJ_Sxw4Eimi6mKg>
    <xmx:y_SBZJhP5cYtaa7pcncXhrZyp-tZhoq-NSwSCodocfyQU8-AMKjvHQ>
    <xmx:y_SBZGuWnSO2aEWvQjNZ4687abmS4GaS2U5x-OmgUMM-oxcwexNyBg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 11:33:30 -0400 (EDT)
Date:   Thu, 8 Jun 2023 11:33:26 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZIH0yQCICZRpliSc@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3sHQtKDb7zekSfB"
Content-Disposition: inline
In-Reply-To: <ZIGRXrSGmgLF/07O@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3sHQtKDb7zekSfB
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 Jun 2023 11:33:26 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks

On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monn=C3=A9 wrote:
> > > On Tue, Jun 06, 2023 at 01:01:20PM -0400, Demi Marie Obenour wrote:
> > > > On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monn=C3=A9 wrot=
e:
> > > > > On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour wrot=
e:
> > > > > > -	if (be->major | be->minor) {
> > > > > > -		if (be->major !=3D major || be->minor !=3D minor)
> > > > > > -			pr_warn("changing physical device (from %x:%x to %x:%x) not=
 supported.\n",
> > > > > > -				be->major, be->minor, major, minor);
> > > > > > +	diskseq_str =3D xenbus_read(XBT_NIL, dev->nodename, "diskseq"=
, &diskseq_len);
> > > > > > +	if (IS_ERR(diskseq_str)) {
> > > > > > +		int err =3D PTR_ERR(diskseq_str);
> > > > > > +		diskseq_str =3D NULL;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * If this does not exist, it means legacy userspace that do=
es not
> > > > > > +		 * support diskseq.
> > > > > > +		 */
> > > > > > +		if (unlikely(!XENBUS_EXIST_ERR(err))) {
> > > > > > +			xenbus_dev_fatal(dev, err, "reading diskseq");
> > > > > > +			return;
> > > > > > +		}
> > > > > > +		diskseq =3D 0;
> > > > > > +	} else if (diskseq_len <=3D 0) {
> > > > > > +		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
> > > > > > +		goto fail;
> > > > > > +	} else if (diskseq_len > 16) {
> > > > > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but=
 limit is 16",
> > > > > > +				 diskseq_len);
> > > > > > +		goto fail;
> > > > > > +	} else if (diskseq_str[0] =3D=3D '0') {
> > > > > > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with =
'0'");
> > > > > > +		goto fail;
> > > > > > +	} else {
> > > > > > +		char *diskseq_end;
> > > > > > +		diskseq =3D simple_strtoull(diskseq_str, &diskseq_end, 16);
> > > > > > +		if (diskseq_end !=3D diskseq_str + diskseq_len) {
> > > > > > +			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
> > > > > > +			goto fail;
> > > > > > +		}
> > > > > > +		kfree(diskseq_str);
> > > > > > +		diskseq_str =3D NULL;
> > > > > > +	}
> > > > >=20
> > > > > Won't it be simpler to use xenbus_scanf() with %llx formatter?
> > > >=20
> > > > xenbus_scanf() doesn=E2=80=99t check for overflow and accepts lots =
of junk it
> > > > really should not.  Should this be fixed in xenbus_scanf()?
> > >=20
> > > That would be my preference, so that you can use it here instead of
> > > kind of open-coding it.
> >=20
> > This winds up being a much more invasive patch as it requires changing
> > sscanf().  It also has a risk (probably mostly theoretical) of breaking
> > buggy userspace that passes garbage values here.
>=20
> Well, if the current function is not suitable for your purposes it
> would be better to fix it rather than open-code what you need.  Mostly
> because further usages would then also need to open-code whatever
> required.

That is fair.

> > > > > Also, you tie this logic to the "physical-device" watch, which
> > > > > strictly implies that the "diskseq" node must be written to xenst=
ore
> > > > > before the "physical-device" node.  This seems fragile, but I don=
't
> > > > > see much better optiono since the "diskseq" is optional.
> > > >=20
> > > > What about including the diskseq in the "physical-device" node?  Pe=
rhaps
> > > > use diskseq@major:minor syntax?
> > >=20
> > > Hm, how would you know whether the blkback instance in the kernel
> > > supports the diskseq syntax in physical-device?
> >=20
> > That=E2=80=99s what the next patch is for =F0=9F=99=82.
>=20
> Hm, I think we should separate diskseq support from the notify open
> stuff: it's possible a different (non-Linux) backend wants to
> implement open notify support but doesn't have diskseq.

I like this idea!  What about having blkback set diskseq to zero?
Userspace could then replace it with the actual value.

> > > Can you fetch a disk using a diskseq identifier?
> >=20
> > Not yet, although I have considered adding this ability.  It would be
> > one step towards a =E2=80=9Cdiskseqfs=E2=80=9D that userspace could use=
 to open a device
> > by diskseq.
> >=20
> > > Why I understand that this is an extra safety check in order to assert
> > > blkback is opening the intended device, is this attempting to fix some
> > > existing issue?
> >=20
> > Yes, it is.  I have a block script (written in C) that validates the
> > device it has opened before passing the information to blkback.  It uses
> > the diskseq to do this, but for that protection to be complete, blkback
> > must also be aware of it.
>=20
> But if your block script opens the device, and keeps it open until
> blkback has also taken a reference to it, there's no way such device
> could be removed and recreated in the window you point out above, as
> there's always a reference on it taken?

This assumes that the block script is not killed in the meantime,
which is not a safe assumption due to timeouts and the OOM killer.

> > > I'm not sure I see how the major:minor numbers would point to a
> > > different device than the one specified by the toolstack unless the
> > > admin explicitly messes with the devices before blkback has got time
> > > to open them.  But then the admin can already do pretty much
> > > everything it wants with the system.
> >=20
> > Admins typically refer to e.g. device-mapper devices by name, not by
> > major:minor number.  If a device is destroyed and recreated right as the
> > block script is running, this race condition can occur.
>=20
> Right, but what about this device recreation happening after the admin
> has written the guest config file but before the call to (lib)xl
> happens?  blkback would also end up using a different device than
> indented, and your proposed approach doesn't fix this.  The only way to
> solve this would be to reference devices by UUID (iow: diskseq)
> directly in the guest config file.

That would be a good idea, but it is orthogonal to this patch.  My
script opens the device and uses various means to check that it did
open the correct device.  It then passes the diskseq to blkback.

> Then the block script will open the device by diskseq and pass the
> major:minor numbers to blkback.

Alternatively, the toolstack could write both the diskseq and
major:minor numbers and be confident that it is referring to the
correct device, no matter how long ago it got that information.
This could be quite useful for e.g. one VM exporting a device to
another VM by calling losetup(8) and expecting a human to make a
decision based on various properties about the device.  In this
case there is no upper bound on the race window.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--r3sHQtKDb7zekSfB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSB9MkACgkQsoi1X/+c
IsGCMxAAqG5vSBmNdrqnGJZtBSgrA3UZ/y3fsa0PnxKkWgF3nhun+A8UeKOmjz0t
RW9nmG3h6EhpC6XwBop/HnjHIRUS7Z77yDPGtyCHluCNQM3Tj2LOoK6rPn5TVxiR
lsfvUkI41GYaOBKbQ+IEo9IKqpZZE7QIAnVZG8xNW7Klb67Pgi+Q2zb535Ghw67u
xCaV90KBqXTqPZj4hODd8FT/4ewealg7a8Gsb+94TiXMhNPLFMgUbldwURuVp7gl
+16jnXeKkgJ+ccw0Q6UueDxx5o5T3tArta/rfjy2YW18te6QKfv7Ro51eIjCBS3k
uInhLdrnAbfUUW4Y6XzPWXIc2ggBgxIxbhO/illtppLzqBXnlRsXdsSijk3E2y4/
Qg56hHb3xDNXKmN6J4HOIF03AEAoD4R3aqt0WB8SKHNN3YMhTequs2RCmGTOrHTf
QdXVw07joEeYwsZhgrVVtHEGheBeM0+2zdzgF5rUyy/8dS7wyIliFQgNOW8fPRXt
RYPLy6GV+BJZtgTL0LrSw/kCcXEozbPI7Ju4nqwmQVzeXuklYYDvt8nkLkeY3bzz
o895IvUlQGKODDHxJb55eCN6A7ztY9K4sb6gij7ny0RWjHuQezGIA334zfV0n3EM
J4QwgQsldOF/lYTnpCefwXdOWf5PxXENvQi1G25JJWn4Z8JvpGw=
=TpT1
-----END PGP SIGNATURE-----

--r3sHQtKDb7zekSfB--
