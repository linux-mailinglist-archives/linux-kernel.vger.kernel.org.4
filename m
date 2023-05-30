Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFB715379
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE3CKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjE3CKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:10:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780BB7;
        Mon, 29 May 2023 19:10:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVbTX0LcVz4x3g;
        Tue, 30 May 2023 12:10:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685412640;
        bh=wDYppAoDJWMdt7tdGl5WSBq+MGJG+/ZQyPPcIBRD7Y0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ukOe2dCr+kWkOAVuA0TKoGo9HBDaSysy+fC+C7d8ZoMJMDVKNn7PMDY/mSFQCuIMj
         C54KQ1jN6lWRw4+8qzx8vPCj8alLiYiSdClFCYChy7dDI/tT4Gy/EYokyX5rDJGaVZ
         Q20fpe/dorOhRGsr4zlxjQ9w/ZnaDPXcPmk+8+SJzcXcTfQWq/8KVkD4bWUxh6npT7
         q61JlS9pZrEn4DBjLYuHDOMFcuC2iXPfcfkxGc49mImVoBCcsMpbZCHiy1Otm6+boU
         tEyExQF9STfGohFjMoIbspT+/8I7Y8LmvYAeMxDPkQwVCda+g8Rj/QOBKM2g1zyOzh
         iKzRKqhAdwVyQ==
Date:   Tue, 30 May 2023 12:10:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Fei Yang <fei.yang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: Re: linux-next: manual merge of the drm-intel tree with the drm
 tree
Message-ID: <20230530121039.6a2037c9@canb.auug.org.au>
In-Reply-To: <20230530115752.14f0f1b5@canb.auug.org.au>
References: <20230530115752.14f0f1b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5vtcpJN63QOoP2wlS0l_0Zw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5vtcpJN63QOoP2wlS0l_0Zw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 May 2023 11:57:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> @@@ -920,33 -587,8 +640,9 @@@ static const struct intel_device_info j
>   #define GEN12_FEATURES \
>   	GEN11_FEATURES, \
>   	GEN(12), \
> - 	.display.abox_mask =3D GENMASK(2, 1), \
> - 	.__runtime.pipe_mask =3D BIT(PIPE_A) | BIT(PIPE_B) | BIT(PIPE_C) | BIT=
(PIPE_D), \
> - 	.__runtime.cpu_transcoder_mask =3D BIT(TRANSCODER_A) | BIT(TRANSCODER_=
B) | \
> - 		BIT(TRANSCODER_C) | BIT(TRANSCODER_D) | \
> - 		BIT(TRANSCODER_DSI_0) | BIT(TRANSCODER_DSI_1), \
> - 	.display.pipe_offsets =3D { \
> - 		[TRANSCODER_A] =3D PIPE_A_OFFSET, \
> - 		[TRANSCODER_B] =3D PIPE_B_OFFSET, \
> - 		[TRANSCODER_C] =3D PIPE_C_OFFSET, \
> - 		[TRANSCODER_D] =3D PIPE_D_OFFSET, \
> - 		[TRANSCODER_DSI_0] =3D PIPE_DSI0_OFFSET, \
> - 		[TRANSCODER_DSI_1] =3D PIPE_DSI1_OFFSET, \
> - 	}, \
> - 	.display.trans_offsets =3D { \
> - 		[TRANSCODER_A] =3D TRANSCODER_A_OFFSET, \
> - 		[TRANSCODER_B] =3D TRANSCODER_B_OFFSET, \
> - 		[TRANSCODER_C] =3D TRANSCODER_C_OFFSET, \
> - 		[TRANSCODER_D] =3D TRANSCODER_D_OFFSET, \
> - 		[TRANSCODER_DSI_0] =3D TRANSCODER_DSI0_OFFSET, \
> - 		[TRANSCODER_DSI_1] =3D TRANSCODER_DSI1_OFFSET, \
> - 	}, \
> - 	TGL_CURSOR_OFFSETS, \
> - 	TGL_CACHELEVEL, \
> ++	.max_pat_index =3D 3 \

I fixed the above up to have a ',' after the '3'

>   	.has_global_mocs =3D 1, \
> - 	.has_pxp =3D 1, \
> - 	.display.has_dsb =3D 1, \
> - 	.max_pat_index =3D 3
> + 	.has_pxp =3D 1
--=20
Cheers,
Stephen Rothwell

--Sig_/5vtcpJN63QOoP2wlS0l_0Zw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1Wx8ACgkQAVBC80lX
0Gw+SAf+Ilv/tNfr1MSGBJMxlVyniZfQkGznYVHPJJ/VECE06jL+2+aotBU6Ygt2
sgw7fI3865uFbcMzirfj7ny2wMSQQ4grVrWeBVTlbdtqgRqJtWoH5te5DrNNEdM6
7JdWLaWGZmI6au/Nl6tZ5Plcui8jHTe+DDGNKL+I5fhmGKtLZE+MXn7V5aV8o44Q
47B7wYS+xHqPDZ746/UyG4gCBJJ3h+Fzt6wGZp3mEE5Jh+gTWLhCavA04kcntxpv
FFv3PzrbLq+DDIQ+AUmcjeGXNDb+KYwW/er1pqrLkqARuGiLb1X5s4Ak39xm6XQc
HkNDUSJzgMpfARd8GBMIHwTVPsh1Bw==
=Ghjg
-----END PGP SIGNATURE-----

--Sig_/5vtcpJN63QOoP2wlS0l_0Zw--
