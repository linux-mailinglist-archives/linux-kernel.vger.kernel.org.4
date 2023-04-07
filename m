Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4E6DB6E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDGXJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDGXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:09:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62231E188
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:08:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d22so25065659pgw.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680908936; x=1683500936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/A9yoOa2sBpUnZIMrQVqmsVGIbqBmbp6pkbYZ4l6UU=;
        b=AhzIPIoWtUHXfiZAGqj7Rh0bGux7x12APDYsEuR6hOMdIkSo29jtI/VJ/WdcMY6r9u
         N4rZMnqz+lp6KnK7yOPo2xAhLDgFMWl9isRqcqS2ZoJCGuftfrOehqNHqpok3HslgeIR
         /4h+nNK/8QEzWQ1QzmGerO22l/rADw49EZtQhWeBI+d+1jcetYxSBT3DjjNEnkkxTU05
         U+isNCl6gov9gwbOkThLeDfxwkemOFhSEoxF6rmIFY3MdKyo7jygNnFPumxBne9tiTRK
         Po2nDkrACosdwk/prT78kKxhApms5YMGxsJfZe3pXbXbeJcO9d8RCsmjp5HpDdMcoWTa
         GiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908936; x=1683500936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/A9yoOa2sBpUnZIMrQVqmsVGIbqBmbp6pkbYZ4l6UU=;
        b=sPG/zSedjbTxDltve1g7eCLhLOZDGqljWrMXZJcTEbKutE0f/Xbs31H5Li41WIIKo6
         L72IznBsBUaSuBpKzo/uhIQ6RxfeDlaFK1G9xQuxQgv4EYwoMv9oZgH7wdtPni04R3tF
         luHUTwWGJtyiupAyNq5IUAT2pCEywGi7KhUhUmY+iNQ8834tGS2HoWLfq6uouQFS2Bcu
         wFz/DenYRD69H8cu1JjpzrZXnvGX9JqaiULFm1vd1iou3894tt2rBMepK/2JjIweMaB2
         6w8/af25M+TMLVeU00t/KVvZVqkA6BHEjjdSYlhDLPHMNioqsyuXNy1qmNIhSoKEUdDi
         78YA==
X-Gm-Message-State: AAQBX9dsLE474mQzatDXda92UyBtsNhcRW2QzRwoheferLGkzMDJRAbp
        5JQ3JRkNTo0+12Bhq+oeUv/Nl6CLxKSyCbFO+6iCeoR4YvEZIpmhvxChtg==
X-Google-Smtp-Source: AKy350a96OQojp02wkoJRuAsojor0z+CMD9evmEOlOj7kP5JYN9cUpHiLLD6TzRymSJO3R5M4Z/6MncmZRZ3WPdVAzQ=
X-Received: by 2002:a65:6201:0:b0:4fc:2058:fa29 with SMTP id
 d1-20020a656201000000b004fc2058fa29mr782408pgv.1.1680908935492; Fri, 07 Apr
 2023 16:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <202304050954.yskLdczH-lkp@intel.com>
In-Reply-To: <202304050954.yskLdczH-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 16:08:43 -0700
Message-ID: <CAKwvOdmXTOaK+JALp+fr4Q_MtVgi23Te9RvLPF8-Sisc3qWQ=A@mail.gmail.com>
Subject: Re: arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning:
 "THREAD_SHIFT" is not defined, evaluates to 0
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 6:29=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Masahiro,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   76f598ba7d8e2bfb4855b5298caedd5af0c374a8
> commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to K=
BUILD_CPPFLAGS for W=3D1 builds
> date:   4 months ago
> config: powerpc-buildonly-randconfig-r003-20230405 (https://download.01.o=
rg/0day-ci/archive/20230405/202304050954.yskLdczH-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D80b6093b55e31c2c40ff082fb32523d4e852954f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 80b6093b55e31c2c40ff082fb32523d4e852954f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc olddefconfig
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash arch/powerpc/kernel=
/ arch/powerpc/kvm/ virt/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304050954.yskLdczH-lkp@i=
ntel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/powerpc/kvm/bookehv_interrupts.S:26:
> >> arch/powerpc/kvm/../kernel/head_booke.h:20:6: warning: "THREAD_SHIFT" =
is not defined, evaluates to 0 [-Wundef]
>       20 | #if (THREAD_SHIFT < 15)
>          |      ^~~~~~~~~~~~

Should arch/powerpc/kernel/head_booke.h be #include'ing
asm/thread_info.h before using THREAD_SHIFT?

>
>
> vim +/THREAD_SHIFT +20 arch/powerpc/kvm/../kernel/head_booke.h
>
> 1a4b739bbb4f88 Christophe Leroy 2019-04-30  10
> 63dafe5728e735 Becky Bruce      2006-01-14  11  /*
> 63dafe5728e735 Becky Bruce      2006-01-14  12   * Macros used for common=
 Book-e exception handling
> 63dafe5728e735 Becky Bruce      2006-01-14  13   */
> 63dafe5728e735 Becky Bruce      2006-01-14  14
> 63dafe5728e735 Becky Bruce      2006-01-14  15  #define SET_IVOR(vector_n=
umber, vector_label)           \
> 63dafe5728e735 Becky Bruce      2006-01-14  16                  li      r=
26,vector_label@l;             \
> 63dafe5728e735 Becky Bruce      2006-01-14  17                  mtspr   S=
PRN_IVOR##vector_number,r26;   \
> 63dafe5728e735 Becky Bruce      2006-01-14  18                  sync
> 63dafe5728e735 Becky Bruce      2006-01-14  19
> e12401222f749c Yuri Tikhonov    2009-01-29 @20  #if (THREAD_SHIFT < 15)
> e12401222f749c Yuri Tikhonov    2009-01-29  21  #define ALLOC_STACK_FRAME=
(reg, val)                     \
> e12401222f749c Yuri Tikhonov    2009-01-29  22          addi reg,reg,val
> e12401222f749c Yuri Tikhonov    2009-01-29  23  #else
> e12401222f749c Yuri Tikhonov    2009-01-29  24  #define ALLOC_STACK_FRAME=
(reg, val)                     \
> e12401222f749c Yuri Tikhonov    2009-01-29  25          addis   reg,reg,v=
al@ha;                         \
> e12401222f749c Yuri Tikhonov    2009-01-29  26          addi    reg,reg,v=
al@l
> e12401222f749c Yuri Tikhonov    2009-01-29  27  #endif
> e12401222f749c Yuri Tikhonov    2009-01-29  28
>
> :::::: The code at line 20 was first introduced by commit
> :::::: e12401222f749c37277a313d631dc024bbfd3b00 powerpc/44x: Support for =
256KB PAGE_SIZE
>
> :::::: TO: Yuri Tikhonov <yur@emcraft.com>
> :::::: CC: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests



--=20
Thanks,
~Nick Desaulniers
