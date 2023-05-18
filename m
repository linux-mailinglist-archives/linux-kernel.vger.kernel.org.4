Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CEC707A12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjERGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjERGKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:10:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014526B7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:10:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae6b4c5a53so1698395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684390214; x=1686982214;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdZ6lNhcTbmmawstm709fk1BlCRQMqv9MWk98EMtELc=;
        b=Hr9LZpzVKqkv/NoDxfKbctB0AkqASrbXWw0Y8F5k56hgMvxyAm9fH4SGHO7keZa3v4
         u3+Ko71OWoRFbnSermH4sg7VfGMb9e6sXM6F5aiYMaoNXUX09COMAYi2KqQr1+KGAV3u
         Y4G7qctWM2WE4LZE3PKhNkeMLhqRC8er1km548aD0YfjICyoLZhCTc4/3T+jXxmWw5en
         x9qWdJei7EuVQan81wAEX5lJ/SB9bGnFHEv4VWD9ft4UeDT3VDtQ2HPpc9SL1SaXa9JE
         w5m55F+x6epYun0g1dBBqgzsL3t/BkqDdf2ryUdj2DS0wAPI20ctIorQLSzNQGOZDp+F
         8IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684390214; x=1686982214;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EdZ6lNhcTbmmawstm709fk1BlCRQMqv9MWk98EMtELc=;
        b=aD4ZSMg8Zm7XmIlnjt1DuRE6CoaVlUR0rckRZO7RqdI3iHmWc8LIsVicdHzFN56eCX
         9D02RuGexuKAP2NfUsA1PzaMfaOw1OOARwtYPiI1NGothtC3fXa+DTaDYONIQaWee2ka
         RMdeSI25g5u/PgUi7wGY/zXeLZSD3D00l/M5rkBITZzQX0F94To8ZZ7yuRqOo49lNhWJ
         WVnFGvcxs+5IfG2A0aoVI8y8tm1saOGU/WluVM480Ajswten1M1YSJjHI9bP0ub73Igi
         I7uEQ8jL6Hi73xXlcBD3oIpTpiKxAAHrA+n9daRsRKwdwv/4S8eVTTLQl4/YsPlI2G94
         87eg==
X-Gm-Message-State: AC+VfDwyh2w7g9F1KKj61mTVT8s54K300YYKfmwLNX/OBWfsnnM1DovL
        0p/Vjqg4PZyH05H2VBIOeZDcHg==
X-Google-Smtp-Source: ACHHUZ51QNXw8Dk8XUEA5xx3HJZPUbxG8rgdCAe7mewpu3s98RFRjFORkhocUeOAp+Bri6Hv4tPxww==
X-Received: by 2002:a17:902:934a:b0:1ad:e364:10c7 with SMTP id g10-20020a170902934a00b001ade36410c7mr1384378plp.12.1684390213855;
        Wed, 17 May 2023 23:10:13 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001ac7c6fd129sm478744pln.43.2023.05.17.23.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 23:10:13 -0700 (PDT)
Message-ID: <d3e03ee2-284e-1e32-6273-cf21b4afcf99@bytedance.com>
Date:   Thu, 18 May 2023 14:10:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 01/10] maple_tree: Rework mtree_alloc_{range,rrange}()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-2-zhangpeng.00@bytedance.com>
 <20230517181705.rdfffvfhqzlsjjlm@revolver>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
In-Reply-To: <20230517181705.rdfffvfhqzlsjjlm@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/18 02:17, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:58]:
>> Use mas_empty_area{_rev}() to refactor mtree_alloc_{range,rrange}()
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> ---
>>   lib/maple_tree.c | 63 ++++++++++++++++++++++++------------------------
>>   1 file changed, 32 insertions(+), 31 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 4eb220008f72..e1820e90f167 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -6493,32 +6493,31 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>>   {
>>   	int ret = 0;
>>   
>> -	MA_STATE(mas, mt, min, min);
>> +	MA_STATE(mas, mt, 0, 0);
>>   	if (!mt_is_alloc(mt))
>>   		return -EINVAL;
>>   
>>   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>>   		return -EINVAL;
>>   
>> -	if (min > max)
>> -		return -EINVAL;
>> -
>> -	if (max < size)
>> -		return -EINVAL;
>> -
>> -	if (!size)
>> -		return -EINVAL;
>> -
>>   	mtree_lock(mt);
>>   retry:
>> -	mas.offset = 0;
>> -	mas.index = min;
>> -	mas.last = max - size + 1;
>> -	ret = mas_alloc(&mas, entry, size, startp);
>> -	if (mas_nomem(&mas, gfp))
>> -		goto retry;
>> -
>> +	ret = mas_empty_area(&mas, min, max, size);
>> +	if (!ret) {
>> +		mas_insert(&mas, entry);
>> +		/*
>> +		 * mas_nomem() may release the lock, causing the allocated area
>> +		 * to be unavailable, so try to allocate a free area again.
>> +		 */
>> +		if (mas_nomem(&mas, gfp))
>> +			goto retry;
>> +	}
>>   	mtree_unlock(mt);
>> +	if (!ret) {
> 
> Checking for a mas_is_err() should probably be outside if (!ret)
> statement.  If mas_insert() returns something besides ENOMEM, we will
> not detect the error.  I'm not sure if this is possible today since this
> should never return an -EEXISTS, but having it this way doesn't add much
> to the overhead.
I don't think there will be error that can't be detected here.
In fact, there are two sources of errors:

1. mas_empty_area(), the error number is in the variable ret,
    and may also be in mas->node, but ret must contain all errors.

2. mas_insert(), the error number is in mas->node

When we check errors, we should first check errors from
mas_empty_area(). If there is no error in mas_empty_area(), we
will check errors from mas_insert().
So, mas_is_err() is inside the if (!ret) statement, no problem here.

Of course, even if mas_insert() returns -EEXISTS, it can be detected
under the current encoding, because "if (!ret)" is true in this case.
But I don't think this can happen, if it happens, it's a bug of maple
tree.

I don't think it's good to put mas_is_err() outside, because the error
number stored in mas->node may come from mas_empty_area(). We should use
the ret variable to detect the error from mas_empty_area() first.
> 
>> +		if (mas_is_err(&mas))
>> +			return xa_err(mas.node);
>> +		*startp = mas.index;
>> +	}
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(mtree_alloc_range);
>> @@ -6529,29 +6528,31 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>>   {
>>   	int ret = 0;
>>   
>> -	MA_STATE(mas, mt, min, max - size + 1);
>> +	MA_STATE(mas, mt, 0, 0);
>>   	if (!mt_is_alloc(mt))
>>   		return -EINVAL;
>>   
>>   	if (WARN_ON_ONCE(mt_is_reserved(entry)))
>>   		return -EINVAL;
>>   
>> -	if (min > max)
>> -		return -EINVAL;
>> -
>> -	if (max < size - 1)
>> -		return -EINVAL;
>> -
>> -	if (!size)
>> -		return -EINVAL;
>> -
>>   	mtree_lock(mt);
>>   retry:
>> -	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
>> -	if (mas_nomem(&mas, gfp))
>> -		goto retry;
>> -
>> +	ret = mas_empty_area_rev(&mas, min, max, size);
>> +	if (!ret) {
>> +		mas_insert(&mas, entry);
>> +		/*
>> +		 * mas_nomem() may release the lock, causing the allocated area
>> +		 * to be unavailable, so try to allocate a free area again.
>> +		 */
>> +		if (mas_nomem(&mas, gfp))
>> +			goto retry;
>> +	}
>>   	mtree_unlock(mt);
>> +	if (!ret) {
> 
> Same here.
> 
>> +		if (mas_is_err(&mas))
>> +			return xa_err(mas.node);
>> +		*startp = mas.index;
>> +	}
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL(mtree_alloc_rrange);
>> -- 
>> 2.20.1
>>
