Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C649A65C20B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjACOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbjACOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:37:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D6AFD3F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22B653EE9E;
        Tue,  3 Jan 2023 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672756617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxhFS7I2ISoqjLRhc7J0LagWlzINz+tb8rFIcAjGTX0=;
        b=24UqXN8rZGqaZh//q7UjI5E04o6yRatG16Cr7x7D0/TjxBvFMwnYnTDMhrImH02s2AyeFc
        KtV4/FZq1WUw4w4Yq7RJ9tmPlBbviakfBkdv+xuBhZ1DwI7kyQuNOWwe+h5EH4qElIKrU1
        tR4g8tVUJDWD/eVkZ3eFYNVFS9dAHdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672756617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxhFS7I2ISoqjLRhc7J0LagWlzINz+tb8rFIcAjGTX0=;
        b=rOXhukERf7zQ/Sho+7sdLPsIsufjxM1JR5DVj/6pO0bbb1E5O0Gce4I4PHjuFGy3pV/r2U
        1Fzos6SCJ8LRqLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E12271392B;
        Tue,  3 Jan 2023 14:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WYEBNog9tGMtTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 03 Jan 2023 14:36:56 +0000
Message-ID: <8097505c-66a6-f60d-d8aa-2c36062813ff@suse.cz>
Date:   Tue, 3 Jan 2023 15:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 14:46, Oliver Sang wrote:
> hi,
> 
>> 
>> Yet the page owner info tells us, 0x2daee was most recently used as order-1,
>> and now it seems to be (based on the raw struct page dump) sitting on a pcplist.
>> 
>> So the events leading up to this could be something like:
>> 
>> - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
>> - despite being on partial list, it's freed ???
>> - somebody else allocates order-2 page 0x2daec and uses it for whatever,
>> then frees it
>> - 0x2daec is reallocated as order-1 slab from names_cache, then freed
>> - we try to allocate from the slab page 0x2daee and trip on the PageTail
>> 
>> Except, the freeing of order-2 page would have reset the PageTail and
>> compound_head in 0x2daec, so this is even more complicated or involves some
>> extra race?
> 
> FYI, we ran tests more up to 500 times, then saw different issues but rate is
> actually low
> 
> 56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :500         12%          61:500   dmesg.invalid_opcode:#[##]
>            :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
>            :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
>            :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
>            :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
>            :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c

Hm even if rate is low, the different kinds of reports could be useful to
see, if all of that is caused by the commit.

>> 
>> In any case, this is something a debug_pagealloc kernel could have a chance
>> of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
>> and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
>> configuration, and repeat the test?
> 
> ok, we are starting to test by these 2 additional configs now.

Great, thanks!


