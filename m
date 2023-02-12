Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87ED693654
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBLHFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:05:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBE144A4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 23:05:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PDz4Y5qv7z4x5V;
        Sun, 12 Feb 2023 18:05:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676185502;
        bh=jsG+y4OElrTrC3RMybNPnAvuif9/44TbMj9mpqSSRLc=;
        h=From:To:Cc:Subject:Date:From;
        b=drFMad1bjkqljmyZ0DrvUVzpTZNCLo5U5oo0T8LlG9e8o+Lbm/ksdZTzjCrcgfASF
         O8f86vb+ISJ+GArrBSA1W/e9Mk63OR7gMm9NQ6bIBzgGtdcpNPCEFtR/TkbDON0jF2
         DUIt5aWJ8HuCt9tTJOKKQqC3kxkMD5Tqe1+/cWsUmhCxms1WyFYNtJrqgFexG8a14A
         rv5eeNmm8jniAQWMRSiRiGqqEt59Oxmp5J6FhxfgVze1NfNLBSarCGL8127LiHwKc0
         HmAfWMoGSt2rJ7vP5FN//5HaJwaAj5fs9Z2GQ/az48Xy4dI6bWDBD7d3OwadMaJE0G
         LGgNXBy9eHksg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, rdunlap@infradead.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.2-5 tag
Date:   Sun, 12 Feb 2023 18:05:00 +1100
Message-ID: <874jrrwehv.fsf@mpe.ellerman.id.au>
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

Please pull some more powerpc fixes for 6.2:

The following changes since commit 1665c027afb225882a5a0b014c45e84290b826c2:

  powerpc/64s: Reconnect tlb_flush() to hash__tlb_flush() (2023-02-02 13:25:47 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.2-5

for you to fetch changes up to 2ea31e2e62bbc4d11c411eeb36f1b02841dbcab1:

  powerpc/64s/interrupt: Fix interrupt exit race with security mitigation switch (2023-02-07 10:13:33 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.2 #5

 - Fix interrupt exit race with security mitigation switching.

 - Don't select ARCH_WANTS_NO_INSTR until warnings are fixed.

 - Build fix for CONFIG_NUMA=n.

Thanks to: Nicholas Piggin, Randy Dunlap, Sachin Sant.

- ------------------------------------------------------------------
Michael Ellerman (1):
      powerpc: Don't select ARCH_WANTS_NO_INSTR

Nicholas Piggin (1):
      powerpc/64s/interrupt: Fix interrupt exit race with security mitigation switch

Randy Dunlap (1):
      powerpc/kexec_file: fix implicit decl error


 arch/powerpc/Kconfig              | 1 -
 arch/powerpc/kernel/interrupt.c   | 6 ++++--
 arch/powerpc/kexec/file_load_64.c | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmPoj04ACgkQUevqPMjh
pYB3wA/+Kt7u27m3MjbwXMb127eP2V6nzGLkyN1wL8/xGMtehNGfLRVI7VGs96J8
cGAvr7nxRjamhfjqAzUPBWihhmQhrTTzrUb/Czlgbxpjov3KHCif2aaQsLuZRI8P
KaZbCJJdx1mBh7mpREWrCT1FlZhN6j8mDfjbmUjlnEKcZnTk/xDF6SHYRjbmPbLh
KsWSFAE/zwiPYSuaIDASdLHvNJ9YomysSYpu8b9JSJlyT/JZftPzRdvf8ab8ji++
AyVNeCLr7S/Dejn0AZZNaB9FJ6R+KB6KnHBwFYraykASao60qwcDvQ6enUknWsYS
eDLPkpPLZ5lwiNF834MsYz/Cci/nUO1Vg8++e3c5++62kyDsljQPyPrLG40lL6Ok
SXnFI4CsygUrHbIB/7glesceagOPkeVQwoUtZHC11o+SG0YsqSzT2Mb4KbnocTaf
Veyon0OJfWu4ylfHGsQdpFl6hlCdu/COzV5Qwv57mXG6sem4nQBkcIE5+MdW6IAG
UQiFHVWvF2P/rvX23Qf4nade2Aspw7Al2VLN0dPrvv04+BO8wHRdXkHjF/PldDMC
D7yRjTlBQ5irZW+CwRe2XbRMuiHOiwc6R8v4k2Qs2zWIrmfGOdusM9mM8Xlet8EK
lwyImXGeInFNh6bRwcPshFiIvWY/EfmPZ8A0zTqxBU9GpQV0J18=
=1Ktz
-----END PGP SIGNATURE-----
