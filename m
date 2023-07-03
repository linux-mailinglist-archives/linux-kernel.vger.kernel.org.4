Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9373745C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGCMyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGCMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4AB118;
        Mon,  3 Jul 2023 05:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A63160F06;
        Mon,  3 Jul 2023 12:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F7EC433C7;
        Mon,  3 Jul 2023 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688388838;
        bh=hewjnNwAOpFhWN8t9+3hp7dpuy2ksO2+BijfX7/pwtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWP6F7tvelb32aSFkmXp3E37CiVtJLdyV1Q/Ol+oRCeZ8nbkDPcaKwnvipmDJY7tH
         54BJt+Oc4y83gshDU9zSBY8HSz7K/MU8Y0voUnWGhtfIy1CdScydVw8NVkMU1EoU2n
         zQ7PTlmNXODiJcTWCcRKDWy6zczUYmSHoqRbRHJ21RUV2qlBOEw0yuexv38JuMAhSx
         sFkOlE4rxVTL3Qbj35KkPeFAQTB7J9Jz41zlNo3gfESItN/Y9hSRVQ6Bq1nPFiw674
         nOiuhwpXKQywk/gVZzjACg//zXsHevdnUMkGHdOaJWCePBUDyigaQH1iPwiFg4JO6l
         DQeRuvSaX7XWg==
Date:   Mon, 3 Jul 2023 13:53:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        hverkuil@xs4all.nl, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
Message-ID: <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
 <ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
 <CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
 <87h6ql5hch.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XyTCZVqlIuin1XJf"
Content-Disposition: inline
In-Reply-To: <87h6ql5hch.wl-tiwai@suse.de>
X-Cookie: Please go away.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XyTCZVqlIuin1XJf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 02:07:10PM +0200, Takashi Iwai wrote:
> Shengjiu Wang wrote:

> > There is no such memory to memory interface defined in ALSA.=A0 Seems
> > ALSA is not designed for M2M cases.

> There is no restriction to implement memory-to-memory capture in ALSA
> framework.  It'd be a matter of the setup of PCM capture source, and
> you can create a corresponding kcontrol element to switch the mode or
> assign a dedicated PCM substream, for example.  It's just that there
> was little demand for that.

Yeah, it's not a terrible idea.  We might use it more if we ever get
better support for DSP audio, routing between the DSP and external
devices if driven from the CPU would be a memory to memory thing.

> I'm not much against adding the audio capture feature to V4L2,
> though, if it really makes sense.  But creating a crafted /dev/audio*
> doesn't look like a great idea to me, at least.

I've still not looked at the code at all.

--XyTCZVqlIuin1XJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSixNsACgkQJNaLcl1U
h9AHBgf+PmrkjDoGNN2pkJ1mNw5jmGsBAJkUX+OHPdAbWl0Su866gJ9fD6vXajFO
Y/9d2UZ5ubbmVeBZn47fj95dmPvq2povgtl2nzNz85MpDwcac03pQBVmS+ZPfYlk
Ui4s5mk+QFpXMRCxt4b9vYr8Wkp/lVH4RaD2q3fOXGeQqUvCp0Sn99z6tDZaTWBO
9hShFfh4il+VkKeBk6+m2MxWTcAEy5pAM7moCIE0VMDmZ4MEWmaXxvyJCZEOapD9
f+WpZURGpbdIi5yBHwfi/zVEHzfo2DGccC2UauYc50Z+hekml26dBQuTvfZM37Qc
BN0Unl4+vKxBW8rdx7rkbRIUueFLGA==
=SMUJ
-----END PGP SIGNATURE-----

--XyTCZVqlIuin1XJf--
