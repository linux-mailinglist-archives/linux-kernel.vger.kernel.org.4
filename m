Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561897148AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjE2Lh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjE2Lh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:37:27 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4BCF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:36:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5659d85876dso43206267b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360193; x=1687952193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoI6RIFWmkR6RsayaSDeG9vrwq5HEAIBN0C4cFCwmxU=;
        b=rEvkuSjagh9iStLeoPvMpwrJz6x+mwxkc3FpFtZ14yz9AfLohDuGAdKgPuNi+orFLy
         iMuVrVuh4aEacsaKdJCrite5vzML30WMEEK3K/kcJq068Ld+ZGMPUw94PkN4452ammoS
         9WJm7D6I4QwvrAUBS3Q+JQA16HvdnzpKSSsWqFomgiGQvfXMrUtW4iwdsJBvW+Sr3JQd
         bFoUJxPPB2KmA1lS3GTmYMFUvt821ViolHiPsfKGK3qS/I+a5lX7hL2PiHADEMrQfd8C
         3nlj/UOltHiJNNk2NelGZsSpCLgzCwU1G5r4lbtdoAaCropNQJFj2qWtVOiZvsOYgRX/
         Lu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360193; x=1687952193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoI6RIFWmkR6RsayaSDeG9vrwq5HEAIBN0C4cFCwmxU=;
        b=kdmtaopNLWF/1C9kOfkUbTCT5e5wo9lm0cDFi4MHIj6E0Y0J5soa3CurQ7lQHdQ093
         KT0hYyN45rNoD1xgQ+W1i9phq3zH0m7ugJDmZkC6h9Ozdsiumhq6d9D9gO6urqgYU+YS
         0Trz10uDqMNY+olljwUP1NlNjcLUvY1qe49chb7B7Djw/p7klCro3oizHk++RKVPEGn2
         vpg2VuAOGOcaT1a08bcdnLvOW6NsWadIrEb5T2NueqEx30wbEJVe/AUu/uj3rnJrot6d
         y4KJqmYThEFRcgdgnqAq9leQYWph+SLidjAFZ4eEv/7UdYMokuZdCPqN5MHDXYTDyLCf
         aWCA==
X-Gm-Message-State: AC+VfDxKWvkJE0uobFYmhkHeNC2nCPZxrTU3wr2IPSaYnOclc0GAgKG1
        MlxmD0NTuQWMBDpB7HkZne7AzpTH3WtPHDaj1ZqMXA==
X-Google-Smtp-Source: ACHHUZ6+jh4+tbU+SfGMG2BuCtmCkY5Bzh3D6KZgIeRmr32Ju8T5V3ocy30tZfeRJ/1Xq7Gpj/PLhSebiPoTiPBzDzc=
X-Received: by 2002:a0d:d6cb:0:b0:561:d18c:f3fb with SMTP id
 y194-20020a0dd6cb000000b00561d18cf3fbmr12632914ywd.9.1685360193206; Mon, 29
 May 2023 04:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230525092202.78a1fb01@canb.auug.org.au> <CACRpkdYUPmaBWDwH_ARHp-bFtpML3aShd_mKBBq+ndQATGEJjQ@mail.gmail.com>
 <1b757588-66cc-4946-a9fb-a2a88c5c54cf@app.fastmail.com>
In-Reply-To: <1b757588-66cc-4946-a9fb-a2a88c5c54cf@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 13:36:22 +0200
Message-ID: <CACRpkdYneu+c0d5jGgZqEHqyoAbcx6UbkQYHXsNeFvGnehp6SQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the asm-generic tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 6:41=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> > Aha Catalin ACKed it and Will picked it up, perhaps Arnd can drop it fr=
om
> > his tree, albeit it is not a disaster, I am surprised this was the
> > biggest fallout
> > we've seen of those patches.
>
> I can't easily drop it without undoing the merge from your branch.

Ah yeah they we loose all the nice tag messages and such.

> Maybe you can just rebase your branch on top of -rc2 and send
> a new pull request. That should automatically drop the duplicate
> patch.

It was even  -rc3 actually. But yeah, that was simple enough :)

I hope the netdev people don't randomly apply the xen/netback
patch, I told them not to.

Below is an v6.4-rc3-based pull:

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511=
:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/virt-to-pfn-for-arch-v6.5-2

for you to fetch changes up to ef7d0f5d03b9e65c9daa8dfe8b405b10566055eb:

  m68k/mm: Make pfn accessors static inlines (2023-05-29 11:27:08 +0200)

----------------------------------------------------------------
This is an attempt to harden the typing on virt_to_pfn()
and pfn_to_virt().

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry, we do the same with pfn_to_virt().

The problem with this inconsistent typing was pointed out by
Russell King:
https://lore.kernel.org/linux-arm-kernel/YoJDKJXc0MJ2QZTb@shell.armlinux.or=
g.uk/

And confirmed by Andrew Morton:
https://lore.kernel.org/linux-mm/20220701160004.2ffff4e5ab59a55499f4c736@li=
nux-foundation.org/

So the recognition of the problem is widespread.

These platforms have been chosen as initial conversion targets:

- ARM
- ARM64/Aarch64
- asm-generic (including for example x86)
- m68k

The idea is that if this goes in, it will block further misuse
of the function signatures due to the large compile coverage,
and then I can go in and fix the remaining architectures on a
one-by-one basis.

Some of the patches have been circulated before but were not
picked up by subsystem maintainers, so now the arch tree is
target for this series.

It has passed zeroday builds after a lot of iterations in my
personal tree, but there could be some randconfig outliers.
New added or deeply hidden problems appear all the time so
some minor fallout can be expected.

----------------------------------------------------------------
Linus Walleij (12):
      fs/proc/kcore.c: Pass a pointer to virt_addr_valid()
      m68k: Pass a pointer to virt_to_pfn() virt_to_page()
      ARC: init: Pass a pointer to virt_to_pfn() in init
      riscv: mm: init: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page() in cifsglob
      netfs: Pass a pointer to virt_to_page()
      xen/netback: Pass (void *) to virt_to_page()
      asm-generic/page.h: Make pfn accessors static inlines
      ARM: mm: Make virt_to_pfn() a static inline
      arm64: memory: Make virt_to_pfn() a static inline
      m68k/mm: Make pfn accessors static inlines

 arch/arc/mm/init.c                   |  2 +-
 arch/arm/common/sharpsl_param.c      |  2 +-
 arch/arm/include/asm/delay.h         |  2 +-
 arch/arm/include/asm/io.h            |  2 +-
 arch/arm/include/asm/memory.h        | 17 ++++++++++++-----
 arch/arm/include/asm/page.h          |  4 ++--
 arch/arm/include/asm/pgtable.h       |  2 +-
 arch/arm/include/asm/proc-fns.h      |  2 --
 arch/arm/include/asm/sparsemem.h     |  2 +-
 arch/arm/include/asm/uaccess-asm.h   |  2 +-
 arch/arm/include/asm/uaccess.h       |  2 +-
 arch/arm/kernel/asm-offsets.c        |  2 +-
 arch/arm/kernel/entry-armv.S         |  2 +-
 arch/arm/kernel/entry-common.S       |  2 +-
 arch/arm/kernel/entry-v7m.S          |  2 +-
 arch/arm/kernel/head-nommu.S         |  3 +--
 arch/arm/kernel/head.S               |  2 +-
 arch/arm/kernel/hibernate.c          |  2 +-
 arch/arm/kernel/suspend.c            |  2 +-
 arch/arm/kernel/tcm.c                |  2 +-
 arch/arm/kernel/vmlinux-xip.lds.S    |  3 +--
 arch/arm/kernel/vmlinux.lds.S        |  3 +--
 arch/arm/mach-berlin/platsmp.c       |  2 +-
 arch/arm/mach-keystone/keystone.c    |  2 +-
 arch/arm/mach-omap2/sleep33xx.S      |  2 +-
 arch/arm/mach-omap2/sleep43xx.S      |  2 +-
 arch/arm/mach-omap2/sleep44xx.S      |  2 +-
 arch/arm/mach-pxa/gumstix.c          |  2 +-
 arch/arm/mach-rockchip/sleep.S       |  2 +-
 arch/arm/mach-sa1100/pm.c            |  2 +-
 arch/arm/mach-shmobile/headsmp-scu.S |  2 +-
 arch/arm/mach-shmobile/headsmp.S     |  2 +-
 arch/arm/mach-socfpga/headsmp.S      |  2 +-
 arch/arm/mach-spear/spear.h          |  2 +-
 arch/arm/mm/cache-fa.S               |  1 -
 arch/arm/mm/cache-v4wb.S             |  1 -
 arch/arm/mm/dma-mapping.c            |  2 +-
 arch/arm/mm/dump.c                   |  2 +-
 arch/arm/mm/init.c                   |  2 +-
 arch/arm/mm/kasan_init.c             |  1 -
 arch/arm/mm/mmu.c                    |  2 +-
 arch/arm/mm/physaddr.c               |  2 +-
 arch/arm/mm/pmsa-v8.c                |  2 +-
 arch/arm/mm/proc-v7.S                |  2 +-
 arch/arm/mm/proc-v7m.S               |  2 +-
 arch/arm/mm/pv-fixup-asm.S           |  2 +-
 arch/arm64/include/asm/memory.h      |  9 ++++++++-
 arch/m68k/include/asm/mcf_pgtable.h  |  3 +--
 arch/m68k/include/asm/page_mm.h      | 11 +++++++++--
 arch/m68k/include/asm/page_no.h      | 11 +++++++++--
 arch/m68k/include/asm/sun3_pgtable.h |  4 ++--
 arch/m68k/mm/mcfmmu.c                |  3 ++-
 arch/m68k/mm/motorola.c              |  4 ++--
 arch/m68k/mm/sun3mmu.c               |  2 +-
 arch/m68k/sun3/dvma.c                |  2 +-
 arch/m68k/sun3x/dvma.c               |  2 +-
 arch/riscv/mm/init.c                 |  4 ++--
 drivers/memory/ti-emif-sram-pm.S     |  2 +-
 drivers/net/xen-netback/netback.c    |  2 +-
 fs/cifs/cifsglob.h                   |  2 +-
 fs/cifs/smbdirect.c                  |  2 +-
 fs/netfs/iterator.c                  |  2 +-
 fs/proc/kcore.c                      |  2 +-
 include/asm-generic/page.h           | 12 ++++++++++--
 64 files changed, 108 insertions(+), 80 deletions(-)


Yours,
Linus Walleij
