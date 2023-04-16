Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B876E36D2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjDPJyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDPJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:54:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A2D1BDC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:54:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pzls50sK8z4x1f;
        Sun, 16 Apr 2023 19:54:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681638873;
        bh=11k8drVLwW5MOsM1gDeUlNGi/Vh1UVitdUzaneMsZ5g=;
        h=From:To:Cc:Subject:Date:From;
        b=qc7aZGzOAl0JzuzzaQ2s75+O8jRP7g+uMrlLXk/kSu3VnOGMF4loNFFfapcDNjpy9
         oBZvwbZMSuCNnvIeQYiu/puColtDu7xlnJKG4QmDOiL7e3INFruNnasKnvA9+pC7E3
         BTRQoYAjM5rv5TbKOsXzTQoHvP8WzJnwUT2smmEdcwM8gA0y6GAXXVgGMS9zGGXExT
         sHfUcZpL0e2Fpa35QG4E0FEwB+O1W+ExUCNda2aQ0njEL8zsPQdhUPtfrBsPRbXHXQ
         oR39IdiF0X3kgW5sDbnQFeeZLIR+n3mzSsXlag+dB5zM/G9kh6dIwMIW/TPGXO86l4
         11E+gIrS6Agag==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-5 tag
Date:   Sun, 16 Apr 2023 19:52:23 +1000
Message-ID: <87r0ski27c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 6.3:

The following change since commit eca9f6e6f83b6725b84e1c76fdde19b003cff0eb:

  powerpc/pseries/vas: Ignore VAS update for DLPAR if copy/paste is not enabled (2023-03-29 23:01:35 +1100)

is available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-5

for you to fetch up to b277fc793daf258877b4c0744b52f69d6e6ba22e:

  powerpc/papr_scm: Update the NUMA distance table for the target node (2023-04-04 22:08:35 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.3 #5

 - A fix for NUMA distance handling in the pseries SCM (pmem) driver.

Thanks to: Aneesh Kumar K.V

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/papr_scm: Update the NUMA distance table for the target node


 arch/powerpc/mm/numa.c                    | 1 +
 arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
 2 files changed, 8 insertions(+)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmQ7xSEACgkQUevqPMjh
pYB+dRAAq1ochTHshZ1uYXI2WdPMV5L+RYWp+2VNEufRBFmguOnfYTrICWvhCD03
6EzrU9foN8wsmZXlFCnGUiFRHlymUDbh6e9AeOwYhlD7UhfMN8KcABjtUVQuGjen
DF63mu6vtOn0/oE8J/dMdJ+ZMqsfb2kGzQKFgAwiqqi3izwVVpInLuNyZ8CgDKss
Zpeg92NNidaODhUhsRJMPI7easWUzZWY3cXmOd8hWHirCKCPRrP5B12p39B1EQ7W
S8iUsidQIkfAr2Ti9+4JThqnr99EuRZigqm+FbmFqD4L21FsJlIk7qtAPHjKJ7E3
+K5vjYc9dWQra04i+IRt42Yn4lc37kn50OKAbsjxlE7WkNqvZO1PPNnMpbtfhbOU
k+qDEJr6WrmV1c/y6BQ2iMvYcstVisG7eDBo2c4iesFI0QVJZ8/vTJiN7GiLZYQV
wC0C7WIw8MXcwjtuID4uofdoIfMRnHlL/j9j49pRW3DeaIxyXZ8H90bqUXIiLqN4
lntl8mt2Xgl3vwUbtbahh/qGYwpBBNg0pxuCiisuGL8y++MA/xaXyfUbrvNrGPh2
HWvAPBdf7aYtqFnTdtfLXrefTFnqmuKA4qmW8tqM2zRwy/LFQl8nMVJwz3AMD/FV
SP/Rwj5YdlKOJKYAcms45+fn3akFy01ga2pC3SqzW1Am8772LpY=
=Q8fq
-----END PGP SIGNATURE-----
