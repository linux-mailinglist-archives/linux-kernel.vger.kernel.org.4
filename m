Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDBC74FD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGLCvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGLCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:51:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D311AE;
        Tue, 11 Jul 2023 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689130277;
        bh=hbvmqUn4K5h0Wmr7Y3QeUu0Gk9RV14VVpCTT5uZbzZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=labvdQMB1LkMEbLPFcdz0hY2+b1lJgSMpmiLbjxz+0j1lIwHFySM/MNxDBNi4P78w
         C2c8u2WjVemqP8lkWi79PNecg8dpDO44xBjTN57XPxFoE8+5bu25h5of7qAK+WK3Gx
         R/IjvgIVIXqPP1Xy1HJ1swdRpcOJTrb2gwGeypq2cG6K3+h8a9QTagCnI0otRxge6W
         SG9A4zBAi+/JKyL3cJZxeZWed28g4kGW49gGkPT+I+lWbE11kiQBZR3lPGr/OQH1Tq
         8ZXvjgMIk0z8txgGWlJmJWbId/y+/Ctiw0nvvGAFqGLl0eldNuv00Oz4ZsiyVxCd0w
         2eQI3iiyu3KfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R12LX4KfJz4wy8;
        Wed, 12 Jul 2023 12:51:16 +1000 (AEST)
Date:   Wed, 12 Jul 2023 12:51:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20230712125115.06caf01f@canb.auug.org.au>
In-Reply-To: <53602f8f-c37b-6570-d76d-5dd3c3329280@infradead.org>
References: <20221118175545.762d1a20@canb.auug.org.au>
        <20230712091509.4f6f7a19@canb.auug.org.au>
        <53602f8f-c37b-6570-d76d-5dd3c3329280@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RLftZouG86vvxK3dKWG+aE/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RLftZouG86vvxK3dKWG+aE/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 11 Jul 2023 19:26:33 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> On 7/11/23 16:15, Stephen Rothwell wrote:
> >=20
> > On Fri, 18 Nov 2022 17:55:45 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> >>
> >> After merging the amdgpu tree, today's linux-next build (htmldocs)
> >> produced these warnings:
> >>
> >> drivers/gpu/drm/amd/display/dc/dc.h:548: warning: Function parameter o=
r member 'dispclk_khz' not described in 'dc_clocks'
>=20
> This patch:
> https://lore.kernel.org/lkml/20230712022339.17902-1-rdunlap@infradead.org=
/T/#u
>=20
> removes all 175 kernel-doc warnings from dc.h.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/RLftZouG86vvxK3dKWG+aE/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSuFSMACgkQAVBC80lX
0GwJewgAiwtZZDn286quU9xHc8wOpV5e1CWWKMjAq02PigCohZ8wRAaImk8T5KAH
D8xHPXgnMdTlQ2QvUuzmRxwP1Yps7Pt0wqWkUH+5G0apk8lZQhN9cNBwhR873Tug
EVnpWwudK+ON/Pnj/LM3iWP+h6ixdpNj468AE59H+0/Rz6yiPeieyS/qN0uUpnDE
IVOfxDfXoofh5NLNj8zoMQD7IhoWJ+cxvn3dTInFJzm4+In3WKyUil590EgQuHe3
LZFo0tjr98ruy+QRB2TGLc1R/AwayXhqD9YOMA1/d5MVLLe1d3LRvVjHfWz/4Le2
q2qIYWHtToCgUjatIB04R95HUG1ruQ==
=2E1H
-----END PGP SIGNATURE-----

--Sig_/RLftZouG86vvxK3dKWG+aE/--
