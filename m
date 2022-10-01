Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137BB5F1D5C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJAPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJAPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:52:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DEF61D70;
        Sat,  1 Oct 2022 08:52:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c93so664116edf.11;
        Sat, 01 Oct 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=k+3BQBwxtLJXLQ0QaDk7H6em/NpQG07RIwz+Z7aJg3c=;
        b=kwGH7DMkuKAgQTVy3bYhBwoRAkESeLKRqrCtGcFkiAqH8Sen8Rqy4KupPBZ8uWtIax
         dETgs58VorBRFHujQ+hFEUV7gZw69PsN2GDIV+tq73PnEMBEpuwIW0bl3udxOZjAkttl
         31rqmgRVwEVZ7fHZxa03RqjZefIYLXKsu3qyBPq7nmYICVBfu2TMKGMRgzV3a7CqP52+
         F5w3e1w0z4GX94BqFlJt1JYDfUyWxmqJBdGb95o3YxRZ/9/+5SGql/Wi/ajAohKp5WoM
         Y3+pgSzENHikMp8NBFpReCd0uWbx9IweXttOZ2FB/HN9ricKJy1F/cIphCkEygzhI5v0
         Ob5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k+3BQBwxtLJXLQ0QaDk7H6em/NpQG07RIwz+Z7aJg3c=;
        b=ylJG+ayUQnB1Byn+SpmFubCT+GLEj0N0HjcAwAtUvDxlBjLG7VHfMFkdzKlJERHOrD
         FyxdPnMUQFPUR3XqM1IkHrxqLEedpQa2NyCvE0kotv6OJekJAZBcA64dvfxTrHielvJv
         hqi1pEMavFca/coKK0AwGa4k/ZO6n56rIOZh3vcuXwhJxwnMdNhrS6U968ZTrRAJxhbF
         Mok3JVuZNNyICJJiNr7qoh70B+3mKzzineMvlQIqjZpUmf8oqlaBwhAQ67Coruc21qS7
         Bg2mH+DI8mrkLTrmZy9gV6xb2jGQyn41f81xtNIz7xRoK/egnELI3CYFbNkasSSUp3k8
         4I9w==
X-Gm-Message-State: ACrzQf0+AK0hId5NLWLrEpRx6YvIslfRlMkSRzSrjVrICslBat2POhdR
        oYgVtcWWXgShJ347l9OsX1B/6YqszfBtZrcDOmw=
X-Google-Smtp-Source: AMsMyM7/sAtQrtbv7/XfC2Dt29ZdACl6QsLGYU0oRF6kETV2NynKxBfUXHImlz7+ZdqeBpqPNzvcmwHWldWwvT8n3k0=
X-Received: by 2002:aa7:da03:0:b0:458:ded:29b with SMTP id r3-20020aa7da03000000b004580ded029bmr12194296eds.421.1664639572531;
 Sat, 01 Oct 2022 08:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <202210012320.xRNBamDx-lkp@intel.com> <CAADnVQL9S5gwykdxQoGjOzuAewpLMX+sgZ0RVo7yD4e4vumb4w@mail.gmail.com>
In-Reply-To: <CAADnVQL9S5gwykdxQoGjOzuAewpLMX+sgZ0RVo7yD4e4vumb4w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 1 Oct 2022 08:52:41 -0700
Message-ID: <CAADnVQJNK8d+=v2BTEdbp=x7x0Yk6XoyuWxuzOee_cYoSNpvng@mail.gmail.com>
Subject: Re: [bpf-next:master 7/11] htmldocs: Documentation/bpf/linux-notes.rst:55:
 WARNING: Malformed table.
To:     kernel test robot <lkp@intel.com>
Cc:     Dave Thaler <dthaler@microsoft.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Sat, Oct 1, 2022 at 8:45 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Dave,
>
> please take a look.
> Thanks!

Pushed a fix to delete the broken table.
It shouldn't have been part of the commit that moves
legacy definition into its own file.

> On Sat, Oct 1, 2022 at 8:28 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > head:   5f388bba7acbdb097a9e7ed932a39b40f7eb2acf
> > commit: 6166da0a02cde26c065692d0c05eb685178fee75 [7/11] bpf, docs: Move legacy packet instructions to a separate file
> > reproduce:
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=6166da0a02cde26c065692d0c05eb685178fee75
> >         git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >         git fetch --no-tags bpf-next master
> >         git checkout 6166da0a02cde26c065692d0c05eb685178fee75
> >         make menuconfig
> >         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
> >         make htmldocs
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> Documentation/bpf/linux-notes.rst:55: WARNING: Malformed table.
> > >> Documentation/bpf/linux-notes.rst:58: WARNING: Blank line required after table.
> > >> Documentation/bpf/linux-notes.rst: WARNING: document isn't included in any toctree
> >
> > vim +55 Documentation/bpf/linux-notes.rst
> >
> >     54
> >   > 55  ======  ====  ===================================================  =============
> >     56  opcode  imm   description                                          reference
> >     57  ======  ====  ===================================================  =============
> >   > 58  0x20    any   dst = ntohl(\*(uint32_t \*)(R6->data + imm))         `Legacy BPF Packet access instructions`_
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
