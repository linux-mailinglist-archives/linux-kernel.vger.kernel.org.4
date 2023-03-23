Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B26C5D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCWD3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCWD3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:29:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A425BAA;
        Wed, 22 Mar 2023 20:29:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhrRP523zz4x5Q;
        Thu, 23 Mar 2023 14:29:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679542146;
        bh=eB+ZBVh+q97T9JttvMsWf61yjuGoHTF/1PIfRoSLsIA=;
        h=Date:From:To:Cc:Subject:From;
        b=LYcR9omSxC6funnHo/sui/s6TrWgljoRl64N2cOi2Y92SxvitHbWBFgfhu6QvSlhL
         ZL9nqEyl4tHXXdiPmI193qj1ZDbyP4RaFJajaxHHkIQCLSeSHrKJdIY/mmDHNJ5U2k
         OeFDqP+gR1HW4338UPiyTLNDxQJ9qvY6td+OzQ5P9t7hEPWdLhLOlKq8Q27hBpjO8n
         c6MH4Z3jkzRGNrjv3FmbNzhnyOJbYlsw09O/iCLp2PTX3qq9yH/lyTdPwfU2e/yaRu
         T7+mFBc/w1AWkmTybIUVwT2zT7JfGtNPbS+yuL8SaUCfTHxi2K5UOlzVlHMUJ10uYo
         kO5rEZ/WLleVA==
Date:   Thu, 23 Mar 2023 14:29:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the leds-lj tree
Message-ID: <20230323142904.1a136fdf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kvpuqO2mO=Elk8T4CVSaikk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kvpuqO2mO=Elk8T4CVSaikk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds-lj tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/leds/leds-mt6370-rgb.rst: WARNING: document isn't included in=
 any toctree
Documentation/leds/leds-mt6370-rgb.rst:39: WARNING: Literal block ends with=
out a blank line; unexpected unindent.
Documentation/leds/leds-mt6370-rgb.rst:41: WARNING: Line block ends without=
 a blank line.
Documentation/leds/leds-mt6370-rgb.rst:46: ERROR: Unexpected indentation.
Documentation/leds/leds-mt6370-rgb.rst:44: WARNING: Inline substitution_ref=
erence start-string without end-string.
Documentation/leds/leds-mt6370-rgb.rst:50: WARNING: Literal block expected;=
 none found.

Introduced by commit

  4ba9df04b7ac ("docs: leds: Add MT6370 RGB LED pattern document")

--=20
Cheers,
Stephen Rothwell

--Sig_/kvpuqO2mO=Elk8T4CVSaikk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbx4AACgkQAVBC80lX
0Gx0mgf/dMgC+IwLdJRPRNa6naJvkspVLIvCenNWifHPDB9iHT8TOunJIYiJt1BC
LNmIofraMYpqPBw40VEo2s5O49kmzJH7I2qLLJOogfQcUaBqnLSW6URVn0dtjdcp
5GcJTVhGpAWlSrX1X85wwyw4rtuCEHiUs6LgpXb+/kzy2SJkxqtbh/qepSKrXcZr
OdRUnDMBEtCg0LwYcC2/o3xZwKadhEkw1erQ1GhM3iMtV/5gIVW055tTlmbdvJtq
l5LT36LsurxFNU87uq6QVaQom5Wv+d15qWPvdciUy2kbpfMjG2B5yQ+Ljm1QP2gd
MAylIkh6roIMCYSTd6nqfLktwoF15w==
=DwTk
-----END PGP SIGNATURE-----

--Sig_/kvpuqO2mO=Elk8T4CVSaikk--
