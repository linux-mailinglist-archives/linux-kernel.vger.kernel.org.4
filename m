Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B947270B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjFGVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFGVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:48:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392851BFA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:48:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-97460240863so1073994766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174481; x=1688766481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABCuqfiPRsAOga+TnK4tpbusNiqsy1hT+o8UBpE6sh4=;
        b=Vl3gDG7bsUWOB9LmtHTGGlHBqXNiNkbJucFn7IXtkeV3+TcD0iCP3o6dpiG//c7QM6
         5eMt2jCEM4CO3RwhJzSyjjjtkvOXTQWizMm9mf1a9PzudLN8R5XM4aUXQEjRnrfbIw7i
         KH10/TNHi5BVMxVv6/5DKgaxNSVRFXUw54R/x7sWiP8qFPrzTLFffNtsob2Q6gWwtwd1
         VjajKz+xRC5jrOoEXZXOzHGpOLxPT2cX2ve02XTIzpc3sIEJ90J6L5obMLOCcDlER9II
         yL6pkpW79hTYBI+8VAc9l6/dAveQzDRZLfAdeTc7Xg7xLdppyw4Z5jEAbq1uwWB/1Syq
         5dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174481; x=1688766481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABCuqfiPRsAOga+TnK4tpbusNiqsy1hT+o8UBpE6sh4=;
        b=Dt/0+Hk8nOpTj2eIV2nIw9FOXsenY/qLBpHf98Ow/F2eMxtsOW+GPhdWhg9hEZQ/QJ
         94OnYAR8cipcKOPcIfc31HKRs9xCpR959wouFBAu5IpP5tU7zbn9DTzN6qoSjvx6IVs8
         GQGMAO0qno+mjubOisIx4V9206BI/UxhEmP3qLf7iToneVKd6MSTI5YtQ+cSn6d5Rc+T
         edZhRlYnIAWjb1e4W+KozxTAEzl+18bpnPRVZWtHGYoY7m56bczuLpj2rrBzaCsNaw7u
         QwU4SkN6yQw3ZeI7zcrYHgewpdyYyfTGMB2iIoWFGP6J50TVLjNVDBYeOW4mupJ5UQET
         DuqQ==
X-Gm-Message-State: AC+VfDwX5FOy98wg21emgIQvpxwJslLsQG5XO6i71WDJVCKTR43abCv8
        iWjFHD6j6SU8DegK0B76slU=
X-Google-Smtp-Source: ACHHUZ7pfRyVVNndK/Sgs1L/ia+0JjfslJ0W2HGQwlRuFJ/jdTsGB4DRjte6SDMOIbWuuGOJN8Du6w==
X-Received: by 2002:a17:907:d88:b0:96f:d8a9:d045 with SMTP id go8-20020a1709070d8800b0096fd8a9d045mr7208728ejc.59.1686174481279;
        Wed, 07 Jun 2023 14:48:01 -0700 (PDT)
Received: from nz ([2a00:23c8:a613:101:729c:d1ff:fe4f:94a3])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090680ca00b0096a68648329sm7246163ejx.214.2023.06.07.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 14:48:00 -0700 (PDT)
Date:   Wed, 7 Jun 2023 22:47:59 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: make[5]: *** No rule to make target 'scripts/module.lds',
 needed by 'tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko'.
Message-ID: <20230607224753.37df61df@nz>
In-Reply-To: <202306080543.EJWQZYkE-lkp@intel.com>
References: <202306080543.EJWQZYkE-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2023 05:24:07 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Sergei,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a27648c742104a833a01c54becc24429898d85bf
> commit: 82880283d7fcd0a1d20964a56d6d1a5cc0df0713 objtool: Fix truncated string warning
> date:   1 year, 4 months ago
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=82880283d7fcd0a1d20964a56d6d1a5cc0df0713
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 82880283d7fcd0a1d20964a56d6d1a5cc0df0713
>         make W=1 O=/tmp/kselftest headers
>         make W=1 O=/tmp/kselftest -C tools/testing/selftests
>         make W=1 O=/tmp/kselftest -C tools/testing/selftests/bpf
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306080543.EJWQZYkE-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:19:1: warning: no previous prototype for 'bpf_testmod_test_mod_kfunc' [-Wmissing-prototypes]  
>       19 | bpf_testmod_test_mod_kfunc(int i)
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:24:14: warning: no previous prototype for 'bpf_testmod_loop_test' [-Wmissing-prototypes]  
>       24 | noinline int bpf_testmod_loop_test(int n)
>          |              ^~~~~~~~~~~~~~~~~~~~~
> >> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:36:30: warning: no previous prototype for 'bpf_testmod_return_ptr' [-Wmissing-prototypes]  
>       36 | __weak noinline struct file *bpf_testmod_return_ptr(int arg)
>          |                              ^~~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:53:1: warning: no previous prototype for 'bpf_testmod_test_read' [-Wmissing-prototypes]
>       53 | bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>          | ^~~~~~~~~~~~~~~~~~~~~
>    tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:89:1: warning: no previous prototype for 'bpf_testmod_test_write' [-Wmissing-prototypes]
>       89 | bpf_testmod_test_write(struct file *file, struct kobject *kobj,
>          | ^~~~~~~~~~~~~~~~~~~~~~
> --
> >> make[5]: *** No rule to make target 'scripts/module.lds', needed by 'tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko'.  
>    make[5]: Target '__modfinal' not remade because of errors.

This failure looks unrelated to the commit it points to.

lkp@, can you have a look at your bisection rules in a bit
more of detail? There are at least 2 problems with this report:

1. the commit is 1.5 years old, it's unlikely you care about that old material
2. build failure might be an indication of a flaky build failure (or outright
   stale build tree)

Both points have a chance of decreasing signal value from 0-DAY CI.

Thanks!

-- 

  Sergei
