Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF5626EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiKMKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiKMKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:30:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367BB12087;
        Sun, 13 Nov 2022 02:30:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N97xG6qwTz4xD8;
        Sun, 13 Nov 2022 21:30:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668335411;
        bh=epb7iYIZTXLqGbxxN2Y583zmJEhodSXY+U9Amoa20fA=;
        h=Date:From:To:Cc:Subject:From;
        b=AnFDWnD5vBLtFJOgshnoXyUtSYUAsKXVyWos3IR31dXrHQHToyrdwC6OSAOW0gsN5
         mftHAZVDLaU5ApsJGm+CcG8Um5wHT0lqe/AZJjE78964nQgLqpvhurRM66h200Xr5n
         ncDrrczbndXL36SUMP+N6kG9dctX8sYmC7EPQtsdcPI4csOUVj0HNBqp8o/cRQ8qd2
         8C0/KFNt1+Pj5NX9NkQtEJP6qsYI1saAxsRhOKmPjoPOO1gNcZ7gL8jnHBmtl1UaBY
         UmgdFVRLacAGvhpbz4V3CunxBFoME0NOTK0AD4WWIbtAVtJ8fgGvMa9UrE6qrPM7uS
         5SZWRC7xBFaOw==
Date:   Sun, 13 Nov 2022 20:57:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the nvmem tree
Message-ID: <20221113205734.40500074@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RIxShlngNK=XA=PvDa6I73T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RIxShlngNK=XA=PvDa6I73T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7a69ff9c9bde ("nvmem: u-boot-env: fix crc32_data_offset on redundant u-bo=
ot-env")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/RIxShlngNK=XA=PvDa6I73T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNwv44ACgkQAVBC80lX
0GxcdggAgcSoGC0sEWZesj63DlBPekQlIhBeMYsvO5Qh+7UuusozsNKTx1ey6Z2X
Zz/N0VTPLchDnKI6YS4OInMj98MOTHk2lWcKj8MlebPxqkO3gDk1LNz//7A4AMZR
7UOLE1csDrPaQsArkwHVcYavSFr2FHnpuZYBEMNO5REVMSOhliXRLLMdoVUaX7Ur
QAej5NQtnB2Amy2mxu7DfPDHvElLWjICmpSmJU3r0rB9N1fR3ZqdCEeRAPefsaxS
ILtIKoUaytT8gSFO7/HEc1o2m8akR1oT41yiztIH41rXFHlRIXPWbAfYW0NMeIL7
k5HltpbzKStGM0L0yJJo0mwGAN5AaQ==
=9O69
-----END PGP SIGNATURE-----

--Sig_/RIxShlngNK=XA=PvDa6I73T--
