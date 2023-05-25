Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE97710FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbjEYPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjEYPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:44:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46659195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE438645C2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEECAC433D2;
        Thu, 25 May 2023 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685029441;
        bh=Rnh9uTUVYZr2YTUohkaeBeK8GIk4QC1ZRZZ7ndFmbVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oj25qAs5uQVw0/DNnVys3tM7gwwxhUjBEYwOI0WyAzJBJ6H5iiovRJsvBTtxREjIL
         YZN2JJTCuiMDWxHzQofwPrLiG8h2AuUCbpXojkDxX/s+eemR0a3fvMqmCXHp2biIF+
         YGLOTAZYQ/hG5ocXQeceabwkT6Li/Z5oSCsDw6D7TSphBX+xt4X0Ea982wTl1tUbkl
         R9f33XhPqHhXV/mppwBjcwhbt6b7KVashmsd6kYFBd55/5aXbFzuLxtFWbbnT2aUT/
         b3snwtgcA3FVLmJc5EG7RajzZpDZz1E2PgmtmWafVRuvG7oeiJZrUQPgmCs01M5hEe
         td/2KtAtHxLiQ==
Date:   Thu, 25 May 2023 16:43:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 00/13] ALSA: hda: Adding support for CS35L56 on HDA
 systems
Message-ID: <3205049f-387c-42cf-a8a4-b1156707655c@sirena.org.uk>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vCCJbWOxCPIHYsGh"
Content-Disposition: inline
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vCCJbWOxCPIHYsGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 04:06:46PM +0100, Richard Fitzgerald wrote:
> This set of patches adds support for using the CS35L56 boosted smart
> amplifier on HDA systems. In these systems the CS35L56 audio is
> routed through a HDA-to-I2S bridge codec.
>=20
> This doesn't include the changes to the Realtek driver to actually hook
> up the CS35L56 driver, because we don't yet have the QUIRK IDs to
> associate it with. But we want to publish the driver now so that it is
> available for bringing up hardware with the CS35L56.

The ASoC bits look fine modulo the one issue I mentioned, with that
fixed

Acked-by: Mark Brown <broonie@kernel.org>

--vCCJbWOxCPIHYsGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvgjsACgkQJNaLcl1U
h9B4RwgAhD9nQ7OWhpSd8WAk5CrscWbsV62DLDcm/qwLsFzz3VQlHXq5LY2/KM27
aqGH/8f0zUAWZxK/LMGQ7Q89lkYrmCghahCylHSHwwkyk3/U6RqPdVTjvoMeQuHC
7Cm6LwklU933g1I7SfwonG9y5Yt0DnszDCpuk9fbvohu46DtOpx3M+4kVcP/fCpP
qcjMNz5SYyUipk5Rdn8H9XN1kG5bi2DDoM+x5pVIaAfjNgTMVp04IiFZGeLzY6Fl
gtGB2rcDwvkgVXQGSg7i51+YkfA6/wflcxfxhv/o1TupzeeYwW97xyYXfbh+1NJ5
FZtCv0oydYAaWBTsnGMfWDuXaizAxQ==
=28Kw
-----END PGP SIGNATURE-----

--vCCJbWOxCPIHYsGh--
