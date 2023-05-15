Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515B87022A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 06:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjEOEBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 00:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEOEBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 00:01:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BBE5E;
        Sun, 14 May 2023 21:01:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKQfX61KNz4x3g;
        Mon, 15 May 2023 14:01:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684123301;
        bh=V3NceTSG9Z6fFi3hw5PL+pGERNwdCfAI2gfl1cci37M=;
        h=Date:From:To:Cc:Subject:From;
        b=rK3+qLB2wWrNawGKuVmCoJsQ9Md1xsxtIrHLviWM9SNJ8rRaLQGfoI/uWY1/w6xge
         3ghyLNcaCndZJe2MDB5VTSjgxTs2sgc37qb/fpCASBBV5juKE3wUORpNUvCrI35ZBd
         SeRtKN+0qql/nbZe+DDy8Z0F5t2tVdzZ8IOV7bWhXCekLdjcOcBJVF57V0Hj4oHVmr
         /kisE4nwME2MJBDPSh8H+1I7ux70JWrPw3ugoe1j1QdhWe8e5W3uN5ZX/3c8LygUvR
         3mXviCGHg5UaBJU2sB5FhaN7LZBZ4xiHm6qhtgDR441yCXn9idKBMedrR1DMOQ5vEg
         QacMEIjpZZ2CA==
Date:   Mon, 15 May 2023 14:01:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Athanasios Oikonomou <athoik@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the v4l-dvb-next tree
Message-ID: <20230515140138.5617c97d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b4Mpu/ULjnqN31+8YJPlZDy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b4Mpu/ULjnqN31+8YJPlZDy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-11-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-4-15'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-14-45'
Documentation/output/frontend.h.rst:6: WARNING: undefined label: 'fec-7-15'

Introduced by commit

  1825788e2a96 ("media: dvb: add missing DVB-S2X FEC parameter values")

--=20
Cheers,
Stephen Rothwell

--Sig_/b4Mpu/ULjnqN31+8YJPlZDy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhrqIACgkQAVBC80lX
0GyKAQgAhuRhY2MQhlS8Q9Pj0D6xyRs5FN0xfXcW3Ugc/sbykn74mVyXFquR/Vo0
IkbP+6rGkdVqH+gGDSiiAWe2cO1mssBgI2vqXQVUsWJkNwa60E+TKfZgSBcX1nfZ
9hnb+5Qx4CMVKLf7Ccdo32DvUinjUeJI04+EwNqd0Z5kSSfNfTBdk4oGZvZ6PbfK
D3ZHP+ZtY7qMvtmdiFD3p2ZOuFFBkvG1OIeJ3K/XBwhL0BSLXSFe2DRKM/rWgF1M
iBkHDz8y34TaR1eDqaQVBbl/4uaTw4vcYX529cV/yBiC1HDH7mkJ2+Hix0Yje/L1
8slI/lkq1ceWIGUPTe8+qsb6s6Q4TA==
=t3kr
-----END PGP SIGNATURE-----

--Sig_/b4Mpu/ULjnqN31+8YJPlZDy--
