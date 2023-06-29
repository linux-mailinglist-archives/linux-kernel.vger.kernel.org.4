Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714297429D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjF2PoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF2PoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6062D51;
        Thu, 29 Jun 2023 08:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51ECC61575;
        Thu, 29 Jun 2023 15:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF21C433C0;
        Thu, 29 Jun 2023 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688053443;
        bh=oFbwbaYZ7miTeEicmpAwOWw6KnWiitf02o31s9XNxgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPrDjawA7h6uOw2dna84rNP+2QX8PeYOcxYWShOQm1d+BAcRmfl5dtoKzNzPTf8/x
         lNV1ED63afrSNMXdNDLmmfqXKb2lz1gxaeDo6PNhPBIaZYLBp0yFOHI0kVFKP7ajLj
         EbmxD+3IBFi2FXFlwPThooy7Yxfv5AsXgJO6GvS/kfAzS5AvciBtYdrbK6Z4+CojeZ
         01qLep/3yir0mNJaH1sM673ttVzA7NGhiPtqiGi3CePjNiDystNTaYfJHJ7Qje3z1E
         YZt6CSJTtWqaUvVtUYLzPXvwG585NZRE4zACuvv6NXhSJvkJlQC1jObuwFmVPxj5Ri
         lyMHYspPkd0kw==
Date:   Thu, 29 Jun 2023 16:43:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8bc6I2dYpV5RLa6+"
Content-Disposition: inline
In-Reply-To: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bc6I2dYpV5RLa6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 10:24:04AM +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with a setup without this flag.
> This resulted in inconsistent sound card devices numbers which
>  are also not starting as expected at dai_link->id.
>  (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)

Why is this a problem?

> With this patch patch now the MultiMedia1 PCM ends up with device number 0
> as expected.
>=20
> Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
> Cc: <Stable@vger.kernel.org>

Won't this be an ABI change?  That seems like it'd disrupt things in
stable.

--8bc6I2dYpV5RLa6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdprwACgkQJNaLcl1U
h9Bxhwf/dRqOJwBGONvDNGWdiQqXTCARa1cZb/fPFJNqdwS5EFz8B5791vslE7oN
uoUsLEC8VgPFaQ0cLq2s9NEDlMfgQmMbCoKmS1mlxGMQKLwcGeC9ahtf2H8YSgyp
D8Gq3/bVdYBvhXM7EbsEo2+LVlyZgKfMioGnc1p3p24GK7sq6DqYUhSEZwwRgY0R
aU7Wk5ys8U9QMlwQ4DyznHd9tEVXKu7HhCce1+qxsbFXHFg/OEI17X1MxQEMRKB5
3zcs9LHnaOcIdQi12y79ubmhQ1nrfupBHdz8CA5RxZfWCFkAKxVc/u4pQ5hCfRt3
wv0YoiXXnyclAf7gpeuiHLVueG/XEQ==
=yiRQ
-----END PGP SIGNATURE-----

--8bc6I2dYpV5RLa6+--
