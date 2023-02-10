Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6726916A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjBJCVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBJCVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3546E9B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FD661C4E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C93AC433A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675995674;
        bh=1sP9jIJG0wrDjgbsqpT8bzkNcwlkMcsPC4S53XGw+Rc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/x73bkuOff0OY6Djb8YHZ5L7eFhvSbnNCzfbvNBhFg17ypFAk1Nsd2mQy4oR+lYM
         Q9r5xKiMu9etaUhdb0buJX5AbDkPE5TAB0NxdedoYPnEzF8eD9BgWojzsUj2uOq/0c
         JrZkKtk718K4VB6ZY/sT9rz0GOycLQDY9oMws0kcqepcyXGvOuhYyQXZsoZGVN86J+
         vwf5HIutSUM8Rhiza/t02QlJg/Cx5ECTTfPUDha14/XK5F6BiFaY7QhP+HnEGHG/Xp
         UHDNBUlPiTpmKo5NrWxdldxllCiCfdG0xCZuFTEhocmtsIVgHX1FKKlSxZqnK98prB
         csJJFiTOmRhKQ==
Received: by mail-ej1-f48.google.com with SMTP id rp23so12195634ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:21:14 -0800 (PST)
X-Gm-Message-State: AO0yUKXZGU4Db/LouQwI6lHnMlfti6xSFLX0pHUKTBPEhXSjJzn9UC9G
        oInGgIOEhH0b3xCkIDfZDJePxD3jzuHp3xw/30Y=
X-Google-Smtp-Source: AK7set8vylhz9lR91yV2S2Hpd3P3Rgjf63corR1vcLr1xdLjADy1ro8ZE2MuVO6XDXtHt3IIE70i5Icd0pPSYlD0jY4=
X-Received: by 2002:a17:906:3e04:b0:884:c19c:7c6 with SMTP id
 k4-20020a1709063e0400b00884c19c07c6mr2687701eji.120.1675995672658; Thu, 09
 Feb 2023 18:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N> <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N> <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <8154e7e618d84e298bad1dc95f26c000@AcuMS.aculab.com> <CAJF2gTQGxxgusRgPdNaw4-d+o0a4vefUj7PNpZuym6VKQC4dhw@mail.gmail.com>
 <CAJF2gTQ61BHUgtPaaH49Srp6Y5NGD4Bvdvw1GF57owuw-h-+nQ@mail.gmail.com> <Y+TC037Erd+bsrB7@FVFF77S0Q05N>
In-Reply-To: <Y+TC037Erd+bsrB7@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Feb 2023 10:21:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSL0c2GH0Jy+hrhFsswq3BsoqyC81harC_K=9TspS8eaQ@mail.gmail.com>
Message-ID: <CAJF2gTSL0c2GH0Jy+hrhFsswq3BsoqyC81harC_K=9TspS8eaQ@mail.gmail.com>
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     David Laight <david.laight@aculab.com>,
        Evgenii Shatokhin <e.shatokhin@yadro.com>,
        "suagrfillet@gmail.com" <suagrfillet@gmail.com>,
        "andy.chiu@sifive.com" <andy.chiu@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 5:54 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Feb 09, 2023 at 09:59:33AM +0800, Guo Ren wrote:
> > On Thu, Feb 9, 2023 at 9:51 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Thu, Feb 9, 2023 at 6:29 AM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > > >   # Note: aligned to 8 bytes
> > > > > >   addr-08               // Literal (first 32-bits)      // patched to ops ptr
> > > > > >   addr-04               // Literal (last 32-bits)       // patched to ops ptr
> > > > > >   addr+00       func:   mv      t0, ra
> > > > > We needn't "mv t0, ra" here because our "jalr" could work with t0 and
> > > > > won't affect ra. Let's do it in the trampoline code, and then we can
> > > > > save another word here.
> > > > > >   addr+04               auipc   t1, ftrace_caller
> > > > > >   addr+08               jalr    ftrace_caller(t1)
> > > >
> > > > Is that some kind of 'load high' and 'add offset' pair?
> > > Yes.
> > >
> > > > I guess 64bit kernels guarantee to put all module code
> > > > within +-2G of the main kernel?
> > > Yes, 32-bit is enough. So we only need one 32-bit literal size for the
> > > current rv64, just like CONFIG_32BIT.
> > We need kernel_addr_base + this 32-bit Literal.
> >
> > @Mark Rutland
> > What do you think the idea about reducing one more 32-bit in
> > call-site? (It also sould work for arm64.)
>
> The literal pointer is for a struct ftrace_ops, which is data, not code.
>
> An ftrace_ops can be allocated from anywhere (e.g. core kernel data, module
> data, linear map, vmalloc space), and so is not guaranteed to be within 2GiB of
> all code. The literal needs to be able to address the entire kernel addresss
> range, and since it can be modified concurrently (with PREEMPT and not using
> stop_machine()) it needs to be possible to read/write atomically. So
> practically speaking it needs to be the native pointer size (i.e. 64-bit on a
> 64-bit kernel).
Got it, thx. Let's use an absolute pointer as the beginning.

>
> Other schemes for compressing that (e.g. using an integer into an array of
> pointers) is possible, but uses more memory and gets more complicated for
> concurrent manipulation, so I would strongly recommend keeping this simple and
> using a native pointer size here.
>
> > > > > Here is the call-site:
> > > > >    # Note: aligned to 8 bytes
> > > > >    addr-08               // Literal (first 32-bits)      // patched to ops ptr
> > > > >    addr-04               // Literal (last 32-bits)       // patched to ops ptr
> > > > >    addr+00               auipc   t0, ftrace_caller
> > > > >    addr+04               jalr    ftrace_caller(t0)
> > > >
> > > > Could you even do something like:
> > > >         addr-n  call ftrace-function
> > > >         addr-n+x        literals
> > > >         addr+0  nop or jmp addr-n
> > > >         addr+4  function_code
> > > Yours cost one more instruction, right?
> > >          addr-12  auipc
> > >          addr-8    jalr
> > >          addr-4    // Literal (32-bits)
> > >          addr+0   nop or jmp addr-n // one more?
> > >          addr+4   function_code
>
> Placing instructions before the entry point is going to confuse symbol
> resolution and unwind code, so I would not recommend that. It also means the
> trampoline will need to re-adjust the return address back into the function,
> but that is relatively simple.
>
> I also think that this is micro-optimizing. The AUPIC *should* be cheap, so
> executing that unconditionally should be fine. I think the form that Guo
> suggested with AUIPC + {JALR || NOP} in the function (and 64-bits reserved
> immediately bfore the function) is the way to go, so long as that does the
> right thing with ra.
>
> Thanks,
> Mark.



-- 
Best Regards
 Guo Ren
