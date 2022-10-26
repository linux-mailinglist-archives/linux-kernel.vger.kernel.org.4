Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E5460D8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiJZA6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 20:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiJZA6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 20:58:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DEB97B3;
        Tue, 25 Oct 2022 17:57:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mxr5C2tjZz4x1G;
        Wed, 26 Oct 2022 11:57:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666745871;
        bh=5IlccjlQdb3J4JC2XtAZbByG+Gm56eELSBVozfhpvB4=;
        h=Date:From:To:Cc:Subject:From;
        b=BZ3VGS9Mt2UBt9Lv6VhbTJGIieHpmfXIrrNp+8xQjNDWUkmaZCXQ4LklCExy1LBFK
         qm0uZssJR2AanqroEXe7yPElHrHEnC9apB5vHA39vy5P329fOlHbf90l8GkYwIlpfH
         7eKOR//dQT36Uvw2/5y0glHEcrfssR03Q3Dwph/p2qXIon0m1IHNxmwdiIzhiT8BW9
         mBNEQD1iHCl2pdEsrMch/5snYuHu2R4mC/0bkOV+lQI+vkJnyz8H28q90al72TeZ5s
         Y7OBsXbdncmFMHDnVqEqHTKkF9SpSc1Vt5a8K1vjBdWhSWPNmfek74gvCKsc43KB7U
         kKQwTkKmNQ/Gg==
Date:   Wed, 26 Oct 2022 11:57:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20221026115748.24b57082@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XmmDxMS4vjpgoI4_/V_70=M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XmmDxMS4vjpgoI4_/V_70=M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/admin-guide/blockdev/zram.rst:304: WARNING: Title underline t=
oo short.

10) Deactivate
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  410119cc7a63 ("Documentation: document zram pool_page_order attribute")

--=20
Cheers,
Stephen Rothwell

--Sig_/XmmDxMS4vjpgoI4_/V_70=M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNYhgwACgkQAVBC80lX
0GzLIgf/YX++N8gscjbi+yMofgjtxEYQuctN6lxHEf2qOe5gVpiBaWzZ+B/R2el4
WXvIIinUCwJT+7WqeJoZ0zSjfnnmW5ptTWLt4Awyn/Ez4pMTKvyPx5GkRMQPMph2
8jZPf5USRegYHnwemN3HuudjUz4jNWOxicsy2JZedLfJcw5teyFTDrFO5adhDILx
zBsOIcAP/9/y1th1nQJWXZZc5J6cwgQ37UkQuWENq+iwlqGzMTphGEJ7fy3ehrn9
UFZrKdSAKKVIyPryBCpZPL6FLUegKZz0Dl8kMvK/oztEQA+1o3jGT3enMKBRrO2m
geRE/7/cXe5MVYa0kEnGD4/MlRWAoQ==
=olgM
-----END PGP SIGNATURE-----

--Sig_/XmmDxMS4vjpgoI4_/V_70=M--
