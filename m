Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3579C6B263E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCIOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCIOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:06:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6615F1852
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:04:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79731B81EEB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF50C4339B;
        Thu,  9 Mar 2023 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678370675;
        bh=4R35ElemQenvIP7XOXmps7y6mw+Vr13Ba7RcexOZnwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAaAi+55lcMzorhxpAHCWAvs6myW/8QSx3mkJNAAJyYP6e+yDMs/LHlnFwOE4t1DT
         FvqUR3NUn3e0femASF+wk7Nv0Vju1+/crDQU4PYMxO2m3riBRReFtnLequIqOgrQPz
         phueGVz15Z1QOjCaDsbEj2pM8+OddBRJ0aDJZu9DM1vwgT2DIEGXvo8ocDGM5ZfEas
         WvIvbQMdDB/JSWodhrehV1VmTjIR+3sDxKXobgDPtcDVWA4TfDLjKdhDd5ceWgvqPt
         sewAa6rleSQfVtpGDLnmZVtChYBWK4/wFf84w6e8hzYZXTmzMXZvKW2Ll4CyGQvCcN
         ScbpafbNPuCbQ==
Date:   Thu, 9 Mar 2023 14:04:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Message-ID: <c5b6077c-1e6e-43fe-8f83-ca7019d4a43d@sirena.org.uk>
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
 <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MeVrIPWLE+hND0ym"
Content-Disposition: inline
In-Reply-To: <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
X-Cookie: I will never lie to you.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MeVrIPWLE+hND0ym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 09, 2023 at 11:42:42AM +0100, Krzysztof Kozlowski wrote:
> On 09/03/2023 11:41, Lucas Tanure wrote:

> > -	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
> > -	if (ret >= 0)
> > -		hw_cfg->bst_type = val;
> > +	if (device_property_read_bool(dev, "cirrus,shared-boost-active")) {

> You are now changing ABI and adding undocumented properties.

Note also that this doesn't change the existing property, it continues
to work identically.

--MeVrIPWLE+hND0ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQJ52wACgkQJNaLcl1U
h9BfzAf/ZQZeIWhkvUG2zW0YhKX/DwPY1nwEQk5jrslFfBH7hfk1/RrxzhQOCKNU
OXzDL807rwVGAzO6/2MESzNSmYkLV8iGt6bYehvyYAY4lsP8NMh/e7bFKawYYhDi
j/oMJ0xjxtEA5wiGMEP0ZnReXvIy73RnqO1QNHHRpUCNTrZJPU6ly4MDpI6LoDXe
wRLxAw2ZZwplCQM6nnnTD0MMy68tU2WCbGjArdjYCncA7B83MdIdcgvWj+Cs4X80
1psaVYXntOe91bOQkGiZFdGmTV2ZP0fWZcPIBYqhbONAJHNOIi1b4qf1qm5kgQtH
duszXlKKyxRo2iVEzZEq8nxwylnMNQ==
=L0t6
-----END PGP SIGNATURE-----

--MeVrIPWLE+hND0ym--
