Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F30626634
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiKLBlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKLBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:41:03 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEE56584D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668217261; x=1699753261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkxzV91Rv/U=;
  b=VNBarMPfMfkH6qP8EH8oZTd3xvghcFcwIAMKcBYPAnRxCP2FU79OGPPM
   Schnnnv20PsVTBkuqmIjYPTov31s2GyP2yC6G6ulxX+T88bVwLGl/NJAa
   f5/SlCNIfCFKoJNLSz/jgzR/YX7jE9Jvs8+Ao2M4s3TmI9mpkH9RzHvee
   7btveWUmWGBJLGJJBKBF8hxES/OgjoxDXoiaWGjqyDnXOKB2FmlnrU7Uw
   MofXlTrIjuglqZYbyEstRcLZ+jpqcGSYHfVCQ4k3qIItVOhPM0KV+xQuE
   8tTBh8j0UQhd4hwP0so2DA0xeiEcvs/BalwefVLRADANuGWb/hiErq5GD
   A==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="216094310"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 09:41:01 +0800
IronPort-SDR: lDNfaju6bV9TDpTB/6Pj4bpZ3DIWSLQg+z2qaS1DNwmGDZAQJmYJ1PC8jfhgH91/+dGl/q74VH
 yA4+Dp1/aCscLb8RZkx2jdkNHLLriLhvLJGBIRRmL8k/HqAYJmABomOegNt0pCcknWzIBJMwOt
 9bpkPFoXhKA6WBFuwpuWlapX6zVgcmJi7nhnVEbM72kXfnMJvfq7ezVTS38aEicQgEc57iOCjB
 sBPe5yA3NwwEAhAshDzqH3Mj0AV3igXL+4qDJKXEwusaB9iW7NVAOrzODY8hA+7nAwjMjf01V9
 u0s=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 16:54:17 -0800
IronPort-SDR: orSYoWCeCVHYUBbwJhYbX85iejdZ47IpiUzWIm2DBSU0ltyymYO9F1/eiZt0lbGjBgzy7ba1i9
 NWYmS1pv3VSTeygtMGADBBDSxgxC55xLHwKzkZiN50e09charD4sR7pBQqB6msv9THPv6i908c
 gN3T00KIQCipgarlMZJ1Enw6zMLaXEH/tnSDyhJrGcWSyhW862juDK+5RgAzoRe9NKhkIVSHNX
 lISxBiQQXKbSy/P1IpLTJTsUDN6naOWT9VxZA3YYHfTt+jlyu3asBbe7MRpPxMr3hjRtU0pwbV
 zw4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:41:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8JF869d3z1RwtC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 17:41:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668217259; x=1670809260; bh=kWfbDk7epBE8N+lvIUYGuQa6NGCEfO5LUkx
        zV91Rv/U=; b=Xt/iwKvzhSDgTK+B4NYDMAfHOtqp1/lm6m42MJplgxGQ/MhvZcg
        DiL5QupgB6hf9pSwls6trrK2Go0lAWor98lJ4CXB77UDfuOK8rMfb22YZtw3Pweh
        pFj4HQ927gmUPDBO38wl7Ip+uoDPouRj5UdJclRCe++QlSW4WcwEB3zS5c8/17Ya
        YhnZhArolHjrAo5SLDsgoQhohh2WglL66ga54503AkORVEj09pZexQratT96uFEg
        DOJmCaIsPpNzz8oZtvgW5YPUcKo1AebpsvfRu1TW7iW9MlkGGHlIGrFDC6Iq1pLS
        oVQLQj32vK2wFWj3Sp1cTHoo024dHRz3qSA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gKGJAEuw1Kn6 for <linux-kernel@vger.kernel.org>;
        Fri, 11 Nov 2022 17:40:59 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8JF265dcz1RvLy;
        Fri, 11 Nov 2022 17:40:54 -0800 (PST)
Message-ID: <e4076fcb-9736-937d-634b-5b8fb342723e@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 10:40:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y260tkNHc2vFITJ3@spud>
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

On 11/12/22 05:46, Conor Dooley wrote:
> On Fri, Nov 11, 2022 at 11:33:30AM +0100, Vlastimil Babka wrote:
>> On 11/8/22 22:44, Pasha Tatashin wrote:
>>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> Hi,
>>>>
>>>> as we all know, we currently have three slab allocators. As we discussed
>>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>>> two of them do not.
>>>>
>>>> The unsurprising reasons include code maintenance burden, other features
>>>> compatible with only a subset of allocators (or more effort spent on the
>>>> features), blocking API improvements (more on that below), and my
>>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>>> without resorting to spelling out the letters.
>>>>
>>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>>> two to be removed, so I'd like to focus on it first.
>>>>
>>>> I believe SLOB can be removed because:
>>>>
>>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>>> by putting all objects together, which has its CPU performance costs
>>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>>> aware of any "tiny linux" deployment that opts for this. For example,
>>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>>> SLOB impact is too much for those who tried. Googling for
>>>> "CONFIG_SLOB=y" yielded nothing useful.
>>>
>>> I am all for removing SLOB.
>>>
>>> There are some devices with configs where SLOB is enabled by default.
>>> Perhaps, the owners/maintainers of those devices/configs should be
>>> included into this thread:
>>>
>>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> 
>>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> 
>>
>> Turns out that since SLOB depends on EXPERT, many of those lack it so
>> running make defconfig ends up with SLUB anyway, unless I miss something.
>> Only a subset has both SLOB and EXPERT:
>>
>>> git grep CONFIG_EXPERT `git grep -l "CONFIG_SLOB=y"`
> 
>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_EXPERT=y
> 
> I suppose there's not really a concern with the virt defconfig, but I
> did check the output of `make nommu_k210_defconfig" and despite not
> having expert it seems to end up CONFIG_SLOB=y in the generated .config.
> 
> I do have a board with a k210 so I checked with s/SLOB/SLUB and it still
> boots etc, but I have no workloads or w/e to run on it.

I will try with SLUB over the weekend.

-- 
Damien Le Moal
Western Digital Research

