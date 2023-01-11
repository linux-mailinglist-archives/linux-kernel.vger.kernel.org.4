Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CED366596E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjAKKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbjAKKww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:52:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095A10F7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:52:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6ADDE174D7;
        Wed, 11 Jan 2023 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673434368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX3w237Fe0EtKS+kDpTx3rxaui4HbkknVgwOhcx+Sq4=;
        b=mOhUTrrU4Zhwbupx+LzWk1Lu3zKajz9L60ryC3qyil9Kw0zeitc8g/hp29SL5DNGCz1z2m
        OrkShYbNpuQ2IKEEu9x9cFRju0G93oXbVblOJk0wwgeKKMRxKcf9ueuKkywoeTAXvhROGX
        jQN5NRjeFoSbX5ICM64zi1pDvb1ItAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673434368;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX3w237Fe0EtKS+kDpTx3rxaui4HbkknVgwOhcx+Sq4=;
        b=x5acz98V/0tWbyiXor69iaT+ukW4jUbMfAHb1k1N4rPxTdB/Yms66j3rvraUNczDX4CaR1
        UszE23wz/n4kQ7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DC7B13591;
        Wed, 11 Jan 2023 10:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9rBZDgCVvmPiEwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 11 Jan 2023 10:52:48 +0000
Message-ID: <53fc9fde-6132-9f2d-55e3-7119d11dc261@suse.cz>
Date:   Wed, 11 Jan 2023 11:52:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020> <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <3f7fa3b3-9623-5c4c-94b1-a41dea6eaaf2@suse.cz>
 <Y7weKyxIY+QFYq6j@xsang-OptiPlex-9020> <Y71t89JMgtRoNHM/@xsang-OptiPlex-9020>
 <d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz> <Y74eYCOBkRKlQN+H@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y74eYCOBkRKlQN+H@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 03:26, Feng Tang wrote:
> On Tue, Jan 10, 2023 at 10:09:36PM +0800, Vlastimil Babka wrote:
>> On 1/10/23 14:53, Oliver Sang wrote:
>> > hi all,
>> > 
>> > On Mon, Jan 09, 2023 at 10:01:15PM +0800, Oliver Sang wrote:
>> >> 
>> >> On Fri, Jan 06, 2023 at 11:13:15AM +0100, Vlastimil Babka wrote:
>> >> 
>> >> > And if the rate at the parent (has it increased thanks to the
>> >> > DEBUG_PAGEALLOC?) is sufficient to bisect to the truly first bad commit. Thanks!
>> >> 
>> >> got it. Thanks for suggestion!
>> >> 
>> >> since 0af8489b02 is based on v6.1-rc2, we will test (both rectorture and boot)
>> >> with same config upon v6.1-rc2 to see if it's really clean there.
>> >> if so we will use dmesg.invalid_opcode:#[##] to trigger new bisect.
>> >> 
>> >> will keep you updated. Thanks
>> > 
>> > by more tests, we cannot make sure the v6.1-rc2 is clean, so we also checked
>> > v6.1-rc1 and v6.0. from results, we have low confidence that we can make a
>> > successful bisection based on them [1][2]. could you suggest?
>> 
>> So am I reading it right, that the probleam appears to be introduced between
>> v6.0 (0 failures) and v6.1-rc1 (>0 failures)? But agree that with such low
>> incidence, it's hard to bisect.
> 
> Yes, it's hard for bisection, as it happens at a higher reproduce rate
> on several commits, hope it could be bisected soon.
> 
> Before Oliver found the parent commit also trigger the problem, I did
> some debug, and I think related factors could be compound_page, folio,
> slub and i386(struct page size and layout), which cause some compound
> page structures corrupted. 
> 
> * I tried change the slub_max_order to 0 for SLUB_TINY (much less
>   compound-page operations), and no issue is found for 350 runs.
> 
> * Disable order>=1 in pcp list, the issue's reproduce rate keeps
>   similar, which means the pcp operation is not related.
> 
> * Tried add some debug info in unused members of struct page of tail
>   pages (not first tail page), or add one more member at the end of
>   'struct page', can't reproduce it. 
> 
> From Oliver's reports, there are several kinds of errors: list
> operation failure (list_head structure corruption), compound page
> check failure (PageTail warning) etc, which seem to indicate the
> struct pages are randomly corrupted. In dump_page(), I tired to dump
> more pages befor and after 'raw' and 'head' pages
> 
> [   18.265162][  T186] page:43caddc9 refcount:1 mapcount:0 mapping:00000000 index:0xedece900 pfn:0x2dece
> [   18.266205][  T186] head:5e92e8e2 order:1 compound_mapcount:0 compound_pincount:0
> [   18.266928][  T186] flags: 0x10200(slab|head|zone=0)
> [   18.267339][  T186] raw-2: 00010200 c0100b70 c0100b70 c01a0680 edecd000 00020001 ffffffff 00000001
> [   18.268055][  T186] raw-2: 00000000 00000000
> [   18.268419][  T186] raw-1: 00000000 e7652fe1 00000101 ffffffff 00000000 00000000 ffffffff 00000000
> [   18.269124][  T186] raw-1: 00000000 00000000
> [   18.269488][  T186] raw: 00010200 e7652fe1 c0100bf0 00000400 edece900 000a0003 ffffffff 00000001
> [   18.270187][  T186] raw: edce5f81 00000000

Yeah this just doesn't make sense at all, it looks like prep_compound_tail()
was called on two pages instead of one when creating the raw-2 order-1
compound page, corrupting the folowing slab order-1 page's head.
Even if we assumed the compound_head "e7652fe1" was wrongly copied or
something, we have mapping == 00000400 which his very specifically done by
prep_compound_tail() "p->mapping = TAIL_MAPPING;"
In the raw-1 (first tail page) it's then rewritten to ffffffff by
prep_compound_head()'s atomic_set(compound_mapcount_ptr(page), -1)". but in
'raw' it remains 00000400, so this means the operation
prep_compound_tail("raw-2", 2); had to happen, but not
prep_compound_tail("raw-2", 3); as we don't have the same kind of corruption
in raw1 below.
Hey maybe the CPU speculated wrongly on the number of iterations in
prep_compound_page() and accidently written the result of one extra
prep_compound_tail() to memory...

> [   18.270534][  T186] raw1: 00000000 e7653031 00000101 ffffffff 00000000 00000000 ffffffff 00000000
> [   18.271257][  T186] raw1: 00000000 00000000
> [   18.271617][  T186] raw2: 00010200 00000100 00000122 c01a0780 00000000 000a000a ffffffff 00000001
> [   18.272330][  T186] raw2: edd5bf01 00000000
> [   18.272690][  T186] raw3: 00000000 e7653081 00000101 ffffffff 00000000 00000000 ffffffff 00000000
> [   18.273424][  T186] raw3: 00000000 00000000
> 
> [   18.273793][  T186] head: 00010200 c0100b70 c0100b70 c01a0680 edecd000 00020001 ffffffff 00000001
> [   18.274534][  T186] head: 00000000 00000000
> [   18.274909][  T186] head1: 00000000 e7652fe1 00000101 ffffffff 00000000 00000000 ffffffff 00000000
> [   18.275633][  T186] head1: 00000000 00000000
> [   18.275996][  T186] head2: 00010200 e7652fe1 c0100bf0 00000400 edece900 000a0003 ffffffff 00000001
> [   18.276725][  T186] head2: edce5f81 00000000
> [   18.277093][  T186] head3: 00000000 e7653031 00000101 ffffffff 00000000 00000000 ffffffff 00000000
> [   18.277820][  T186] head3: 00000000 00000000
> [   18.278182][  T186] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
> [   18.278747][  T186] page_owner tracks the page as allocated
> [   18.279447][  T186] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 186, tgid 186 (udevadm), ts 18262675212, free_ts 18262044539
> ...
> 
> The page 'head' is actually 'raw' - 2, while page 'raw' seems
> corrupted as it has PG_head bit set, while PageTail() is also true. 
> 
> Another problem is 'raw-1' and 'raw' both points to 'raw-2', and
> if it is an order-2 compound page, the 'raw+1' should also points
> to 'raw-2' as 3 tail pages point to one head page. Or there is some
> switch(corrupted) between order-1 and order-2, as Vlastimil
> supsected in earlier reply?
> 
> Thanks,
> Feng
> 
>> > a further information not sure if it's helpful, [1][2] are both i386 based.
>> > we also tried to run boot tests on x86_64 upon commit 0af8489b02, whatever
>> > with or without CONFIG_DEBUG_PAGEALLOC/CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT,
>> > we never obseve similar issues (also run 999 times).
>> 
>> Yeah it looks very much like something that manifests only on i386 (perhaps
>> only in QEMU as well?) and never x86_64.
>> 
>> What might be interesting then is v6.1-rc1 with further modified config to
>> enabled CONFIG_SLUB_DEBUG and CONFIG_SLUB_DEBUG_ON. Maybe it will catch the
>> culprit sooner. Or maybe it will obscure the bug instead, unfortunately.
>> 
>> Thanks for all your effort!
>> 
>> > [1]
>> > boot results:
>> > =========================================================================================
>> > compiler/kconfig/rootfs/sleep/tbox_group/testcase:
>> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/1/vm-snb/boot
>> > 
>> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
>> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>> >            |             |             |             |             |             |             |             |             |
>> >            :999          0%           2:999          0%           1:999          1%          11:999         21%         208:999   dmesg.invalid_opcode:#[##]
>> >            :999          0%            :999          0%            :999          0%           2:999          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>> >            :999          0%           1:999          0%            :999          0%           4:999          4%          40:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>> >            :999          0%           1:999          0%           1:999          0%           4:999         11%         111:999   dmesg.kernel_BUG_at_lib/list_debug.c
>> >            :999          0%            :999          0%            :999          0%            :999          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>> >            :999          0%            :999          0%            :999          0%           1:999          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
>> > 
>> > [2]
>> > rcutorture results:
>> > =========================================================================================
>> > compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>> >   gcc-11/i386-randconfig-a012-20221226+CONFIG_DEBUG_PAGEALLOC+CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT/debian-11.1-i386-20220923.cgz/300s/vm-snb/default/rcutorture/tasks-tracing
>> > 
>> >             v6.0                    v6.1-rc1                    v6.1-rc2 56d5a2b9ba85a390473e86b4fe4 0af8489b0216fa1dd83e264bef8
>> > ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>> >        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>> >            |             |             |             |             |             |             |             |             |
>> >            :999          0%           3:999          0%            :999          1%           8:998         20%         200:999   dmesg.invalid_opcode:#[##]
>> >            :999          0%            :999          0%            :999          0%            :998          5%          51:999   dmesg.kernel_BUG_at_include/linux/mm.h
>> >            :999          0%            :999          0%            :999          0%           3:998          4%          42:999   dmesg.kernel_BUG_at_include/linux/page-flags.h
>> >            :999          0%           3:999          0%            :999          0%           4:998         10%         102:999   dmesg.kernel_BUG_at_lib/list_debug.c
>> >            :999          0%            :999          0%            :999          0%            :998          0%           2:999   dmesg.kernel_BUG_at_mm/page_alloc.c
>> >            :999          0%            :999          0%            :999          0%           1:998          0%           3:999   dmesg.kernel_BUG_at_mm/usercopy.c
>> > 
>> >> 
>> >> > 
>> >> > 
>> 
>> 

