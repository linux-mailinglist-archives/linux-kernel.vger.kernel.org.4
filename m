Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62EB62B46E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiKPIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiKPICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:02:25 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDD6171
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668585744; x=1700121744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aiQ1E4MA/V7AYoAnhMYGLoTHKrhMUZFLqWEuM1zwwcE=;
  b=mngN03wJYTkprAx/ORZqvd79fB775RGsHHcCmdA6TPcHiIhTXAt5qfhc
   IDZ++BeOPAvhNtIZ5a9rNY7+c4mcRnOoVSzaUpjMM5Pk9w+G1mRChO4J/
   9zIu+p2kGvU2oJct6oio6lBAPCJmXJtHP4pWMHIOlYT2h9cYWtoj/Me1I
   9Kccf59mRTZGy8JnOPVpeguu12jV5MTL4wect47qh8XEWlnmWcsdfWQut
   Mz3//hOZc9yE2Imug0AVeja+oVnF1+QutoYrZVc7F0y6+MRwomzDP8FEd
   s3orBwYzHJV4NEHorpSeC56uenismzin+6VPFmRGgBFIfwCTxivnKEtdq
   g==;
X-IronPort-AV: E=Sophos;i="5.96,167,1665417600"; 
   d="scan'208";a="216718589"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2022 16:02:23 +0800
IronPort-SDR: Duf6aZHd9yGoreOu25Z6eOp4Go3g3ktXa8/Va3QA/KaI/2kaUANahbE4V1bvmtorWZPE5zCyU4
 NiVSavJk3zDMzCwMvCj9hoAFGxgMfE9zGfU+vK1ouCvHs3wlX5nTXmaT+ZXRwrIBsP5jr7aE/8
 rd7XsfosahuHwjPgHRRrCgIwZ22KCz7NEf7foJslWfzD9fF0ClqGGKrfPYxHHqUEsZlf6Mw+v2
 898B+agP3xf8pCPwAe/uPHlwNcCNVjWJnjeb219ZBJd+Et4JJheCv+eSwIQHfy7MStIR9pneac
 nrM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 23:15:34 -0800
IronPort-SDR: 4KPthMJeFgxPsHpkI9iVNuh3VuQMtWnf1exdR3CdoXzQ+cjIAOb52hF2rfS9+EiOBUn4qrNc5h
 qS77mq1nJXviUBzy0q/FHVrLwblzmea80s5N/4cepf2z5FLIkBa+7oBISjVl7hvbAU5OrW4Gdk
 2BKsuwTNk1FSytY4YQgr79Z1eUK2P7t8YgGlHm4iHg7w9xIaaxXY39iCA8iqBx5FE9d2R7c+qG
 Rt2toiPeNkGGzVEwrD23s9lxCsahCe7UvqhW5a4S9FfwpONEq3sdbsI215E+LOAJOz0tXnHlZi
 nXw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Nov 2022 00:02:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NBwWK6btTz1SHjy
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:02:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668585740; x=1671177741; bh=aiQ1E4MA/V7AYoAnhMYGLoTHKrhMUZFLqWE
        uM1zwwcE=; b=hdZa3KjwjCP+zobptX+TYBaWDRq+niaGBKZNqK4WbXEsNSwavmx
        cUywVHBdz9AfXs0to7hesyrQ2NWAl2it/5LxRsnt31Y1Nwz0QotwGD1GyOdU7h1r
        lF2IEAiPhXR0YixGF8rl/oIAADace+mzN5uFTNNMtfHZh1b7+STGBqhhYdXZp/Dz
        vGRWrTISYkzpbFDqtddZUypWBqnvzHD0Epxn77mA56wYhXDDu0lLWBjrCdi4Y86j
        NwGAEAGKRiOoYB8erbrLYp2xLTqj5bd1I4UfWc9FHWdmVvCCQFMwqqio06GHNLgz
        KXgtVJNH3CLEKLoRjhAAKK8b25on/CuMLtQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7NnU54Wan09S for <linux-kernel@vger.kernel.org>;
        Wed, 16 Nov 2022 00:02:20 -0800 (PST)
Received: from [10.89.82.19] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NBwW94Qxqz1RvLy;
        Wed, 16 Nov 2022 00:02:13 -0800 (PST)
Message-ID: <b119e0b7-be10-46d8-886b-b5071b1b9562@opensource.wdc.com>
Date:   Wed, 16 Nov 2022 17:02:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Conor Dooley <conor@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
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
References: <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <c1caa5ce-eeaf-8038-2dea-051c98aade45@suse.cz> <Y260tkNHc2vFITJ3@spud>
 <a5bba3ca-da19-293c-c01b-a28291533466@opensource.wdc.com>
 <93079aba-362e-5d1e-e9b4-dfe3a84da750@opensource.wdc.com>
 <44da078c-b630-a249-bf50-67df83cd8347@suse.cz>
 <35650fd4-3152-56db-7c27-b9997e31cfc7@opensource.wdc.com>
 <Y3JU5cfyid1rBoOy@hyeyoo>
 <97c0735c-3127-83d5-30ff-8e57c6634f6e@opensource.wdc.com>
 <0e45a2f2-6dd5-5a43-c1a0-7520c1ed2675@opensource.wdc.com>
 <Y3SYA31zobR6/qbj@casper.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y3SYA31zobR6/qbj@casper.infradead.org>
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

On 2022/11/16 16:57, Matthew Wilcox wrote:
> On Tue, Nov 15, 2022 at 01:28:14PM +0900, Damien Le Moal wrote:
>> On 11/15/22 13:24, Damien Le Moal wrote:
>>> 6.1-rc5, SLOB:
>>>     - 623 free pages
>>>     - 629 free pages
>>>     - 629 free pages
>>> 6.1-rc5, SLUB:
>>>     - 448 free pages
>>>     - 448 free pages
>>>     - 429 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0:
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>     - 508 free pages
>>>     - Init error, shell prompt but no shell command working
>>> 6.1-rc5, SLUB + patch:
>>>     - Init error, shell prompt but no shell command working
>>>     - 433 free pages
>>>     - 448 free pages
>>>     - 423 free pages
>>> 6.1-rc5, SLUB + slub_max_order=0 + patch:
>>>     - Init error, no shell prompt
>>>     - Init error, shell prompt, 499 free pages
>>>     - Init error, shell prompt but no shell command working
>>>     - Init error, no shell prompt
>>>
>>> No changes for SLOB results, expected.
>>>
>>> For default SLUB, I did get all clean boots this time and could run the
>>> cat command. But I do see shell fork failures if I keep running commands.
>>>
>>> For SLUB + slub_max_order=0, I only got one clean boot with 508 free
>>> pages. Remaining runs failed to give a shell prompt or allow running cat
>>> command. For the clean boot, I do see higher number of free pages.
>>>
>>> SLUB with the patch was nearly identical to SLUB without the patch.
>>>
>>> And SLUB+patch+slub_max_order=0 gave again a lot of errors/bad boot. I
>>> could run the cat command only once, giving 499 free pages, so better than
>>> regular SLUB. But it seems that the memory is more fragmented as
>>> allocations fail more often.
>>
>> Note about the last case (SLUB+patch+slub_max_order=0). Here are the
>> messages I got when the init shell process fork failed:
>>
>> [    1.217998] nommu: Allocation of length 491520 from process 1 (sh) failed
>> [    1.224098] active_anon:0 inactive_anon:0 isolated_anon:0
>> [    1.224098]  active_file:5 inactive_file:12 isolated_file:0
>> [    1.224098]  unevictable:0 dirty:0 writeback:0
>> [    1.224098]  slab_reclaimable:38 slab_unreclaimable:459
>> [    1.224098]  mapped:0 shmem:0 pagetables:0
>> [    1.224098]  sec_pagetables:0 bounce:0
>> [    1.224098]  kernel_misc_reclaimable:0
>> [    1.224098]  free:859 free_pcp:0 free_cma:0
>> [    1.260419] Node 0 active_anon:0kB inactive_anon:0kB active_file:20kB
>> inactive_file:48kB unevictable:0kB isolated(anon):0kB isolated(file):0kB
>> mapped:0kB dirty:0kB writeback:0kB shmem:0kB writeback_tmp:0kB
>> kernel_stack:576kB pagetables:0kB sec_pagetables:0kB all_unreclaimable? no
>> [    1.285147] DMA32 free:3436kB boost:0kB min:312kB low:388kB high:464kB
>> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB
>> inactive_file:28kB unevictable:0kB writepending:0kB present:8192kB
>> managed:6240kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>> [    1.310654] lowmem_reserve[]: 0 0 0
>> [    1.314089] DMA32: 17*4kB (U) 10*8kB (U) 7*16kB (U) 6*32kB (U) 11*64kB
>> (U) 6*128kB (U) 6*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3460kB
>> [    1.326883] 33 total pagecache pages
>> [    1.330420] binfmt_flat: Unable to allocate RAM for process text/data,
>> errno -12
> 
> What you're seeing here is memory fragmentation.  There's more than 512kB
> of memory available, but nommu requires it to be contiguous, and it's
> not.  This is pretty bad, really.  We didn't even finish starting up
> and already we've managed to allocate at least one page from each of
> the 16 512kB chunks which existed.  Commit df48a5f7a3bb was supposed
> to improve matters by making exact allocations reassemble once they
> were freed.  Maybe the problem is entirely different.

I suspected something like this when seeing the reported "free:859" :)
What I can try next is booting without SD card and the bare minimum set of
drivers to see if the fragmentation is still there or not. Would that help ?
These one page allocations may be for device drivers so never freed, no ?

-- 
Damien Le Moal
Western Digital Research

