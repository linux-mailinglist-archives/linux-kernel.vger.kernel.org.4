Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D856ED453
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjDXS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXS1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:27:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BD5FE1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:27:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0632D1F74C;
        Mon, 24 Apr 2023 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682360859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCPgtZFEHFdO33L4qW+mtMOH4PY+cCivsZXH++p2zhc=;
        b=lxcmhjDiTbIW82m9qsZg6R8aXN3qWoRtJFAP3N5r8dsqevC0kcW3RmbWzWtFDWCnD/F+AP
        jpVS76G6R0Mwwzj/NqFJvLdCE01Wbq3ggxN00W0SNAwiqaPkgUt7VYL6yIB/5aVdddIhBD
        Gcv2qeBmv+hvC7inpjPObdouElyk5KM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682360859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCPgtZFEHFdO33L4qW+mtMOH4PY+cCivsZXH++p2zhc=;
        b=ib/RjeEzkiWcQFeEWiuV0AMzWF6BtlYYWEXsUUyAiUG8DxklSsm3TEy//IQCZlnZQoKFCo
        CVNJd+uA3S4iBKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D728213780;
        Mon, 24 Apr 2023 18:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GdRkMxrKRmQnTQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Apr 2023 18:27:38 +0000
Message-ID: <63f33512-f426-d808-5680-d5dfd8e0c9d2@suse.cz>
Date:   Mon, 24 Apr 2023 20:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] mm/slab: add a missing semicolon on
 SLAB_TYPESAFE_BY_RCU example code
Content-Language: en-US
To:     paulmck@kernel.org, SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230415033159.4249-1-sj@kernel.org>
 <20230415033159.4249-2-sj@kernel.org>
 <21cd0c00-4738-49f7-899f-ec3792520bfb@paulmck-laptop>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <21cd0c00-4738-49f7-899f-ec3792520bfb@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 19:43, Paul E. McKenney wrote:
> On Sat, Apr 15, 2023 at 03:31:58AM +0000, SeongJae Park wrote:
>> An example code snippet for SLAB_TYPESAFE_BY_RCU is missing a semicolon.
>> Add it.
>>
>> Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Or please let me know if you would like me to take it.  (Probably better
> going up through the usual slab route, though.)

Yeah will take it via slab after merge window, but was hoping you'd ack
that (mainly 2/2) as indeed the correct example first.

Thanks, Vlastimil

> 							Thanx, Paul
> 
>> ---
>>  include/linux/slab.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index f8b1d63c63a3..b18e56c6f06c 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -53,7 +53,7 @@
>>   * stays valid, the trick to using this is relying on an independent
>>   * object validation pass. Something like:
>>   *
>> - *  rcu_read_lock()
>> + *  rcu_read_lock();
>>   * again:
>>   *  obj = lockless_lookup(key);
>>   *  if (obj) {
>> -- 
>> 2.25.1
>>
