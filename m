Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182F6733BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjASIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:33:36 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DCF67969;
        Thu, 19 Jan 2023 00:33:25 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30J8WfGM033267;
        Thu, 19 Jan 2023 02:32:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674117161;
        bh=fH9V0X8Q6I5ZHbOtDvD4f+bsLpr5+aytm4ferShY5j0=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ygkFn29MNnRe52+stLg3j9jg/dKk2UOj3dxpmPEM+jh9U+Zm6eRbOgU8/lYB1qjqo
         YSfsY0uqZwAyA1SbPOJZmrD9vPua2gSx53+NzT9fmx7B5wVnk8pzsqMRXjbSD1b6Vi
         dwNIPwiC3evxOS2y/d7fuXAzz7yBjtpzOIP2rIIY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30J8WfLs009823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 02:32:41 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 02:32:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 02:32:40 -0600
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30J8WZWm063421;
        Thu, 19 Jan 2023 02:32:36 -0600
Message-ID: <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
Date:   Thu, 19 Jan 2023 14:02:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Content-Language: en-US
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>
References: <Y8VSslRJZpFbo1/u@uudg.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <Y8VSslRJZpFbo1/u@uudg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 16/01/23 19:05, Luis Claudio R. Goncalves wrote:
> Hello RT-list!
> 
> I'm pleased to announce the 5.10.162-rt78 stable release.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v5.10-rt
>   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> 
> Or to build 5.10.162-rt78 directly, the following patches should be applied:
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
> 
>   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.162.xz
> 
>   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.162-rt78.patch.xz
> 
> Signing key fingerprint:
> 
>   9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26
> 
> All keys used for the above files and repositories can be found on the
> following git repository:
> 
>    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
> 
> Enjoy!
> Luis
> 
> 


I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
Any pointers on what maybe wrong?


[0]

arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
make: *** [Makefile:1837: arch/arm64] Error 2


[1]
143ef105f40a ~/work/lcpd_kernel:v5.10.162-rt78 ✓ aarch64-none-linux-gnu-gcc --version
aarch64-none-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 10.3-2021.07 (arm-10.29)) 10.3.1 20210621
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


{13:21:32}143ef105f40a ~/work/linux_kernel:v5.10.162-rt78 ✓ make defconfig ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu-
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
{13:21:39}143ef105f40a ~/work/linux_kernel/:v5.10.162-rt78 ✓ make  ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- 
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTCC  scripts/dtc/yamltree.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/sorttable
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  WRAP    arch/arm64/include/generated/uapi/asm/kvm_para.h
  WRAP    arch/arm64/include/generated/uapi/asm/errno.h
  WRAP    arch/arm64/include/generated/uapi/asm/ioctl.h
  WRAP    arch/arm64/include/generated/uapi/asm/ioctls.h
  WRAP    arch/arm64/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/msgbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/poll.h
  WRAP    arch/arm64/include/generated/uapi/asm/resource.h
  WRAP    arch/arm64/include/generated/uapi/asm/sembuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/shmbuf.h
  WRAP    arch/arm64/include/generated/uapi/asm/siginfo.h
  WRAP    arch/arm64/include/generated/uapi/asm/socket.h
  WRAP    arch/arm64/include/generated/uapi/asm/sockios.h
  WRAP    arch/arm64/include/generated/uapi/asm/stat.h
  WRAP    arch/arm64/include/generated/uapi/asm/swab.h
  WRAP    arch/arm64/include/generated/uapi/asm/termbits.h
  WRAP    arch/arm64/include/generated/uapi/asm/termios.h
  WRAP    arch/arm64/include/generated/uapi/asm/types.h
  WRAP    arch/arm64/include/generated/asm/early_ioremap.h
  WRAP    arch/arm64/include/generated/asm/mcs_spinlock.h
  WRAP    arch/arm64/include/generated/asm/qrwlock.h
  WRAP    arch/arm64/include/generated/asm/qspinlock.h
  WRAP    arch/arm64/include/generated/asm/set_memory.h
  WRAP    arch/arm64/include/generated/asm/user.h
  WRAP    arch/arm64/include/generated/asm/bugs.h
  WRAP    arch/arm64/include/generated/asm/delay.h
  WRAP    arch/arm64/include/generated/asm/div64.h
  WRAP    arch/arm64/include/generated/asm/dma-mapping.h
  WRAP    arch/arm64/include/generated/asm/dma.h
  WRAP    arch/arm64/include/generated/asm/emergency-restart.h
  WRAP    arch/arm64/include/generated/asm/hw_irq.h
  WRAP    arch/arm64/include/generated/asm/irq_regs.h
  WRAP    arch/arm64/include/generated/asm/kdebug.h
  WRAP    arch/arm64/include/generated/asm/kmap_size.h
  WRAP    arch/arm64/include/generated/asm/local.h
  WRAP    arch/arm64/include/generated/asm/local64.h
  WRAP    arch/arm64/include/generated/asm/mm-arch-hooks.h
  WRAP    arch/arm64/include/generated/asm/mmiowb.h
  WRAP    arch/arm64/include/generated/asm/msi.h
  WRAP    arch/arm64/include/generated/asm/rwonce.h
  WRAP    arch/arm64/include/generated/asm/serial.h
  WRAP    arch/arm64/include/generated/asm/switch_to.h
  WRAP    arch/arm64/include/generated/asm/trace_clock.h
  WRAP    arch/arm64/include/generated/asm/unaligned.h
  WRAP    arch/arm64/include/generated/asm/vga.h
  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  UPD     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/arm64/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  LDS     arch/arm64/kernel/vdso/vdso.lds
  CC      arch/arm64/kernel/vdso/vgettimeofday.o
  AS      arch/arm64/kernel/vdso/note.o
  AS      arch/arm64/kernel/vdso/sigreturn.o
  LD      arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h
  CC      init/main.o
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_initrd.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  CC      init/init_task.o
  AR      init/built-in.a
  HOSTCC  usr/gen_init_cpio
  GEN     usr/initramfs_data.cpio
  SHIPPED usr/initramfs_inc_data
  AS      usr/initramfs_data.o
  AR      usr/built-in.a
  OBJCOPY arch/arm64/kernel/vdso/vdso.so
  AS      arch/arm64/kernel/vdso/vdso.o
  AR      arch/arm64/kernel/vdso/built-in.a
  AR      arch/arm64/kernel/probes/built-in.a
  AS      arch/arm64/kernel/head.o
  LDS     arch/arm64/kernel/vmlinux.lds
  CC      arch/arm64/kernel/debug-monitors.o
  AS      arch/arm64/kernel/entry.o
arch/arm64/kernel/entry.S: Assembler messages:
arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
make: *** [Makefile:1837: arch/arm64] Error 2


-- 
Regards
Vignesh
