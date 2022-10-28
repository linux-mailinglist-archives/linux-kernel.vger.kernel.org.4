Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180061165C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJ1PwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJ1PwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6D422E5;
        Fri, 28 Oct 2022 08:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 640C1B82A02;
        Fri, 28 Oct 2022 15:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D3CC433D6;
        Fri, 28 Oct 2022 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666972320;
        bh=YuD9edLwCKn8/1OHDoLVRahTHEgWClfCgIAXeXZRoSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8UEdhNzF8n6KQcXq89uYZwAHbJEAUUJhEpnNKFzYI8s10zxSitlX9EOVW7Cq2hy0
         CXLbwnBJTZ+VhmkI2CnYNkKdvgYC81sTjuzanUbbAe0i7+iNR55FDKaH32zAWCRRfW
         gl7BdQdSH/4n+/HelSLGU7DRW5kYvA2OFPUgubJYqCbgRlDpwxLQXaRJNgyEHPakLc
         wZ7l9uS2h9D+cBtoyvzjm17Llg24l0pjFxpVEJTssTbSOm0uGHN1a2BNHjB4Xj9ZkO
         VizvUDXmZ39UiAXEo12EwnLAeOeYxNvALbcoCPhHAYDa0L15TYix0rNAflH6WHFgDf
         p7mTcP8UEHdfQ==
Date:   Fri, 28 Oct 2022 16:51:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add regulator-output bindingg
Message-ID: <Y1v6migO2PNV4ksW@sirena.org.uk>
References: <20220925220319.12572-1-zev@bewilderbeest.net>
 <20220925220319.12572-3-zev@bewilderbeest.net>
 <20220929210714.GA2684335-robh@kernel.org>
 <YzYNt+IQRomycRLs@hatter.bewilderbeest.net>
 <Y1rRCq9Kdd2zPPkw@hatter.bewilderbeest.net>
 <ee37b5a1-5afc-71b3-f777-add295d9ce17@linaro.org>
 <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7NOnigghnnBn635q"
Content-Disposition: inline
In-Reply-To: <Y1tWpikPogEtV0+x@hatter.bewilderbeest.net>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7NOnigghnnBn635q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2022 at 09:12:22PM -0700, Zev Weiss wrote:

> I can see why it might look that way, but I'd argue it's actually not.  The
> systems this is intended to support provide power to entirely separate
> external devices -- think of a power distribution unit that might have
> arbitrary things plugged into it.  It seems to me like a property of the
> hardware that those things shouldn't have their power supply turned off (or
> on) just because a controller in the PDU rebooted.

We don't turn things off on reboot?  We don't do anything in particular
on reboot...

> > I guess it easy
> > to understand in case of Linux which disables unclaimed regulators
> > during. But what if other system/firmware does not behave like that?

> In this case, then no change would be needed -- a system that (unlike Linux)
> doesn't twiddle regulator state on its own would just continue to not do
> that.

We don't turn unclaimed regulators off until userspace has had a chance
to start, if there's some problem with system integrators arranging to
do this we can look into how that works, for example making the delay
tunable.  I don't think this is really meaningfully different from a
driver deciding to turn things off from a binding point of view.

> > And what is the "external actor"? OS is not an external actor?

> It's admittedly a bit vague, but I couldn't think of a clearer way to
> express what is a sort of nebulous concept -- essentially, some entity
> outside the "driver" (or analogous software component) using the information
> in the device-tree.  In many common cases this would essentially mean "a
> human user", since in the PDU-like systems I'm targeting here the only thing
> that should ever be deciding to turn the regulator on or off is an operator
> logged in to the system to manually enable or disable an outlet.  I was
> aiming to leave the wording a bit more general though, since in some other
> context I could imagine some other piece of software toggling things
> automatedly (e.g. lights getting turned on and off on a schedule or
> something, if that's what happens to be plugged in).

This is policy stuff, it doesn't translate into DTs at all.

> > I could not get the problem you want to solve with this property - I
> > looked at cover letter and at commit msg.

> The problem is that a driver deciding on its own to enable or disable the
> regulator (e.g. during boot or shutdown) would be a critical failure for the
> kind of systems I'm aiming to support.

If the driver is doing something like this it should be addressed in the
driver.

> > I can only imagine that you want to keep regulator on, after last its
> > user disappears... but for what purpose? Do you expect that after system
> > shutdown the pin will stay high so regulator will be also on? If so, you
> > need hardware design, e.g. with some pull up (if control is over GPIO).

> As described above, the regulators involved here (in these sorts of PDU-like
> systems) provide power for external systems and devices.  It is critical
> that the controller's boot and shutdown sequences not alter the state of the
> regulator.

This really sounds like a full stack system integration problem, not
something that can be resolved with one software component.

--7NOnigghnnBn635q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNb+pkACgkQJNaLcl1U
h9AmNwf+PU1nGinh9Sa0B+FKy242nXvLwhyaRVwk0UbA1tzlYICW0ZG5rfK9hAC+
EPLyzaA9o4xfgY7ghbvBCKgvxuNsooPzcqO4Qroe5G+EMn+iWUEkTIHbIElxaRAW
SucCtYBzqvyw4ZiJ4fPeGAnmD0FXQru3QbUrnfHWN+lFpBUFYFawuk7OrioIbBIn
Vybk6Q+4PfuWDORXU35NExOeAkXJpFOd6rTVe+pL7FObV8hJOEelqLYoipCw2J0w
7a/tuDF0Jd7QJM1+qS/2cWtQikWTh4ndiPOmx+zxsUth3jPg8/ZcQip+TCqy+z9J
u+Xd/9ueAkcRHDQjRFGeN/TcXASmJA==
=Fa5f
-----END PGP SIGNATURE-----

--7NOnigghnnBn635q--
