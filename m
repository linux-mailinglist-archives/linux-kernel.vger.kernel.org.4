Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048BA6B842E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCMVqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCMVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:46:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022495CC25;
        Mon, 13 Mar 2023 14:46:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pb9GC1d26z4whh;
        Tue, 14 Mar 2023 08:46:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678743987;
        bh=Z53a6q+bbCCn8GLXM5pWz9falpfSYpf+QeC3vrxprEA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZtBhXCu4TotiGblkYTaFxdqOa9YrrTt0CNmNu/MrPzwwxFjnpPJsLks7od//hyCG4
         CdDw9bDtVO9hNMFO7Y8XYWdKHEaOcLKEywtqefxTeGFfztU4F9F7eiHDS2bkOaJy1i
         k5yfgO//nxV8RWSY8/qS79ghbWL0niynuVjxU+NcePTyowOvNzCDlwGAyl61u6xQ9F
         E4GT27X/lPQySpfysePVyFS7ZAeQTNVY0kbhE2robwrgAEB4cyxQbzujqRXkWB8Eqs
         fleR+3TYbFRKT0e22G3SGb7DDqA1ubyez/FcAXbi736YovLToMAHAaqoHg14IVRPYx
         wZUbLMjJWhhHg==
Date:   Tue, 14 Mar 2023 08:46:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the block tree
Message-ID: <20230314084625.3530839b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/peD7sxK.Bo2GppS61dYUzvT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/peD7sxK.Bo2GppS61dYUzvT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  6d114e22385b ("io_uring: silence variable =E2=80=98prev=E2=80=99 set but =
not used warning")

This is commit

  fa780334a8c3 ("io_uring: silence variable =E2=80=98prev=E2=80=99 set but =
not used warning")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/peD7sxK.Bo2GppS61dYUzvT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPmbIACgkQAVBC80lX
0GwFHgf+PzjjIR8vq3MMkwULDbC7iksGPI4TprsRIFCyGZNTbazNvhNgR/Afg332
IClXlVVKRMrv74kIzXC9umDagGNTKIxJTt8rnGr4n+xXqnOor+Q9DnN5vmTknf8p
Qv3/VMLqnorVwKYpyd6AUoY4+rZCx0O+5w5gPJSKJ23FHGeJeIMrlfs2bCD3cYN2
BTGq4mIuXvuNOJ7ypt1ico5ea2N3Ph48Q+SrA2zpH9f/tVS3OoePnLOv2dC38NCU
BxMY4wFOIcIpSM4C4Y/kqA+e22NmnUKg/kZcoo/urgFbI71WDLiBTj/iOc5Ts49/
E+0hC1AOHIqKeG8U/QLCZYovg9z+LA==
=T/S7
-----END PGP SIGNATURE-----

--Sig_/peD7sxK.Bo2GppS61dYUzvT--
