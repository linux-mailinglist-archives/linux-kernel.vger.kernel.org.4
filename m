Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48E75B6D60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiIMMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiIMMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:36:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477631363
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:36:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MRjcs6wMpz9swL;
        Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J-_IE-R0VMXd; Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MRjcs67g9z9swK;
        Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1A868B780;
        Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id l5GnJCXuci9M; Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
Received: from [192.168.232.91] (unknown [192.168.232.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 412E88B763;
        Tue, 13 Sep 2022 14:36:13 +0200 (CEST)
Message-ID: <4f540391-37dc-8e22-be0a-74543082504d@csgroup.eu>
Date:   Tue, 13 Sep 2022 14:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Fragmented physical memory on powerpc/32
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20220520080454.c3cqodsdbfbkmg56@pali>
 <935b426a-6c64-beb0-907f-8c3f0a089ab7@heyquark.com>
 <20220520123002.rd46p5ty6wumi7cc@pali> <20220609222420.ponpoodiqmaqtwht@pali>
 <20220808184034.lskqrk6z3gb5q76r@pali>
 <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu>
 <20220908153511.57ceunyusziqfcav@pali> <20220908201701.sd3zqn5hfixmjvhh@pali>
 <9fbc5338-5e10-032a-8f55-e080bd93f74b@csgroup.eu>
 <Yx9GpV1XT8r2a++R@kernel.org> <20220912211623.djb7fckgknyfmof7@pali>
 <1c95875c-29f8-68b7-e480-fed8614f3037@csgroup.eu>
In-Reply-To: <1c95875c-29f8-68b7-e480-fed8614f3037@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/09/2022 à 08:11, Christophe Leroy a écrit :
> 
> 
> Le 12/09/2022 à 23:16, Pali Rohár a écrit :
>>>
>>> My guess would be that something went wrong in the linear map setup, 
>>> but it
>>> won't hurt running with "memblock=debug" added to the kernel command 
>>> line
>>> to see if there is anything suspicious there.
>>
>> Here is boot log on serial console with memblock=debug command line:
>>
> ...
>>
>> Do you need something more for debug?
> 
> Can you send me the 'vmlinux' used to generate the above Oops so that I 
> can see exactly where we are in function mem_init().
> 
> And could you also try without CONFIG_HIGHMEM just in case.
> 

I looked at the vmlinux you sent me, the problem is in the loop for 
highmem in mem_init(). It crashes in the call to free_highmem_page()

#ifdef CONFIG_HIGHMEM
	{
		unsigned long pfn, highmem_mapnr;

		highmem_mapnr = lowmem_end_addr >> PAGE_SHIFT;
		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
			struct page *page = pfn_to_page(pfn);
			if (!memblock_is_reserved(paddr))
				free_highmem_page(page);
		}
	}
#endif /* CONFIG_HIGHMEM */


As far as I can see in the memblock debug lines, the holes don't seem to 
be marked as reserved by memblock. So it is above valid ? Other 
architectures seem to do differently.

Can you try by replacing !memblock_is_reserved(paddr) by 
memblock_is_memory(paddr) ?

Thanks
Christophe
