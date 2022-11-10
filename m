Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A49623DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiKJIhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiKJIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:37:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12325209A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:37:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD46233921;
        Thu, 10 Nov 2022 08:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668069436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6V5hKKGu3v1+LAYo3Y1CZXcFGnq/6skCmrLZL7X5ZHA=;
        b=y1tUkKJzhASIt8eQwU/QPh+wy6Uvi8vX2zmgPtIlnc5+UhL+7quEhEdom0BEDM0Z6yxEPJ
        82T00CKq6ifLDvdMthBxRhxq0QlOaWe10rYHyc8Csrrjn5hliSpWi9j4tnn7EaoJYSUYRY
        x2J1aptazPYI5qGhwshyaWb62oa7JNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668069436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6V5hKKGu3v1+LAYo3Y1CZXcFGnq/6skCmrLZL7X5ZHA=;
        b=YufNe2XWyz5tA6lJ/MTKEBMVScc/94PlCqN68PhDYC5HVn1mpAem2HvcyoLTWBIrpJy2wQ
        rUH3ejKrflcKxoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AD121332F;
        Thu, 10 Nov 2022 08:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T5UIITy4bGNERgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Nov 2022 08:37:16 +0000
Message-ID: <8e4080f8-7021-1c02-56cf-a105a5141abd@suse.cz>
Date:   Thu, 10 Nov 2022 09:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCHv2] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
References: <20221011145413.8025-1-aahringo@redhat.com>
 <931c87d8-5856-e393-7108-66275ee4099a@suse.cz>
 <CAK-6q+ho0+mDP08yXvg7vupC-+GdUUY4zUHdfwU_7Q=B2VbQ-Q@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAK-6q+ho0+mDP08yXvg7vupC-+GdUUY4zUHdfwU_7Q=B2VbQ-Q@mail.gmail.com>
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

On 10/14/22 13:59, Alexander Aring wrote:
> Hi,
> 
> On Fri, Oct 14, 2022 at 3:35 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/11/22 16:54, Alexander Aring wrote:
>> > This patch will add a comment for the __GFP_ZERO flag case for
>> > kmem_cache_alloc(). As the current comment mentioned that the flags only
>> > matters if the cache has no available objects it's different for the
>> > __GFP_ZERO flag which will ensure that the returned object is always
>> > zeroed in any case.
>> >
>> > I have the feeling I run into this question already two times if the
>> > user need to zero the object or not, but the user does not need to zero
>> > the object afterwards. However another use of __GFP_ZERO and only zero
>> > the object if the cache has no available objects would also make no
>> > sense.
>>
>> Hmm, but even with the update, the comment is still rather misleading, no?
>> - can the caller know if the cache has available objects and thus the flags
>> are irrelevant, in order to pass flags that are potentially wrong (if there
>> were no objects)? Not really.
> 
> No, the caller cannot know it and that's why __GFP_ZERO makes no sense
> if they matter only if the cache has no available objects.
> 
>> - even if cache has available objects, we'll always end up in
>> slab_pre_alloc_hook doing might_alloc(flags) which will trigger warnings
>> (given CONFIG_DEBUG_ATOMIC_SLEEP etc.) if the flags are inappropriate for
>> given context. So they are still "relevant"
>>
> 
> yes, so they are _always_ relevant in the current implementation. Also
> as you said the user doesn't know when they become relevant or not..
> 
>> So maybe just delete the whole comment? slub.c doesn't have it, and if any
>> such comment should exist for kmem_cache_alloc() and contain anything useful
>> and not misleading, it should be probably in include/linux/slab.h anyway?
>>
> 
> ctags brought me there, but this isn't a real argument why it should
> not be in the header file...
> 
> I am not sure about deleting the whole comment as people have an vague
> idea about how kmem_cache works and still need to know for __GFP_ZERO
> that it will always zero the memory, but thinking again somebody will
> make the conclusion it does not make sense as the user doesn't know
> when objects are reused or allocated. Having that in mind and reading
> the current comment was making me do more investigations into the
> internal behaviour to figure out how it works regarding __GFP_ZERO.

So, I did the following, which IMHO resolves the misleading parts and also
mentions __GFP_ZERO. Sounds OK?

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.2/cleanups&id=d6a3a7c3f65dfebcbc4872d5912d3465c8e8b051

