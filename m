Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3E697C82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjBOM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjBOM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:59:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C81EFCC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D1D61B9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594FEC433D2;
        Wed, 15 Feb 2023 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676465924;
        bh=eyP/8H2w6Aq7Vb2ltmRwluPS7KXnfTSnFc3mifM9j/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NijATvzR8b6e7No1G41E+8G6J2f/+t01fspm1dRlVUs84T/vitbZV/XCYlM5FzSyc
         CtioQM7mqHmZpCB3mcmxZuO9SbsNkYvGLoi0SAhNW9DEIU7xdBgAr1+H/2w0o7vuBO
         PMR+jJe6wvYnYdUSb4s9k5dHDearL3aUvIf8/O4BfzBne5J6D+Xw2KeQpG/ewgAby0
         6/6UjdvHKfbK1tHtgTsq8Z6qx6W+FmQbck+2hKvZAuYaJ60466adJzzBMDjadATaeW
         gC6MbrHE0/Ry0EV7PlbLyao87AkvUSEFLiB1UywwzcfPS6ubO/laCiCuW4hnOZ4b77
         cm3LV3/InRo0w==
Date:   Wed, 15 Feb 2023 12:58:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ASoC: soc-dapm.h: fixup warning struct snd_pcm_substream
 not declared
Message-ID: <Y+zXAQHHhkPtjXZB@sirena.org.uk>
References: <20230215094643.823156-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H4pdYQ3rNz1gxtj+"
Content-Disposition: inline
In-Reply-To: <20230215094643.823156-1-lucas.tanure@collabora.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H4pdYQ3rNz1gxtj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 09:46:43AM +0000, Lucas Tanure wrote:
> Add sound/pcm.h header to include struct snd_pcm_substream used in
> snd_soc_dapm_update_dai function.

> +#include <sound/pcm.h>
> =20
>  struct device;
>  struct snd_soc_pcm_runtime;

This should be a forward declaration of the struct like the
adjacent forward declarations that are already there, we only
pass a pointer to it we don't need the contents.

--H4pdYQ3rNz1gxtj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPs1v4ACgkQJNaLcl1U
h9BmuQf/XGMHuzkuHa6g7NfdPJiXEc/2CMdz9QaXMWzdXCKriEHeZwvEBNDb5vbT
OTfHFHZT6SA2/b1xjFJNizc/EhG5bAf9VpYPKHeY5QzoaoXnK/LmnGaSz9bd3avi
stM3whRCQDFAv2MswJna4r/+oRWOssZbhv/2TjTCLi5pWca1LTm24sooqKG+g11w
NG+ooCEE2IquycBT56spysa0ds+Ekxkx9lwu5rJXmj5rg9QiWMQG+JlBhxA2BUrD
V3atTKZEL5IdLpGazmQFe7V/9wM4jDtnhSHMonapfX2fQ/TprcqjvJUwjy/9eXU3
cjKvJsorSjFww1TPSV1piq+s5x0syg==
=g84M
-----END PGP SIGNATURE-----

--H4pdYQ3rNz1gxtj+--
