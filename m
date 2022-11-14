Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBC627D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiKNLyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiKNLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:54:32 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC82A27B24;
        Mon, 14 Nov 2022 03:50:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d20so9814169plr.10;
        Mon, 14 Nov 2022 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxLw92CxNmXV7lUHwwNNh3pTOe6v+PoNrvkBfjZKYfc=;
        b=KRZeS7F7eWOmhgnb4D7Y4+WqRwo8eLME20CHDJIBZlfXI6X4le5Kor2WIa1YVw4LM7
         znrdNlx3rbhxecE9Q883iLc6fL9Jr+Hr2//jJdJGgVusXzXvJ+FyKKsiwr28hy8bsi1l
         fqEM4oXGaIGnNPmocA7h0jot+GMhRXl9oF8B0Ny8L4UsLANYRDZG1D6LiaeAxeDvTdQd
         nIoaI+6GXagI3hJ9Po9/vsKKQ7/5LJFeCdRQFWklw2UvLYZJT5hkxFmgiHe2s/DDRCGk
         HZUXEwWGqYqOjM8TFuceqGQPQ5D1yYzFxPsMMqX89I7raHubUCEHlPV4W3DJG8nz5wrR
         fALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxLw92CxNmXV7lUHwwNNh3pTOe6v+PoNrvkBfjZKYfc=;
        b=capqamEk5O1b9JbAKwBlT2IjLcLe0RtSGQX3XxPEtBEIk+/unKtJVGO3etsyBraOsG
         LLjVq8GzvL2o+rZ0b+qIKYsEckVh2CuvQ7mFYJFxd8vzvIR0xukLWbgLBJJv6cM+1Pw3
         Z15YbpYpHNBhucoy/+cqi6qf76WWUgOW0scKdtDdGoy9lHNGkTO+AYtIj6klmRJ4xhjT
         5csgyAN99N70LDcJ6dCpVIpp242qWc6QnFalXZLJbNTSa/gfb5bYAqoWdK2SJN1IiJqe
         mFQh4NwFm4/1CLTQEuWsxNetcAtTg5prn7/jQpo1ehXFYzmJPKVcSIqvRt1sSRxt5ktM
         wInw==
X-Gm-Message-State: ANoB5pkAAI+pXl0NyZEh0K8iYrTQShCMWoNwe0nLaXu+ZNzqDsmEis2J
        uQIimb9tXiqruKbYYutiMsQ=
X-Google-Smtp-Source: AA0mqf51MvSUlnnQ65C1Z0llSKT9K+dncVmWd3bQIUneAAbtt+mMxubD8JoJPEXzsVKPNOov/K3OIg==
X-Received: by 2002:a17:902:7843:b0:187:282c:9b9c with SMTP id e3-20020a170902784300b00187282c9b9cmr13412451pln.29.1668426614110;
        Mon, 14 Nov 2022 03:50:14 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79acc000000b0056ddd2b5e9bsm6517901pfp.41.2022.11.14.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:50:13 -0800 (PST)
Date:   Mon, 14 Nov 2022 20:50:03 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor.Dooley@microchip.com, Paul Cercueil <paul@crapouillou.net>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y3Ira4A7jNF+5l2d@hyeyoo>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz>
 <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:36:31AM +0100, Vlastimil Babka wrote:
> On 11/14/22 06:48, Damien Le Moal wrote:
> > On 11/14/22 10:55, Damien Le Moal wrote:
> >> On 11/12/22 05:46, Conor Dooley wrote:
> >>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
> >>>> On 11/8/22 22:44, Pasha Tatashin wrote:
> >>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> as we all know, we currently have three slab allocators. As we discussed
> >>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
> >>>>>> two of them do not.
> >>>>>>
> >>>>>> The unsurprising reasons include code maintenance burden, other features
> >>>>>> compatible with only a subset of allocators (or more effort spent on the
> >>>>>> features), blocking API improvements (more on that below), and my
> >>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
> >>>>>> without resorting to spelling out the letters.
> >>>>>>
> >>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
> >>>>>> two to be removed, so I'd like to focus on it first.
> >>>>>>
> >>>>>> I believe SLOB can be removed because:
> >>>>>>
> >>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
> >>>>>> by putting all objects together, which has its CPU performance costs
> >>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
> >>>>>> aware of any "tiny linux" deployment that opts for this. For example,
> >>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> >>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> >>>>>> SLOB impact is too much for those who tried. Googling for
> >>>>>> "CONFIG_SLOB=y" yielded nothing useful.
> >>>>>
> >>>>> I am all for removing SLOB.
> >>>>>
> >>>>> There are some devices with configs where SLOB is enabled by default.
> >>>>> Perhaps, the owners/maintainers of those devices/configs should be
> >>>>> included into this thread:
> >>>>>
> >>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> >>>
> >>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
> >>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
> >>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> >>>
> >>>>
> >>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
> >>>> running make defconfig ends up with SLUB anyway, unless I miss something.
> >>>> Only a subset has both SLOB and EXPERT:
> >>>>
> >>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
> >>>
> >>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
> >>>
> >>> I suppose there's not really a concern with the virt defconfig, but I
> >>> did check the output of `make nommu_k210_defconfig" and despite not
> >>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
> >>>
> >>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
> >>> boots etc, but I have no workloads or w/e to run on it.
> >> 
> >> I sent a patch to change the k210 defconfig to using SLUB. However...
> 
> Thanks!
> 
> >> The current default config using SLOB gives about 630 free memory pages
> >> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
> >> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
> 
> Thanks for the testing! How much RAM does the system have btw? I found 8MB
> somewhere, is that correct?
> So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
> difference [1]. But that was looking at Slab pages, not free pages.

IIRC overhead of s->min_partial (between 5 and 10) was pretty big because SLUB
caches at most (s->min_partial) * (nr of caches) * (size of slab) bytes of
unused memory.

Passing slub_max_order=0 also may help a little bit.

> The extra overhead could be also in percpu allocations, code etc.

SLUB do not use large amount of percpu allocator I think, less than
30kB on such a small machine.

Maybe also it would help reducing code size to disable CONFIG_MEMCG and CONFIG_TRACING,
CONFIG_SLUB_DEBUG and CONFIG_SYSFS.

I started from tinyconfig and enabled only necessary configs when testing in [1]
(it's a bit laborious cuz pure tinyconfig does not even boot...).

> >> This is with a buildroot kernel 5.19 build including a shell and sd-card
> >> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
> >> definitely see more errors with shell commands failing due to allocation
> >> failures for the shell process fork. So as far as the K210 is concerned,
> >> switching to SLUB is not ideal.
> >> 
> >> I would not want to hold on kernel mm improvements because of this toy
> >> k210 though, so I am not going to prevent SLOB deprecation. I just wish
> >> SLUB itself used less memory :)
> > 
> > Did further tests with kernel 6.0.1:
> > * SLOB: 630 free pages after boot, shell working (occasional shell fork
> > failure happen though)
> > * SLAB: getting memory allocation for order 7 failures on boot already
> > (init process). Shell barely working (high frequency of shell command fork
> > failures)
> > * SLUB: getting memory allocation for order 7 failures on boot. I do get a
> > shell prompt but cannot run any shell command that involves forking a new
> > process.
> > 
> > So if we want to keep the k210 support functional with a shell, we need
> > slob. If we reduce that board support to only one application started as
> > the init process, then I guess anything is OK.
> 
> In [1] it was possible to save some more memory with more tuning. Some of
> that required boot parameters and other code changes. In another reply [2] I
> considered adding something like SLUB_TINY to take care of all that, so
> looks like it would make sense to proceed with that.
> 
> [1]
> https://lore.kernel.org/all/Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal/
> [2] https://lore.kernel.org/all/eebc9dc8-6a45-c099-61da-230d06cb3157@suse.cz/

-- 
Thanks,
Hyeonggon
