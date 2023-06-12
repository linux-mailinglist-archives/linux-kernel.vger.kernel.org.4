Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A772D4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjFLWrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFLWrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:47:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD9B8;
        Mon, 12 Jun 2023 15:47:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg6Jn1b0mz4x48;
        Tue, 13 Jun 2023 08:47:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686610057;
        bh=6rJYe4VtLcTH0WqHhgXeQteMWcPTfQeNJKAOGCsQtZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=EVKbcslSOn4EkjFd7eld/w9YHlmMEkLwxzq64LcQIp7i+fXGzx3e127muO4o1a/a3
         UhsDyJvsHUdvVgkW7Xkm1DNRQSWVdCqc1C9MvYvSFbgs7hTugrdJ41rwYI9k2ph+Bq
         N4Ax9K/jxTetpxMyJMoL5ozwvFrrdYYl7b6X6sKLV/IkFky+jaOLgj/1epWXYyswKc
         AHMUcYP3P6cVrK0cIndrs79auj+aA0W5YUfArjT6H2DV9pCR58YqTsQ6OCrD2vPpX4
         bE1rDqJvAcPBlDNSKyrJ4IDzIt0ZLDpzkG6y9u5Li+RtcUnkj96PZU57fygTRT6i+U
         ctBIYS+UmnK1Q==
Date:   Tue, 13 Jun 2023 08:47:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mmc-fixes tree
Message-ID: <20230613084736.4a45b317@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lv.DYElX3XBt.3mbg_Fc7te";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lv.DYElX3XBt.3mbg_Fc7te
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9cc857657b8c ("mmc: sunxi: fix deferred probing")

Fixes tag

  Fixes: 2408a08583d ("mmc: sunxi-mmc: Handle return value of platform_get_=
irq")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/lv.DYElX3XBt.3mbg_Fc7te
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHoIgACgkQAVBC80lX
0Gz7bQf+LbirZ3yjKoPOj79Dc+5AxeaUYG8xTaQEouCcLvrUM8UBCzGHU5bAcpyJ
p8eS90ZISQkD0i1G9HkDPryOyqyMzMHFq7R54LZmjopNJsaC14AWUGy0bHVFRE+2
zvXNzvApomf7Qge2YlY6YHducInmWTHIbfMnPOOR6vakwQsrVWtSPbCDcA7ntWNC
nwce/sBXZxwHCfyslA2FOPhPydmH88+TTq55pRA17qs3ClzQA9JY0AFpYzX07wdS
iil9LPZKsrYxc7uU+547mrW7ESEsb2FB2K0nugxcRpbiLm4udOdehwtjYKo8O2Mf
CKKV1H0hi3Sg5CnBSxUZeWNtm4DU7A==
=02II
-----END PGP SIGNATURE-----

--Sig_/lv.DYElX3XBt.3mbg_Fc7te--
