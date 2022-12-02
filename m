Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316963FD25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiLBAf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiLBAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:35:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7AB82
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:35:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s7so3230040plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kwP5HcBF+fgUi/kKFaJ4xv8JAo6gbyWvQve+daSpqhY=;
        b=kOmuyKfNLbpiXl+TQfql3B5Bqpu+wn5veS+rx409QF/AQ1VxlGTkAMlFcf65me/CcH
         trPOVLGIaU0I6tryrM9zdQRBPdpd+KbDTPExQAqT5ncmP8G8B2QqOLVCwOfO7oPVSSB+
         4Uo5OKWgZv8W0/yk0HsI2eMN8+dugRyxdid+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwP5HcBF+fgUi/kKFaJ4xv8JAo6gbyWvQve+daSpqhY=;
        b=sziaCSDWeGXZQfgfGcn3JqzJtK9QCtN8hxxaiofmWHzHcwSdTXBbgQHeOIZokWE0sM
         IaDW4hS/wn2naVQybsVaH5PUxPMT6Pro4YPb3c2lKPJt7Mkzu3VUe6ypym1jnFXhgcTz
         jPGzE4s1+iMQDKezXwk+eeFDC6uM9s7TaxP/AVzAwIwuiXbvLsyRrxMA1HCYxXEgjDnL
         epDLCeTEMTYy1B6kbphmez3C41+sgi8xTJTAEbr/W67u9HWh7Jha12HnIjIiiRgmuky2
         QPPdkVFOrtGzDcP8DPdLF/E5Wa2cMYuZsmY7eCpd/FeYBNSihzXRGIrfyY+LVm8HWj2C
         2KRQ==
X-Gm-Message-State: ANoB5plkxmHmR6rcJzAU2lERwP5Hi/oE7zCecTBeLCtY2cMQ41oial1j
        tvTCSZxSfPjsJotMmDIEu9p5OIkBWILB6g==
X-Google-Smtp-Source: AA0mqf4dHitAUKJftdOplFruo5ficLsZOByUDzPKchriOKqVeeqjRAVCNStAziR0fva4gU8CybR5Cw==
X-Received: by 2002:a17:90a:b946:b0:213:d7cc:39cb with SMTP id f6-20020a17090ab94600b00213d7cc39cbmr78732576pjw.144.1669941325242;
        Thu, 01 Dec 2022 16:35:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a564f00b001ef8ab65052sm3566016pji.11.2022.12.01.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:35:24 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:35:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: include/linux/fortify-string.h:50:33: warning:
 '__builtin_memset' offset [0, 7] is out of the bounds [0, 0]
Message-ID: <202212011632.C56CEB7B@keescook>
References: <202211271212.SUZSC9f9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211271212.SUZSC9f9-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 12:37:10PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   faf68e3523c21d07c5f7fdabd0daf6301ff8db3f
> commit: ba38961a069b0d8d03b53218a6c29d737577d448 um: Enable FORTIFY_SOURCE
> date:   3 months ago
> config: um-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba38961a069b0d8d03b53218a6c29d737577d448
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ba38961a069b0d8d03b53218a6c29d737577d448
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=um SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/string.h:253,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/mm_types_task.h:14,
>                     from include/linux/mm_types.h:5,
>                     from include/linux/buildid.h:5,
>                     from include/linux/module.h:14,
>                     from arch/um/drivers/virt-pci.c:6:
>    arch/um/drivers/virt-pci.c: In function 'um_pci_send_cmd':
>    include/linux/fortify-string.h:48:33: warning: argument 1 null where non-null expected [-Wnonnull]
>       48 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
>      438 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:483:26: note: in expansion of macro '__fortify_memcpy_chk'
>      483 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    arch/um/drivers/virt-pci.c:100:9: note: in expansion of macro 'memcpy'
>      100 |         memcpy(buf, cmd, cmd_size);
>          |         ^~~~~~
>    include/linux/fortify-string.h:48:33: note: in a call to built-in function '__builtin_memcpy'
>       48 | #define __underlying_memcpy     __builtin_memcpy
>          |                                 ^
>    include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
>      438 |         __underlying_##op(p, q, __fortify_size);                        \
>          |         ^~~~~~~~~~~~~
>    include/linux/fortify-string.h:483:26: note: in expansion of macro '__fortify_memcpy_chk'
>      483 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>          |                          ^~~~~~~~~~~~~~~~~~~~
>    arch/um/drivers/virt-pci.c:100:9: note: in expansion of macro 'memcpy'
>      100 |         memcpy(buf, cmd, cmd_size);
>          |         ^~~~~~
>    arch/um/drivers/virt-pci.c: In function 'um_pci_cfgspace_read':
> >> include/linux/fortify-string.h:50:33: warning: '__builtin_memset' offset [0, 7] is out of the bounds [0, 0] [-Warray-bounds]
>       50 | #define __underlying_memset     __builtin_memset
>          |                                 ^
>    include/linux/fortify-string.h:316:9: note: in expansion of macro '__underlying_memset'
>      316 |         __underlying_memset(p, c, __fortify_size);                      \
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/fortify-string.h:323:25: note: in expansion of macro '__fortify_memset_chk'
>      323 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
>          |                         ^~~~~~~~~~~~~~~~~~~~
>    arch/um/drivers/virt-pci.c:192:9: note: in expansion of macro 'memset'
>      192 |         memset(buf->data, 0xff, sizeof(buf->data));
>          |         ^~~~~~

I had noticed this too while running kunit tests, but never tracked it
down. That's done now. Patch sent:

https://lore.kernel.org/lkml/20221202003137.never.887-kees@kernel.org

Thanks!

-Kees

-- 
Kees Cook
