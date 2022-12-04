Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0B8641D2F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiLDNT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 08:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 08:19:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BE175B1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 05:19:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQ6jL2GR1z4wgr;
        Mon,  5 Dec 2022 00:19:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1670159990;
        bh=O6WIIUv4HAQEWxuJH3CwIfKqhsQR7d/ljcXdPZYuOVE=;
        h=From:To:Cc:Subject:Date:From;
        b=jeb2GVqo//4HfOkaxp4/iSYycoFPN2jVnxhOLq0IM9tMWEOQrpu6SSoSqLmCy7P9v
         UlyLLxy22Q9/aLLFeIGsGoKH/twMufWsinXLm3YALRYEL/1jNGpR6NIKGq8M2/WyN0
         7YAbXzjXuPZ+hWOIEJJtbiY08vrC8FxDSGHSpjTCSovLzySBIAqURj0dSwWtM9kbuH
         ecGkmeA7nQB/oPfFkkxuH9ObUKxQygk2Bbcd7jiBjzz3Cw/LyJWVa9VYsQx0oYXwG/
         sh43eJzIeadF56bDu/K4dD5QtQRK8WnZKJrGlZHsVu3eCwganuCw9BRRFSFlsh4or3
         pWx/w3heERBGQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-6 tag
Date:   Mon, 05 Dec 2022 00:19:45 +1100
Message-ID: <87sfhvs3v2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.1:

The following changes since commit eb761a1760bf30cf64e98ee8d914866e62ec9e8a:

  powerpc: Fix writable sections being moved into the rodata region (2022-11-16 21:37:14 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-6

for you to fetch changes up to 2e7ec190a0e38aaa8a6d87fd5f804ec07947febc:

  powerpc/64s: Add missing declaration for machine_check_early_boot() (2022-11-26 00:25:32 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.1 #6

 - Fix oops in 32-bit BPF tail call tests
 - Add missing declaration for machine_check_early_boot()

Thanks to: Christophe Leroy, Naveen N. Rao.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/bpf/32: Fix Oops on tail call tests

Michael Ellerman (1):
      powerpc/64s: Add missing declaration for machine_check_early_boot()


 arch/powerpc/include/asm/interrupt.h |  1 +
 arch/powerpc/net/bpf_jit_comp32.c    | 52 ++++++++------------
 2 files changed, 22 insertions(+), 31 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmOMnkwACgkQUevqPMjh
pYC6iA//cPx4MT/SddmFB4bC9Vxp0lBUxu9zcepbWdsvVK/X1+eSHtPVFdfXdxYq
DhfHuEHizo6pKGYZnSYXjAG8/0pUQrKvnopgX0dNHtPvXSyRdeMyW10oiaweUa5v
WSRhKf6Uy+9cw1ZS9wwAAtssiLXt2rmV/xEGb9hs7o8NAW27067LKfntCkd8++9M
bs5V74c4X1WY1iJ86lxH3CYvOasZ/R7f46FeAu8KXX2n7+rlt1SOEnA2zaYtPYZ0
00dOCQpN5RuwCEjixJ9mFUZIJ+gL9AgjoOVF3lAGE6Ro2fyy/XRrh4BDnUCpfLhY
vylKDdy6BACz9vxQiY/phvWn//66GaLb2wbf5vhbH7Wc91ouMJlwh9g0JvD6ViRb
tAt4OOvRuOgenmpeigWUpJGpvX71Ib+sfPxpnmEwZDgTvt+aIxb0bgbEewgU/9Fz
BD89DxjS3lsj+B9vUYhXOSdkKbJg3B4MLcQP//0E2QWiHMTvCSuB8xoWNK68J6/D
3DnMVJkbvb0IrF0Q0rTXBzj1aMosc3dbwM/ezu5Zs3DK7/GWcRw4noKyWUXI6/NF
XB/R2xhxDnOyT/oZF0ssQzbA4rh1E4m9zj/RTrgn12SprT67p1sKQ5ppWPTTyd65
x3pCgocIzZvJc9S1ExmpZ9Seo9LQZxqXEsIzTqVU+5UjzFYC6tk=
=3xA+
-----END PGP SIGNATURE-----
