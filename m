Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A891D670C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAQWsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAQWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:46:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75387B2D3F;
        Tue, 17 Jan 2023 13:48:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxMw70dchz4xMx;
        Wed, 18 Jan 2023 08:48:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673992119;
        bh=75Yy+WlgV7Ex/vzs3d+z+VuSR6ePdxf+ksxThEs556g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eUrD1izkefCGdU0GkTwpFXkSea45FsmDooNhuxzEozUS2ERpoXmXVmH+UVGIBxi19
         nEc40XS9polRJgAe1QsBkuDETFTlOl183ayNhp2g5rHrphEm0N54uqny3Lg9QnJGjT
         jl+WFvCo/dPFjPbvxP9Ub9b3ChBHIkycXjbB7dmsQ9QCrSRTwelPsH9uHjrHFWb7oI
         Mc5GsMIkjM31FpQfdGTAnb+udsA8cxO16m3/CUbh7gdBmHHAMxLwWIydCMICdGq1pb
         ZxHWAAmEnaYtCia4oeAjRyQDAUm3I3A+c1OnvKTX2UOy5/yrH+mEEmmXFZkldU+loi
         CdJOeF0kWgc/Q==
Date:   Wed, 18 Jan 2023 08:48:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Message-ID: <20230118084837.492b1611@canb.auug.org.au>
In-Reply-To: <E6550C77-4A13-4AD6-8991-D1E369F716E2@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
        <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
        <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
        <20230117115228.13b55d07@canb.auug.org.au>
        <C72F2CC7-EB89-44D4-AC4A-C33EBED4B120@oracle.com>
        <20230118080027.300ab7b5@canb.auug.org.au>
        <E6550C77-4A13-4AD6-8991-D1E369F716E2@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AQ8XAsxpQ=/_f5XNHLj7od.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AQ8XAsxpQ=/_f5XNHLj7od.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Tue, 17 Jan 2023 21:23:45 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>=20
> That's now been done for-rc -> nfsd-fixes and for-next -> nfsd-next.

I have updated here as well, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/AQ8XAsxpQ=/_f5XNHLj7od.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHF7UACgkQAVBC80lX
0GwBOQf/fF/Y/88sLoaisXK3Tm7cJn4rwR30RQ1ecILgeHy01yChGDAv5CTuJpIm
Ss6U/LOjSAPQyQX4QxnLvenTDJuWP+/dep5yxkZgmHidFC9xdwp61k3BCg53CXmB
Hwqxb+uhmQrEw9jRnNqtj+/50/6Vr/0/izHVAKZVuqgTiWcZ63MLaiLU4rx+akay
xI7QcELOHrgoRC+rFz0trFHhqu0G/M5MMbuvbAtxKxAx8tqt1Md4onMp90NTu5X2
NCSgZ5bYfxo3laQ6i5tb5AoRCBMzUkxIAOjIoMh14NlEQEsHo6JL1wi1bSp0cJlm
Df4HCbDcI6//ZnN9t0jbaeLBGC8+VA==
=BiCg
-----END PGP SIGNATURE-----

--Sig_/AQ8XAsxpQ=/_f5XNHLj7od.--
