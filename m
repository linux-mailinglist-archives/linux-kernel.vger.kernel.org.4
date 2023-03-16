Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8526BDD37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCPXzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPXzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:55:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5438B5FFF;
        Thu, 16 Mar 2023 16:55:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd3zP71gjz4xD5;
        Fri, 17 Mar 2023 10:55:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679010914;
        bh=TTjDSLUcnaYKA9KYz2ECOkaoZ5nMnAseoZt3Zv1fufM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r9iIkGYRDCxzDiBKHtTLY/P0WPeNf4AunhO0IDm1vvw2D2hzW1+J0ey6IPdGVfDkW
         90mc4B4ZSGtvE0mNyf51TpbLs83CP0sxK96ah3LPfYCv2GC6qcpGao81yprmwnh1NP
         F0dpptgOZy1/1jj6Wsvo5CbGm+6YqGiilE9rQrunrTjE8hTHSocmLL1bwr2kVhmqcR
         JpqVr5Dt9bCKoEqlOC24BE/LMznj4eHBuc11DdGWp1aOUA9Fvf3jBer0H3MkSr2qv5
         qcDwWK9RJG3mIE/6uGyHLHP7lmFVcedsWaGxC1dt0A+4KQKcCp4b4OeLFha0PAh6ms
         J6stH2a+/dZ8g==
Date:   Fri, 17 Mar 2023 10:55:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        irogers@google.com, namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230317105513.591a6383@canb.auug.org.au>
In-Reply-To: <7D15C431-1AB6-482E-B4B9-289A15C0E2E4@gmail.com>
References: <20230317095025.49aa34f9@canb.auug.org.au>
        <7D15C431-1AB6-482E-B4B9-289A15C0E2E4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.p==j/IlGH_tenQqFisAc2p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.p==j/IlGH_tenQqFisAc2p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 16 Mar 2023 20:11:11 -0300 Arnaldo Carvalho de Melo <arnaldo.melo@g=
mail.com> wrote:
>
> Can you try adding NO_BPF_SKEL=3D1 to the make -C tools/perf command line?

That made it build.  Can that be automated, or is there something else
I need to install to make it work?  Or, at least can the error be made
more informative?

--=20
Cheers,
Stephen Rothwell

--Sig_/.p==j/IlGH_tenQqFisAc2p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQTrGEACgkQAVBC80lX
0GyxbggAlZpJ7qt6N6BE81mTDCZJiLkbHrf3kxqMGImO44C0oHCCDJcwigh5U2Cj
tyEuyFHxj2dQ3M9XnT/NG5RrlnN6tMaDjB6r8LAJtD8PQiv0/HztENaU3mVEegI+
/GKPIbBZr4JtN4g3MVVELmRFcXWNndjVzO9wC5vPkbg0nXznklBLxEV7sqjAvnKZ
UYB700tQ3+mfaHXNfrw96ZM76cPHx8hRW1++GPOTri6WxNiOmnMTlUzWQNcrQMYP
Rh3M3HOefrYsLhSMOiCAYIDs+H3Ida3vWCE0IsISNkn/5LSlI1rejsEBd5N6mOAi
O5ozAwL4IIvZSV5i++7VDOR1aLC2hQ==
=sIqB
-----END PGP SIGNATURE-----

--Sig_/.p==j/IlGH_tenQqFisAc2p--
