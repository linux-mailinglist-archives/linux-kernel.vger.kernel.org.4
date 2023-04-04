Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A096D55C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjDDBO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDDBO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:14:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7642117;
        Mon,  3 Apr 2023 18:14:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pr8tJ23Skz4xD5;
        Tue,  4 Apr 2023 11:14:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680570858;
        bh=xWnFz3omlSSUQ6pvXBh3mJjfwj9wtwa5df2BWKY78pc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G9E55lfuGdGA131O4+pTINB+ymgUrF2mgfKAeOte7YN8cB77cZRgUQCWUAKl/+8Fo
         XrvHBGmVPXLFTwOX7O8+wR6kjrGlwvmEhogO7Mo5VkUKHFoE0Q2rZ6+GvtWEr0RE1J
         86hTC2myip1AymwrAo4esue0g30P5fQWF/vR9+HAiPGVZGh5OU+4FfOqlaPGtAaPrf
         I6OhWu9SFIMwDuRNN/p1UISrGs/pcOrkCiKETxRwBv/RCkd9VVZIE8yThP4hqsc8Kn
         NRJErWRk+hFPwrGnUdQcoIAiC5aqBh8V+s/j3AGiljBT9agf9WHh6wox9f3e5zPyza
         D/fjvFNBkM2Lg==
Date:   Tue, 4 Apr 2023 11:14:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Erico Nunes <nunes.erico@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20230404111414.249956af@canb.auug.org.au>
In-Reply-To: <CAKGbVbv=eyaKPQM8QfD-999-=vbrrqnEXkhuE7dy=vpK7OFY6Q@mail.gmail.com>
References: <20230403121617.61e2a929@canb.auug.org.au>
        <CAKGbVbv=eyaKPQM8QfD-999-=vbrrqnEXkhuE7dy=vpK7OFY6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Jf/o1jzUlq4sM1feIx+gKn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Jf/o1jzUlq4sM1feIx+gKn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Qiang,

On Mon, 3 Apr 2023 16:51:27 +0800 Qiang Yu <yuq825@gmail.com> wrote:
>
> I think you can just revert the following three lima commits when merge:
> * 4a66f3da99dc ("drm/lima: add show_fdinfo for drm usage stats")
> * 87767de835ed ("drm/lima: allocate unique id per drm_file")
> * bccafec957a5 ("drm/lima: add usage counting method to ctx_mgr")

OK, I have done that from today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Jf/o1jzUlq4sM1feIx+gKn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQreeYACgkQAVBC80lX
0Gztwwf/ayUr24dwPGpBwuOZNuHc+gqzczYFs/UNV0yGedqRxRR3wJKAh5BlSvMJ
tZIpDIglihMPeJzvh2voTXagFeRKO/rrvXgjSz+hqe61OmTYj7N+NbydUNNzbhZR
0ouapqxmeeL8+WW6d7EQF88C0ERPuNaOPoivGU5bxuzwZP5nfNq2ZLkrMSiNTWOF
g4eZ/fJP0uHFg8Aj6uR/GMaD7MCve5qXAT10f7IN7hWeRdeP9AiI8tD5UF/HoMus
+bZzF3zzTOsYn8YOIXoVkWawD/VjfjX/6TALsgclq1HDSaMgv9tLN+MxWp/jLplw
r4SZoPkaQf0J3f4xZ+NddlaVdsPz5w==
=AUB1
-----END PGP SIGNATURE-----

--Sig_/.Jf/o1jzUlq4sM1feIx+gKn--
