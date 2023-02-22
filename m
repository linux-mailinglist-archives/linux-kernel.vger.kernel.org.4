Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609B69F46D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjBVMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBVMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:21:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78B3B0E3;
        Wed, 22 Feb 2023 04:20:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC1CB81230;
        Wed, 22 Feb 2023 12:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC03DC433D2;
        Wed, 22 Feb 2023 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068349;
        bh=+WMfH/vfA9sE+7maMWnfJwBB0XRFBu9RGwN8ZN2WlwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tf2XAqDW1NM4oO68ExxpeLH7wGvx6qChu7z+A26+n7la5TlOEuJ29jRH93Iyktc89
         Jmv7yfNJZDuTrm3dfHSEshvvN5fx8XLd16GUflx/ElI1lLeKjHnPBsLdR0d4MwVHzh
         TDjQumrZvRvpRFTuaAfXK31YQOiXoRXVR1PYRESwVAxhYSg9K12Q5Ln4U03kilVkS9
         MkzXFVUzs5rEUP57u6aurQc/oT7nCrpYvCZarsGOeTXEKYq/gjgjxgFjZDx8wn3W/6
         t1PScAepRkK9gThLrTLYE8NhauX7kfAD3IsQmUUk+ZxZDnzp2IbPpXaGQOwQktW30o
         mnG5hBmAZQUmw==
Date:   Wed, 22 Feb 2023 12:19:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 07/10] ARM: tegra: transformers: update bindings of
 sound graph
Message-ID: <Y/YINlZFHQlXFd/Y@sirena.org.uk>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-8-clamor95@gmail.com>
 <Y/VFMl5Darm7YEK1@sirena.org.uk>
 <CAPVz0n072v3XVt-Ogcx1QwBfEfOG4O7e8Ge9f3rpWOqU=44Qkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r8uDps5uYYJHdecZ"
Content-Disposition: inline
In-Reply-To: <CAPVz0n072v3XVt-Ogcx1QwBfEfOG4O7e8Ge9f3rpWOqU=44Qkw@mail.gmail.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r8uDps5uYYJHdecZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 10:02:09AM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:27 Mark Brown=
 <broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Tue, Feb 21, 2023 at 08:32:08PM +0200, Svyatoslav Ryhel wrote:
> > > - fix headset detection in common device tree;

> > At least this should probably be split out as a separate change
> > so it can be backported as a fix.

> It should not be backported anywhere.

That's non-obvious.  There's certainly changes in here that just look
like bug fixes to the existing DT, like the corrections to the DAPM
routing.

--r8uDps5uYYJHdecZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2CDUACgkQJNaLcl1U
h9DePgf/cx8wo+jaPYNuQCrgdm7hjhsdy1bhQb+A9d+0XSYC75Kd4BEQTCgPJXdf
f0CRA71HNHSmZPrb1YlMcVYS/33kjdrZ1Q9XQ2ViFJKLLBA+WIySAQCfbTFH0Hfw
Ry8To8+GpfptKNBlyZxy9RsbiGp6jLjmSjoQNmpIPjafCLd943Rt468B9HYQOyoj
vaToVCRK0DJMsKUCxS5TQGmqr2xHws9PX4bmfjWy7/s3dom8u46FBaIw0Zht6/Hx
hQbgIhCTZ6I2TBqIPXuSDxM89xumRJsguIV1EyYvzn/AwUQ5x7gwz/c8oV1M8JmG
WDGQhzrEQ3EBzA6wDLp9ZYAZfFTfqQ==
=BEkB
-----END PGP SIGNATURE-----

--r8uDps5uYYJHdecZ--
