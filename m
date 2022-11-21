Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6B631851
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKUBwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:52:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9992A725;
        Sun, 20 Nov 2022 17:52:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFr420ShCz4xFy;
        Mon, 21 Nov 2022 12:52:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668995538;
        bh=rqbZuHNONpUMkRr9YcA+Az41+7a0NcwDwPHtWcIDBQo=;
        h=Date:From:To:Cc:Subject:From;
        b=hzYNfbHMyaJdk/EAPWw5KqPR9KZ5xryg/T+osXo5zSBxMRg1qImfBatF0aaJGj1qT
         zFagySnmafUAdTbmSvRw2wv9p+u/qixRcWDdsK7POp8MVFIx7+Xs+Ump4biS8s/DrU
         Qj7XFt7bmBqZjIKjt71CiabI297x+wpgSgNz6B1kcLDRxMHX1elerUMyMILJ6w1ul9
         zqYz8LuvNe4Oc4ErPV5SAxkJZudCXSLtjvktel10+d7SIQ5/cBilgmNLQzc77do5EV
         P8pwAZmwNfW/bHwNSmCW1lD0UdD8NXplTNCqKRJJffpr3kXTIZvPftogCnniRpO7u1
         Pnkr3xfBsuBVA==
Date:   Mon, 21 Nov 2022 12:52:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the crypto tree
Message-ID: <20221121125216.5b94243f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kN=+YqAcf3V.InuKPPsh7Co";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kN=+YqAcf3V.InuKPPsh7Co
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

WARNING: modpost: drivers/crypto/ccree/ccree.o: section mismatch in referen=
ce: init_module (section: .init.text) -> cc_debugfs_global_fini (section: .=
exit.text)

Introduced by commit

  4f1c596df706 ("crypto: ccree - Remove debugfs when platform_driver_regist=
er failed")

--=20
Cheers,
Stephen Rothwell

--Sig_/kN=+YqAcf3V.InuKPPsh7Co
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN62dAACgkQAVBC80lX
0Gy3qggAjDQIW23JTnvGZV8kgrjf6HB5QNnl7s6XYyBCneEK0s7x9thZQIb9AQ1t
jkiNbV8jnsYJcGvcT7XOHSF+o83/zaImRtyYqRyOBHZWTl/7U9uHlbmayX4uu83k
BTmi22Fkg4Mlo1XyfQQgLBUkAxR3cQey1RiZg1bV/wKMIDTTO0IqjeI2oKpCORKg
yVQeGI4UIeCcvrrdpGAIPMSkI+ybqG39/1LAWDXEMANYRbxt/KO1f5bpvN6WqZHy
KeDMCVdoOwok1UDKvuPtUlEMJUnmKegS38Xxnx9zogVlRyck/hie2S8mhNYQ6pjy
Qh/4ozxkE78i+evlbRozHOvzCi/86Q==
=LfSK
-----END PGP SIGNATURE-----

--Sig_/kN=+YqAcf3V.InuKPPsh7Co--
