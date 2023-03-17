Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B76BDF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQDZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCQDZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:25:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392031E21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 20:25:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pd8dN1h4lz4x4r;
        Fri, 17 Mar 2023 14:24:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679023497;
        bh=+772HMtbGhPv+DtNZJaD3dLNNsKybhWx1jy0I4qG7ms=;
        h=From:To:Cc:Subject:Date:From;
        b=FyWdg1E9LxSnWVlyMtVaIp8VJNeGzFgJ+ImtdKg8KQ8Oxi9Sov0zubftQytf8AGjv
         9qSUSsiugax+LlMKcRFPCdY2no3e1fFhJM7tHJPFtJJs65TMODqwrEQpC8MmQXZOgE
         Y4iRP7H0NZcWIvt5WcA1rKVzDxCDvi1hfzO0dl7Q5GLz+6p6DJEhVcesV71kIPYuOX
         yZRBRl5qQe1g4BKRc7+fy34sSOLLnNGy67v2SBaigI1AGmMSvdeDWnGuIkM8FE5ZTS
         AQQ8uXxZ6THMbPFgmAg4YhTJT1HdOC1ZFM8rNFfCHEzCtbTuKR0tXTTQ6fDF2oh4br
         eMgHmBQc7+7xA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        rdunlap@infradead.org, ruscur@russell.cc
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-3 tag
Date:   Fri, 17 Mar 2023 14:24:51 +1100
Message-ID: <87cz58m54s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.3:

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.3-3

for you to fetch changes up to f2c7e3562b4c4f1699acc1538ebf3e75f5cced35:

  powerpc/mm: Fix false detection of read faults (2023-03-15 20:48:53 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.3 #3

 - Fix false detection of read faults, introduced by execute-only support.

 - Fix a build failure when GENERIC_ALLOCATOR is not selected.

Thanks to: Russell Currey, Randy Dunlap, Michal Such=C3=A1nek, Nathan Lynch,
Benjamin Gray.

- ------------------------------------------------------------------
Randy Dunlap (1):
      powerpc/pseries: RTAS work area requires GENERIC_ALLOCATOR

Russell Currey (1):
      powerpc/mm: Fix false detection of read faults


 arch/powerpc/mm/fault.c                | 11 ++++++++---
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmQT3ToACgkQUevqPMjh
pYApfA/5AdTCYQx6dLZOvYbLWLnfq9V1W1EREx8QzLNyKfgJ8gTdDr8ogBZLvg42
KDpxWjzY2eLNC3Ip9rXjUDu8n06YcpqTzPK/kvJR7RfWtOnMzsY9FqRALrQdz+BO
nr/rSxMVJN4we1Rc2iaVuSXhGV65kWJ2X0j9kVx5LrG4LOWSWMr1Y61J9GJi/Emv
44eiIfcfHNILxHpm7QBYGNBhQpRyOzh8feNTnKxxHr+qQS3GQ0+QdGk21MwCtVHM
A2cPmpSW5cvGGsDOxjyNn5B4Mrkgbp9vW182XqqxMCC0KZf2PSksQVp3LTTua2GP
HPX9peeiiTO1ct2/HeL+EiLrshAghmE9J7DFhuhXZpdDQY68iej/sUQhMfrmj+/W
UTA2qHi63Yv7VcflT7mtFUoqdFH33fuyzkFB1+R9FBzR7nYHpDs8osKbIkXNX4Fr
O9eiv/A1cbwN2tr6bnXUoILPMU0rc6EZgQqq8qaGrvxDDdVPcgsmDaHxLaV/OWGS
Uh4KB79WmYr3MIqXF7Ehb7Svh8G+8oTJ7OAaO6ev8f7izBzjf1RY8o1LF8hn1AJd
jpkclCwVulP/t9rb9BpX7iUBref4JwWBE3LDASM02WPJR9ykW3QPlbWmyPVjXvCS
0rex8gU8ki2lWUvoeq29DDasRbTIEjkOYLnWp6A0yd00HA/sNm4=3D
=3DAMyS
-----END PGP SIGNATURE-----
