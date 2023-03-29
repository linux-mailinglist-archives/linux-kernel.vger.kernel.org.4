Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96576CF198
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjC2SAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC2SAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:00:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149A618E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:59:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id kq3so15675441plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1680112785;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ATAQe7qivttkaF6z/d0hrLKosZU1JWYo/P3cLZVbkw=;
        b=NEdOUx/javmB9kDa7FGeUc51U/Wn0STrKWBa4uDg3vm2+W9FVlVH1+/ZMb1zTGKdDj
         d3KLDNLFiScX2SoDgiYm71CYQHSrFsT80Vwc5DPAARaURlvkxOnL/I2SpNS/7RjVoq7M
         jjBHG4IkvUpJrr88X3pQ1Wfo+pEhSovMq/MTY7fiCKb7Nr6D9uNLsLzURn6rQVZeGbce
         2RLnovtWpOUC6EB7GYynif//9myEVnFqbAQ6SEV67g2Ps9E2dBH1Zb7EzSix25ynrfat
         k7WO6rSP3p9XcTqrR8xuaSeMtQV/wtnrluHPs9zpByqTym6w08+dV+DrUSg5AioJPwMA
         gXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112785;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ATAQe7qivttkaF6z/d0hrLKosZU1JWYo/P3cLZVbkw=;
        b=UDm3Ahv0yOrGqBHwB8FN2ZiVE8NSBAcrzUnQjl98jQvqA7zFVfMDmWRxyEHpz83LuY
         22Q0kdINemAk/+eZxV2rVsWRt9vahj4XlodtqE2/w7NeByyBUvSBHMssrC35+VIVJ+IL
         sJRpAHnajQ61+eWaVw3uQFdAMKZ2rMvZtcen0Qo2erx7HkIE+mgAcQ5swK6QunG+NQbB
         Igq/yNRAZPCOfYVO2fQi13aavRT1KEqUnjqKeVDSpV/uoseUYTBpHB/N0T/1QDxpLdze
         8ypH2B+gGvFsA5J9o9JWSrr+XceUOiYeYKG70iLSke/7iw/JsQteyhP7NpfnR9mLFMka
         GoHg==
X-Gm-Message-State: AO0yUKUZCV3fqlS260EQmsG6cRYo5mRmSWsyM74RBI7gHO8u6FGh4uZT
        LIurb9mnr55X803imcZUN0d69Q==
X-Google-Smtp-Source: AK7set8WybREuJ/MU50NhWHApZc7Q738Nt6HMrkX3X3+yzmaIkDHQziymzMOq45dYkW+fnJxn7v6Yw==
X-Received: by 2002:a05:6a20:21d5:b0:de:247e:d1fe with SMTP id p21-20020a056a2021d500b000de247ed1femr20032034pzb.1.1680112785240;
        Wed, 29 Mar 2023 10:59:45 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7804d000000b00592626fe48csm6374660pfm.122.2023.03.29.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:59:44 -0700 (PDT)
Date:   Wed, 29 Mar 2023 10:59:44 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Mar 2023 10:59:40 PDT (-0700)
Subject:     Re: [PATCH v8 0/1] riscv: Allow to downgrade paging mode from the command line
In-Reply-To: <20230228154629.240541-1-alexghiti@rivosinc.com>
CC:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, bjorn@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, alexghiti@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alexghiti@rivosinc.com
Message-ID: <mhng-4507ad68-27bd-4d29-bb72-8d8f5bc27e34@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 07:46:28 PST (-0800), alexghiti@rivosinc.com wrote:
> This new version gets rid of the limitation that prevented KASAN kernels
> to use the newly introduced parameters.
>
> While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
> avoid relocating the kernel twice for KASLR"): it allows to use the fdt
> functions very early in the boot process with KASAN enabled by simply
> compiling a new version of those functions without instrumentation.
>
> I had to change the handling of the command line parsing to make the
> code self-contained in kernel/pi/cmd_early.c to avoid calling too many
> __pi prefixed functions from outside this file.
>
> I'll use this approach like arm64 to handle the extraction of the random
> seedi from the device tree for KASLR.
>
> base-commit: eb9be8310c58 ("RISC-V: add a spin_shadow_stack declaration")

I have that in my tree, I'm still getting a bunch of boot failures 
though.  I can try to get a list if you're not seeing any, but I'm kind 
of stuck on some other stuff for a bit...

> v8:
> - Fix LLVM ld warning by moving the section .init.sdata from
>   kernel/pi/string.c into the newly created section .init.pidata
>
> v7:
> - Rebased on top of for-next which introduces lots of errors (thanks to
>   the patchwork CI)
> - Add __NO_FORTIFY to avoid undefined __pi_fortify_panic
> - Add an alias to our newly introduced strlen
> - Remove __init as sections are already prefixed in the Makefile
> - Introduce new section for kernel/pi/string.c to quiet the following
>   warnings (once we have all the string functions, we'll be able to get
>   rid of this):
>
> warning: orphan section `.init__bug_table' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init__bug_table'
> warning: orphan section `.init.srodata.cst8' from `arch/riscv/kernel/pi/string.pi.o' being placed in section `.init.srodata.cst8'
>
> v6:
> - Fix llvm warning by forward declaring set_satp_mode_from_cmdline
>
> v5:
> - Handle null command line, Thanks Björn!
> - Add RB/TB from Björn
>
> v4:
> - Introduce pi/ for KASAN to work
>
> v3:
> - Massage commit log to make no4lvl clearer, as asked by Conor
> - Add a note to kernel-parameters.txt regarding the impossibility to use
>   those parameters when KASAN is enabled, as suggested by Conor
> - Add RB from Björn
>
> v2:
> - Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Björn
>
>
> Alexandre Ghiti (1):
>   riscv: Allow to downgrade paging mode from the command line
>
>  .../admin-guide/kernel-parameters.txt         |  5 +-
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
>  arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S               |  8 +++
>  arch/riscv/lib/memcpy.S                       |  2 +
>  arch/riscv/lib/memmove.S                      |  2 +
>  arch/riscv/lib/strlen.S                       |  1 +
>  arch/riscv/mm/init.c                          | 36 +++++++++--
>  9 files changed, 148 insertions(+), 7 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/Makefile
>  create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
