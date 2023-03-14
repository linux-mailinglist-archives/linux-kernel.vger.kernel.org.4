Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96916B9F28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjCNSyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCNSyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A5C222E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:54:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1FE761920
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9765BC433D2;
        Tue, 14 Mar 2023 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678820037;
        bh=0rWEbh1iqocpECak3rB9nnjKjmNuv5R/eCsiQzS8se8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN8JgtU4xWTjtaILfBdXG2ta5XBpQNArCoO1f4vtB9dk8EwohGHZKlnG/H/tseb9D
         BE4qPp7oXCEbs3ntDtKj96ukhzqCzHgib3niRxNCk5Nbt1wZ8OYIcrPIpsNXC6QI12
         p4jLevSgMm6hjfRJZ6ViratxH1KdH87bSZqpRRGcXcNzgQ282DZlCbFbEaKl1UDQdi
         91eLPh393/UAFXtB9jy4n3IXo8kkQmYg3ik74aYwZoqMIahVacYly4xRp+V4nPKFna
         jM4D6aj47S6DkrNQS/DxmKIKg09eI3nZicDToAQPfLeMQIy3B9+IUOtkIruPHjUwr6
         WuVt6SRzFgX+A==
Date:   Tue, 14 Mar 2023 18:53:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
Message-ID: <06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org.uk>
References: <20230313181820.2482385-1-dianders@chromium.org>
 <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
 <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk>
 <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
 <f76b82ef-bece-4eee-8711-ceb2f77b1c6f@sirena.org.uk>
 <CAD=FV=Xtrka6tyJNfeZkPgNUDED2+ZJG06f4e_AP3RO1PdLfJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+dn952XglmHIQawV"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xtrka6tyJNfeZkPgNUDED2+ZJG06f4e_AP3RO1PdLfJA@mail.gmail.com>
X-Cookie: For office use only.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+dn952XglmHIQawV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2023 at 09:35:28AM -0700, Doug Anderson wrote:

> The "special" things are:

> * It's been confirmed that this one random driver is involved in
> slowing down boot a significant amount.

> * The fixed regulator driver is among the simplest of the regulators
> and doesn't have the complex interactions that are typically
> associated with async probe problems.

I would be surprised to see regulators being in that category.

> For reference, some of the problems I'm aware of that have been seen
> in the past when trying to enable async probe more broadly:

> a) Apparently, on ACPI child devices aren't guaranteed to be probed
> before parent devices once you turn on async probe. This is not
> typically the case with device-tree probed devices where children show
> up due to of_platform_populate() which is called by a parent device.
> This can be handled properly but often isn't.

That seems unlikely to be an issue here.

> b) Some drivers try to poke directly at other devices and can get
> confused if the other device is probing at the same time. One example
> was dual-MIPI on Rockchip [1]. Again, this can be handled properly but
> often isn't because nobody tested it.

Again, unlikely to be an issue for regulators - where multiple
regulators interact with each other that's already coordinated through
the core.

> c) Dynamically allocated ID numbers can change unpredictably from boot
> to boot with async probe. This showed up on MMC where eMMC and SD
> would change each boot between "mmcblk0" and "mmcblk1".

No numbers exposed to userspace here so that'll be fine.

> d) Async probe (obviously) changes timing and that can expose latent
> bugs. Almost always those bugs should have been fixed anyway.

> e) Async probe tends to stress out other driver's (consumers of the
> device that's now probing async) error handling (since they are more
> likely to see -EPROBE_DEFER) and can expose latent bugs there.

Right, not sure I'd worry about either of those though and given how
widley used fixed regualtors are I'd expect it to be one of the riskiest
here.

> ...but b) _could_ be a problem. Specifically, today I think that
> (unless some of its supplies aren't available at probe time) the PMIC
> driver will _always_ finish probing before the RTC/clock driver
> because of the order specified in the source code:

>   { .name = "max77686-pmic", },
>   { .name = "max77686-rtc", },
>   { .name = "max77686-clk", },

> One would need to do deeper code inspection (and, ideally, testing) to
> find out if indeed the RTC driver and clock driver will have problems
> if the regulator is not finished probing before their probes start.

Behind the scenes interactions would be quite unusual, the power demands
of the on chip devices are typically minimal so there's not much to do -
it's typically all always on functions.  Could happen of course but it'd
be surprising.

> I guess the last thing I'll say is that PROBE_PREFER_ASYNCHRONOUS was
> added specifically so that we could enable this on drivers that were
> found to be slow to boot and that were tested to work with async
> probe. Without being able to add PROBE_PREFER_ASYNCHRONOUS people were
> open-coding solutions per driver to speed probe.

Sure, but my point is that at least every regulator with a ramp time
(which will be most of them, even those that don't have one they tell
the kernel about one probably should) is going to have a similar issue
so could probably benefit from a similar solution.

--+dn952XglmHIQawV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQQwr8ACgkQJNaLcl1U
h9BGMwf/bFd6+wQ34XfA/vC2t0rpuhLYnPWk+kHxEh1vhHULfTzCyDMyOa7SiYMr
xQ69JQ58QLlZ0KwpXOxTaj1QJeSqc+rRtdJCa6p+R+8SmgfliKDwIBoTkeqtSmID
dA/Y5Ao5w6NPJdPXPsRsR/kADCHOvyDuwminp8qiwof+TfVgZFsIUnMkb/EJbq8N
uz2GgSmGa6RUoHNAwEMeO1t+USP15/H8Nt3fTatL6AYb17UGu1QS/SmeGra2YEr0
2JU5QwEcVX7gONTIvweHL6SWsu5VpUgYS7dEqhSYqcqXSGGcoKY7JREoT3OU1nQJ
yKoa11PCoDhiWCdSKdKYjUxvuTfHhw==
=BfbI
-----END PGP SIGNATURE-----

--+dn952XglmHIQawV--
