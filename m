Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96425F4D12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJEAeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJEAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:34:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870A56B82;
        Tue,  4 Oct 2022 17:34:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhwYd4Xvtz4x1D;
        Wed,  5 Oct 2022 11:34:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664930053;
        bh=paQd6ikY9lE6Pe/hj3vtoqHStYRO3Yb6qPf04KFMpG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DK09CE7qEDlQYvel4CxvPjuBIPnDocbJkkh2WkLXhsDtuEC1mLyksDidNFFe2SAwj
         PTTle2L+/yWGY/xsVQwy3+G9eX25BFPyonKbUD/dXY9XRD9HA5p8T/gsSKJeBQyI7S
         YXLtAujauOcjvlgBwkDsTVyoX79wHa7ahv3Xt5GucaTLlV3ZMLrZtkgt/aLKGAVEth
         hqOICDXK0nAz3jVZdiMs95F7rkByADcFd610dhty2K8RKA5BjLtSA4GAGMIMff+97q
         AQ+BHLm17ZUVKJmKgu+L0jYTgOnmF66dRxBNoh4DkZWODpabDFWQr541Od/6nnH+OD
         sNPli67cTym9Q==
Date:   Wed, 5 Oct 2022 11:34:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20221005113411.0224d4a8@canb.auug.org.au>
In-Reply-To: <20220831090026.2e6b57ac@canb.auug.org.au>
References: <20220811121050.0da83776@canb.auug.org.au>
        <20220831090026.2e6b57ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vjBMNJSiiEsDGO4kNnHK.T7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vjBMNJSiiEsDGO4kNnHK.T7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 31 Aug 2022 09:00:26 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Thu, 11 Aug 2022 12:10:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the amdgpu tree, today's linux-next build (htmldocs)
> > produced these warnings:
> >=20
> > drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT=
_AVOID' not described in enum 'pipe_split_policy'
> > drivers/gpu/drm/amd/display/dc/dc.h:465: warning: Enum value 'MPC_SPLIT=
_AVOID_MULT_DISP' not described in enum 'pipe_split_policy'
> >=20
> > Introduced by commit
> >=20
> >   a2b3b9d57bdb ("drm/amd/display: Document pipe split policy") =20
>=20
> I am still seeing these warnings.

Still ...

This now commit

  ea76895ffab1 ("drm/amd/display: Document pipe split policy")

in the drm tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/vjBMNJSiiEsDGO4kNnHK.T7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM80QQACgkQAVBC80lX
0GxUAgf/b/dyXFMqAIaQ2r3Fr2uqeHwd9C/IvEctFXQ1hB9ieIexUgoaw2Ju+q89
qrQsmB+QhhWyz/LViHFO+oWT0kv/MCqpyQQ5eOM27tFD3+a+uDV5GpEkCo+gSmjR
t4yefM04VaqFTaeAN+DYUrhIreVkfwYGWhBcJwlMau21QgGjWIz8gpvmy11Obc1m
WLyjiGuzbE+QPDkCzp8wNHUhT4Y03n5lnfyCxVpLEIDYH53/7B6Nz9oikfRuaCYN
g8tXcepN9k5M44jYAwJKQqqsGP6qGgTkkUtuTqS1dbXU/49fMbuwuqvGoyWUVUSE
Q+1aJ76vlYgrjqdgQnMonlH/jmDznA==
=7Agk
-----END PGP SIGNATURE-----

--Sig_/vjBMNJSiiEsDGO4kNnHK.T7--
