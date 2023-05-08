Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4622A6F9ECE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 06:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjEHExX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 00:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEHExV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 00:53:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B691569D;
        Sun,  7 May 2023 21:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ZnHBmSZtzyHbh3DRcxsOT9oQjgl/X0HxAfXgk7O0ayk=; b=PO++imuj8207+H1PWdTKvv8pdF
        umEF824b5MRQYspJ+evU66VEuRefMCoIYWZgq2oANHsSqgqW/8Wo4tEUvD3l3+t1Kb/16Bgvuk+oN
        fsRawoo2QwxkQ6SrRzu63sl4LueGmeI20PEvUG8dOIWVWaa5YalyfySJKNbfSgNPbIAzVvZ9ghJXE
        DX610JclugzIesrGnaT/JumuOg1KYvnKAamUkxO1eDG0+8Yvc2Hvrf4Jok0xxMXsXP8nt5KPvS7vG
        aHKFXWAfbBqf3PdBG8laqzba3Jc1nTBK4YZ+ulcLk2F+cusvDN1gCB0zNRHfEADfuazIsDUS0dN+w
        v+ZUbu9A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvss9-00HGG3-2m;
        Mon, 08 May 2023 04:53:17 +0000
Message-ID: <24a5daa4-2c6c-781d-bbb3-8f5a4f035c08@infradead.org>
Date:   Sun, 7 May 2023 21:53:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: build warnings after merge of Linus' tree
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230508144947.3ac1dfe9@canb.auug.org.au>
 <cccc2dc5-b4d5-3b2b-bd23-b63c20b1023a@infradead.org>
In-Reply-To: <cccc2dc5-b4d5-3b2b-bd23-b63c20b1023a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/23 21:52, Randy Dunlap wrote:
> 
> 
> On 5/7/23 21:49, Stephen Rothwell wrote:
>> Hi all,
>>
>> While building Linus' tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
>>  on line 11496 - I thought it was a doc line
>> kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>>  on line 11505 - I thought it was a doc line
>>
>> Introduced by commit
>>
>>   223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
>>
> 
> I have sent a patch:
>   https://lore.kernel.org/lkml/20230428031111.322-1-rdunlap@infradead.org
> but haven't seen any replies to it (possibly due to the merge window or travel).
> 

Oops, Peter did reply, but no info on merging it.

-- 
~Randy
