Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0556C60E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCWHgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCWHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:36:04 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329141816F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:35:57 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 89so14402267uao.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556956;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsMzf3UxCr/45y+SUBS2Lbphjni6uOskpNxe5T0zuLA=;
        b=azSsMVG8zi4c5adKwlh1cuSP2D0Fj2ABGsZriLH+BsndYQSGB8l2/eCIAzF3SgVWyB
         biraIJ9g27cSZ29lgJqXF34EquRYF9d5OWpJI5NWhsAIXy34x1en+7y6h7Nrx3aFSGgd
         HGwrD0sCaHW1kA4steQ/cEQCtmXZEaDU9TLl/Nb92Ns6uuVCA4ZLWzX/eTvTbs2/22Tj
         fdOM+qbUTwHnJZuoaoxMXMad4yF4X1tufry9zMtxsCdFIxN1dsrdEsuYCj43GZJjlKDb
         UJnm/4drDEIC9Dk7+jNQMgO6vSTzOr2q4f5mMUy3CGsotSaNzK00OWmgA7fepYD4e/zz
         YVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556956;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsMzf3UxCr/45y+SUBS2Lbphjni6uOskpNxe5T0zuLA=;
        b=urdnLRwUTF4pyGzyBUnsVhtGZLE/wHNMj9+0GnYAP2XCoa2n1q9HRFfjrgF2cibmvG
         rH9TKQNe1bV0lmc8Yb4gCu8CA80zZaqJ+JLU1qyYJRDZboWIdV2ovyF+UZOIfDmZ6p0G
         QR/VRLodUPL9pVQ4OLA8vjD93tIW2aGSJkFHADeBglKOiwkD+CsCfablbgvaPQsUNX+2
         Wn8B6WLcckMGEmKqamrBz0X7v+ZqkofE3Vr27sD7gsYLIsNGlhzqOnNM7SnFKSPCboSU
         +CgDVI9o4PmPtVILoAobL5Cgrowxtzsu9TUhRQwY0aa5c5UtIpxqna2GTEZWj9pLm7Mc
         o2OQ==
X-Gm-Message-State: AO0yUKUhokwPkYr3KkxuA4TU9dEiKqq8e3i1KrDzAuJK6VJtSljSCzQl
        YXorAtRk83zt4xD217CfK+9tAyXxRkg9RGXOhykKYUONyt50cOoWfxA=
X-Google-Smtp-Source: AK7set8XhtTVPuhuDJ3TT1nlpub+BwUOKiT3pYjQDIOR/bKhKjaIYC+eMS2ov4vUrNGFHx/sRLhAgJV3voZsNSQ+eGA=
X-Received: by 2002:a1f:9e03:0:b0:406:6b94:c4fe with SMTP id
 h3-20020a1f9e03000000b004066b94c4femr1335124vke.0.1679556955683; Thu, 23 Mar
 2023 00:35:55 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Mar 2023 13:05:44 +0530
Message-ID: <CA+G9fYvBxp38KEggtvtvVtGMaSBdL3NDV9ns=Zi9-Jtx7H9g1A@mail.gmail.com>
Subject: next-20230323: arm64: vma_merge (mm/mmap.c:952 (discriminator 1)) -
 Unable to handle kernel paging request at virtual address 0000000000100111 -
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lstoakes@gmail.com,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <liam.howlett@oracle.com>, willy@infradead.org,
        vernon2gm@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following kernel crash was noticed on arm x15, arm64 hikey-6220, Juno-r2,
x86_64 and i386 devices on Linux next-20230323.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

crash log on arm64:
---------------
[   19.281223] Unable to handle kernel paging request at virtual
address 0000000000100111
[   19.289189] Mem abort info:
[   19.291995]   ESR = 0x0000000096000006
[   19.295757]   EC = 0x25: DABT (current EL), IL = 32 bits
[   19.301086]   SET = 0, FnV = 0
[   19.304151]   EA = 0, S1PTW = 0
[   19.307302]   FSC = 0x06: level 2 translation fault
[   19.312194] Data abort info:
[   19.315083]   ISV = 0, ISS = 0x00000006
[   19.318930]   CM = 0, WnR = 0
[   19.321901] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008a23c5000
[   19.328374] [0000000000100111] pgd=08000008a14c5003,
p4d=08000008a14c5003, pud=08000008a14c6003, pmd=0000000000000000
[   19.339037] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[   19.345315] Modules linked in:
[   19.348373] CPU: 2 PID: 1 Comm: init Not tainted 6.3.0-rc3-next-20230323 #1
[   19.355347] Hardware name: ARM Juno development board (r2) (DT)
[   19.361273] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   19.368246] pc : vma_merge (mm/mmap.c:952 (discriminator 1))
[   19.371917] lr : vma_merge (mm/mmap.c:945)
[   19.375670] sp : ffff80000b37bb40
[   19.378985] x29: ffff80000b37bb40 x28: ffff000820c0ff20 x27: 0000000000000000
[   19.386139] x26: ffff000820c17210 x25: ffff000800bfac00 x24: 0000ffff8e8b7000
[   19.393293] x23: 0000000000100071 x22: ffff000800898d80 x21: 0000000000100071
[   19.400446] x20: ffff80000b37bd18 x19: 0000ffff8e8ba000 x18: ffff80000b37bd18
[   19.407599] x17: 0000000000000000 x16: ffff8000099a58c8 x15: 0000ffff8e9aefff
[   19.414752] x14: 0000ffff8e8b7000 x13: 1fffe001041bb361 x12: ffff80000b37baf8
[   19.421905] x11: ffff000822473400 x10: ffff000820dd9b08 x9 : ffff80000830fc64
[   19.429057] x8 : 0000ffff8e8b7000 x7 : 0000ffff8e8b7000 x6 : ffff000820dd9b50
[   19.436210] x5 : ffff000820c0ff20 x4 : 0000000000000187 x3 : ffff000800bfac00
[   19.443363] x2 : 0000000000000000 x1 : 0000000000100071 x0 : 0000000000000000
[   19.450515] Call trace:
[   19.452960] vma_merge (mm/mmap.c:952 (discriminator 1))
[   19.456279] mprotect_fixup (mm/mprotect.c:676)
[   19.460034] do_mprotect_pkey.constprop.0 (mm/mprotect.c:862)
[   19.465094] __arm64_sys_mprotect (mm/mprotect.c:880)
[   19.469283] invoke_syscall (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:57)
[   19.473041] el0_svc_common (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/syscall.c:150)
[   19.476796] do_el0_svc (arch/arm64/kernel/syscall.c:194)
[   19.480117] el0_svc (arch/arm64/include/asm/daifflags.h:28
arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:142
arch/arm64/kernel/entry-common.c:638)
[   19.483177] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
[   19.487454] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[ 19.491123] Code: eb18001f 54000800 52800002 b40004d7 (f94052e1)
All code
========
   0:* 1f                    (bad)  <-- trapping instruction
   1: 00 18                add    %bl,(%rax)
   3: eb 00                jmp    0x5
   5: 08 00                or     %al,(%rax)
   7: 54                    push   %rsp
   8: 02 00                add    (%rax),%al
   a: 80 52 d7 04          adcb   $0x4,-0x29(%rdx)
   e: 00                    .byte 0x0
   f: b4 e1                mov    $0xe1,%ah
  11: 52                    push   %rdx
  12: 40 f9                rex stc

Code starting with the faulting instruction
===========================================
   0: e1 52                loope  0x54
   2: 40 f9                rex stc
[   19.497226] ---[ end trace 0000000000000000 ]---
[   19.501883] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[   19.509551] SMP: stopping secondary CPUs
[   19.513665] Kernel Offset: disabled
[   19.517152] CPU features: 0x400002,0c3c0400,0000421b
[   19.522123] Memory Limit: none
[   19.525181] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 7c4a254d78f89546d0e74a40617ef24c6151c8d1
  git_describe: next-20230323
  kernel_version: 6.3.0-rc3
  kernel-config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZBWCUG4Ypift7/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/815177945
  artifact-location:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2NOjwfRUa0fjWWZBWCUG4Ypift7
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org
