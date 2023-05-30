Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6207171E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjE3Xkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjE3Xkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:40:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F8F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b04949e4e9so16213235ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685490022; x=1688082022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U4NZTnB3HOnHtoHzo7ahpVbK7T9rabz3LAeBB2m5AVg=;
        b=fmr7bTHb9dPBgzswN3RMWRcPe2e5CocBmP5VO5eZ99drQrCDkv1ydS46lrp+4oqHoz
         accbzkX7lFaNSPJfJFAqZsEGpp/cdjctuf4exBahHwQe4pGGlyzssVRf6hBKFohCxgkC
         x7aL7gsYAEQM2hnDAKBqMjdHuN/0mnWsbh+R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490022; x=1688082022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4NZTnB3HOnHtoHzo7ahpVbK7T9rabz3LAeBB2m5AVg=;
        b=Id4pq3SogtOGdt9cZDoQNjCmDRBAmyHX/51JBf3x6YlOFPi/ilmuJdwLhhfqq2UNb4
         4ehoX2hlrNwlA4l85msh+a4XZZDw/oUegTPqmVfAo9MPDOn9nExOQqM9tb40ybR+UyU1
         6PdtmqZIgMTJxOh0j5Bhkof3wEuYiSS4lNFsyPdqu6B6s5DE2eFkibC8yUuVmmZUMcGh
         ZwdUvpoAQQLwu3X4Urs0HAvEAdmqdKf0vlJpkWSIRlKuDeEydDyEnu2EdfGZ9OYlrS+4
         3+D34gftZktDurSZM0xFQ0EujRIBxi0m/Dtl0u0/hFjq//K+vbQta9xu8Xn0mq8aiFFS
         LM2g==
X-Gm-Message-State: AC+VfDwyyHKL/fjYkjfhyXNKTJwQIv90xeO1/QN4RbzJoeb/1MIrCDGc
        bXBe5HEGAZ4T6tmU7JTQq0p/pTiU2X1T4Q+DGOk=
X-Google-Smtp-Source: ACHHUZ7PSq91ujI8SrrGb0C2VID+a14xW0uYQ/wXdiq76eaw9ogxMHKC9mQG+F+/rr4CXZ/DaHJefg==
X-Received: by 2002:a17:902:ec8a:b0:1b0:36ad:fe13 with SMTP id x10-20020a170902ec8a00b001b036adfe13mr4316905plg.16.1685490022547;
        Tue, 30 May 2023 16:40:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001ac7af58b66sm10826031ple.224.2023.05.30.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 16:40:22 -0700 (PDT)
Date:   Tue, 30 May 2023 16:40:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: undefined reference to `ftrace_likely_update'
Message-ID: <202305301639.C19C2BE38@keescook>
References: <202305221244.L4XDdQ1Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305221244.L4XDdQ1Q-lkp@intel.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:01:30PM +0800, kernel test robot wrote:
> Hi Kees,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   44c026a73be8038f03dbdeef028b642880cf1511
> commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()

The warning below does not seem to be due to this commit.

> date:   9 months ago
> config: s390-randconfig-r025-20230521
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305221244.L4XDdQ1Q-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
> >> (.text+0x248c): undefined reference to `ftrace_likely_update'
> >> s390-linux-ld: (.text+0x2984): undefined reference to `ftrace_likely_update'

-Kees

-- 
Kees Cook
