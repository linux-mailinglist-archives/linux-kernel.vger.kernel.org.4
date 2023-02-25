Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422BC6A2BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBYUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 15:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 15:40:06 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F6E3B4;
        Sat, 25 Feb 2023 12:40:04 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id h16so2959861qta.8;
        Sat, 25 Feb 2023 12:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q19los03a5z3kEE7iE7F654CxeAtz03ELvIXEXg2X1I=;
        b=i8u0ho2y26b3gctpPW6nEBV3zlyJEn4Rr//rstsaCcP7mCQeYz2nPU9FZZwmu1dIXi
         KCdQClIoiunDqtXxByqa47MuHpbFGScqJS+BwsK/mQ3qcqL1flagQvAh28CzhLP3UVec
         BZjhrew+5S5fhxxSWBwrMTQxFNSIcuyglu6oDdx6ruuHzYhcnW+MhuimLxgNTfkMr0PK
         4PqfU2ab69qyFlPcnf/Qniy/6Xm/oFATfRKmgdcGXRWeePhRem5Ob/KHXbyyKbSgn0AZ
         n9l0mg/88U9om9XanaphHjhv/PRv9ov18PXU4DMgN2ZF2sBSB9UTS1Bz2he/BQ9ojyAv
         ccrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q19los03a5z3kEE7iE7F654CxeAtz03ELvIXEXg2X1I=;
        b=f22fsYryLq0sk6iVz878Re29uayp2QJGO43bRo0CGR7SO2J0852y7HtHukml0FQ2Lg
         udCU53INtordhVVZtFM4l9FqUsbUWzK+58s9WRDk7JDc/hNs3j27ioNxxRBFpn4NZ6fD
         oCpqO+UAS9eDO9uuRB4wP5iMTfOpWWLk1nDe7LW8PDrPbDlhuhrZqmKWx8tu3dAUBxVw
         BEXwQwe4aEWSHPzsYApEN0cu1yFCcKLQDgXJKZJIvGxB36Tcot+JNlrLmbaf1qP570Fb
         pJ2AV88kh8hWT+14BPYkWwjVdDEEFPMtzG0LJwEFyqCt7gXyftqT2h+6SKoiFUlxSRAe
         zayA==
X-Gm-Message-State: AO0yUKXJbbZvIVTQZ35PqvlVajM7cguDWEO1lNbLsj7zrQgFB3NPJpGB
        Hyugwwh3TAQImxbVey/fHVHTm4XLWqIlTQ==
X-Google-Smtp-Source: AK7set/LDLNXQpsMXyBHF37uXkjNQERaPDl9H5hLnq3toAOGly1tntaH5i3K8Wa7xjM3vDyjdMCCKA==
X-Received: by 2002:ac8:4e46:0:b0:3b8:6bef:61c5 with SMTP id e6-20020ac84e46000000b003b86bef61c5mr38246565qtw.63.1677357603694;
        Sat, 25 Feb 2023 12:40:03 -0800 (PST)
Received: from localhost ([162.208.5.36])
        by smtp.gmail.com with ESMTPSA id z29-20020ac8431d000000b003bfc1f49ad1sm1813172qtm.87.2023.02.25.12.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 12:40:02 -0800 (PST)
Date:   Sat, 25 Feb 2023 15:40:01 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20230225204001.eostfx5mcba5vaiq@framework.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxdmpabilz6nmnc5"
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oxdmpabilz6nmnc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few changes for alpha. They're mostly small janitorial
fixes but there's also more important ones: a patch to fix loading large
modules from Edward Humes, and some fixes from Al Viro.

Thanks,
Matt

The following changes since commit f6feea56f66d34259c4222fa02e8171c4f2673d1:

  Merge tag 'mm-hotfixes-stable-2023-02-13-13-50' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-02-13 14:09:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 290ec1d58049e6203062d5fc796c50852112ae00:

  alpha: in_irq() cleanup (2023-02-24 23:14:22 -0500)

----------------------------------------------------------------
Al Viro (5):
      alpha: fix FEN fault handling
      alpha/boot: fix the breakage from -isystem series...
      alpha/boot/tools/objstrip: fix the check for ELF header
      alpha/boot/misc: trim unused declarations
      alpha: lazy FPU switching

Bjorn Helgaas (1):
      alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions

Changbin Du (1):
      alpha: in_irq() cleanup

Colin Ian King (1):
      alpha: osf_sys: reduce kernel log spamming on invalid osf_mount call typenr

Edward Humes (1):
      alpha: fix R_ALPHA_LITERAL reloc for large modules

Joe Perches (1):
      alpha: Avoid comma separated statements

Kees Cook (1):
      alpha: Implement "current_stack_pointer"

Lukas Bulwahn (1):
      alpha: update config files

Maciej W. Rozycki (1):
      alpha: Remove redundant local asm header redirections

Minghao Chi (1):
      alpha: remove redundant err variable

Yang Yang (1):
      alpha: replace NR_SYSCALLS by NR_syscalls

Zhang Jiaming (1):
      alpha: Add some spaces to ensure format specification

rj1 (1):
      alpha: fixed a typo in core_cia.c

 arch/alpha/Kconfig                   |   1 +
 arch/alpha/boot/bootp.c              |   2 +-
 arch/alpha/boot/bootpz.c             |   2 +-
 arch/alpha/boot/main.c               |   2 +-
 arch/alpha/boot/misc.c               |   2 -
 arch/alpha/boot/stdio.c              |  16 ++--
 arch/alpha/boot/tools/objstrip.c     |   2 +-
 arch/alpha/configs/defconfig         |   2 -
 arch/alpha/include/asm/Kbuild        |   1 +
 arch/alpha/include/asm/asm-offsets.h |   1 -
 arch/alpha/include/asm/div64.h       |   1 -
 arch/alpha/include/asm/fpu.h         |  61 +++++++++------
 arch/alpha/include/asm/io.h          |   4 -
 arch/alpha/include/asm/irq_regs.h    |   1 -
 arch/alpha/include/asm/kdebug.h      |   1 -
 arch/alpha/include/asm/thread_info.h |  18 +++++
 arch/alpha/include/asm/unistd.h      |   2 +-
 arch/alpha/include/uapi/asm/ptrace.h |   2 +
 arch/alpha/kernel/asm-offsets.c      |   2 +
 arch/alpha/kernel/core_cia.c         |   2 +-
 arch/alpha/kernel/entry.S            | 148 ++++++++++++++++++-----------------
 arch/alpha/kernel/module.c           |   4 +-
 arch/alpha/kernel/osf_sys.c          |   2 +-
 arch/alpha/kernel/pci_iommu.c        |   8 +-
 arch/alpha/kernel/perf_event.c       |   6 +-
 arch/alpha/kernel/process.c          |   7 +-
 arch/alpha/kernel/ptrace.c           |  18 +++--
 arch/alpha/kernel/signal.c           |  20 +++--
 arch/alpha/kernel/traps.c            |  30 +++----
 arch/alpha/lib/fpreg.c               |  43 ++++++++--
 arch/alpha/lib/stacktrace.c          |   2 +-
 kernel/trace/trace.h                 |   2 +-
 32 files changed, 238 insertions(+), 177 deletions(-)
 delete mode 100644 arch/alpha/include/asm/asm-offsets.h
 delete mode 100644 arch/alpha/include/asm/div64.h
 delete mode 100644 arch/alpha/include/asm/irq_regs.h
 delete mode 100644 arch/alpha/include/asm/kdebug.h

--oxdmpabilz6nmnc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQReryEEmoa4pUzLG/qs6yl0DJpOlwUCY/pyIV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0NUVB
RjIxMDQ5QTg2QjhBNTRDQ0IxQkZBQUNFQjI5NzQwQzlBNEU5NwAKCRCs6yl0DJpO
l1KCAP4/d7Ch+6aqUPpIg+aJGawQfJdHIyX0PDj0FQEhYiRO4AD/RxfmB7DAp4vu
XjPSX2fZh/GiX7nJ2/oJbU8ZSvCa1g4=
=Gv71
-----END PGP SIGNATURE-----

--oxdmpabilz6nmnc5--
