Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31905FA262
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJJRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJJRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:03:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A973FA22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:03:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so10802391pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uVVF0ywPHnxCaOhihQyyrYzXw/M4LRseJx/a5/YCvC8=;
        b=o1Ommk3uYo/CbyxjxhXIMbXpBvdodAlxFK6fxvbvvuBXf49xEXHZcZfCfK4zdEQm/D
         OwJaxylMlO3IN+8OHrebs6c+iYstHRuKU3Tlxf8CWx/uuj9FD7ZcOScErKlDkoKaiWca
         ZvV5JR8A6yJXZLwEwPG07Wt8VJeTsSsn7yukvuXy1pag4LC4VwUZJZopr9nm5CtHOykC
         yu4vi465kmGt6siZv749t3greEQwcXnOEms8Uw6iGnXohqRCDl/pDbLV1HKtbvO1GNix
         28RAvp1gXAwdZAaR1eFRcUUrs1/QRYYKfDkuJj8jOOjXMfYXnAawHiJ6bwvHO+IqdhfM
         nL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVVF0ywPHnxCaOhihQyyrYzXw/M4LRseJx/a5/YCvC8=;
        b=w84W4QyNGz5v1HYEUojEPggdm6ENZ2k4sfIxMnY0uxGwUEOPOwBj+r7W4JCWBDJTrt
         LhYlYKBH0RHo5h+ushxSdZHW0D7wE2HDl/uCrXVReRCGPri21fDLsPyq3A39JbXekxDW
         OJge2Opg6//tPcsaFqLFVbHHyVOI3LTPG0M1aNmxiZy5VCD8HIa35+OBrRnM5ZOg5wcK
         hPVc5qx7P+fyVWXGbYok5xW6h+x4Xhmi+5JxsG6jXEWaR+WUBmCs4PLDnI1JzZlYebUi
         /610Y8tPQSuf3ofau/S1tAbGpjCelhG+G51pQSC3UpBcb1easLTcSzN0A1PMmXQ9h8zz
         YAqA==
X-Gm-Message-State: ACrzQf3CrOT/3Pt2JZflddnErRXDNYJ//fEFHmDLwz2r5xsMm+e6cfPd
        Llqt5sOU9/KZuMt6plsxnQfnj7YpWzq4Lgjx1jguAA==
X-Google-Smtp-Source: AMsMyM5+7xDw0rqy938s2uCrs/AGRNsrVizRXzya0pre6w6guJSTEhqwaHnRr7ZV7/z3I2EtqL3Txe42qpuucrpBhY0=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr32872220pjb.102.1665421431985; Mon, 10
 Oct 2022 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <202210072120.V1O2SuKY-lkp@intel.com>
In-Reply-To: <202210072120.V1O2SuKY-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 10:03:40 -0700
Message-ID: <CAKwvOd=CgD0xaUA4sUqbofJjA2x_peOuVh=YTV_GuiUNNTjACA@mail.gmail.com>
Subject: Re: arch/arm/include/asm/xor.h:60:3: error: write to reserved
 register 'R7'
To:     kernel test robot <lkp@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 6:16 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Ard,
>
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

Thanks for the report. Filed
https://github.com/ClangBuiltLinux/linux/issues/1732
to follow up on this.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4c86114194e644b6da9107d75910635c9e87179e
> commit: d6800ca73a7d325627c045c16d7cfdc7465f4333 Revert "ARM: 9144/1: forbid ftrace with clang and thumb2_kernel"
> date:   8 months ago
> config: arm-randconfig-r013-20221007
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6800ca73a7d325627c045c16d7cfdc7465f4333
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout d6800ca73a7d325627c045c16d7cfdc7465f4333
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from crypto/xor.c:17:
> >> arch/arm/include/asm/xor.h:60:3: error: write to reserved register 'R7'
>                    GET_BLOCK_4(p1);
>                    ^
>    arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
>            __asm__("ldmia  %0, {%1, %2, %3, %4}" \
>                    ^
>    arch/arm/include/asm/xor.h:62:3: error: write to reserved register 'R7'
>                    PUT_BLOCK_4(p1);
>                    ^
>    arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
>            __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
>                                 ^
>    arch/arm/include/asm/xor.h:81:3: error: write to reserved register 'R7'
>                    GET_BLOCK_4(p1);
>                    ^
>    arch/arm/include/asm/xor.h:20:10: note: expanded from macro 'GET_BLOCK_4'
>            __asm__("ldmia  %0, {%1, %2, %3, %4}" \
>                    ^
>    arch/arm/include/asm/xor.h:84:3: error: write to reserved register 'R7'
>                    PUT_BLOCK_4(p1);
>                    ^
>    arch/arm/include/asm/xor.h:42:23: note: expanded from macro 'PUT_BLOCK_4'
>            __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
>                                 ^
>    4 errors generated.
>
>
> vim +/R7 +60 arch/arm/include/asm/xor.h
>
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  13
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  14  #define GET_BLOCK_2(dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  15      __asm__("ldmia  %0, {%1, %2}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  16              : "=r" (dst), "=r" (a1), "=r" (a2) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  17              : "0" (dst))
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  18
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  19  #define GET_BLOCK_4(dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  20      __asm__("ldmia  %0, {%1, %2, %3, %4}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  21              : "=r" (dst), "=r" (a1), "=r" (a2), "=r" (a3), "=r" (a4) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  22              : "0" (dst))
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  23
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  24  #define XOR_BLOCK_2(src) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  25      __asm__("ldmia  %0!, {%1, %2}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  26              : "=r" (src), "=r" (b1), "=r" (b2) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  27              : "0" (src)); \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  28      __XOR(a1, b1); __XOR(a2, b2);
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  29
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  30  #define XOR_BLOCK_4(src) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  31      __asm__("ldmia  %0!, {%1, %2, %3, %4}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  32              : "=r" (src), "=r" (b1), "=r" (b2), "=r" (b3), "=r" (b4) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  33              : "0" (src)); \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  34      __XOR(a1, b1); __XOR(a2, b2); __XOR(a3, b3); __XOR(a4, b4)
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  35
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  36  #define PUT_BLOCK_2(dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  37      __asm__ __volatile__("stmia     %0!, {%2, %3}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  38              : "=r" (dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  39              : "0" (dst), "r" (a1), "r" (a2))
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  40
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  41  #define PUT_BLOCK_4(dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  42      __asm__ __volatile__("stmia     %0!, {%2, %3, %4, %5}" \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  43              : "=r" (dst) \
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  44              : "0" (dst), "r" (a1), "r" (a2), "r" (a3), "r" (a4))
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  45
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  46  static void
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  47  xor_arm4regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  48  {
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  49      unsigned int lines = bytes / sizeof(unsigned long) / 4;
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  50      register unsigned int a1 __asm__("r4");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  51      register unsigned int a2 __asm__("r5");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  52      register unsigned int a3 __asm__("r6");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  53      register unsigned int a4 __asm__("r7");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  54      register unsigned int b1 __asm__("r8");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  55      register unsigned int b2 __asm__("r9");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  56      register unsigned int b3 __asm__("ip");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  57      register unsigned int b4 __asm__("lr");
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  58
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  59      do {
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16 @60              GET_BLOCK_4(p1);
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  61              XOR_BLOCK_4(p2);
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  62              PUT_BLOCK_4(p1);
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  63      } while (--lines);
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  64  }
> ^1da177e4c3f41 include/asm-arm/xor.h Linus Torvalds 2005-04-16  65
>
> :::::: The code at line 60 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
>
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Thanks,
~Nick Desaulniers
