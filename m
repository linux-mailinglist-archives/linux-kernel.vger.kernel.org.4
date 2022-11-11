Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C96260DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiKKSIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKKSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:08:17 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8BC3F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:08:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m15so2890175ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzildjphP78ORjqAex871mDD4z0gFMjDqjeT7JThqmk=;
        b=bTY4ZJjdJeBr5z83RMWnY6KSL53pFLmQxcn2lzv1VePZcPP3+Q7siffhCHeRs0Qo5I
         +pxih/VyUkFufHu27A+XyxBp/kAywZt37Z0yrZAxMdwUxMYvhvjq6/gFY2qbv4Zvyv75
         Y5xiPgk6gHIPHkPPAmHa6C0NSaBeUzzmWFSSWOc0AfHHi0RQzjSMgA4tbb1LpmAJihwh
         lznv/qtrdoEDJvOOtZvo/zL9uMd0poCQAsQgO9QHxrESet2EEyR1XaAlistizHn3itPl
         tXfQqY9ukvhPR+oxzRSpQ9S+6hOEaBCHXQKBLlE/jp4woBULUtodqpA7qPpz7TdjijxS
         pQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzildjphP78ORjqAex871mDD4z0gFMjDqjeT7JThqmk=;
        b=q8YLWLRoGhO2kZFlB54YOky5Kfuf1esptuN1NLW47IjSEsccIq2wlC5+jIG7mBo8T0
         0OIQle23bqCkkzjs5rI8Xd9bNjNoUV+HlCaF87q0C8k7DgBVM5SQ6o80cWex096affpD
         r++PcBn+4B9Gt97Ie+X4KP3gjn94tl3vW0WxqtVxGJAGRn7lIg5zgbCZRRVZGZMsxVfP
         6OyV1hIx4TjWwmm4MUyk8gRrP9Zj9L1vXCbLK6R2TO9E81y9pYDqgi+wOo3uBSvgu4Hy
         tQytMxiJDuv81wmCbKKIZskXbPh/0auzGWZFNjC+JTACknA9fTH/a9+GZxAyuUw+8iqV
         FD8A==
X-Gm-Message-State: ANoB5pnpm+i1Yp9lT6rweAF6T7THUBd2U+6TBg3rObQM13+HBqO0H5bb
        vEiYyUAofdGHgNEjOE3nINWNshj4MxXkEcIbvWkLLQ==
X-Google-Smtp-Source: AA0mqf5izvO9kURPgMasnpvMX0+BaAVkvpmXYkYa08zM1CfJrEERiMcUyYRdbWb8KzWlUypbRL/NkuMvNMDLS5ckUAY=
X-Received: by 2002:a05:6e02:dce:b0:300:d39b:4d03 with SMTP id
 l14-20020a056e020dce00b00300d39b4d03mr1662477ilj.137.1668190094948; Fri, 11
 Nov 2022 10:08:14 -0800 (PST)
MIME-Version: 1.0
References: <tencent_29D7ABD1744417031AA1B52C914B61158E07@qq.com>
 <Y26FgIJLR3nVKjcb@google.com> <Y26MSS2twSskZ5J2@lore-desk>
In-Reply-To: <Y26MSS2twSskZ5J2@lore-desk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Nov 2022 10:08:04 -0800
Message-ID: <CAKH8qBvxZBX7_GQYQzSrZ5j=P3rViyqNq3V3oo5CtEMR9BQepA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error undeclared identifier 'NF_NAT_MANIP_SRC'
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Rong Tao <rtoax@foxmail.com>, ast@kernel.org,
        Rong Tao <rongtao@cestc.cn>, kernel test robot <lkp@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Xu <dxu@dxuuu.xyz>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 9:54 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On 11/11, Rong Tao wrote:
> > > From: Rong Tao <rongtao@cestc.cn>
> >
> > > commit 472caa69183f("netfilter: nat: un-export nf_nat_used_tuple")
> > > introduce NF_NAT_MANIP_SRC/DST enum in include/net/netfilter/nf_nat.h,
> > > and commit b06b45e82b59("selftests/bpf: add tests for bpf_ct_set_nat_info
> > > kfunc") use NF_NAT_MANIP_SRC/DST in test_bpf_nf.c. We copy enum
> > > nf_nat_manip_type to test_bpf_nf.c fix this error.
> >
> > > How to reproduce the error:
> >
> > >      $ make -C tools/testing/selftests/bpf/
> > >      ...
> > >        CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> > >        error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> > >              bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> > >                                                             ^
> > >        error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> > >              bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> > >                                                             ^
> > >      2 errors generated.
> >
> > $ grep NF_NAT_MANIP_SRC
> > ./tools/testing/selftests/bpf/tools/include/vmlinux.h
> >         NF_NAT_MANIP_SRC = 0,
> >
> > Doesn't look like your kernel config compiles netfilter nat modules?
>
> yes, in bpf kself-test config (tools/testing/selftests/bpf/config) nf_nat
> is compiled as built-in. This issue occurs just if it is compiled as module.

Right, but if we unconditionally define this enum, I think you'll
break the case where it's compiled as a built-in?
Since at least in my vmlinux.h I have all the defines and this test
includes vmlinux.h...

> Regards,
> Lorenzo
>
> >
> > > Link: https://lore.kernel.org/lkml/202210280447.STsT1gvq-lkp@intel.com/
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > > ---
> > >   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> >
> > > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > index 227e85e85dda..307ca166ff34 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> > > @@ -3,6 +3,11 @@
> > >   #include <bpf/bpf_helpers.h>
> > >   #include <bpf/bpf_endian.h>
> >
> > > +enum nf_nat_manip_type {
> > > +   NF_NAT_MANIP_SRC,
> > > +   NF_NAT_MANIP_DST
> > > +};
> > > +
> > >   #define EAFNOSUPPORT 97
> > >   #define EPROTO 71
> > >   #define ENONET 64
> > > --
> > > 2.31.1
> >
