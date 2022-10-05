Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1ED5F5724
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJEPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:10:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673EF6DFB0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 08:10:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so2030139pjo.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PvaSCkaPGAxkZorgrCwTUknSyqZlm4KrB/Urh29jNvQ=;
        b=O6XKHwdHXMLi59BL0KLLa1Ow02XVPqPDii7ceVObg8+/lzU9bep8SpuUWf/P6G1kZD
         usQ9qOKNqlGGZIsPv8GPzXNpnmLrIksKCuH8b/gqWT7Fkf9J9AYYooaxWnAxaXP65vV9
         OmnXKvE5sknkQcFtvXLXSFo5i1xfpbBQmXN8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PvaSCkaPGAxkZorgrCwTUknSyqZlm4KrB/Urh29jNvQ=;
        b=kQdGWx9FulYkCJ8LQHbbKS9CteoYJ9IJKnNN0qSKRILMY6KjJTaMIcHDhT6+2JDc4t
         za9RHhqugLLgHhRbSkNLw+3cukofgUZXaeq/sPV9JbsosAaoRGVF4f17Kk79TFQM4hz7
         jiy2eYScEU8UiJDAz2vg0hhBaquYH0i5ow8NcVYOo8FFrqaNaZZRPl3R0JAMzJqPhKBh
         1E0SwccRYXB0Gr5sfXzBGIXX5efLZkEjlpbequKhcVBpp2EVIXI92X++bpSs8jo4hUyw
         xcWzdTy990LhFlChMsBewZuBnYkAJXJY7w9gS4me+u9690PDAw6k4yXH2NMfJLBQyjX+
         iclw==
X-Gm-Message-State: ACrzQf2pLKoT9xgwzxWHh4D3cIpRoBKdGsBPyeCaITMdm0xk/zpEDSvU
        1gzTYJV5UJkg0Niv5aQcGZAKlt53H9BTO1O4ExA71xwv22kgsw==
X-Google-Smtp-Source: AMsMyM5hifwOy6yqLAoPpdTkHGIwjL5zM2ptwqjbIimKXrl0RtaG91VVG9qMju5GQIqDbtANSizC2iI5k5jpUGDchRI=
X-Received: by 2002:a17:90b:4c8b:b0:203:5db5:8b71 with SMTP id
 my11-20020a17090b4c8b00b002035db58b71mr210459pjb.51.1664982644827; Wed, 05
 Oct 2022 08:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net> <YzG51Jyd5zhvygtK@arm.com>
 <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N> <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N> <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com> <20221005110707.55bd9354@gandalf.local.home>
In-Reply-To: <20221005110707.55bd9354@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 5 Oct 2022 17:10:33 +0200
Message-ID: <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Oct 2022 22:54:15 +0800
> Xu Kuohai <xukuohai@huawei.com> wrote:
>
> > 1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'
> >
> > # dd if=/dev/zero of=/dev/null count=1000000
> > 1000000+0 records in
> > 1000000+0 records out
> > 512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s
> >
> >
> > 1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'
> >
> > # dd if=/dev/zero of=/dev/null count=1000000
> > 1000000+0 records in
> > 1000000+0 records out
> > 512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s

Thanks for the measurements Xu!

> Can you show the implementation of the indirect call you used?

Xu used my development branch here
https://github.com/FlorentRevest/linux/commits/fprobe-min-args

As it stands, the performance impact of the fprobe based
implementation would be too high for us. I wonder how much Mark's idea
here https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops
would help but it doesn't work right now.
