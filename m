Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4F5F1D45
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJAPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJAPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:45:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211974C62B;
        Sat,  1 Oct 2022 08:45:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so9461722edc.10;
        Sat, 01 Oct 2022 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CBeN6iaBYdbiDey296zXVYuTe9GCmYYjkX+OLGzEQ6Y=;
        b=gzNs0o/uXndlG7c0OGd8JcufuTNLJBlspe9S/VKSJjD2yEhJOyifO1kgV7f7YTP/w9
         8bL1tl5XULDnFomTZqxdo3ir2aUDhh7xSAR0OhZnXwJ9osSHxwvvbCKhK7CaDdvZKDy9
         gASrCMsOQECyqBcreEF821qOG1+zmL8Ve364noPaiVx9Mk+WnSqIKo7C1nIk5es2pP+h
         xbGBI5kVPtT2z45xPrhZh/PXhkOd6Vb7PjOoZ4IAagPzAW7A9eFt+z8PoubKMckRJom9
         X0R72Dd7d5u/n0S7qC47+NTGprGk/wNRJfbHy0iC9dkMQOOcW46NWJVd86kPFER/lhI0
         2FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CBeN6iaBYdbiDey296zXVYuTe9GCmYYjkX+OLGzEQ6Y=;
        b=JpVf4MXEIdtQSjUmQPyX/8bOw8I+CqrKFy+o9u4T6BuyO71YPfVbpgzJsAld6sJ1TJ
         gvfxh07oCDxsbUv33wkMFZ1lqEj3uXfqY9TFzCkmPa4VJpePaupVp0ta9Dzj1betK1WH
         IKR4HgDknAj6vyKQPvHYo7ZmJsJ+X5CAisIni3IYRyaoNnG5Yuz0UvOcejYwDjQVImYy
         0X92kmIJxVJ3oLbUNCA7UHfijXoFQcUeA/r93i8UjZb3tqfqU9CJAzjKrjHQGf6ifVtc
         MvEW//gnRO4+A3I+UmNQ9gsVYyHBGVBjRI72dkZOiZ6F8l4y5u6/h8WjNxIvxsXfTfDs
         C2nw==
X-Gm-Message-State: ACrzQf2BSW5piidHsPgYB5oBWTa1Sq+kq+jc/WWI7C7zVS1Sgdz90b/c
        mUOzkoXuFvVcIq9h7PiQSsG1xf9uXXScFrU34FGq0DBc
X-Google-Smtp-Source: AMsMyM7doVuIN7gr6Hp9Y2JGpmAvZ+qnLeD9CrKwzo/4JzOtwBcWhiltBGX2rH8BV6sFH8g1Q5dQ9j7xEg75F1qhBSg=
X-Received: by 2002:aa7:c601:0:b0:458:1e8b:ada0 with SMTP id
 h1-20020aa7c601000000b004581e8bada0mr12068309edq.338.1664639134479; Sat, 01
 Oct 2022 08:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <202210012320.xRNBamDx-lkp@intel.com>
In-Reply-To: <202210012320.xRNBamDx-lkp@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Oct 2022 08:45:23 -0700
Message-ID: <CAADnVQL9S5gwykdxQoGjOzuAewpLMX+sgZ0RVo7yD4e4vumb4w@mail.gmail.com>
Subject: Re: [bpf-next:master 7/11] htmldocs: Documentation/bpf/linux-notes.rst:55:
 WARNING: Malformed table.
To:     kernel test robot <lkp@intel.com>
Cc:     Dave Thaler <dthaler@microsoft.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

please take a look.
Thanks!

On Sat, Oct 1, 2022 at 8:28 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> head:   5f388bba7acbdb097a9e7ed932a39b40f7eb2acf
> commit: 6166da0a02cde26c065692d0c05eb685178fee75 [7/11] bpf, docs: Move legacy packet instructions to a separate file
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=6166da0a02cde26c065692d0c05eb685178fee75
>         git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>         git fetch --no-tags bpf-next master
>         git checkout 6166da0a02cde26c065692d0c05eb685178fee75
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> Documentation/bpf/linux-notes.rst:55: WARNING: Malformed table.
> >> Documentation/bpf/linux-notes.rst:58: WARNING: Blank line required after table.
> >> Documentation/bpf/linux-notes.rst: WARNING: document isn't included in any toctree
>
> vim +55 Documentation/bpf/linux-notes.rst
>
>     54
>   > 55  ======  ====  ===================================================  =============
>     56  opcode  imm   description                                          reference
>     57  ======  ====  ===================================================  =============
>   > 58  0x20    any   dst = ntohl(\*(uint32_t \*)(R6->data + imm))         `Legacy BPF Packet access instructions`_
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
