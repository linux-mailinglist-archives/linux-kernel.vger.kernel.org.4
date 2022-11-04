Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C87618DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 02:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKDBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKDBt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 21:49:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD1023BEA;
        Thu,  3 Nov 2022 18:49:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N3NpZ04wbz4xGQ;
        Fri,  4 Nov 2022 12:49:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667526566;
        bh=YF6g3NMiz2XuJjBE/5QtHdP17D6vrSLTuUEPImyPtZM=;
        h=Date:From:To:Cc:Subject:From;
        b=lkp/KSZL2U0RWbNVod6XsD2QPNiCO0H7HmeKlNXDQGuEWlEx42DKCdvKSf1Og4pMw
         8rnIqkWtYjE2MYspsfBDPk4bMlP1Sd9RSwZMhsiMusKnMl6zbZ2U3EwJCA1natkV+H
         iBBDXextDZbOuRnagtNuAlGKoaDaTzraLCZ0IkgFxoj8QrSfzLHm0mbbO8Yw9q4h1u
         wgY9vnBiDg2JrZfdMhLH9b/lRCWfrkhXbsMrarWoeKdoxo9J8KDcU0Ciyt2DAO32uA
         TPoGOrLxIUzHJG8S62IY8zAlXUQHcdvbh/9QuwSfDTDuzTZAr4mUfGscoJjqNdRx8u
         1ifmxC0MFQR2w==
Date:   Fri, 4 Nov 2022 12:49:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rob Herring <robherring2@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the iio tree with the devicetree tree
Message-ID: <20221104124922.499bdece@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l1gY7jIs4abwCp_cP=YN8Pq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l1gY7jIs4abwCp_cP=YN8Pq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml

between commit:

  c9adc3bd1180 ("dt-bindings: Remove "status" from schema examples, again")

from the devicetree tree and commit:

  a4728fe6b58b ("dt-bindings: iio: addac: adi,ad74413r: improve example")

from the iio tree.

I fixed it up (I just used the latter whic included the former change
to this file) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/l1gY7jIs4abwCp_cP=YN8Pq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNkb6IACgkQAVBC80lX
0Gyy8Qf/UyUG5s/rsgbzd+HpXFiuMDPgWihb6VuipQ7F3NbAy95UMqZaVsFiqDUD
/+TZmGNZQTUdf9u18gN9EiWV6f1AL+vnTKGChBYedeia4aDlejDfG/QEbYldJC52
BI1ISJfLv2dZmlhRtLIQoe8tUjBx6sWbhCCWo0/+oPYksvQSB3/3k19Cz2H7gapF
zDZ3VqzQO/r+m9oxqATwRXES7r/dtSX9H+NS1J5wp83JdyeECE3N/Og8d1qolzDP
hdOcZtV7UMnxfQyclH2WuFM/SSIhJU4ZU//BYCK1Hr50G9D3lm5VCttU1yFa2NDK
uviXWsYxlKrVvoHAlAUI7uFVPb6LIw==
=ZOMy
-----END PGP SIGNATURE-----

--Sig_/l1gY7jIs4abwCp_cP=YN8Pq--
