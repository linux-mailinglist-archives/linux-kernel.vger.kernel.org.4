Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0104773856F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjFUNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjFUNjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:39:12 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537A1981
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:39:10 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-78f36f37e36so2108238241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687354749; x=1689946749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HkLY4acLLjF0A3xk0LZgmQ+TO1EiwpzKoMSwjPDVWZc=;
        b=k/88j7JjShr9vImgDPEUIWiHbk24HJrF3XhtdRJTjNVM+TtI3njFjpQ8zzVD/yZI3V
         5Ljhgo6HfkbhkkzX8KzGpRSb45sYiox9wHY7EIePx8JcsbH7g+JKP4Zk1ML7BAGCD2Ki
         tTjzMbXKxqUSUfoMn9qmnnES1ZHHY55rFpuLzKit8v3J4W8rKuRtBulpsIxZ6SCQ3Ik1
         jfsT2oPw+Kqghonzvkzi+2jrtF87eaEXqdti3NnSX+UhZ2PO4L0COsDd5o6cuONbwjrp
         KETQLWsBR3fxDG8eNYeM2gua+sQXhtl1O6fFITE53Ph84DpuczuByFPKrMuakgiorUWz
         LMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354749; x=1689946749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkLY4acLLjF0A3xk0LZgmQ+TO1EiwpzKoMSwjPDVWZc=;
        b=b3CDZ17ldrnB9mKrpi1vC1JHHLtbg6nv7G5f4wpHIG1wSFKW58kCzOm4sCBtTv9VO8
         n46TADhMdNRj4KQy+wuieWjE9lO16AE5IgJgG13OjjtkAomvu5HwXsZa2ylV0bz6GV7C
         fRqFlAYey6NfBeSOws3lYObg6VKJFxLkvYXakCmjdnmHW0ee4Pj5SRpVvIgOJph0/TjO
         dKyuWu+O5e0LzatGuZ38rHghehhMe93pY12w6r8/ZuY5fttO+bb17ZLPshMpg7giLN1J
         8ucyNPx9jD2yndP5tA0jrHrMCgmtD2E5hF5Xw81M8ka1Q0ywzmqRGf18FC/wjl9AhtfX
         kcGg==
X-Gm-Message-State: AC+VfDyZTj3E1u+t6aKcXQklPFeyx6J/pUQWEjxpZGBHc4FQx062skTA
        dDtJQqgciRfSIy45Gze2o/KwHnhYAxbJuIH7UJWLPA==
X-Google-Smtp-Source: ACHHUZ7fcrBNIO3CGgjLEKdIkYbKMTvL7QMNQqJfTkKqwlHIaMaK7I3JdmLhKFbk6WgAJIn79mGez/9/1yvhNajnKCQ=
X-Received: by 2002:a05:6102:2f8:b0:440:a341:b45b with SMTP id
 j24-20020a05610202f800b00440a341b45bmr5884538vsj.10.1687354748953; Wed, 21
 Jun 2023 06:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuifLivwhCh33kedtpU=6zUpTQ_uSkESyzdRKYp8WbTFQ@mail.gmail.com>
 <ZJLzsWsIPD57pDgc@FVFF77S0Q05N>
In-Reply-To: <ZJLzsWsIPD57pDgc@FVFF77S0Q05N>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jun 2023 19:08:57 +0530
Message-ID: <CA+G9fYvwriD8X+kmDx35PavSv-youSUmYTuYTfQ4oBWnZzVRUQ@mail.gmail.com>
Subject: Re: next: Rpi4: Unexpected kernel BRK exception at EL1
To:     Mark Rutland <mark.rutland@arm.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 21, 2023 at 06:06:51PM +0530, Naresh Kamboju wrote:
> > Following boot warnings and crashes noticed on arm64 Rpi4 device running
> > Linux next-20230621 kernel.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > boot log:
> >
> > [   22.331748] Kernel text patching generated an invalid instruction
> > at 0xffff8000835d6580!
> > [   22.340579] Unexpected kernel BRK exception at EL1
> > [   22.346141] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
>
> This indicates execution of AARCH64_BREAK_FAULT.

I see kernel panic with kselftest merge configs on Juno-r2 and Rpi4.

>
> That could be from dodgy arguments to aarch64_insn_gen_*(), or elsewhere, and
> given this is in the networking code I suspect this'll be related to BPF.
>
> Looking at next-20230621 I see commit:
>
>   49703aa2adfaff28 ("bpf, arm64: use bpf_jit_binary_pack_alloc")
>
> ... which changed the way BPF allocates memory, and has code that pads memory
> with a bunch of AARCH64_BREAK_FAULT, so it looks like that *might* be related.
>
> Are you able to bisect this?

I have not started bisection on this issue yet.
Let me give it a try.

>
> In the mean time, I've Cc'd the relevant BPF people to give them a heads-up.

Thanks.

Extra information from boot failures.
This is always reproducible on Juno-r2 and Rpi4 devices.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot crash log:
[    3.605232] Kernel text patching generated an invalid instruction
at bpf_prog_99a0cd861b84ee07___loader.prog+0x0/0x728!
[    3.616052] Unexpected kernel BRK exception at EL1
[    3.620849] Internal error: BRK handler: 00000000f2000100 [#1] PREEMPT SMP
[    3.627736] Modules linked in:
[    3.630796] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
6.4.0-rc7-next-20230621 #1
[    3.638140] hub 1-1:1.0: USB hub found
[    3.638206] Hardware name: ARM Juno development board (r2) (DT)
[    3.638210] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.642431] hub 1-1:1.0: 4 ports detected
[    3.647879] pc : bpf_prog_99a0cd861b84ee07___loader.prog+0x0/0x728
[    3.647891] lr : kern_sys_bpf+0x130/0x218
[    3.669061] sp : ffff80008391bc10
[    3.672376] x29: ffff80008391bc10 x28: ffff8000826e70d8 x27: ffff800082450110
[    3.679533] x26: ffff8000820ed948 x25: ffff800082427b10 x24: 0000000000000289
[    3.686687] x23: ffff000800acfa00 x22: ffff8000837f8000 x21: ffff000823dbc240
[    3.693841] x20: ffff8000839b1000 x19: ffff80008391bca8 x18: 000000001d03406d
[    3.700995] x17: ffff800080464204 x16: ffff8000804640b4 x15: ffff8000803f8af0
[    3.708149] x14: ffff8000803f88f8 x13: ffff800081717720 x12: ffff8000824514b4
[    3.715302] x11: ffff800080015788 x10: ffff800082470304 x9 : ffff8000800f3338
[    3.722456] x8 : ffff80008391bcf8 x7 : 0000000000000000 x6 : 0000000000000001
[    3.729609] x5 : 0000000000000001 x4 : ffff8000831f0000 x3 : ffff8008fc63d000
[    3.736763] x2 : ffff800083b6d88c x1 : ffff8000839b1048 x0 : ffff000823dbc240
[    3.743917] Call trace:
[    3.746362]  bpf_prog_99a0cd861b84ee07___loader.prog+0x0/0x728
[    3.752210]  bpf_load_and_run.constprop.0+0x120/0x1d8
[    3.757270]  load+0xf4/0x278
[    3.760159]  do_one_initcall+0x50/0x2f0
[    3.764001]  kernel_init_freeable+0x224/0x438
[    3.768368]  kernel_init+0x30/0x200
[    3.771862]  ret_from_fork+0x10/0x20
[    3.775447] Code: d4202000 00000780 d4202000 d4202000 (910003c9)
[    3.781550] ---[ end trace 0000000000000000 ]---
[    3.786172] note: swapper/0[1] exited with irqs disabled
[    3.791526] note: swapper/0[1] exited with preempt_count 1
[    3.797043] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    3.804711] SMP: stopping secondary CPUs
[    3.808843] Kernel Offset: disabled
[    3.812331] CPU features: 0x40000106,1e010000,0000421b
[    3.817476] Memory Limit: none
[    3.820536] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

Links:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701148/suite/log-parser-test/tests/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701148/suite/log-parser-test/test/check-kernel-panic/log
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17701148/suite/log-parser-test/test/check-kernel-panic/details/


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 15e71592dbae49a674429c618a10401d7f992ac3
  git_describe: next-20230621
  kernel_version: 6.4.0-rc7
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia3YDkqaoV6ztyqdW/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/lkft/builds/2RVAA4lj35ia3YDkqaoV6ztyqdW/
  toolchain: gcc-11
  build_name: gcc-11-lkftconfig-kselftest


--
Linaro LKFT
https://lkft.linaro.org
