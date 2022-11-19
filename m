Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931EC630C1F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKSF1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSF0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:26:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A301BF593;
        Fri, 18 Nov 2022 21:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Oyh1N77AUIR8biKDA4ZZW31e5gFvL6G7BfYmUpcFkYs=; b=T86BOnrA6k/isow+Gz6LM8HKrq
        RuS6bXLabOUjY+GE8XqjpUGtS0pcdI7qr2m1e9avhc3BlDGzBVD9HAmL49dYR/70R7nvAlp/Ax0nm
        iHzUIl1bCauWQ/4639Oz3TNFJiinEiIWvYKDP5oKF2V8Mh0XTT9SCgem1CJk4a1nRRrKfef92Hfc7
        h3h631eiZ7TfnDPXYRpHjqaqcecnXxQdPxsDUFq2YbqTFocAAdy47F1kTaUDKNSlgguWl/iljTw+5
        FI1T+c4SXpc/KC3FKrHixzKOWTW9NaNHzCpxSwwUn/46pLT/02HZMHb3lWpr9b0dDmbBlxey4hexp
        810QqjPw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owGNM-00BNov-Th; Sat, 19 Nov 2022 05:26:49 +0000
Message-ID: <87c11d37-50ab-2c81-c454-d085c1fdff52@infradead.org>
Date:   Fri, 18 Nov 2022 21:26:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Cannot parse struct or union error on mm-everything
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
References: <Y3hXJ0D+qAwfpm7B@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y3hXJ0D+qAwfpm7B@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/22 20:10, Bagas Sanjaya wrote:
> Greetings,
> 
> I found a new htmldocs warning on mm-everything:
> 
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -internal ./include/linux/mm_types.h' failed with return code 1
> 
> Checking the header with './scripts/kernel-doc -v -none 
> ./include/linux/mm_types.h', I got the full error:
> 
> include/linux/mm_types.h:255: info: Scanning doc for struct encoded_page
> include/linux/mm_types.h:268: error: Cannot parse struct or union!
> include/linux/mm_types.h:287: info: Scanning doc for struct folio
> include/linux/mm_types.h:917: info: Scanning doc for typedef vm_fault_t
> include/linux/mm_types.h:924: info: Scanning doc for enum vm_fault_reason
> include/linux/mm_types.h:1028: info: Scanning doc for enum fault_flag
> 1 errors
> 
> The culprit is encoded_page struct, which is null struct (nonexistent type)
> with kernel-doc comments:
> 
> /**
>  * struct encoded_page - a nonexistent type marking this pointer
>  *
>  * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
>  * with the low bits of the pointer indicating extra context-dependent
>  * information. Not super-common, but happens in mmu_gather and mlock
>  * handling, and this acts as a type system check on that use.
>  *
>  * We only really have two guaranteed bits in general, although you could
>  * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
>  * for more.
>  *
>  * Use the supplied helper functions to endcode/decode the pointer and bits.
>  */
> struct encoded_page;
> 
> The struct is introduced by d57ab372568585 ("mm: introduce 'encoded' page
> pointers with embedded extra bits").

https://lore.kernel.org/all/CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com/

I guess that nobody has "fixed" it yet.

-- 
~Randy
