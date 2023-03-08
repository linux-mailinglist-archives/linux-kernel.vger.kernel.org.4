Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1486B04B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCHKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCHKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:39:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D885168A2;
        Wed,  8 Mar 2023 02:39:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C981F21A0C;
        Wed,  8 Mar 2023 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678271948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNZPDd1h+V7c8y4zbj3TUyGQ4AIRsQ8PJ9MlbnzDo+A=;
        b=vkOnQ1gEmHEclBKwGNUyQvnWPcskuZJZjqA2ec8jNzh3vPISlrZYDAjOZTNfxLB6NsiGHa
        1QjN5PPCzkQ1oLxoqv0zTVyGq4No6KKVEmvJRPmvbn0YL1p0WmG+GRPmOo1goxeGdZGPND
        r+s25UhN+nrMPEWJCWEdSU26Qa7K9Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678271948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNZPDd1h+V7c8y4zbj3TUyGQ4AIRsQ8PJ9MlbnzDo+A=;
        b=NrmAxNRa9WBs1/vFXW7SeQXuv5AOB60b3HPiSqsC1utUFtBtVwgEW3hxyDt9l6YfXOFWvH
        wZGz9xNc3sZK9yAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2DD51391B;
        Wed,  8 Mar 2023 10:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 24+SJsxlCGSeYwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 10:39:08 +0000
Message-ID: <43f35191-9147-0aec-cb57-0bc14d041039@suse.cz>
Date:   Wed, 8 Mar 2023 11:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
 <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
 <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
 <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
 <87jzzu7jt9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87jzzu7jt9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/23 02:25, Huang, Ying wrote:
> Hi, Linus,
> 
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Sat, Mar 4, 2023 at 3:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>
>>> Ah. Ying did it this way:
>>
>> Yeah, I saw that patch flying past, but I actually think that it only
>> silences the warning almost by mistake. There's nothing fundamental in
>> there that a compiler wouldn't just follow across two assignments, and
>> it just happens to now not trigger any more.
>>
>> Assigning to a union entry is a more fundamental operation in that
>> respect. Not that the compiler still doesn't see that it's assigning a
>> value that in the end is not really type compatible, so a different
>> version of gcc could still warn, but at that point I feel like it's
>> more of an actual compiler bug than just "oh, the compiler didn't
>> happen to follow the cast through a temporary".
> 
> Yes.  Your fix is much better.  This can be used for
> __page_set_anon_rmap() family too to make the code look better?

Those are trickier due to the PAGE_MAPPING_ANON tagging bit which your
code doesn't need to handle because you can simply store an untagged
anon_vma pointer. Otherwise we could have the union at the struct page
level already (but probably not at this point as IIRC Matthew is
planning to have completely separate types for anon and file folios).

So right now we have e.g. folio_get_anon_vma() using unsigned long as
the intermediate variable, page_move_anon_rmap() using a void *
variable, __page_set_anon_rmap() casting through a (void *) ... Is there
a single recommended way for "tagged pointers" that we could unify that to?

> Best Regards,
> Huang, Ying
> 
