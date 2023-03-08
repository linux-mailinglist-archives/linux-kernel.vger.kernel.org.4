Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88F6B14D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCHWPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjCHWPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:15:37 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7F848E0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:15:36 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id l24so12261441uac.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678313735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OqQ3EI188CowuYOZmSAukdXapAzBQtZ77d6uRCmdYk4=;
        b=gDVFrvZN1fTkmS59qr2tc1bOXYnDbM85t+ZAKK8LkT2S3Mqrh5RH8aE8i3dWv+lrdQ
         mlblqFs10qLB58g4PxUakiMXZgBhTGcRVTmWGYaeTZHpEe/7tLOP0zKqA8kG3fobIg0L
         fGMwRDjRw1sJEGyd1WsZEzsuBDDqbZ7rPUaJdcfJFZegx0y6PHcV0xp00c0xg3WaeH2f
         q4qBATZgKxRkywY3g5NvzUBdWgGevJEoiiUK/us+rzRZ8JimIs4bQAu3MiQ+tgENchiJ
         XvQteTBgPaZFBv7MJjVBbfN5lvf+UhokSYwqzq1B9w/AAyq4yt/bmySFWfIGhO88UfXq
         YisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqQ3EI188CowuYOZmSAukdXapAzBQtZ77d6uRCmdYk4=;
        b=Wtq5kfvA6DaZV4e998+czXLyj/kJejv4Fj3QM9d/h0DM09ab3bCP6jABkLeAmRQ924
         vqZd42eNb5j47OieIh9DUu+jP3MKjCFuKtDSvIH4u93pAQDsRkmqrjwAOhR6lmFPkrab
         g0U5Ng7awg/9+3LcAncSC9lD8GefazIF2IGd8ilWSHayYrLa6P+3J1K92CclfLacS2ac
         j2I7hnCleLgA5B0F9VIF5fQ/vuZObq4RV0PkI3zGJ7LKsJuzcXJkDP9rLKsxf04jLKAf
         AfgLOyRgdTPEG0NOSCJBKkpMPN3EDQEneYX+VZvgTthNOH5TizDRy55et1aIQUcVXT36
         jxfg==
X-Gm-Message-State: AO0yUKUKsaFu7qhTe1tFaYvMB75+LJrF6a/RyPfH9IGR0I2XT3QoYmnK
        n50xdi+f4V8NLUSekD0iQwWXSdjVFNHtCFTGZd3XZw==
X-Google-Smtp-Source: AK7set8qOFCTlsiSulkEPgGML+flaI1zps+GAKkX3YWHu4GvtmRKJrr0ZCGTo8L6VyWz7WfxnrGjIpRpgaVIXo8gfiI=
X-Received: by 2002:a1f:c847:0:b0:411:ff57:d3b9 with SMTP id
 y68-20020a1fc847000000b00411ff57d3b9mr11444842vkf.2.1678313734597; Wed, 08
 Mar 2023 14:15:34 -0800 (PST)
MIME-Version: 1.0
References: <202303090422.ss2Hbm4f-lkp@intel.com> <20230308130735.bbc4b21a3aff977bced451fa@linux-foundation.org>
In-Reply-To: <20230308130735.bbc4b21a3aff977bced451fa@linux-foundation.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Mar 2023 23:14:58 +0100
Message-ID: <CANpmjNMGd=mfz3tBJcGMYeVo3iRy7F2EqCk_5j+2mJT38_ZNbQ@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: memcpy
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 at 22:07, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 9 Mar 2023 05:01:04 +0800 kernel test robot <lkp@intel.com> wrote:
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
> > commit: 36be5cba99f6f9984a9a9f0454f95a38f4184d3e kasan: treat meminstrinsic as builtins in uninstrumented files
> > date:   6 days ago
> > config: powerpc-randconfig-r036-20230305 (https://download.01.org/0day-ci/archive/20230309/202303090422.ss2Hbm4f-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install powerpc cross compiling tool for clang build
> >         # apt-get install binutils-powerpc-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36be5cba99f6f9984a9a9f0454f95a38f4184d3e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 36be5cba99f6f9984a9a9f0454f95a38f4184d3e
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303090422.ss2Hbm4f-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: undefined symbol: memcpy
> >    >>> referenced by xmon.c:1896 (arch/powerpc/xmon/xmon.c:1896)
> >    >>>               arch/powerpc/xmon/xmon.o:(prregs) in archive vmlinux.a
> >    >>> referenced by zstd_compress.c:4814 (lib/zstd/compress/zstd_compress.c:4814)
> >    >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_createCDict_advanced2) in archive vmlinux.a
> >    >>> referenced by zstd_compress.c:4910 (lib/zstd/compress/zstd_compress.c:4910)
> >    >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_initStaticCDict) in archive vmlinux.a
> >    >>> referenced 5 more times
> > --
> > >> ld.lld: error: undefined symbol: memset
> >    >>> referenced by slab_common.c:579 (mm/slab_common.c:579)
> >    >>>               mm/slab_common.o:(kmem_dump_obj) in archive vmlinux.a
> >    >>> referenced by kasan_test.c:558 (mm/kasan/kasan_test.c:558)
> >    >>>               mm/kasan/kasan_test.o:(kmalloc_oob_in_memset) in archive vmlinux.a
> >    >>> referenced by kasan_test.c:505 (mm/kasan/kasan_test.c:505)
> >    >>>               mm/kasan/kasan_test.o:(kmalloc_oob_memset_2) in archive vmlinux.a
> >    >>> referenced 10 more times
> >
>
> Will this fix?

I think this patch got lost:
https://lkml.kernel.org/r/20230227094726.3833247-1-elver@google.com

By the looks of it 36be5cba99f6f9984a9a9f0454f95a38f4184d3e in
mainline doesn't have any of the powerpc bits.

Thanks,
-- Marco
