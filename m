Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805360E12D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiJZMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiJZMt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:49:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0758046;
        Wed, 26 Oct 2022 05:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F73CB821D9;
        Wed, 26 Oct 2022 12:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0473C433D6;
        Wed, 26 Oct 2022 12:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666788592;
        bh=wwcloTob6ie8tz5qopW+PLurg6OWyL6eKN6MA1+Xs6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ju/p43pK7hPQJaIF7nJ1R2GsqT3DIHUa5vG3D7i5tSDDRrrG4bqAWT3Za50If1kxJ
         cvsNrSzuTmwd4sTOb6bpH74w70yTkQ3MhzXa2NdXd40HJz3Lt03FVkXPU0VKnZ8Ken
         Tp6TRHIIkb2rwnrnUqxKW+ln4wSzfPVGIM1f0M5w9UeRZx2RXXbWRWmglFLxSeJFb1
         OxGFryVcLpeG//Q7d7FHWbJXtIzkY9qQsPUAySTq0hATpDfL0LLCNLktUefh/JAxJX
         tsM3pr/sB+9sU2MxPYZgjTgpWHtdfAfBLS3rWOhViRfueOGD+ZWorJ4BxeQlMNINWE
         OReMoTgPh7qHg==
Date:   Wed, 26 Oct 2022 13:49:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <Y1ks6n7wCfhArza/@sirena.org.uk>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ws0GFWnXGiIRAF8"
Content-Disposition: inline
In-Reply-To: <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
X-Cookie: Prunes give you a run for your money.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ws0GFWnXGiIRAF8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2022 at 01:12:49PM -0700, Chen-Yu Tsai wrote:
> On Mon, Oct 24, 2022 at 3:01 PM N=EDcolas F. R. A. Prado

> > The rt5682s codec can have two supplies: AVDD and MICVDD. They are

> Neither does the datasheet specify the ordering of AVDD, DBVDD, and
> LDO1_IN for power sequencing, just that three should be toggled together.

> Should we model these? Or wait until some design actually splits these?

Yes, the driver for a chip should be a driver for the chip not for some
specific board.

--6ws0GFWnXGiIRAF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNZLOkACgkQJNaLcl1U
h9B/zgf9EephDS7CV9faIUtycitCDpOJIbYZYIhjrW6esmg6J2Kt5y00+V7/DQta
zIHGZ9GXpX1DDlleJSrm3AgC03rKRub8VV75SwGvRGwuiSA5oaslFPiRPcYbBSEX
B1TrN9NfwUYvJnaFVlXPoCxoVhrB0t2Mp4bltVVqfKFzkEoBRD+PeuCpIIM7OzSL
d4kdyDLF/5L9hW5WQVCMH33zkmf02p1z8SWT/4KHFzqtuHc4f8Md9qzCLlbl0AY7
WMv+pah7enDvFw/Uvr9adIYrWIwLEfMP4DiTZO4a8JjT03wAwgdC+A2aTeMyle9P
fPnVMh6XtsDxs0KKcKD2p5ihwKlF4w==
=Rizo
-----END PGP SIGNATURE-----

--6ws0GFWnXGiIRAF8--
