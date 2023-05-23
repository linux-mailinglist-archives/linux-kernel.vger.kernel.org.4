Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75870D273
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjEWDin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:38:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE7390;
        Mon, 22 May 2023 20:38:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQKmD3kczz4x49;
        Tue, 23 May 2023 13:38:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684813117;
        bh=wYTvdtFL5j3SZYY4mECa+gjC9UYT7rwBnC8XI814UWU=;
        h=Date:From:To:Cc:Subject:From;
        b=bGAt+Y6IWlB73gVyg+yTvZ5JJaGwREXcAuK2GMhV4QXKf75n244c56hTS7CycnJVV
         Xv2tCu7CyNdydI2rju/pG7n25aebpNS/zY+ydk+XROzmaMidBywlhZfAK5CCbRiWGJ
         67AwmQsjK8/epA5FoDGZADHc2gHNvnwuGtHB63uQ9S3bZQgpx5U0WyW0FrfTTzsw1p
         fJZJgKwgQavfRUwFSBthq6fUPcXv5KlhubOEdLnPr1uZJsi94P+XgjDZZMCTAUCo9N
         wiVsPwQsPi+9R3k0uhxMEMSsVnMve03yKRjx+BHIb9w8JDDD9vuA/PCmBjCGR5O+2W
         qG5mDg35W2x8Q==
Date:   Tue, 23 May 2023 13:38:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the scsi-mkp tree
Message-ID: <20230523133833.64560bf3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bfTixNXUNneq2CUZdg+=RJc";
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

--Sig_/bfTixNXUNneq2CUZdg+=RJc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (htmldocs)
produced this warning:

drivers/ata/libata-scsi.c:3864: warning: Function parameter or member 'spg'=
 not described in 'ata_mselect_control'

Introduced by commit

  df60f9c64576 ("scsi: ata: libata: Add ATA feature control sub-page transl=
ation")

--=20
Cheers,
Stephen Rothwell

--Sig_/bfTixNXUNneq2CUZdg+=RJc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRsNTkACgkQAVBC80lX
0GyO/ggAocLS77HWx2vBVyH30j7xeXZKl2b5OkVQwP6V+mTgxIKFw7CPTOmdbUIY
Nx92BpqhfvaUu++TLh5KXoFzeaMAebaSraFoDarLwh9jOc6iiDt3d6V1G/7GCQQa
w0q7QifAH5g1Tgh+jtsfKrnPsvhKZM7ZIhZMTHUHmamZ4ZNSx4h0wIZQm7zGaOl3
fkCVuAoKZjrj7/r/14+lcq4GFzlFnEYLAx/XxJeQKBRvpOe2ay+kXPqSgzcgdBxB
oEt8QOv4yrr6GxE7ufeIpmJixkIcyHa6gO/xL1zFxN7LYEQtSsQ0XIkhp5p3Xb9z
POLjB+JThAV6vsHn6/d5OdTxd/+tFA==
=zDp7
-----END PGP SIGNATURE-----

--Sig_/bfTixNXUNneq2CUZdg+=RJc--
