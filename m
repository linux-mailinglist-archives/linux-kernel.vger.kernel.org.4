Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A86A222F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBXTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjBXTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246D34ECFE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8DC7B81BA6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 19:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3DFC43442;
        Fri, 24 Feb 2023 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677266107;
        bh=wvpHz3Awiez4EzQ/5a9FnelPVKhKufDDpe5+aqSfoVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4ZimhzFe113b+q2l+n7gImRPaTvekuZtWzz9EMWw4/hQKQUV+HEXMrS3hANxJ8yn
         WqdkjEiYeWpIUNdSBNQ9QMOSW0Rzl0g70WzSSy6pxLnZA1vWq5uylWRFnY1RT+WTTM
         NxoZJPNUXCg2qWrXw8w+sRummFlXU/fYwgKjMVi60z/5sSC+bJVcSoWWMtNaBkaJQM
         rtIi0B7JJnzzbv388SsmJiqpS4hEwEnI7yp38zgLcm/9NHSmE0Q7/7UJg8GPYNpN88
         IzSSj8Ea7YFGFcORBpn2dkB9fsgnfJ9dxBI0WVwCLjVflshHTns4zXSUT9BH42tC4U
         BPBC+aVbYKQ/g==
Date:   Fri, 24 Feb 2023 19:15:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: mt8192: Remove spammy log messages
Message-ID: <Y/kMtXmrIYoLNV8a@sirena.org.uk>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
 <20230224190657.edrvkg22gz5gff4g@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udvt/bvCvfnRf3US"
Content-Disposition: inline
In-Reply-To: <20230224190657.edrvkg22gz5gff4g@notapiano>
X-Cookie: The early worm gets the bird.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udvt/bvCvfnRf3US
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 02:06:57PM -0500, N=EDcolas F. R. A. Prado wrote:

> Probably the spammiest messages are=20

> [   33.881459] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_ru=
ntime_resume()
> [   33.889320] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_en=
able_clock()
> [   34.029456] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_ru=
ntime_suspend()
> [   34.041718] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_di=
sable_clock()

> from mt8192-afe-pcm.c, so I think it would make sense to get rid of those=
 in
> this commit as well.

They should definitely go as well, I don't know that there's a specific
need for it to be this commit though - it was mostly just what I noticed
while looking at the controls that were failing tests.

> Way less spammy, but there are also

> [  176.209790] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_dai_tdm_h=
w_params(), id 43, rate 48000, channels 2, format 6, mclk_rate 24576000, bc=
k_rate 3072000
> [  176.224149] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_dai_tdm_h=
w_params(), out_channels_per_sdata =3D 2
> [  180.272153] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_tdm_en_ev=
ent(), name TDM_EN, event 0x8
> [  180.281462] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_tdm_bck_e=
n_event(), name TDM_BCK, event 0x8, dai_id 43

> from mt8192-dai-tdm.c.

Yup.

> Anyway, if you prefer to keep only changes in the ADDA driver for this co=
mmit
> that's fine too, and I can send another patch removing these other ones l=
ater.

That'd be great, I will probably take more passes at this stuff at some
point but it's very much a background thing.

--udvt/bvCvfnRf3US
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP5DLUACgkQJNaLcl1U
h9DLFwf/YAM2Ep/kv6qQZQ6+TxtU7vTdLiprq5aQtl2WrtHV1TeDyqQh7kR9Li5D
75H051WimadBJSKxF19fHEd3ISMefuIYUhpQACpS0xyyN5Dg8kbp/Kfp2HdIWLsl
Kiptkup62x8YDVO1kVkyNrsJlimZU14yPx8OhPk475PB/pBXUXrozRiI9uwxHELc
/GiMndnDjS/xHRHqIBvg2wrSQYaZblAw8NBNL5wbgc99twQ04kftOceFoY+LDZ1y
ouTizm1i/w8ZtV9WjbQ2sq3/dMS3hSoXEMgQFcuZfyGdN/JTKKTwtg/2BiHr8k/J
3+69dA+Tg4vSKZjKrkiZs6ROKKxJ4w==
=J6dC
-----END PGP SIGNATURE-----

--udvt/bvCvfnRf3US--
