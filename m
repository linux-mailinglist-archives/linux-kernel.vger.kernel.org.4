Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183C06867E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjBAODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjBAODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:03:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE1193E7;
        Wed,  1 Feb 2023 06:03:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2D70B821A9;
        Wed,  1 Feb 2023 14:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D926C433D2;
        Wed,  1 Feb 2023 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675260192;
        bh=2DbOtTQRhr8tnJUsWJlJ8/mz0ACGWFvVrr7Khf67Jw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFlfGnI1en/ZcXxspRRKujokG0KfusW/3vbZN6nQ1sBWV9M3AJirnOhHNOCa6d1rp
         +Xo7tdZGOphyvxQmtXrdpPoUbYi84vdrNBD2JBXBOCDGEPhGQ0vcO4RCkXlFX4XuAt
         73UZ0jmt88xKYYOPv2DmpcTWsun1xr0mhRMrWoGSYeOvpJtFdRc9deY5bI0GPnzW/M
         3VxHq8piROjRVbKlbqSkMzyYOdE/5mw5BxPoVehnA6IFlCgUVTxjPgSXbVghdeBg/1
         zejP3mtJa6CLBc1EMd7XvQI3tm+2C+GK8kX27LrTj+jl9NhoHwHz+IE3Y6Jpz+q8fP
         vw6GWaKQm24Nw==
Date:   Wed, 1 Feb 2023 14:03:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kiseok Jo <kiseok.jo@irondevice.com>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
Message-ID: <Y9pxGUMWyMeXQpZM@sirena.org.uk>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMD2Qw0vG4t+o25k"
Content-Disposition: inline
In-Reply-To: <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
X-Cookie: Oh no, not again.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMD2Qw0vG4t+o25k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 02:13:46PM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 14:10, Krzysztof Kozlowski wrote:

> > Because the binding:
> > 1. Was never tested,
> > 2. Was never sent to Devicetree maintainers,
> > 3. Is entirely broken and wrong, so it would have to be almost rewritten
> >    from scratch,
> > 4. It does not match the driver, IOW, the binding is fake.

> I understand that in general we tend to fix, not just to revert. But the
> poor quality of this binding and the next patch, which was suppose to
> fix it, plus complete lack of testing, means I do not believe the author
> will send correct binding.

> More over, fixing binding might require dropping incorrect properties,
> thus changing the driver. I am not willing to do that, I doubt that
> anyone has the time for it.

It is an absolutely trivial binding as is, it is utterly
disproportionate to delete both the binding and the driver to fix
whatever it is that the issues you're seeing are (I can't really tell
TBH).  Undocumented properties are a separate thing but again a revert
is obviously disproportionate here, glancing at the driver the code is
all well enough separated and can have default values.  Looking again I
did miss the sysclk selection which should be dropped, clocks should use
the clock bindings.

> It's the job of submitter to work on it.

It's also not the end of the world if we have a driver that isn't
perfect.

Please, try to keep things constructive.

--XMD2Qw0vG4t+o25k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPacRgACgkQJNaLcl1U
h9Clqgf/fBAlVIkG5zw/SgqTKfN1Yg8nM89WTIvkRkH9P4VzP5/4AcY1JGgQ88LS
wLn12hGKAm9M96JTB3HMPfBuTbF/sn2oduUU1GUx7T0sM13LVwPCM59/Kv0EZO1r
60yUzotgLtAMP+bp6qxi5FXG+K9npW+hk7zhtZOu9ia48m3R2k1T2LfO5Ai0Mp4Q
wJrN5nbyHtXf0MzUcVc+do/mf/1p76HP/NvvyteAoLJVg3l7gEECdws7G+/b1VZf
xS+tjYlH9R0a1XJsJm+7rAcjlovdpMLZESIb6vHYxDJ18rdBlTsfDtSfIiWDrwof
4cTRjKLygsYMBrleaja1+7DlW8Satg==
=nfWJ
-----END PGP SIGNATURE-----

--XMD2Qw0vG4t+o25k--
