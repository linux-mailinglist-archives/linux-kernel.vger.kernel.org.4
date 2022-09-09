Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5218A5B37EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiIIMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiIIMga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:36:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79F536DD8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:36:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFpx1t4lz4xPB;
        Fri,  9 Sep 2022 22:36:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662726985;
        bh=gqLCwR5ksB6FpQbRsYpoI0uGdVoPaLEJOth1SfGfWTE=;
        h=From:To:Cc:Subject:Date:From;
        b=lLZb37grJKR53+9dXWgmx38xqP922SwaXuHpe3ojjUJ6/QEioKQJKV2C+n80NezhW
         7qA3IgA6RYnCc8Ki7lT9PnGuz3sxIIh7uBQrsHznMAxVoQ9+JKBgdZYQ4JI2kteW2k
         P5hdEWc+8KVxMcqGol4DNpdrPooMSAdxXzK6UGcQLWPZIUPk8a7Zn+jEMVjZRRfTBW
         c5XTs0fZRyXWJ1g9t2EGDgFNoNPWd73wzxn6K1jmXCMJqWK/F1/Bhg9thORBlgxiif
         vfhPKgH3OV5Z6Yf7W5tYMpIq8B3w+CRGVqstDKskHHewDUs57EDyIpz9yLM4fCDWT7
         6MExmOiTg1D9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.0-5 tag
Date:   Fri, 09 Sep 2022 22:36:24 +1000
Message-ID: <87mtb8encn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 6.0:

The following changes since commit 6cf07810e9ef8535d60160d13bf0fd05f2af38e7:

  powerpc/papr_scm: Ensure rc is always initialized in papr_scm_pmu_registe=
r() (2022-09-02 18:55:11 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.0-5

for you to fetch changes up to a66de5283e16602b74658289360505ceeb308c90:

  powerpc/pseries: Fix plpks crash on non-pseries (2022-09-08 10:45:57 +100=
0)

- ------------------------------------------------------------------
powerpc fixes for 6.0 #5

 - Fix crashes on bare metal due to the new plkps driver trying to probe an=
d call the
   hypervisor on non-pseries machines.

Thanks to: Nathan Chancellor, Dan Hor=C3=A1k.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc/pseries: Fix plpks crash on non-pseries


 arch/powerpc/platforms/pseries/plpks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmMbMlsACgkQUevqPMjh
pYDiuQ//YmIsWEcmoHw68cNBVxousox6fuzlAtAjUKPXuIk5ftZqEJV65CoPfp9/
MzQnW+BeLJ1ubMnkHxO5/ZNSly7t428EdvmO3fApOmrwbiUSTBhZKd4i7tmlgpoG
qH9PtCekYjm9MHTBg1ksEvZiozQccw0QrXyNoZiaLSsw7nxRUvS2yDQlITHaiA8m
a1HopFZiriouQDlVcm/0ubGCxhOEzB6HtTpiNsT0jrULN/w08Ffjc8auMLycfIJR
53XlfEP3ICd3+LzK0GYlp+IkPkPdJ0ZgWx+bpcq9ZvptYA0S0dW/tDKq4oqguKOu
jk/WwU4ohbmamR/qWIdd+dwcMwQqaoW10Xa0uxthLSsS2d3x1gMU1rSjjQca4Xkq
Bbm3hxWhTZwyYBQEhLPVlUoEzGCLY6JvXwnObypeTNcbGs8l548OIbnXaKT3FEps
pvjLpzwI8hSljXSovXa1hY1h/ywZnFrSTb0KGtDhZ13zuv0Strhr2UJCndmPadFJ
K48aQiDPQmcqXEwCgyEp5TmZhK7hZJlAFAJse/GvLdJTSuHUrszqoqG3pu4GQCWH
Pryw1sMuyWqv/PgTYuoi1PJGn4BA4igCxqISuFnfsUZV+R9r1my+jzIcVkYkfXCm
LOSE1azP2JS8bq9zQKfHYnuldM5As7dz6aNETouSOXqvQtpXMIA=3D
=3D4YFO
-----END PGP SIGNATURE-----
