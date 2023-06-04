Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410E7213E5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjFDAdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 20:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjFDAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 20:33:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22361A5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 17:33:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QYd4m3Tl9z4x3x;
        Sun,  4 Jun 2023 10:33:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685838792;
        bh=HlEyZhE+LrdUOZTCV04b2fMeKrsIesj187fO09UzUIU=;
        h=From:To:Cc:Subject:Date:From;
        b=qdrVHzFHHkmCWaBGYXaFZALpDl71Ul/+uEYHsJoBvsLf5Voq/G5qpvVS5uMZ74ZUe
         QeCAdykR4oSeykmCPAsmDKN1aC3cWaW7mQdzTNVf1smELK3eAx/WIT1wkIZiNQ1H2w
         sloHkLmPm6iew9bbckurez6gINYBPmbmbItCyeXsOOclB+RvEo6sAscqA3Wm2E/pyP
         OevPSmBbiXoH0CYgH/+G7EUJHcIjpwpotdabVZOWvpVlcB3fk79EV0seYADJPXAh6U
         WF6UtIkmIqgB4lZCNL7lC5XQYEXm+SaogJtNiwIVpmmAYTOLW6GBHUWKqqWCPmvuR6
         wgHQh/T3Om33Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gbatra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maninder1.s@samsung.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-4 tag
Date:   Sun, 04 Jun 2023 10:33:12 +1000
Message-ID: <87cz2cgj7b.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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

Please pull some more powerpc fixes for 6.4:

The following changes since commit 358e526a1648cdd773ba169da5867874ae2408e3:

  powerpc/mm: Reinstate ARCH_FORCE_MAX_ORDER ranges (2023-05-21 11:40:34 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-4

for you to fetch changes up to 719dfd5925e186e09a2a6f23016936ac436f3d78:

  powerpc/xmon: Use KSYM_NAME_LEN in array size (2023-05-30 16:46:56 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.4 #4

 - Fix link errors in new aes-gcm-p10 code when built-in with other drivers.

 - Limit number of TCEs passed to H_STUFF_TCE hcall as per spec.

 - Use KSYM_NAME_LEN in xmon array size to avoid possible OOB write.

Thanks to: Gaurav Batra, Maninder Singh Vishal Chourasia.

- ------------------------------------------------------------------
Gaurav Batra (1):
      powerpc/iommu: Limit number of TCEs to 512 for H_STUFF_TCE hcall

Maninder Singh (1):
      powerpc/xmon: Use KSYM_NAME_LEN in array size

Michael Ellerman (1):
      powerpc/crypto: Fix aes-gcm-p10 link errors


 arch/powerpc/crypto/Makefile                            | 10 +++++-----
 arch/powerpc/crypto/aes-gcm-p10-glue.c                  | 18 +++++++++---------
 arch/powerpc/crypto/{aesp8-ppc.pl => aesp10-ppc.pl}     |  2 +-
 arch/powerpc/crypto/{ghashp8-ppc.pl => ghashp10-ppc.pl} | 12 ++++++------
 arch/powerpc/platforms/pseries/iommu.c                  | 13 +++++++++++--
 arch/powerpc/xmon/xmon.c                                |  2 +-
 6 files changed, 33 insertions(+), 24 deletions(-)
 rename arch/powerpc/crypto/{aesp8-ppc.pl => aesp10-ppc.pl} (99%)
 rename arch/powerpc/crypto/{ghashp8-ppc.pl => ghashp10-ppc.pl} (97%)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmR724kACgkQUevqPMjh
pYA43BAAndyoXJ2q+lOdn/tTHA0QUjefB8YON2/9OC/lkX//TWJfInpiZ3GI5DMn
nx44N+zRdYMSjMKGw4NxOiFRoHguXb9Wns/9HEeLz2UpOS5nrxVPJRZsgGDQvzIx
UN8pkOuAQF9nAHUD+ZRp2R61jxlxFrp2V3RvHsRTHyBUUVLcAdjk07GKTm5Z0hYx
eLDka1FjAXUnd/6S4YJAsMpPKdHLxJOsz95mkT5eZJ6Mq67+HeYtd06Kcd6vgMaP
gW91Z93THyKhiEIcSQSJhwngud3UyJfMj+6TIycSHC/21CE9yMHrmt+mjgprJpdd
eLKLIC+I0Gj8rk0NW1AzLveXWoV0tN0rhs+pLA9/l4CbJUlHLq49IG451wksCnWM
Esh3fmHgKQYn8MxNeYUC7h7NNCUWlVLXK4qzSB13ZNBdGVIEwMl5q0cXajXY6g7b
jXwxNLDbuXoyFaZCHdfXkmyMKrxDLVG2kTzLdZ5y5nwmh2OgMu101CqgJyJP34ig
Svu6IZmZepod/A3u4peNKMGHsMRCVI4TYdI3ItbnMV+SDLSLXDQhVvARZNe5PChb
1bSfnFeDG0ib+WLZX85ZlQCsfzoNMRwZYMMOWlreMBKzypVALGFHVADEK+/v1c3w
3bXw58YdrcsjNa5rI0BgucOpQLEzp0VMhB06LIzI0j5yFOjrPy0=
=DY5l
-----END PGP SIGNATURE-----
