Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8F6BE674
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCQKUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCQKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:20:05 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3877A21A0;
        Fri, 17 Mar 2023 03:20:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 825FF32000EB;
        Fri, 17 Mar 2023 06:20:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 17 Mar 2023 06:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1679048400; x=1679134800; bh=R2
        PhvQmlrawFBySIsOtkrlNsyj6Omx2RMGhf6x3YrHg=; b=aMOdgnRWlv3W/79Yr5
        zwaKq4mM6VXVcYqKC3K9jQxDpE5O0i3CjPqVUROdZUJUQtdbn+wQSAK2IwiDCC6+
        dY/fhdNpbDeDvOchyUl+KOEUNDmKvjz64XOs1WgwYR+PMX4hox3DYcScn9b/iNPT
        cPl8tfXPP1Ch5bstZR/rc8otFtfo8hCYKODiOUy1BZ80g/nxA6b1twizN3rHLS1h
        ZfKXEAhkoa3ra9nk3Kk5mlyYI/focJ5/nUyWtVCBcwRsvPHPG1cj29IESAo+9FGx
        7VqaFKq59gLzsxs5gNm8Cl5Sn953afEpZTy7eID0fL1xM9HqE3IwY+THHTEuV01V
        iBpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679048400; x=1679134800; bh=R2PhvQmlrawFB
        ySIsOtkrlNsyj6Omx2RMGhf6x3YrHg=; b=G3Myr2ALwXfc7bS4pAyC21hkfLSWP
        Bt7f9a2hDwk8/FITqun7YedWwyJB6XT5yCPBWw4ty3OH6LboomKwl2ltF2adRCqh
        VUm/kJAWX2Px+jXlioRKVLesI9beBG824riZuy/qj7aiSV6HkF49V8vmXZ/bGNcV
        lkaeMhSovdTdO86t9OldI9hjN/4E1uOKQmYMTk+ZHKmi19P2s9TjK+4Y27c52MwC
        lsbsFIuPHDb6EiDNuF8K5JvOJh8ehiJOf6QCrHAOqM/NBtVKt2veBP0KNpApeXLJ
        YHZWwUh6NrMLzzEzKKr10EBCLH8AWaiqjGjOqbiNbaTEZ1Yz5ttiiJAGg==
X-ME-Sender: <xms:zz4UZHWQfWN-MtJcTvoPXbsAc0uxWjPPAnFI20xZlciDE4754n0GDg>
    <xme:zz4UZPm7ERboPe--aNUskBx5j7tezaSGEgdoYEdL1_gqbznb7h8Jkz-iTF7VoeSqT
    o-CnUS7Fi2MRwcf0w4>
X-ME-Received: <xmr:zz4UZDYXW4P-RtBCsYfVzfPT-MQjKsWXgaeTTNV3a4821uVthIPEPlxrEn7ZGHtPL7R7H9GddV5m9foRsGq1mXO7YOwoV0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeljeeugfegveetleevkeetffegudevieetieeugeeugeeivddtjeejvdef
    feetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:zz4UZCXSTkPgh-JxRP1U_s-0Y1Dr1XsknTYlfkUebozHCzArYj9oog>
    <xmx:zz4UZBl8vIWvypKuUZ7Feh3RcC6RTGF1M-ImaWiRaDn5lCy4wjigfA>
    <xmx:zz4UZPfosd6z-B4n5wG7YTvqk_AJJJEm4Y5uVV039trqmgUsKgSJng>
    <xmx:0D4UZDUJ1Yv8dPxz9Oin7ogxcvGm_uFVKE1oD1TkrrudmVR7vammfQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 06:19:58 -0400 (EDT)
Date:   Fri, 17 Mar 2023 11:19:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230317101956.ebe4bhpwybjhvsq6@houat>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei>
 <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
 <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
 <ZA8lNBPCB4BNnfUq@smile.fi.intel.com>
 <39a7b489-4856-8dc1-d0a6-f27d0c1324a2@gmail.com>
 <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xdcm5g2kingdnkbe"
Content-Disposition: inline
In-Reply-To: <a41874be-f0bd-1570-8a4a-5b28079b9fed@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdcm5g2kingdnkbe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 12:51:26PM +0200, Matti Vaittinen wrote:
> On 3/13/23 15:59, Matti Vaittinen wrote:
> > On 3/13/23 15:29, Andy Shevchenko wrote:
> > > On Mon, Mar 13, 2023 at 03:11:52PM +0200, Matti Vaittinen wrote:
> > > > On 3/13/23 14:40, Andy Shevchenko wrote:
> > > > > On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
> > > > > > On Sun, 12 Mar 2023 17:06:38 +0000
> > > > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >=20
> > > ...
> > >=20
> > > > > > Ah. I forgot the tests that don't have a device so can't use de=
vm.
> > > > >=20
> > > > > Why not? I have seen, IIRC, test cases inside the kernel
> > > > > that fakes the device
> > > > > for that.
> > > >=20
> > > > I'd appreciated any pointer for such an example if you have one
> > > > at hand. (I
> > > > can do the digging if you don't though!)
> > > >=20
> > > > I am not a fan of unit tests. They add huge amount of inertia to
> > > > development, and in worst case, they stop people from contributing =
where
> > > > improving a feature requires test code modification(s). And
> > > > harder the test
> > > > code is to understand, worse the unwanted side-effects. Also, harde=
r the
> > > > test code is to read, more time and effort it requires to analyze a=
 test
> > > > failure... Hence, I am _very_ conservative what comes to adding
> > > > size of test
> > > > code with anything that is not strictly required.
> > > >=20
> > > > After that being said, unit tests are a great tool when
> > > > carefully used - and
> > > > I assume/hope stubbing a device for devm_ tests does not add
> > > > much extra...
> > > > But let me see if I can find an example :)
> > >=20
> > > drivers/gpu/drm/tests/drm_managed_test.c ?
> > >=20
> > > (somewhere underneath:
> > >=20
> > > =A0 ret =3D platform_driver_register(&fake_platform_driver);
> > >=20
> > > which suggests... what exactly? :-)
>=20
> Thanks to pointer from Andy I found the
> drm_kunit_helper_[alloc/free]_device() functions. I renamed them to
> test_kunit_helper_[alloc/free]_device(), move them to drivers/base, add
> declarations to include/kunit/test-helpers.h fixed KConfigs and existing
> callers + added the tests for managed interfaces. I have this in place in=
 my
> personal playground where I am working towards the v4 of the series.
>=20
> ...
>=20
> After that I asked from Maxime if he had a reason to not make those gener=
ic
> and available to other subsystems besides drm in the first place...
>=20
> And Maxime was kind enough to point me to the fact that something like th=
is
> was done in the CCF context:
> https://lore.kernel.org/all/20230302013822.1808711-1-sboyd@kernel.org/
>=20
> I like the 'single function to get the dummy device which can be passed to
> devm'-approach used in drm helpers. I do also like Stephen's idea of havi=
ng
> the prototypes in kunit/platform_device.h which matches the
> linux/platform_device.h.
>=20
> However, I don't know when Stephen's work will be finished and merged to
> IIO-tree so that it could be used/extended for the needs of these tests.
>=20
> Meanwhile, I don't think it makes sense to go forward with my changes
> splitting the helpers out of drm until we see what Stephen's changes will
> bring us. On the other hand, I don't like delaying the gts-helpers or the
> sensor drivers.
>=20
> So, any suggestions what I should do? I see following options:
>=20
> 1) Drop the tests for managed interfaces for now.
> 2) Add the tests with a yet-another duplicate implementation of the
>    dummy device for devm.
> 3) Add the tests using the helpers from drm as they are now.
>=20
> option 1):
> I like it as it would be an easy way (for now) - but I hate it as it may =
be
> a hard way as well. In my experience, when a driver/helper lands upstream=
 it
> will get first few fixes quite fast - and not having a test available
> upstream when this happens is bad. Bad because it means the out-of-tree t=
est
> may get broken, and bad because there is no easy way to test the fixes.
>=20
> option 2):
> I hate it because it makes the test code more complex - and duplicates the
> kernel code which is never nice. This could be reworked later when Stephe=
ns
> work is done though.
>=20
> option 3):
> It's in general not nice to use functions exported for some other
> subsystem's specific purposes. This would however keep the test code at
> minimum, while leaving the same "I swear I'll fix this later when
> dependencies have settled" - possibility as option 2) did.
>=20
> Oh, in theory there is option 4) to just send out the changes I did(*) wh=
ich
> pull the drm_kunit_helper_[alloc/free]_device() out of the DRM - but I gu=
ess
> that would lead some extra work to merge this later with stuff Stephen's
> series does introduce.
>=20
> Any suggestions which of the options to proceed with?

I think the best course of action would be to synchronize with Stephen,
and make sure that whatever patch you're doing can be used for his work.

Once it works for both of you, then I guess it can go through the kunit
tree and you will use it both.

Maxime

--xdcm5g2kingdnkbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZBQ+xwAKCRDj7w1vZxhR
xbR2AQC+odcZGk8eMOMQcm+pwGNMtd0mUNgViVvhCvCb+4hsCwEAuMAEFb9Uw46L
3O7y7a29aijAc0yWDlTk8ABO7hZxHAk=
=/7fP
-----END PGP SIGNATURE-----

--xdcm5g2kingdnkbe--
