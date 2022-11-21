Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E76631932
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKUEbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKUEa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:30:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3F13D01
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669005055; x=1700541055;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4beOSLpbYZX+oR0kMpyCYOPvXowctFP1xAU6PZQst0A=;
  b=iyvX7N1f9Mwu+loFbxUD2e5nKXx5DMcpXqNziPJmHdSI9lWPINHJXr90
   zzB1u1+g/x4ezQkGmUtBpme2H1IkMyD8tIxJYURerxt7oWIEHFJX8iGOq
   zNBmJpUpumIrzyTXB7YGw5+fPSL2EPhNmYY2v1N/IwG3R2pGWgXlLsomS
   L5TC9t5NWDj27IpUu2BqNPxRm0VCODvSvnT5cKAe4RemNCS6lkyh3mqMS
   JtU+bzcaDb9wyQGxH+m0EZj5+DSdaNfwe6IF3C8eFO/wnxCELngDBc54r
   XwEbSkcbVG5FOVdAdoALWW8/SYjvKn68c6p5N6B7SVXnbCYY9qy4VbbUt
   w==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="217068141"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 12:30:54 +0800
IronPort-SDR: Bdx5++rJbmz6gYTwFSiSeNnyGMYh5XOBPkIgWJ2zMR5+dgxS8lr9aLkUQ1pMQhXArMhpp/k/yr
 NV51frO9keXM2uU6d5CdBPe0+hsHrd2hHndFGxJPT/v+TPmdgwGI9fPOGLgdTj6usQfmJqQz99
 hJTrYBSnhA85ICKyEksdy7jqH3G5i3faYTM2VBG8nMOLdMqMAxCFUpWWvqXQ7eMqq5ex7ps1Xg
 /a/pOYDKvUamopUq3S1n0MtRNp1UcJQ/9iHdh/svhvkNNZigHLh4zdeWjd/CiaRy+IwkIFDmRR
 lHE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 19:43:59 -0800
IronPort-SDR: FEwPv9Fnj2TUns91KMc4+GEXpCho7KnBxqEtoffg6HpxY/yzqANTEIqBlKvLa0CjL8Sq6nG/AE
 qP3Kx3DklozVxIOxw1gqXmUzwCYDIcV3oCgY2IAgkjI8cSOLULwZLyaWaQQ1bgYIfVWWeRvsjF
 m5lXYftj6vJxgFOnlM3UqhcDs/cf/+HiMW/hA/+KaaxwmaycjlKjKhXpeHE7s6AVJ32UFtGt9E
 63z8MJomWenK/7At6vLyTqd3I+WeRoGx8d5DW5knnPzbbqF+Y2Ng5s0Ibql6ysvH1cUuA9RCwb
 sns=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 20:30:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFvb11MJbz1Rwt8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:30:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669005050; x=1671597051; bh=4beOSLpbYZX+oR0kMpyCYOPvXowctFP1xAU
        6PZQst0A=; b=mhu9C6E5SBKSYCUWSuDrqGkm2VYjI+Y5TAEfePCmYGq29reUX8k
        goLMTAHyZLq2jvgzYymOaQ2EnsvFss/6RPCvypwm+215QRuyBJ34nAGd50fJp5ZP
        +02sm8mAFWcccECcxL/lg8JW6IUr5nmyfAE0Y24IhSVQojuQuj1eDAKbE1kxbeQw
        dTLvo6JZD0nf1XTAuxNtu7Cja5Ty+Gn1/yAPfxjRgA/dezV6oArN0n6bmVr/5Y7V
        eQNXDK86D9tLfGfdxQtWxlgQ2/ZROkCnJeIvhnkZlgoH2m2+J3HTvlonMaAhXcqR
        bGcGRWywm2GH2z8ps/MNngWl/Xn7FmD3h/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fvh_Epm-AVhX for <linux-kernel@vger.kernel.org>;
        Sun, 20 Nov 2022 20:30:50 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFvZq1TDDz1RvLy;
        Sun, 20 Nov 2022 20:30:42 -0800 (PST)
Message-ID: <6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 13:30:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
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
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
 <452c3833-9275-37c7-3d48-5c996c0e2557@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <452c3833-9275-37c7-3d48-5c996c0e2557@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/22 02:51, Vlastimil Babka wrote:
> On 11/15/22 05:24, Damien Le Moal wrote:
>> On 11/14/22 23:47, Hyeonggon Yoo wrote:
>>> On Mon, Nov 14, 2022 at 08:35:31PM +0900, Damien Le Moal wrote:
>>>> On 11/14/22 18:36, Vlastimil Babka wrote:
>>>>> On 11/14/22 06:48, Damien Le Moal wrote:
>>>>>> On 11/14/22 10:55, Damien Le Moal wrote:
>>>>>>> On 11/12/22 05:46, Conor Dooley wrote:
>>>>>>>> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>>>>>>>>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>>>>>>>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> as we all know, we currently have three slab allocators. As we discussed
>>>>>>>>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>>>>>>>>> two of them do not.
>>>>>>>>>>>
>>>>>>>>>>> The unsurprising reasons include code maintenance burden, other features
>>>>>>>>>>> compatible with only a subset of allocators (or more effort spent on the
>>>>>>>>>>> features), blocking API improvements (more on that below), and my
>>>>>>>>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>>>>>>>>> without resorting to spelling out the letters.
>>>>>>>>>>>
>>>>>>>>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>>>>>>>>> two to be removed, so I'd like to focus on it first.
>>>>>>>>>>>
>>>>>>>>>>> I believe SLOB can be removed because:
>>>>>>>>>>>
>>>>>>>>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>>>>>>>>> by putting all objects together, which has its CPU performance costs
>>>>>>>>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>>>>>>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>>>>>>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>>>>>>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>>>>>>>>> SLOB impact is too much for those who tried. Googling for
>>>>>>>>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>>>>>>>>
>>>>>>>>>> I am all for removing SLOB.
>>>>>>>>>>
>>>>>>>>>> There are some devices with configs where SLOB is enabled by default.
>>>>>>>>>> Perhaps, the owners/maintainers of those devices/configs should be
>>>>>>>>>> included into this thread:
>>>>>>>>>>
>>>>>>>>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>>>>>>>>
>>>>>>>>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>>>>>>>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>>>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>>>>>>>>> running make defconfig ends up with SLUB anyway, unless I miss something.
>>>>>>>>> Only a subset has both SLOB and EXPERT:
>>>>>>>>>
>>>>>>>>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
>>>>>>>>
>>>>>>>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
>>>>>>>>
>>>>>>>> I suppose there's not really a concern with the virt defconfig, but I
>>>>>>>> did check the output of `make nommu_k210_defconfig" and despite not
>>>>>>>> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
>>>>>>>>
>>>>>>>> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
>>>>>>>> boots etc, but I have no workloads or w/e to run on it.
>>>>>>>
>>>>>>> I sent a patch to change the k210 defconfig to using SLUB. However...
>>>>>
>>>>> Thanks!
>>>>>
>>>>>>> The current default config using SLOB gives about 630 free memory pages
>>>>>>> after boot (cat /proc/vmstat). Switching to SLUB, this is down to about
>>>>>>> 400 free memory pages (CONFIG_SLUB_CPU_PARTIAL is off).
>>>>>
>>>>> Thanks for the testing! How much RAM does the system have btw? I found 8MB
>>>>> somewhere, is that correct?
>>>>
>>>> Yep, 8MB, that's it.
>>>>
>>>>> So 230 pages that's a ~920 kB difference. Last time we saw less  dramatic
>>>>> difference [1]. But that was looking at Slab pages, not free pages. The
>>>>> extra overhead could be also in percpu allocations, code etc.
>>>>>
>>>>>>> This is with a buildroot kernel 5.19 build including a shell and sd-card
>>>>>>> boot. With SLUB, I get clean boots and a shell prompt as expected. But I
>>>>>>> definitely see more errors with shell commands failing due to allocation
>>>>>>> failures for the shell process fork. So as far as the K210 is concerned,
>>>>>>> switching to SLUB is not ideal.
>>>>>>>
>>>>>>> I would not want to hold on kernel mm improvements because of this toy
>>>>>>> k210 though, so I am not going to prevent SLOB deprecation. I just wish
>>>>>>> SLUB itself used less memory :)
>>>>>>
>>>>>> Did further tests with kernel 6.0.1:
>>>>>> * SLOB: 630 free pages after boot, shell working (occasional shell fork
>>>>>> failure happen though)
>>>>>> * SLAB: getting memory allocation for order 7 failures on boot already
>>>>>> (init process). Shell barely working (high frequency of shell command fork
>>>>>> failures)
>>>>
>>>> I forgot to add here that the system was down to about 500 free pages
>>>> after boot (again from the shell with "cat /proc/vmstat").
>>>>
>>>>>> * SLUB: getting memory allocation for order 7 failures on boot. I do get a
>>>>>> shell prompt but cannot run any shell command that involves forking a new
>>>>>> process.
>>>>
>>>> For both slab and slub, I had cpu partial off, debug off and slab merge
>>>> on, as I suspected that would lead to less memory overhead.
>>>> I suspected memory fragmentation may be an issue but doing
>>>>
>>>> echo 3 > /proc/sys/vm/drop_caches
>>>>
>>>> before trying a shell command did not help much at all (it usually does on
>>>> that board with SLOB). Note that this is all with buildroot, so this echo
>>>> & redirect always works as it does not cause a shell fork.
>>>>
>>>>>>
>>>>>> So if we want to keep the k210 support functional with a shell, we need
>>>>>> slob. If we reduce that board support to only one application started as
>>>>>> the init process, then I guess anything is OK.
>>>>>
>>>>> In [1] it was possible to save some more memory with more tuning. Some of
>>>>> that required boot parameters and other code changes. In another reply [2] I
>>>>> considered adding something like SLUB_TINY to take care of all that, so
>>>>> looks like it would make sense to proceed with that.
>>>>
>>>> If you want me to test something, let me know.
>>>
>>> Would you try this please?
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index a24b71041b26..1c36c4b9aaa0 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4367,9 +4367,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>>  	 * The larger the object size is, the more slabs we want on the partial
>>>  	 * list to avoid pounding the page allocator excessively.
>>>  	 */
>>> -	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
>>> -	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
>>> -
>>> +	s->min_partial = 0;
>>>  	set_cpu_partial(s);
>>>  
>>>  #ifdef CONFIG_NUMA
>>>
>>>
>>> and booting with and without boot parameter slub_max_order=0?
>>
>> Test notes: I used Linus 6.1-rc5 as the base. That is the only thing I
>> changed in buildroot default config for the sipeed maix bit card, booting
>> with SD card. The test is: booting and run "cat /proc/vmstat" and register
>> the nr_free_pages value. I repeated the boot + cat 3 to 4 times for each case.
>>
>> Here are the results:
>>
>> 6.1-rc5, SLOB:
>>     - 623 free pages
>>     - 629 free pages
>>     - 629 free pages
>> 6.1-rc5, SLUB:
>>     - 448 free pages
>>     - 448 free pages
>>     - 429 free pages
>> 6.1-rc5, SLUB + slub_max_order=0:
>>     - Init error, shell prompt but no shell command working
>>     - Init error, no shell prompt
>>     - 508 free pages
>>     - Init error, shell prompt but no shell command working
>> 6.1-rc5, SLUB + patch:
>>     - Init error, shell prompt but no shell command working
>>     - 433 free pages
>>     - 448 free pages
>>     - 423 free pages
>> 6.1-rc5, SLUB + slub_max_order=0 + patch:
>>     - Init error, no shell prompt
>>     - Init error, shell prompt, 499 free pages
>>     - Init error, shell prompt but no shell command working
>>     - Init error, no shell prompt
>>
>> No changes for SLOB results, expected.
>>
>> For default SLUB, I did get all clean boots this time and could run the
>> cat command. But I do see shell fork failures if I keep running commands.
>>
>> For SLUB + slub_max_order=0, I only got one clean boot with 508 free
>> pages. Remaining runs failed to give a shell prompt or allow running cat
>> command. For the clean boot, I do see higher number of free pages.
>>
>> SLUB with the patch was nearly identical to SLUB without the patch.
>>
>> And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
>> could run the cat command only once, giving 499 free pages, so better than
>> regular SLUB. But it seems that the memory is more fragmented as
>> allocations fail more often.
>>
>> Hope this helps. Let me know if you want to test something else.
> 
> Could you please try this branch with CONFIG_SLUB_TINY=y?
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-tiny-v1r0
> 
> Seeing your results I didn't modify default slub_max_order by this new
> CONFIG (yet?) so maybe after trying the default, trying then also with
> manual slub_max_order=0 and slub_max_order=1 would be useful too. Otherwise
> it should be all changes to lower SLUB memory footprint. Hopefully it will
> be visible in the number of free pages. But if fragmentation is an issue, it
> might not be enough. BTW, during boot there should be a line "Built X
> zonelists, mobility grouping ..." can you grep for it and provide please, I
> wonder if mobility grouping ends up being off or on on that system.

I ran your branch with CONFIG_SLUB_TINY=y. Here are the results with 3-4
runs per config:

* tiny slub with default slub_max_order:
	- Clean boot, 579 free pages
	- Clean boot, 575 free pages
	- Clean boot, 579 free pages

* tiny slub with slub_max_order=0 as boot argument:
        - Init error, shell prompt but no shell command working
	- Init error, shell prompt, 592 free pages
	- Init error, shell prompt, 591 free pages
	- Init error, shell prompt, 591 free pages

* tiny slub with slub_max_order=1 as boot argument:
	- Clean boot, 601 free pages
	- Clean boot, 601 free pages
	- Clean boot, 591 free pages
	- Clean boot, 601 free pages

For all cases, mobility grouping was reported as off:

[    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 2020

So it looks like your tiny slub branch with slub_max_order=1 puts us
almost on par with slob and that slub_max_order=0 seems to be generating
more fragmentation leading to unreliable boot. I also tried
slub_max_order=2, which gives clean boot and around 582 free pages, almost
the same as the default.

With this branch applied, I have no issues with having slob deprecated :)
Thanks !


> 
> Thanks!
> 
>> Cheers.
>>
> 

-- 
Damien Le Moal
Western Digital Research

