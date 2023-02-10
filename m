Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009E6916A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBJCSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjBJCSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:18:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E61CDE9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A71AC61C12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE3C4339E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675995526;
        bh=f41SyKetgyTJk5AoqYDZA6qemHFr7tnVd+NQEEf/jhw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DOG5qwcJg0TujMpmdgcev0f+2tdrfCilTG2wuskQVb74UD5klnBmLZiQhz0VOe4Si
         vvSfB9oZzkKciOBWK+etmPI7Imlh95Re1G9kGBY+jrYv0/KDPJ5cF3bNsOnH9FAA3G
         TvqFL0Q945S/mrqFyAL1zZ80Q2dXdyQgs1m8UNzW6JRKIUVSr7HF7yv946fQAjjw8w
         i+JrCRR675ipxNacq8+H/dmlVNKyXQjWUBmzAcxBRfC6+LFCzkyzjf2+Q37nUPaWrd
         afJ43eLGlqHP2bmASZiNHMz/KlW6TJjq6fgmxlB1BIqv1MM6SzucGg2LPWXBEb9lsP
         qlUvrj7xB+zAQ==
Received: by mail-ej1-f49.google.com with SMTP id p26so12144577ejx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 18:18:45 -0800 (PST)
X-Gm-Message-State: AO0yUKWdx2CUaoRacdUN11dG0YtkpTBx849gVlz+ejU1t7vDKCXLP2Qj
        iBHQYB1krJsNn5qr+DMfpm/Wq4THmGNuVrOJZ7w=
X-Google-Smtp-Source: AK7set8TcWdcPxU1RclSrshoCn2NZql4i4WcAJAAwP6sVzZJ83BCJxACCuKYPTvQ6ICKOUSbEQUk7mjOIYYvMYnd9lk=
X-Received: by 2002:a17:906:6b1a:b0:879:e5ab:94c7 with SMTP id
 q26-20020a1709066b1a00b00879e5ab94c7mr951800ejr.8.1675995524338; Thu, 09 Feb
 2023 18:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N> <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N> <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <Y+O1qY453BnhqgQZ@FVFF77S0Q05N.cambridge.arm.com> <CAJF2gTT_aMBx3mPnzWWqj6uGM75yT_62x+_wZ4HkWd7BqEzvug@mail.gmail.com>
 <90ad3009049e4d39a952b6e4c170740b@AcuMS.aculab.com>
In-Reply-To: <90ad3009049e4d39a952b6e4c170740b@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Feb 2023 10:18:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTmPfjm2_ds_MU3NmA1+qPBdvW+0x9pLhio63ZEGZc3HA@mail.gmail.com>
Message-ID: <CAJF2gTTmPfjm2_ds_MU3NmA1+qPBdvW+0x9pLhio63ZEGZc3HA@mail.gmail.com>
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
To:     David Laight <David.Laight@aculab.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 6:47 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Guo Ren
> > Sent: 09 February 2023 01:31
> ...
> > > I'm a bit confused there; I thought that the `symbol(reg)` addressing mode was
> > > generating additional bits that the AUPIC didn't -- have I got that wrong?
> > >
> > > What specifies which register the JALR will write the link address to?
> >
> > According to the spec, auipc t1,0x0 should write PC + 0x0<<12 (which
> > is equal to PC) to t1 and then jalr t0, (t0)0 jumps to the address
> > stored in t0 + 0x0 and stores the return address to t0.
> >
> > That means auipc defines xxx << 12 bits, jalr defines lowest 12 bits.
>
> ...
> > What I want to point out:
> > If we keep "auipc (addr+00)" fixed, we could use the different
> > trampolines at "jalr (addr+0x4)" (All of them must be in one 2k
> > aligned area).
>
> I looked up auipc:
> "AUIPC is used to build PC-relative addresses and uses the U-type format.
> AUIPC forms a 32-bit offset from the U-immediate, filling in the lowest
> 12 bits with zeros, adds this offset to the address of the AUIPC instruction,
> then places the result in rd."
>
> So it generates 'pc + (val << 12)'.
> And the jalr then adds in a 12bit offset.
Correct!

>
> I think that means that if you have two trampolines you might need
> to change both instructions even if the two trampolines are actually
> adjacent instructions.
> It is the distance from the call site that mustn't cross a 2k
> boundary - not the absolute address of the trampoline itself.
We could have multiple adjacent trampolines, which must be kept in the
same 2k boundary area. Then we needn't change auipc part when
modifying.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
 Guo Ren
