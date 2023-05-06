Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CB6F8DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjEFBs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEFBs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:48:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728B10E6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:48:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso2162703a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683337705; x=1685929705;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqIkgJf+LItUVuyr4G8d5Rjrbw8WsFdr0mCkPQUW1y8=;
        b=HyBWIOuBxrghu8QGTFyka7rvAfl5rGtcjtY6v8s/bm5sNtnkOsxW0JvnNr+y15RRdn
         NP2qtm2HdOq94SYYkZIAufPg4mMk2wPvkHO0uIwzu8on0tU0H4HzxSinvtGrjVBecKwh
         3wL/38ZWiYH3eAtV9Q/6Agw+8olF8rYmbIiyqq+tNWQRPQJXM0LdgNryFcsyPKo2JO6R
         79kAeG69cmfWgIIPC3VG9vYehKsASMFDfKrtIMr14pAgUF2o2CQH/zENOn4lka32q8XN
         cIPFTy9CvNtd6bjq5F9PzJX/q+fxnjucmOKQaX2hlDByim9WPvYDh3t3hmQWxAhhd4mP
         AJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683337705; x=1685929705;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqIkgJf+LItUVuyr4G8d5Rjrbw8WsFdr0mCkPQUW1y8=;
        b=Ozaa31nWPLUob1nmp7Y24LoX+NKovpYlBlIx4h+3ZdzsPz9IlD1ueMQzVfa/t5PZJ/
         y/KUaWJzw7p1qHJU+C5l0cOTN4oGRE/WgkBriu6b7/qepjCZXcJMk9olnusZWaIr4Ubb
         DpDubwImn45ZLRTdpRP9W2f/W1zcrQ8WSX+nhB4mFbb6s7e7ULoxZ4jC0tt73TRx8HPj
         72o/vEyqeJU97/pa4q82eyzI4n+cybdl0bYNskqPTYxQWF8Pir4czntA41wIHwtwQ7Jz
         rvbwenI4WTY2U99qwCC54wKlDMN+5qMKDF6qNSQZJOvT8yUJoXvJFQvZa5rj0Vbbzmin
         oW9w==
X-Gm-Message-State: AC+VfDxpuskAPf6W2sy/ZrGIMy28bSK1afYuVunR9r2WQvFur1kqghre
        bhvcoU9EKbQlQ1UtsZcpN0g=
X-Google-Smtp-Source: ACHHUZ5i5dtUZYcJMpTkCfn7HjyuXOSiaDosQ6ye1CxFKlbe4RWaI1Q+/9cIq9fKkeas1grYuJmgYg==
X-Received: by 2002:a17:90a:b390:b0:250:4644:d3fa with SMTP id e16-20020a17090ab39000b002504644d3famr1330209pjr.34.1683337705267;
        Fri, 05 May 2023 18:48:25 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a408500b0024c1ac09394sm5725311pjg.19.2023.05.05.18.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 18:48:24 -0700 (PDT)
Message-ID: <1570feed-489c-82f7-8d6b-9f53e9ebb87e@gmail.com>
Date:   Sat, 6 May 2023 09:48:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] maple_tree: Fix potential out-of-bounds access in
 mas_wr_end_piv()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230504031422.47506-1-zhangpeng.00@bytedance.com>
 <20230506011447.2e47mf5kwwo4yz4r@revolver>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230506011447.2e47mf5kwwo4yz4r@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/6 09:14, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230503 23:14]:
>> Access to the pivots array may be out of bounds. Fix it by changing the
>> code to ensure that the index of the pivots does not go out of bounds.
>> It is difficult to assess user-visible impact.
> 
> This is indeed an issue.  There isn't any user-visible impact for
> current node types, since the overflow will access the slots and be
> corrected in the next if clause, but it's certainly better to fix this.
> 
> The commit message is also not as descriptive as necessary, perhaps
> something like:
> 
> Check the write offset end bounds before using it as the offset into the
> pivot array.  This avoids a possible out-of-bounds access on the pivot
> array if the write extends to the last slot in the node, in which case
> the node maximum should be used as the end pivot.
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
>>
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> 
> Cc stable ?
I don't know if it should be cc stable since Andrew says it
always needs to describe user-visible impact.
> 
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 110a36479dced..5a49327444d76 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -4263,11 +4263,13 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>>   
>>   static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>>   {
>> -	while ((wr_mas->mas->last > wr_mas->end_piv) &&
>> -	       (wr_mas->offset_end < wr_mas->node_end))
>> -		wr_mas->end_piv = wr_mas->pivots[++wr_mas->offset_end];
>> +	while ((wr_mas->offset_end < wr_mas->node_end) &&
>> +	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
>> +		wr_mas->offset_end++;
>>   
>> -	if (wr_mas->mas->last > wr_mas->end_piv)
>> +	if (wr_mas->offset_end < wr_mas->node_end)
>> +		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>> +	else
>>   		wr_mas->end_piv = wr_mas->mas->max;
>>   }
>>   
>> @@ -4424,7 +4426,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
>>   	}
>>   
>>   	/* At this point, we are at the leaf node that needs to be altered. */
>> -	wr_mas->end_piv = wr_mas->r_max;
>>   	mas_wr_end_piv(wr_mas);
>>   
>>   	if (!wr_mas->entry)
>> -- 
>> 2.20.1
>>
