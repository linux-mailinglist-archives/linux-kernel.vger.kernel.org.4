Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B75F1867
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiJAB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiJAB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:27:48 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8446853
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:26:38 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2911QNFX017986
        for <linux-kernel@vger.kernel.org>; Sat, 1 Oct 2022 10:26:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2911QNFX017986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664587583;
        bh=LE/Dpd2tZjpIw0AMK+YIkIQj9PhpVgRm18lTBo7vDcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VUFrMmI8C06X2O1t/Fmq/R6ExFTk2nnUVHwxavbeXhPQ0L3WJdFA/XbAFIptzqSwr
         fgBAX23AKJgSPJb3z4rjTHbVcNwqt5uyOgJKrTP2wuBV53MlKoOTKrg+dsCcYUV50A
         pqscOiFK3PfK07qqhnGd4+JmXUG8Gqa3LJXBwd6v/FgnHzUAqiZ0b/39QuNvbfVjeV
         hRwaI18IpjwYncF+YsvZ0hZetA3TEbKlcdQGQbg1315TJIQgyr1HUthLuCH0Gjss6z
         K1asOxLXXO+VS10XgRcbsNSW18eUJ3chHphHIRPWteqw1Co1MUe8ot7t3zbdQwq8q0
         INt6Vv66/7+aQ==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-131886d366cso7313579fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:26:23 -0700 (PDT)
X-Gm-Message-State: ACrzQf0n2I1TnVbcugPiMVxSezieBK364rs1SYWf8+EK9xF4CxhR/uR6
        U8Ro5i6oWlAL3kEgWb7vFLo/yuwfeftQW5RqUJk=
X-Google-Smtp-Source: AMsMyM5ZKYIMWReMOKiLAhg8MgqjTL7XA9yyIinPanZeX8jVLwRLBHicu01yoh/4LKk45NpbehjEjyFH6J6A179doIU=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr396717oab.287.1664587582685; Fri, 30
 Sep 2022 18:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <202210010425.ycjq8GK8-lkp@intel.com>
In-Reply-To: <202210010425.ycjq8GK8-lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Oct 2022 10:25:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASG7tLdmhDisf6fx+0gZLfeEdnsfFBTCt80gLFvoG1-1A@mail.gmail.com>
Message-ID: <CAK7LNASG7tLdmhDisf6fx+0gZLfeEdnsfFBTCt80gLFvoG1-1A@mail.gmail.com>
Subject: Re: [masahiroy:export-cleanups-v3 1/44] ERROR: modpost:
 "HUF_readStats_wksp" [lib/zstd/zstd_decompress.ko] undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 5:56 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git export-cleanups-v3
> head:   7ac12d28f017eabb0a542737402a13bc415d7e45
> commit: a0f775915e777832a36471178ab4af75f7199a76 [1/44] zstd: Fixing mixed module-builtin objects
> config: parisc-randconfig-r004-20220925
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=a0f775915e777832a36471178ab4af75f7199a76
>         git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>         git fetch --no-tags masahiroy export-cleanups-v3
>         git checkout a0f775915e777832a36471178ab4af75f7199a76
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "ZSTD_isError" [lib/zstd/zstd_decompress.ko] undefined!
> >> ERROR: modpost: "ZSTD_getErrorName" [lib/zstd/zstd_decompress.ko] undefined!
> >> ERROR: modpost: "ZSTD_getErrorCode" [lib/zstd/zstd_decompress.ko] undefined!
> >> ERROR: modpost: "HUF_readStats_wksp" [lib/zstd/zstd_decompress.ko] undefined!




I think this report is about the previous patch version (v2).

The issue was fixed by v3.





-- 
Best Regards
Masahiro Yamada
