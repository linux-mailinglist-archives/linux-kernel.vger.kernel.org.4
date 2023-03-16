Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD76BC91C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCPI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:29:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F6949EC;
        Thu, 16 Mar 2023 01:29:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8C21FDEC;
        Thu, 16 Mar 2023 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678955370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVCXY5Bgz2RHJRsH5WCaGi/r+E4g7WP8V9UNBAtw7ik=;
        b=k2M4YZj3WVXFea2cQaYpLXlM5isJrO/4UuFm2CDDxNYtQu+SMXaxMs8VV0/JmZitJXnX1C
        9NQtwPDNh9XyhN70/Q068MzJnS4Up/kgyFjlOoGjalECVh5DziO4veUtSegqR25MrQT/ax
        ZXiQuENZflKlfvAh791pTfyRP6y4/74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678955370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVCXY5Bgz2RHJRsH5WCaGi/r+E4g7WP8V9UNBAtw7ik=;
        b=QBZAtFCFRyt/EAGU1flndM8xAD66jbXQ1npZV7Sd9VBo7zb+IBuQ2GmVKV88+8s1EDl/4S
        /x9y/5R8O0av49BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B6DF13A2F;
        Thu, 16 Mar 2023 08:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GAGYHWrTEmQ4IgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Mar 2023 08:29:30 +0000
Message-ID: <c5d9c8b4-663c-c00f-438b-f104e1228ef7@suse.cz>
Date:   Thu, 16 Mar 2023 09:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ring-buffer: remove obsolete comment for
 free_buffer_page()
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Mike Rapoport <mike.rapoport@gmail.com>
References: <20230315142446.27040-1-vbabka@suse.cz>
 <72de48c7-014d-80ac-51e9-ba22450f1d5b@quicinc.com>
 <1cb12058-f59e-1433-6ba6-f500be250996@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1cb12058-f59e-1433-6ba6-f500be250996@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 16:53, Mukesh Ojha wrote:
> 
> 
> On 3/15/2023 9:21 PM, Mukesh Ojha wrote:
>> 
>> 
>> On 3/15/2023 7:54 PM, Vlastimil Babka wrote:
>>> The comment refers to mm/slob.o which is being removed. It comes from
> 
> nit: mm/slob.c

Thanks, Steven can you fix that up while picking the patch, or need v2?

> -- Mukesh
> 
>> 
>> 
>>> commit ed56829cb319 ("ring_buffer: reset buffer page when freeing") and
>>> according to Steven the borrowed code was a page mapcount and mapping
>>> reset, which was later removed by commit e4c2ce82ca27 ("ring_buffer:
>>> allocate buffer page pointer"). Thus the comment is not accurate anyway,
>>> remove it.
>>>
>>> Reported-by: Mike Rapoport <mike.rapoport@gmail.com>
>>> Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> Fixes: e4c2ce82ca27 ("ring_buffer: allocate buffer page pointer")
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>>   kernel/trace/ring_buffer.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>>> index af50d931b020..c6f47b6cfd5f 100644
>>> --- a/kernel/trace/ring_buffer.c
>>> +++ b/kernel/trace/ring_buffer.c
>>> @@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page 
>>> *bpage)
>>>       local_set(&bpage->commit, 0);
>>>   }
>>> -/*
>>> - * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
>>> - * this issue out.
>>> - */
>> 
>> Thanks for the clean up.
>> 
>> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks.

>> 
>> -- Mukesh
>> 
>>>   static void free_buffer_page(struct buffer_page *bpage)
>>>   {
>>>       free_page((unsigned long)bpage->page);

