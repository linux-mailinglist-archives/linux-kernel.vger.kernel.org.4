Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1A6902F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBIJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546425940
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E4A61953
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E64C433A0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675933897;
        bh=rUqnl2yhgg/wSh6GmALm2a+1dBTMU8RKuIViEGLb7cg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rjXcILcrjp8XTkk6APFP6VS9zYkrvh5Zyu1rMTYhweavvwRYgaQkAOBzjLPmn8DJX
         pIWwXN2OSkeR7R33hzjvtKOqw/kKKEpRf2JTXkEojhFJ1iG6CLw6nOCy5YnmSPBevK
         +XsDcAm+Xw1U3wa7WnQ/u8GGL6fAiJ3KHrHw+gVNm0QMoHrE+K7EoDWqx7Ard1jKqk
         ab4CqeDFPYghFbIqv9t3rblWBYQf2h+7IlLisATFxh8EuwkGjAfcjiHaGv/K/JglrW
         vcVDBf+1W90zIqwhAZDgQJCae1axNi4GAU+o9BCZmQzBzQsgQZpYAaFfn/2laHWTzJ
         lsE4XIcBixwnA==
Received: by mail-ed1-f48.google.com with SMTP id da9so1495308edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:11:37 -0800 (PST)
X-Gm-Message-State: AO0yUKVBxvMter5s2Z6IsJapxLfkOa+KqvLHub3tdXmDlQ7SRtoUQUZP
        eS4LBpapeZ19P+2z5lX+hRYNuC6yvsQ6RYrhjzw=
X-Google-Smtp-Source: AK7set+2zd+izyEqpj97HFiy856DccBJtPH7FTm1sSwGv31V2vQsWyM66vU6jjahWs1vauH5/qlsb6uSqOnq3gA7zik=
X-Received: by 2002:a50:99c3:0:b0:49d:ec5d:28b1 with SMTP id
 n3-20020a5099c3000000b0049dec5d28b1mr2400808edb.7.1675933896149; Thu, 09 Feb
 2023 01:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N> <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N> <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <8154e7e618d84e298bad1dc95f26c000@AcuMS.aculab.com> <CAJF2gTQGxxgusRgPdNaw4-d+o0a4vefUj7PNpZuym6VKQC4dhw@mail.gmail.com>
 <f00256bcbe114669acca1b0105cefb99@AcuMS.aculab.com>
In-Reply-To: <f00256bcbe114669acca1b0105cefb99@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 9 Feb 2023 17:11:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQuEiBMg=2KQXb3UZNaH_AdwCHNyNe07dbPd7JDGGExzg@mail.gmail.com>
Message-ID: <CAJF2gTQuEiBMg=2KQXb3UZNaH_AdwCHNyNe07dbPd7JDGGExzg@mail.gmail.com>
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

On Thu, Feb 9, 2023 at 5:00 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Guo Ren
> > Sent: 09 February 2023 01:51
> ...
> > Yours cost one more instruction, right?
> >          addr-12  auipc
> >          addr-8    jalr
> >          addr-4    // Literal (32-bits)
> >          addr+0   nop or jmp addr-n // one more?
> >          addr+4   function_code
>
> Yes, it is 4 bytes larger but there is one less
> instruction executed (only one nop) when ftrace is disabled.
> That probably matters more than anything in the ftrace
> 'prologue' code.
I've got your point, thx. I would consider your advice and make the tradeoff.

>
> I also suspect that you can use a 32bit integer as
> a table index in 64bit mode to save a word there.
Yes, good idea. I've asked Mark Rutland. Let's wait for his feedback.
It also helps arm64.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
 Guo Ren
