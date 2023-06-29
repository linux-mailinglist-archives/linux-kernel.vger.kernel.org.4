Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207E97430B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjF2WrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjF2Wqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:46:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281021BC2;
        Thu, 29 Jun 2023 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688078809;
        bh=+FKfx5gbwZOoVecsMkvi6D/FkSFbSQLp71H2UI+4/GQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Ikc59I3Q74+YC+SXD7Jfqmy8bjPH8ePU/1seJsU+YnmcKZ4jS8Gfqz12x8QUxuclB
         CFXJAUB9gc22N/tKSGySh+dwtAKWZ8vVYLQNicnPDKuy3rHxwMb9MlCATItL4V0s1e
         UEosA+p0t7ZKYrivOtY9qhAkl69AnSTRZ7zVCcZbd4dTpbppyCfliBl/9T4e1bicjv
         oY16wHK6Vj7Ua2XY4FPCQtX166XXUj9MiKHoM6ITVF7gzNJIHpGbz0zXQXPHN5PjzI
         TC624C5nA4tZpGOd4+qNaQ0gI5g0r6Wv/jIIijlnpbcHjKNtER0rBRY8TrDzSH0R4e
         7WA4unKhT2lDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsYV15cRSz4wZt;
        Fri, 30 Jun 2023 08:46:49 +1000 (AEST)
Date:   Fri, 30 Jun 2023 08:46:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the samsung-krzk tree
Message-ID: <20230630084649.5d4e6f1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rhzk0tqpUb_.b//dpanNj+T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rhzk0tqpUb_.b//dpanNj+T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  858fd147234d ("arm64: dts: exynos: Remove clock from Exynos850 pmu_system=
_controller")

--=20
Cheers,
Stephen Rothwell

--Sig_/rhzk0tqpUb_.b//dpanNj+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSeCdkACgkQAVBC80lX
0GwPTAf+Mxhg2Rd1ZgLmHAa/S76xEMBcu6y8287oXHY/j2IMwAw2IiGzLzE0FWam
tNRi0XRwCN/NtCW2gzZ1iQLBaNkK1zvFCKphJNdaAOLrBjKo72wHOz6qxUrgaeT2
fUwVmi3QFBkcG91bhj3VKUOnOgxHMQzmh4I28NkIW528GAfxLhjWrd1ufvND+w8S
dz6rohT0QSk6oHCNc4gOutD6UUDXpqFzV1V4H/mwUGhoVrvDoPnvzOdRkxzH+qWH
w11WJ1n8spmaLr1ZbmO6aZjvTU05NUAaHpgCAzH6dmAatgoC2QyX3K4XlKMmDMjH
04Cpt8Mpq3ipp/GDfCfoRCSAsQjyOA==
=V7QV
-----END PGP SIGNATURE-----

--Sig_/rhzk0tqpUb_.b//dpanNj+T--
