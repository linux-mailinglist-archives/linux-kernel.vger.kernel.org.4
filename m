Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88348611D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJ1WDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJ1WDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:03:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B22475FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:03:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso5674607pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysgpRHQ7SxT5gxl0SD+wkL++4qEf9TUgt8rvA8vEhV4=;
        b=Lk+pVjPxdJi6kXVzqvewqbXVR9oTuhKJqMp9u0hawj86w/N7qsTGJqoCW+LglQtxrd
         q3ZxhBCOLRccQDoLz/B2gJaU15ItPtFcLro+2fN4qhgBCDoSV1L/ji9bRAz58YQGJiHY
         l7iDUZKwbmcPJuZN2622UCaI54E0Ht6S4oIj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysgpRHQ7SxT5gxl0SD+wkL++4qEf9TUgt8rvA8vEhV4=;
        b=ZZ5p68d5uakhk8ouI2nE6oeVgNbbY/i8YR1TjqrwgWEjARIdyiu9/zvXegBfEX+a8Q
         2AtJwcbTO0jGzuc1aXkw6DmYQ4mDZeQfiGFbyWQR8W1Y8RUxAhr/fofYS7Tke56oMhrW
         pX2RYNdykCGWuBQoJWstQd4Ywslu3XwqwuDeYdXytOkh59ntyBqIEq9C6WqDe6Jd9Qf4
         N1YrhQ3FbvZwzbtpvgoBvXeE7kL8W/iPyU7K2aQM5G4d4d5jEdHBh2YrV8Vf1bj+18Wx
         zpKHFHVm4VXtXApds/WgEUW+XBD5Nc4zrxiKFLTRrtN/TkESpHvZWR6tGwXaANo2DXoQ
         H+yg==
X-Gm-Message-State: ACrzQf3I0oj6vGfHqwUtqZ6gqHuRIG9yUhuAcic7GmVNsEudFru0VOrb
        dKFk3/4JLDd/T2iLdP29o5alRgrD3AV+3g==
X-Google-Smtp-Source: AMsMyM5kSAzDZ0OrbROsUXB+FJd4cVPTp8ZB490WdCUevkt8mgdBUC0aG9vs3op/RkUjf+h922qpAA==
X-Received: by 2002:a17:90b:2705:b0:20a:b4fa:f624 with SMTP id px5-20020a17090b270500b0020ab4faf624mr1458189pjb.124.1666994586339;
        Fri, 28 Oct 2022 15:03:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7972c000000b0056cc538baf0sm1881387pfg.114.2022.10.28.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 15:03:05 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:03:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: include/linux/fortify-string.h:220:25: warning: call to
 '__write_overflow_field' declared with attribute warning: detected write
 beyond size of field (1st parameter); maybe use struct_group()?
Message-ID: <202210281501.29D9A905@keescook>
References: <202210230440.8ZaljZvp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210230440.8ZaljZvp-lkp@intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 04:45:58AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4da34b7d175dc99b8befebd69e96546c960d526c
> commit: 28e77cc1c0686621a4d416f599cee5ab369daa0a fortify: Detect struct member overflows in memset() at compile-time
> date:   8 months ago
> config: arm-randconfig-r012-20221023
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=28e77cc1c0686621a4d416f599cee5ab369daa0a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 28e77cc1c0686621a4d416f599cee5ab369daa0a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/ocfs2/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:253,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/spinlock.h:62,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/slab.h:15,
>                     from fs/ocfs2/dlmglue.c:11:
>    In function 'fortify_memset_chk',
>        inlined from 'ocfs2_lock_res_free' at fs/ocfs2/dlmglue.c:790:2:
> >> include/linux/fortify-string.h:220:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>      220 |                         __write_overflow_field(p_size_field, size);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This appears to be a compiler bug. The line in question is:

        memset(&res->l_lksb, 0, sizeof(res->l_lksb));

Looking at binary output, something is failing in dead code elimination,
as the copy of the code holding this is never called, and has a
non-literal value for the __builtin_object_size() output, which isn't
possible.

-Kees

-- 
Kees Cook
