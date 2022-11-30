Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FABF63E07B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiK3TMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiK3TM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718A5447A;
        Wed, 30 Nov 2022 11:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E5D61D96;
        Wed, 30 Nov 2022 19:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A70C433D6;
        Wed, 30 Nov 2022 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669835548;
        bh=7/PmRXrq9zlqvQApzLYyYr2iRBg23UOELSQ0LVfNJ8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxG6GHRbl0BoIBYr+GpnFqa7iZ5d6WuBRII+WEgu6cHbjQH6CSNuezpNqqgcU+k7S
         9+wygEZGbaspf2ZoQH2YSbLLRWF6d1p/1TBc57LCgkWJUg84YCpeGPB/leJ6F2Wxn8
         yiFJdVHqzzlgOTiquZGiRQjINWai/GDjDVsN+7mc3O3+nos2b7BSgzSI9gsLtuOseR
         OieYfp8JlW4H7dgmTcJMh39cxVm1GhAa4Y5RMYQTB2q9M0rGSMCEl6kG89pPzy8Aen
         V5h6RG26HF3n3IzYL9taskFWUKg7XxCg5MLNKnJYjOdg3M33n7GNrq881GJukMUHdK
         zCQcSDqHKO+uw==
Date:   Wed, 30 Nov 2022 19:12:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add maybe_unused tag for
 system PM ops
Message-ID: <Y4erFaRfGXbSJLMm@sirena.org.uk>
References: <1669726428-3140-1-git-send-email-quic_srivasam@quicinc.com>
 <Y4eN4utrDnEnKu/8@google.com>
 <Y4eP2yFKsmxzyX/4@sirena.org.uk>
 <Y4eU7ra4w3Fm+wLM@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s1pYjTMRz+F+fT4W"
Content-Disposition: inline
In-Reply-To: <Y4eU7ra4w3Fm+wLM@google.com>
X-Cookie: Jesus is my POSTMASTER GENERAL ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s1pYjTMRz+F+fT4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 05:37:50PM +0000, Matthias Kaehlcke wrote:

> The tag of the applied patch is incorrect too, which is actually what I n=
oticed:
>=20
> Fixes: a3a96e93cc88 ("ASoC: qcom: lpass-sc7280: Add system suspend/resume=
 PM ops")
>=20
> This patch is for sc7180, so it should be:
>=20
> Fixes: 2d68148f8f85 ("ASoC: qcom: lpass-sc7180: Add system suspend/resume=
 PM ops")

Oh, well.  It's just a fixes tag for something that has only been in
-next, it doesn't really matter that much.

--s1pYjTMRz+F+fT4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOHqxQACgkQJNaLcl1U
h9DOSAf7BTiWGZhA0UbkwiQEXLZETjGS0qh2Tl7tkdQlpncLUU0hNi0Jzd6Ql4eH
uXUNDqRlRqKmsVM0VzSCESQNEAXIau9rYdpe1dR+cW2+a9jUBUfCcV/tYaoIvOuG
rr4vwWg4vFEleOqXCHGUqMyoONyefdj8ZB8PaiZ+98WU/Syz/GIAvRxWErCOWI2s
xErZ8rzIq3w+AEtHw41neAl5kyPpkwceuxI+h7Gv3cjC0QMCLD1QfQJJLnQx/hvW
wIRHWTXFpyZoO2u4oZkyq4KepyuACdhDfet4UeEp3AB/FFV92SABhsg4Lgo3upbv
SxI9wVuIDTxfFiXnNMg8+DIJqkbvhw==
=H3n3
-----END PGP SIGNATURE-----

--s1pYjTMRz+F+fT4W--
