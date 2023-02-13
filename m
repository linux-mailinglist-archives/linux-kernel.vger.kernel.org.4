Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0161695266
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBMU4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBMU4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:56:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F420690;
        Mon, 13 Feb 2023 12:56:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFxSt23JMz4x5Z;
        Tue, 14 Feb 2023 07:55:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676321759;
        bh=Ab9iMl/Jr3htFtC4xv0rNZBCSyio11GMyeXKEUL/qPg=;
        h=Date:From:To:Cc:Subject:From;
        b=MbFmSotJrL7/NKSNitYD/xaP/qpeIoCIjFKWOH9Zqdo8E8ptAc6JoG+PwDGbI1bXx
         4jdsHXZuO8tuHQ3lZCykzSVXlSNt23zpyYl/stRVof9mheDrk2oPEWAg2Fhmh2rYpH
         9nA18PaiqonAE5CCt1RWa9779kMm3POi1Tk/JRdsaTTMxrAtmArzHOB9FAQvzpTf7b
         2eSWZwed5kkfDz7VAQ/pmfXnfVg6CXFW2MTXGWEg37JzzLH3Nuc4fEl4AJRpnvWeeR
         tXS3nZUM3QuGN5NZ2iWa9nC/8OjewBc14SGq2x5/kojEjeZlGrEPMVibC/gmJvWn+T
         PSPyefAJlnGEw==
Date:   Tue, 14 Feb 2023 07:55:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20230214075542.0cf88eba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/plFJsAfc4f8C+i9wwbn_N5=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/plFJsAfc4f8C+i9wwbn_N5=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  51d0bdb1f7f9 ("char/agp: introduce asm-generic/agp.h")
  690422657cbf ("char/agp: consolidate {alloc,free}_gatt_pages()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/plFJsAfc4f8C+i9wwbn_N5=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPqo84ACgkQAVBC80lX
0Gzvxgf/dhqzriwcCkzrl3eNjr8jLCu+1M165gDEU4PJVn7HzhoKnsh6jzPcATZi
TxN4x4nxntb2tS7Vl/ZW0LNsjUJ9+iyvrBT2aDR4ZP0WUVj1buUCxfkttf1CY/f3
6s2HiDiPeK/Zl/oIr/C8u7Cx7sunVPAobdbhQnX6gUGZYSlTc44Opl6ge0FSL8TU
GBnGJSH/kuZfqz44v3CRNHalNEgMhY4ShUo/Bmht9YlbxHGUn/hQkxYUY3L/JsOr
sfXgFA3+V3nTfSw/bCKhKZ79OWlhPKpEdR4ZD3Lq6o/pgd1V0ge3obOqdDmxr9xW
qdwd0Sv5SwxqBR2oz/hkKej0jwn6ug==
=VuSb
-----END PGP SIGNATURE-----

--Sig_/plFJsAfc4f8C+i9wwbn_N5=--
