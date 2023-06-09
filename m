Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655EE72A0B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFIQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFIQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:55:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101883A88;
        Fri,  9 Jun 2023 09:55:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B65F5C0056;
        Fri,  9 Jun 2023 12:55:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Jun 2023 12:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686329746; x=1686416146; bh=jO2lbJWjlD3AhgpqUQ7r9uAT+WfB1wgKDIz
        85pj33i8=; b=CFe8GJvCu68K0tqO7GAJP6Ph6cIOC2pvsTRjyaNHLMrLHIqfIrj
        YNX4nMFHKqrYV/DXSlCwpi/YUqseg+9pvjoePMDxNbtwMAYglhGHcinU27Lv4Nge
        iprtLLfS05YW420koXxSramZzljJ13kMSyGpcQDKMLu+l2UpLKoIW7JUnoBCC9w5
        3WvQIwc30hDHL3STx5A28AG2gToQmSA/81lgiZGC1aVYYYhhynIITnwaqL0kUcit
        UhqG2xxdv1xqUDE5CCezw2JSimg7m0Kw4MwAkbJSKmeaGTvh3NFF6JEgdWq7uHem
        vm82rr1PCA10l657SPM1nZh1AJkv1cwWAsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686329746; x=1686416146; bh=jO2lbJWjlD3Ah
        gpqUQ7r9uAT+WfB1wgKDIz85pj33i8=; b=w8IbCCCTVKAFYoq8dgC972pYva5Rb
        mmPzwOwxgvYmOjUrELKiPGAM6xKit7KvVC5+LMnxgjZkkmXhX1BMtuM2vE7mcPAk
        GUqBi3l7H46V8uaxggrhYHTiA+8rd8QGK4hoNe2gFaEUH0ZKdpuXoyZ8a4V2r3Ff
        IQDBDuoVWMv/DvmZpg2ksqgOXP5ejpSurUM3D16H09COGtmlebrbEamBJ6dslAX0
        E49uxqb41lq3OyLIbhztPb7oS54B1kP5qaV+P/G5OMka82JA2Ht8ZO3dqTj1P1kq
        9/IbitskUvdGmOc2M5SWosWh4pucYOXQ5ISBq/itbcv/bowxxPPCfBhrQ==
X-ME-Sender: <xms:kVmDZC9XOZM6ptkjSOu_HzwPcmVSxza92St4hphFJ7JJRn_TvOzYbQ>
    <xme:kVmDZCt1CJ2HeRiSmUgAO84fKWAqR7_0tMIbF-CrMahSVI9FsYmjcKo2852XRBJaG
    B9JD3erOYWGja8>
X-ME-Received: <xmr:kVmDZIDd4roaVuvmRuTBFsW_9uyshMMr_FHPRXnUlemwKv8uKEj-qReXJ98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:kVmDZKe7fNwLf_sshCBl8TDwl2n7fLQAEwQz93RdgWpXrtJnN4lmeQ>
    <xmx:kVmDZHO06_1FTNq7mRU6Rkx6aJ9L1U4fwwe96uRP-7r4tPQsPH66ww>
    <xmx:kVmDZEnDZXZLxSX7nDYzpAzBEhRJ6GQyNrKk1n0v0LPOIj5Od2DURw>
    <xmx:klmDZDDm9qAHm16nDZgjqB1d0yGKjkRzPWSz64opTfCUZmIeyAtEIw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 12:55:44 -0400 (EDT)
Date:   Fri, 9 Jun 2023 12:55:39 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZINZj8ubQj7yFxdR@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
 <ZH9mZGbM32CDmKGF@itl-email>
 <ZIA9uBJxx2gqA4Cq@Air-de-Roger>
 <ZICs+WYCPYdu2yoI@itl-email>
 <ZIGRXrSGmgLF/07O@Air-de-Roger>
 <ZIH0yQCICZRpliSc@itl-email>
 <ZINBqToBZVdfmr0e@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ii0jDpZ9bgT07th0"
Content-Disposition: inline
In-Reply-To: <ZINBqToBZVdfmr0e@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ii0jDpZ9bgT07th0
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 9 Jun 2023 12:55:39 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks

On Fri, Jun 09, 2023 at 05:13:45PM +0200, Roger Pau Monn=C3=A9 wrote:
> On Thu, Jun 08, 2023 at 11:33:26AM -0400, Demi Marie Obenour wrote:
> > On Thu, Jun 08, 2023 at 10:29:18AM +0200, Roger Pau Monn=C3=A9 wrote:
> > > On Wed, Jun 07, 2023 at 12:14:46PM -0400, Demi Marie Obenour wrote:
> > > > On Wed, Jun 07, 2023 at 10:20:08AM +0200, Roger Pau Monn=C3=A9 wrot=
e:
> > > > > On Tue, Jun 06, 2023 at 01:01:20PM -0400, Demi Marie Obenour wrot=
e:
> > > > > > On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monn=C3=A9 =
wrote:
> > > > > > > On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour =
wrote:
> > > > > > > Also, you tie this logic to the "physical-device" watch, which
> > > > > > > strictly implies that the "diskseq" node must be written to x=
enstore
> > > > > > > before the "physical-device" node.  This seems fragile, but I=
 don't
> > > > > > > see much better optiono since the "diskseq" is optional.
> > > > > >=20
> > > > > > What about including the diskseq in the "physical-device" node?=
  Perhaps
> > > > > > use diskseq@major:minor syntax?
> > > > >=20
> > > > > Hm, how would you know whether the blkback instance in the kernel
> > > > > supports the diskseq syntax in physical-device?
> > > >=20
> > > > That=E2=80=99s what the next patch is for =F0=9F=99=82.
> > >=20
> > > Hm, I think we should separate diskseq support from the notify open
> > > stuff: it's possible a different (non-Linux) backend wants to
> > > implement open notify support but doesn't have diskseq.
> >=20
> > I like this idea!  What about having blkback set diskseq to zero?
> > Userspace could then replace it with the actual value.
>=20
> I think it would be better if we used a sysfs node, because blkfront
> has no business is knowing whether diskseq is supported by the
> backend or not.
>=20
> xenstore should be reserved to features exposed between blkfront and
> blkback if possible.  I know we haven't been very good at this
> however.
>=20
> > > > > Can you fetch a disk using a diskseq identifier?
> > > >=20
> > > > Not yet, although I have considered adding this ability.  It would =
be
> > > > one step towards a =E2=80=9Cdiskseqfs=E2=80=9D that userspace could=
 use to open a device
> > > > by diskseq.
> > > >=20
> > > > > Why I understand that this is an extra safety check in order to a=
ssert
> > > > > blkback is opening the intended device, is this attempting to fix=
 some
> > > > > existing issue?
> > > >=20
> > > > Yes, it is.  I have a block script (written in C) that validates the
> > > > device it has opened before passing the information to blkback.  It=
 uses
> > > > the diskseq to do this, but for that protection to be complete, blk=
back
> > > > must also be aware of it.
> > >=20
> > > But if your block script opens the device, and keeps it open until
> > > blkback has also taken a reference to it, there's no way such device
> > > could be removed and recreated in the window you point out above, as
> > > there's always a reference on it taken?
> >=20
> > This assumes that the block script is not killed in the meantime,
> > which is not a safe assumption due to timeouts and the OOM killer.
>=20
> Doesn't seem very reliable to use with delete-on-close either then.

That=E2=80=99s actually the purpose of delete-on-close!  It ensures that if=
 the
block script gets killed, the device is automatically cleaned up.

> > > > > I'm not sure I see how the major:minor numbers would point to a
> > > > > different device than the one specified by the toolstack unless t=
he
> > > > > admin explicitly messes with the devices before blkback has got t=
ime
> > > > > to open them.  But then the admin can already do pretty much
> > > > > everything it wants with the system.
> > > >=20
> > > > Admins typically refer to e.g. device-mapper devices by name, not by
> > > > major:minor number.  If a device is destroyed and recreated right a=
s the
> > > > block script is running, this race condition can occur.
> > >=20
> > > Right, but what about this device recreation happening after the admin
> > > has written the guest config file but before the call to (lib)xl
> > > happens?  blkback would also end up using a different device than
> > > indented, and your proposed approach doesn't fix this.  The only way =
to
> > > solve this would be to reference devices by UUID (iow: diskseq)
> > > directly in the guest config file.
> >=20
> > That would be a good idea, but it is orthogonal to this patch.  My
> > script opens the device and uses various means to check that it did
> > open the correct device.  It then passes the diskseq to blkback.
>=20
> How you do this with losetup?  I guess there's an atomic way to setup
> a loop device and get its diskseq?

It can=E2=80=99t be done with losetup.  I use a C program that directly
issues ioctls to /dev/loop-control and /dev/loop*.  Doing this with
device-mapper requires kernel patches that have been submitted but are
not yet upstream.

> > > Then the block script will open the device by diskseq and pass the
> > > major:minor numbers to blkback.
> >=20
> > Alternatively, the toolstack could write both the diskseq and
> > major:minor numbers and be confident that it is referring to the
> > correct device, no matter how long ago it got that information.
> > This could be quite useful for e.g. one VM exporting a device to
> > another VM by calling losetup(8) and expecting a human to make a
> > decision based on various properties about the device.  In this
> > case there is no upper bound on the race window.
>=20
> Instead of playing with xenstore nodes, it might be better to simply
> have blkback export on sysfs the diskseq of the opened device, and let
> the block script check whether that's correct or not.  That implies
> less code in the kernel side, and doesn't pollute xenstore.

This would require that blkback delay exposing the device to the
frontend until the block script has checked that the diskseq is correct.
Much simpler for the block script to provide the diskseq in xenstore.
If you want to avoid an extra xenstore node, I can make the diskseq part
of the physical-device node.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--Ii0jDpZ9bgT07th0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSDWY8ACgkQsoi1X/+c
IsG4QxAA2SL5LAC2MiiRag652Tx+P83kIuMlP80Tw9d8diHvH0RXigUlTyFfvfWs
I9kGjhjt+uLbxPwlyKxkEh4V6DqUjfOE7UP1gfIDy7e1kTJAv09LT/lXII5Bw/0f
YihsdqSa9TwI19LxinadkWk213EgtmZPGE0jp6r6DU897mzg6mHsL94mo5PxmAMM
MRRhQRABTHhggZLCx/JghFfb+C8CXO9mf88vAvClPwTs4BAYZrZG1R2g+Z6i8mHb
y5Hk2++ImNB3FNT8j+dZKT9NdEqAXg8CHaOB5XsMcd4FFAeiFkFOCWr4n/4tRxAJ
nJMgOIfAYFguSHz8UY2tenMh460dbtlKaE2YTKiS9vpCw7AZ+hSQIW/pysiTT0DO
ZrLu3Vri6iWiDWOFx9gpoPR13/j07vlJyCG8Xo6yc4E/JPqUXKZrg8pZtiPmaLe7
XLp+aLPyxTEGQqteROkZe6ZxdawI/DLcmHEc9xbR1iBtWCkBK0J9r5tg/N5nySKE
RB40g9w94ZDkFTBDKZ1PrKWgu3FydVA+hZDMXJuNdl6XLOaGZQuaRUAw1pkB3ING
/wxwQAFqkQCO51XPGKnNX3kwSJkedsMTYcLN8dtcsZ69IXq0sBpsbScVTjyYlVqE
kQL6JEfCjZLiTQIVnwoSmcFmtun9Z+cS3t4RSeLUJHFuM9pJ/mo=
=SvFi
-----END PGP SIGNATURE-----

--Ii0jDpZ9bgT07th0--
