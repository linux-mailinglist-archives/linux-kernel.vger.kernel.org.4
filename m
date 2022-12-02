Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7950964038B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiLBJnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiLBJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:43:01 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3082FA659F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:43:00 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b56782b3f6so43017347b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2slbUiJmXoRmpNuRxOv1K083wWFnheMGIwwKztKIFzE=;
        b=tCQ5/XmgqkcfC40O80yasOYCKHkzhwgepZgGGTeZs9YXcUBntp9tjV3tXTdTKYhQjK
         GcHlOU0T2s/Va9He+t2YF8cAPY30g0D1vPR+g/ttoaY/k7op9dh3OTqtBVAdciWgI29w
         eyph+Px2wuhBix0loKUPb9CiHK/FkTD8P6/POuCMoWPfPSwGPUKLrBNM4q8hV+oAJ3xg
         pKure5WZ6hdoHpma0E9pQm0LusvTP+XGfqYzxX1548PbZvSL0SDYXxJxF+f4lpJSNOLd
         7a5GMX4XWeiIDy9MHRlTNBnR/pCZHoE4fzYmdlul6+h05Zw2DZ9Cjk3Cef+NfcTos9Bc
         CuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2slbUiJmXoRmpNuRxOv1K083wWFnheMGIwwKztKIFzE=;
        b=oyIR+ScEdkdaa46+Ro1o1WS5hLf0VnDziEIG/FocPb+D3baVaNMHlYMjGQ2i+tBftv
         etXWq4U+2fDA4ZhBrqlKLSNATKsZ+uKRCqebtA1y65YGAdNlKqKpHOiF2MqTkZrjf6FA
         TFtm/LsZ67JGZVIPnxW4V4VqSfY+gJO1xUkzZ0FZe1AjvUdM0slI6wNWQ/hwEWRJHvHN
         xNCGs2aiVQiSfIWplnCgfAj9sICLGtvANC7Kt39+gcw6DZ+4Fz5grMAnSdZvfGPyBmY7
         ZoP/POcAWlwdzgzFYpuXZXeTZ2HZJAnKLIFOUIENXt/d5SkhCMXAzRLrcU4ROTklAVnM
         U+tQ==
X-Gm-Message-State: ANoB5pnet8rfpb6IyJYl4qjqP7bq3rjgo27Frh13CTFe+1HUSqyUvGMQ
        1hxxlMkIC8NF/EDcwSCoI6lCXZrVeePCWGPKGNVe6A==
X-Google-Smtp-Source: AA0mqf5kDX6jCDuPLbaGSMnRhNF04YeIJnTtrSOziYlU+zLnS0MyX9YTp0fIYld/VBvyePXysL6Zbyq7V5vq0UVO5gg=
X-Received: by 2002:a81:1915:0:b0:3bf:9e45:1139 with SMTP id
 21-20020a811915000000b003bf9e451139mr28525181ywz.267.1669974179263; Fri, 02
 Dec 2022 01:42:59 -0800 (PST)
MIME-Version: 1.0
References: <202212021713.p3N3pHkV-lkp@intel.com>
In-Reply-To: <202212021713.p3N3pHkV-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Dec 2022 10:42:23 +0100
Message-ID: <CANpmjNNzkSVGeogm4fjHsENW52PEdwJey-=vz89QC9b5Fa-KGA@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __tsan_memset
To:     kernel test robot <lkp@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

On Fri, 2 Dec 2022 at 10:32, kernel test robot <lkp@intel.com> wrote:
>
> Hi Kefeng,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4412fdd49dc011bcc2c0d81ac4cab7457092650
> commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
> date:   12 months ago
> config: arm64-randconfig-r006-20221201
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 6e4cea55f0d1104408b26ac574566a0e4de48036)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dd03762ab608e058c8f390ad9cf667e490089796
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: __tsan_memset
>    >>> referenced by main.c
>    >>>               main.o:(init_setup) in archive init/built-in.a
>    >>> referenced by main.c
>    >>>               main.o:(rdinit_setup) in archive init/built-in.a
>    >>> referenced by main.c
>    >>>               main.o:(do_one_initcall) in archive init/built-in.a
>    >>> referenced 8519 more times
> --
> >> ld.lld: error: undefined symbol: __tsan_memcpy
>    >>> referenced by main.c
>    >>>               main.o:(do_one_initcall) in archive init/built-in.a
>    >>> referenced by initramfs.c
>    >>>               initramfs.o:(panic_show_mem) in archive init/built-in.a
>    >>> referenced by initramfs.c
>    >>>               initramfs.o:(do_collect) in archive init/built-in.a
>    >>> referenced 3922 more times
> --
> >> ld.lld: error: undefined symbol: __tsan_memmove
>    >>> referenced by main.c
>    >>>               main.o:(repair_env_string) in archive init/built-in.a
>    >>> referenced by range.c
>    >>>               range.o:(add_range_with_merge) in archive kernel/built-in.a
>    >>> referenced by core.c
>    >>>               bpf/core.o:(bpf_patch_insn_single) in archive kernel/built-in.a
>    >>> referenced 88 more times

The fix for this has been in -next (-rcu) for a while. Once it hits
mainline, it should also reach stable kernels since I attached Cc:
stable tags to the patches.

Given Clang 16 isn't even released yet, I think this is fair and does
not require urgency at this point.

Thanks,
-- Marco
