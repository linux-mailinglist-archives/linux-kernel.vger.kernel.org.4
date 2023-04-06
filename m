Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD96D8EC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjDFFVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:21:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F39F7;
        Wed,  5 Apr 2023 22:21:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsVGC3GxQz4x84;
        Thu,  6 Apr 2023 15:21:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680758467;
        bh=wHyfLo8fss49nOzMuYF6nW4MOlkB35uiuDbhSeqTq4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uZDL+QNPHsvw8XDude1aEynDjFNjGQZME8/o/tQ0OQv37ATkEkhESSq8lyLKeNfKE
         gyKKf2WnbYTollp1hN5jo8YNyC/iQkBNaam6iirpATBpBvlN5wbJoc4Y/WjHLR4A4X
         2tWe4BNDcWJRDPzBAmUa/03H9dftJEDaB/5KUC2tlvgCIH7sPrBVEn1HxLv7sQ3mds
         Cpyf3vsx0gTjcJU1S1dqqaJ5/DAw+D41Zyl0jMAGOP3qZ19ycTzjBGFqUXDpoxYwiP
         DAyAH/Vn0HH/QOuzfatlb8wXd7LyHXTJuKCnVGCLdvWWJoR1v4FZxT0mBnD+IpfDfV
         UJmyod7RlPCyw==
Date:   Thu, 6 Apr 2023 15:21:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Apr 6
Message-ID: <20230406152106.0816ef49@canb.auug.org.au>
In-Reply-To: <20230406151906.199f1e43@canb.auug.org.au>
References: <20230406151906.199f1e43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HlZryH/2FYc2+5xZgSx7qZ8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HlZryH/2FYc2+5xZgSx7qZ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 6 Apr 2023 15:19:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Changes since 20230405:

There will be no linux-next release tomorrow (Friday) or Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/HlZryH/2FYc2+5xZgSx7qZ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQuVsIACgkQAVBC80lX
0Gy3bwf/eGbLTb94qJ2s8TSZVuM07JmQ1npqnaxHrvbdn75ja4d5q5rXAjH03cig
sSz6Q9jZVD3y5QRkPKFyjhI72HWRhdqNexdkZLkWezWzAImmgfYhD2pHC1+mKph8
uThDIpTXHM0DWZis8k/Kqthw+diSHOIonUVcnImCYMWM9nHCw01pFpCLJPAdkhpz
lygUazx5/qkPP2cynQCc6LMdBeTV2BEw4uVEp4+vXWOB+mjlIpvPrXBMO0XTRPc2
RhKzD/pUvmNiDkU0OZ2onC2VoWXEXxlrFWAbK9ueGyIPkkTAtZtN7J8GnGfEqGLu
6tH76ljltIvlPLypu0xcD9iL31YYpA==
=kgGy
-----END PGP SIGNATURE-----

--Sig_/HlZryH/2FYc2+5xZgSx7qZ8--
