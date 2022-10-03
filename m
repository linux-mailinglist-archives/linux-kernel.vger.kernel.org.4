Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC995F3726
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJCUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJCUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:32:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF64B493;
        Mon,  3 Oct 2022 13:31:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhCDS5W1wz4x1V;
        Tue,  4 Oct 2022 07:31:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664829113;
        bh=9Oof5SvREydAu25UtCKlWyn2zoZDw/nKSxZm1k9j6mA=;
        h=Date:From:To:Cc:Subject:From;
        b=jMXH71oLzAyT0hs/JlECUxmBBSUx6ckb2AYWwVdWtrqOvkACHEMQ5KrY189MG5C4b
         uL3aOnd2UHRyPfvaLlymMqMjFqL+CaDkii+3htrVixVjY1p0MVNZHZbeHHE7R62dLS
         Fz/c51UIkWtSBgDRCZoA/kvEjJmgxaim8JXQLc8ye9aTsXP9thjs5t3bKxEkEzuwH/
         4rYW1dYqYLzsQz5wKNQhtV/c57S0mn55ukKyHtSr7w3TwT1N/QgRBlcDqQdpsWhHGj
         WRTDMpuWzbK4YMS7SxnD5HwE2SwzJBxwDCcAZs4D3hEPjW7HE9o0FYXHtjvtfTK1F4
         +sZYaZkyRM3og==
Date:   Tue, 4 Oct 2022 07:31:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vfio tree
Message-ID: <20221004073151.2d4f778d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BRJmBwVTMahxBNR5AFciTbc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BRJmBwVTMahxBNR5AFciTbc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  66c6b7dbbda3 ("drm/i915/gvt: fix a memory leak in intel_gvt_init_vgpu_typ=
es")

Fixes tag

  Fixes: c90d097ae144 ("drm/i915/gvt: define weight according to vGPU type")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: bc90d097ae14 ("drm/i915/gvt: define weight according to vGPU type")

--=20
Cheers,
Stephen Rothwell

--Sig_/BRJmBwVTMahxBNR5AFciTbc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7RrcACgkQAVBC80lX
0GzJ+Qf+M6sPJnJcJUij3LFVF2O6+Otc/1ACxTebI10nonpxa72SBU7KWfVpCSOZ
gQzcqeVTCC+WYfW/+nfVKRk6OLT4wU9oKALW3nFTwM+zxaXVVpEMK/PndQ3ZMFLq
AFD8GejPcjnV3XVAi47lbIa2MrCnqvwbW2hro/Er1JXTgmOZCGnaFPQjMs/E6uzI
KYYEVDMtU3JAnEPJ7tYQiD0NGpW5mp01CqMKUidKXaph++MOux7ThnMOydeeKQdT
KiQ5TTSKJeBtEawrsHomnTz8mafpP2myrY9DavQBF80xMEh8h/w/ytEp/V6MkM+j
0/igDJJXb7EyJlDBxdq1DqYPtJjlcA==
=BUT0
-----END PGP SIGNATURE-----

--Sig_/BRJmBwVTMahxBNR5AFciTbc--
