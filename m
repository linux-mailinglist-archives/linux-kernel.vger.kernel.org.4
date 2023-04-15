Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFD6E2FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDOIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDOIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:31:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E5A2112
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:31:19 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 98DD53F452
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681547476;
        bh=Wx0/JegDs5ydht80NXH/UwxmxbYUu5hxKxJx5a7E6kw=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=eS2Jyuw91vl0UWu3RmVp5S2AwVLtp88BAmL7/iQGH6uN6L/8n8A87/JsQvvLLmSR1
         gGrMrpGamQGqBUguf1CkVaegjZL5a+3hT8ymFkkllVXUvcBcTJsStRNs9zZLf2gcGb
         gJOuzDrOvV6qDJV+WohEuYviBYFG7QB6Lgu5WAq3Bp3Z0DgWnhQ8PB08EZQJCRFJEG
         vAC1OhCVmrDbAjEusHuPbbMmAoY1TJn4wGJ2skro/NWkJeSadByZ3/sDkXY8kRwGtA
         COT3/GqlaJ+FfB5U0LkhkOncR6C37OB4+VgnB8DSEDaZCoknOjAvdwy9hf0OF+cMNL
         PlbPkaUVaW+5Q==
Received: by mail-ej1-f71.google.com with SMTP id ud12-20020a170907c60c00b0093c44a07ad1so7389545ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681547475; x=1684139475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0/JegDs5ydht80NXH/UwxmxbYUu5hxKxJx5a7E6kw=;
        b=OcQSGMsEUNI3qmyanLd19pkVhL/KdSm+JGUca2AdaSbV67FEpcu9dMPL76O9No9Jwa
         rzScUnSu/9GgZpytlUCE9D20iReFuAb16ZaJzoVIZA4W2yUACvhG7R67YrSGEbvDohr8
         Bml0xQxdw0xaVOm/FVnVGVAYlp4+scVn4q+n1xYym/8TrYhiedGiHaX8bnxYLid9UnxL
         9EkGoUZ2++0Z+yw/1eY46CZOZCDfzSKqxgOugKlvS3P/GDoZb2nyC6ckQn+E8GIZXARH
         GgGqJ4Rjez99XdXUn4sHxBNeafLd1AdIJnJY2raKO4t+9SErMutgvU66vHIVRoLGUe0R
         HIEA==
X-Gm-Message-State: AAQBX9c8Cm8osRHYHvEPGTds5OfgJvh0geRsPB4x2y9ykBYnpdduyrG8
        ngDjOOR1fHuqE7U/XroveL4KPmBtC6Tcjv3665AWUt7tPkY9bAAilSdHHc6R6o30d6NgB4UUCd7
        nI+PIrvz8RZNajO05unUDV/0+xnUUjjxbSDEe+SZu2w==
X-Received: by 2002:a17:907:2d1f:b0:94f:322d:909d with SMTP id gs31-20020a1709072d1f00b0094f322d909dmr9549ejc.63.1681547474682;
        Sat, 15 Apr 2023 01:31:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bD5nX03JewNoORuQdFHtYzSIEKXUwgdDNHDz4qbxSX6RiDgl4Lw29zLgKKwShLulQpqTQmQQ==
X-Received: by 2002:a17:907:2d1f:b0:94f:322d:909d with SMTP id gs31-20020a1709072d1f00b0094f322d909dmr9518ejc.63.1681547474284;
        Sat, 15 Apr 2023 01:31:14 -0700 (PDT)
Received: from localhost (host-87-18-123-182.retail.telecomitalia.it. [87.18.123.182])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709064a4a00b0094a4e970508sm3491554ejv.57.2023.04.15.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 01:31:13 -0700 (PDT)
Date:   Sat, 15 Apr 2023 10:31:13 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
Message-ID: <ZDpg0YmXpZFlvmpM@righiandr-XPS-13-7390>
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
 <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390>
 <q5rj72tmwlpzx6qgkromem5t7q6xmen52aavfr65olnuv52f3z@wzs4p3xz3635>
 <ZDl/KFLy7wOBa2tj@righiandr-XPS-13-7390>
 <CAADnVQJFxoYqBisj4w_Mm35mf3gR6YTK0QvNjQfVSjfcQK33yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJFxoYqBisj4w_Mm35mf3gR6YTK0QvNjQfVSjfcQK33yw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:15:41PM -0700, Alexei Starovoitov wrote:
> On Fri, Apr 14, 2023 at 9:28 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Fri, Apr 14, 2023 at 06:15:38PM +0200, Ilya Leoshkevich wrote:
> > > On Fri, Apr 14, 2023 at 08:15:03AM +0200, Andrea Righi wrote:
> > > > On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> > > > > On Wed, Apr 12, 2023 at 2:59 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > > > > >
> > > > > > Building bpf selftests with clang can trigger errors like the following:
> > > > > >
> > > > > >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > > > > > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
> > > > > >         s = &nlk->sk;
> > > > > >           ^ ~~~~~~~~
> > > > > > 1 error generated.
> > > > >
> > > > > I cannot reproduce this and BPF CI doesn't complain about it either.
> > > > > What kind of clang do you use?
> > > > > Some special version and build flags?
> > > >
> > > > I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special build
> > > > flag (unless Ubuntu enables some different default flags, but it
> > > > shouldn't be the case... I'll double check).
> > > >
> > > > -Andrea
> > >
> > > Hi,
> > >
> > > FWIW, I see similar errors when I don't use recent pahole.
> >
> > I'm using pahole v1.24.
> 
> I believe Ilya is correct.
> 
> struct sock___17 is likely coming from vmlinux.h
> Which means that there were errors due vmlinux build which
> caused multiple structs to be present in BTF
> and therefore bpftool generated such broken vmlinux.h
> 
> The BTF section in such vmlinux is likely much larger than normal.
> Let's get to the bottom of it instead of masking build error.
> 
> Please try pahole 1.25.

Yay! Success. Everything is working fine with pahole 1.25. Please ignore
my patch, the fix is to simply upgrade pahole.

Thanks!
-Andrea
