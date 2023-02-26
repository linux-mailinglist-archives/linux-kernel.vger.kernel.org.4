Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC86A357E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBZXFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjBZXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:04:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4A8AD12;
        Sun, 26 Feb 2023 15:04:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPzj74Cmbz4x4r;
        Mon, 27 Feb 2023 10:04:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677452668;
        bh=p5aLGF30JMtgDVRTFTm3FLalHuhWdaHAP7ZDSNjotnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TQt3kvfnGka3+LJC3WOPw0Ncrysj4+gW26+2yOuKHUWUeVSrmep7WigoLQSnUs3wL
         zIo9emLF1GB66xMQmmwG9iVs4emdXR2hg53x8aID7Gx+pa1uyk+n32PlJsty93WhkR
         pRGD/BFETQV9sT/8CLf7qChB55kDJTrZQePfN3y/B/Im8cmfqfR0BOcatP8vL/wZPu
         khx808XExS5yz1w9/DfVLpVOaM9+c/6/um0RukclE3v++ciJqiTuM+SkoatddmT7oE
         r2Ii7u+bJJZIiyPGMCAlbX3dky9O2AxH7R2VX33kH0ybp+nBAXGFkZpB8kDhS9aY1l
         dVHZGYEV9CNHg==
Date:   Mon, 27 Feb 2023 10:04:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: nvme boot problems after merge of mm-stable tree into
 linux-next
Message-ID: <20230227100426.65fe5352@canb.auug.org.au>
In-Reply-To: <d4260bee-2bec-40e4-b07f-3a9fa18c3d72@roeck-us.net>
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
        <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
        <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
        <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
        <20230214172040.60657882@canb.auug.org.au>
        <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
        <02f796c7-c1d5-2f2b-3385-e72298f5f470@gmail.com>
        <20230227091423.3797ba8e@canb.auug.org.au>
        <d4260bee-2bec-40e4-b07f-3a9fa18c3d72@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fc3Ie.uRp6/BU6yV3Cxc2Dw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fc3Ie.uRp6/BU6yV3Cxc2Dw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sun, 26 Feb 2023 14:53:29 -0800 Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/26/23 14:14, Stephen Rothwell wrote:
> >=20
> > Did this get resolved?
>=20
> I think so. Either the offending patch was reverted, or it has been fixed.
> I still see various boot problems in -next (and most of them are now
> seen in mainline as well), but none of them are nvme related.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/fc3Ie.uRp6/BU6yV3Cxc2Dw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP75XoACgkQAVBC80lX
0GwDvAgAowUk2nkJZtxpeCdFhnTZ4oCdp7k8OwmzK1Pa0k4ZrGpER7vcTkHOEpBi
FWIkMbjOT94F3mQ1w7vjFVcJGS2Ud/RXo0Xoq5pO96vvS6bGe5TSxTaUJMVrjFkp
vUIEQHb94TGaCiWhgPwiPvWRGwEFmG+g4msOkyxsOn3BqZxAysMVSgC48kQImaUS
3Iy7CS+r2ZRddPSJ0vWlAsuQJJzZPmN3sSiZldSTTlYbDEOze0GLiAP3Dvba6i7q
xloGvkBAAzJMePvdSRoMziwpzLIfkhsTfeJ9dhw5p76OAVpsor+Q8Ca66C0+MAdK
fM9lAxPeaQWg2BKGgwpSLmNNQXsmGw==
=V5FX
-----END PGP SIGNATURE-----

--Sig_/fc3Ie.uRp6/BU6yV3Cxc2Dw--
