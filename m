Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B796FC347
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjEIJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjEIJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E2DDBB;
        Tue,  9 May 2023 02:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53152620E4;
        Tue,  9 May 2023 09:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB87C433D2;
        Tue,  9 May 2023 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683626093;
        bh=4Y4KsoymL3vI3NxJE16nycgvLgRutCPHdLycUR0m9BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NACYYs3kELixi/jGJfhdrnnjftwxVRr+iliOnAWmUUTUwYDSSSmT3wiplNL1rzr00
         gYWW1AJtWqc0EUwXYdQwjP4tK34rwpSW/n06ZzcKGznw7rsnW4Qz8bWAezNudc+O4Y
         hjRd2clddUaatDCnLaoxDEFRKUDZVv2Cgnj6S6G0SRijx99wIpC+JNsc29WHRHazAS
         JU7I1hO/4xJrTFpRW/YX+Am8gPma3uRP4dNt1iGG0bh5oZlfMqaQKZuCeKuLrLoOOD
         0N/4LvVdWmtqKYmoCmCJ6CjeOu/zb7uCcifSZhx54LHZKGdLav0Loku5dC8NX4WMlb
         MeFSWDtTfEZ6Q==
Date:   Tue, 9 May 2023 18:54:50 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3 audio
 codec
Message-ID: <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-5-pan@semihalf.com>
 <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z8CDGSKZUTT4IQxF"
Content-Disposition: inline
In-Reply-To: <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z8CDGSKZUTT4IQxF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 08:18:15AM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2023 13:30, Pawe=C5=82 Anikiel wrote:

> > +  "#sound-dai-cells":
> > +    const: 0

> No supplies? How do you get power?

My understanding is that this is deployed to a FPGA so the power would
be going into the FPGA.  In general a memory mapped I2S controller like
this will be part of a larger SoC of some kind.

--Z8CDGSKZUTT4IQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRaGGcACgkQJNaLcl1U
h9DOwwf/QdeieGMjndj9dDM7ZflkZAvEnssvAwTu2oHFp6U1dlOC7TsriRVIxIUS
8kTV0ysluuBngw21aMAXUcTZK/gS8p7Milkz+4t1tXooSFcWN6fzqTksuYUlN0PT
knXqWolQifE8+zx39nIA77EcMMbKfGldat7bdv9GTeSOUpiyKqIyJncmW8EYn6TB
8g4TMIGJ6CoXBvCPrdRz1f+dg7A1E9iC7IquMvG5UpOyJOSzV1RuzxxDGEM+bVGy
5j9+4GOFAD+UN1QkPaQbSruoIj37wZ7f4JtZYHHyNt9NyULcw6S0WJ6VDB5JRGGx
zwE9SRZE/4yIihtXK6OHLRmQeUvCTg==
=dLTt
-----END PGP SIGNATURE-----

--Z8CDGSKZUTT4IQxF--
