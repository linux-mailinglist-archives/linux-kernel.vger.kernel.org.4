Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73645F37B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJCV16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJCV1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:27:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C975C345;
        Mon,  3 Oct 2022 14:18:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhDFz4Wqrz4x1D;
        Tue,  4 Oct 2022 08:18:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664831895;
        bh=Bfc1crEYYMlu0yB2Jop3vo47Wb+0NeL4ZJi29wS/mms=;
        h=Date:From:To:Cc:Subject:From;
        b=KG909QyjhwhlH9DkwTyEJSnzSzlZaLUs+qdUhNUXbGcXZ2qAFTWdsNpor0q6Y3mz8
         X9Bzc9PC5qQd+8l5CzsijrBGZjP+8Yb72iRZOqIatEfx5BJyQSyEvsgxu+l5ggtXD8
         KBHo/9vFbDa9/QqwX75GefgF+/zj0ICvnNFnA/d09JvhvIp4i3IQSYUFvrzYV3EPoj
         rPhJMbu5N5iO3shI5X5HSeezEjFlucXX+Gx0UKxJgxiVB2JCFn2jREJ9xdGrAL4WCZ
         4exKLYfRN9MYrluYNp2sfeECcLmgApFYLNyH9hZ2IrXHtZQdIUaoJlH/9qmSleTMj0
         wZf2LchzC3DXQ==
Date:   Tue, 4 Oct 2022 08:18:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the thermal tree
Message-ID: <20221004081813.4f33f06f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5tVkKsd3W3b.pY3mpreLgxU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5tVkKsd3W3b.pY3mpreLgxU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  74978f704d5c ("thermal/drivers/exynos: Fix NULL pointer dereference when =
getting the critical temp")

Fixes tag

  Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/5tVkKsd3W3b.pY3mpreLgxU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7UZUACgkQAVBC80lX
0Gw6YQf/ZcAMt8n2fLrhkXkzDw6heCjxU7NKctogdFDm+0TdgBBuRwYGXVgS4ma2
Xl7jOZ3w3UKC8fjrIJrv60s5BfGTCr6vfQ2I37C2XERu7+GfHnDavLYIYqegdAVT
UAzoRN9g7Znm0lSUna4RwOZsIBlUKVb61pe2JZ8W+byPetF7qe256y8ugKk3kmGX
GHUrlXGewrAWuF2CSKN1a0DoyK4XBR+eVfcECt6YBv7UPBvZ7MAXqFYNQIPlGSSQ
sRfrxPf042csH+StsHewKMuXLqcba5tGA/uNXR+4r638JfYmkmTRW0c7djQYPpx8
95H7K1Q/lMm6PDQuVPusYLaaE+07yw==
=Qet4
-----END PGP SIGNATURE-----

--Sig_/5tVkKsd3W3b.pY3mpreLgxU--
