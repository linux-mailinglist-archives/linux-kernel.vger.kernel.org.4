Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89E5B6703
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIMEhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiIMEhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:37:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2835F61
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:36:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z187so10588022pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 21:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=9SHXWUEc8+WV+LeDXW4eEXPOgYcfsNmtwn8kPQPqdbs=;
        b=HnvnR19MbXdptGwdmVxul13UFRyv+ZEuSS++a2VHlPbeX4OF4fXegWzIhzw47jbPVL
         MB6svwYYkTXR7N52HdU6FZFYQahbZeblPiLxgVQsHtuVY+cJ9CDRVbZnyKM5AKRmGin9
         pCsvDi2+PXYqTC8WSDJhaNWsxZDQf4LwjvYkub4vkoTzhR6xH9JZU/2M7AfbL0/OyLko
         bUzemPU91bzcyMQrRQSSZu/EQQ+113/xMwZzRxni4Gq8xflL47ZUlzFGciheY1W4NUXl
         8kBtNJc6AAbC88oSNcGZIHba96aDmbzA57uGzWxLYvuCgGje7pGEvKJSkI5/XS/WKLyx
         R04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=9SHXWUEc8+WV+LeDXW4eEXPOgYcfsNmtwn8kPQPqdbs=;
        b=I7dB2ybTNaCcnkmSDc/Alu+zEoX8tMx6M0bw8zAAEW56nUBPFxxaXj++wqh/O3Khwd
         DRZrEfpBkot9Lg48vhpzIDN2Vn8FSrD9UwhpmZLBH0tYfWW7J+G9IMUqILN7VJqgZfBs
         daOTyITbdVOI+qc6een1ABARuENBk3snQCIxAEZnsnhzfkJ5CvM6k+2QqI5Q/gtG0ZI8
         Pj/TOD9e7wk6eYm+CB29gtLRD2mziC4QWsab/tfReG30ca4e+auo1NdFdLlFSPsF46Cx
         zP49rdTw0+ZCEBt1s5+IWc8bScXTBxBHmzpgByFhMr40bjI6Thmo7NuKKrYKTVM13e0x
         x7gg==
X-Gm-Message-State: ACgBeo0kpZOk1UOrALJoOrsg+wytJJFXmwGx4Kjmvyb8GRNO+GVdvtyo
        +9ipNIUsE7RH0dm7A/MPa9KaZg==
X-Google-Smtp-Source: AA6agR7RN4cIMrcl8WzVnYh07kBxd96P6zBiy+X6KQEm24uwTXoJnN6+fYILdgi8BTKG0Fc+F3HHvA==
X-Received: by 2002:aa7:9247:0:b0:544:6566:8ba0 with SMTP id 7-20020aa79247000000b0054465668ba0mr6638777pfp.11.1663043762194;
        Mon, 12 Sep 2022 21:36:02 -0700 (PDT)
Received: from [10.76.37.214] ([114.251.196.101])
        by smtp.gmail.com with ESMTPSA id s129-20020a625e87000000b00537b1aa9191sm6696654pfb.178.2022.09.12.21.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 21:36:01 -0700 (PDT)
Message-ID: <babdb60b-227a-ac37-8fda-367556987c3f@bytedance.com>
Date:   Tue, 13 Sep 2022 12:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V2 3/5] erofs: add 'domain_id' prefix when
 register sysfs
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, huyue2@coolpad.com,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-4-zhujia.zj@bytedance.com>
 <539dcc26-a250-5bf4-0f3c-a3f7cdc2ce48@linux.alibaba.com>
 <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <fc63c7ed-bffe-4127-7622-a7ce0c4b4378@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/9 17:26, JeffleXu 写道:
> 
> 
> On 9/9/22 5:23 PM, JeffleXu wrote:
>>
>>
>> On 9/2/22 6:53 PM, Jia Zhu wrote:
>>> In shared domain mount procedure, add 'domain_id' prefix to register
>>> sysfs entry. Thus we could distinguish mounts that don't use shared
>>> domain.
>>>
>>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>>> ---
>>>   fs/erofs/sysfs.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>>> index c1383e508bbe..c0031d7bd817 100644
>>> --- a/fs/erofs/sysfs.c
>>> +++ b/fs/erofs/sysfs.c
>>> @@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
>>>   int erofs_register_sysfs(struct super_block *sb)
>>>   {
>>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>> +	char *name = NULL;
>>>   	int err;
>>>   
>>> +	if (erofs_is_fscache_mode(sb)) {
>>> +		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
>>> +				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
>>> +				sbi->opt.fsid);
>>> +		if (!name)
>>> +			return -ENOMEM;
>>> +	}
>>
>>
>> How about:
>>
>> name = erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id;
>> if (sbi->opt.domain_id) {
>> 	str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
>> 	name = str;
>> }
> 
> Another choice:
> 
> if (erofs_is_fscache_mode(sb)) {
> 	if (sbi->opt.domain_id) {
> 		str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id, sbi->opt.fsid);
> 		name = str;
> 	} else {
> 		name = sbi->opt.fsid;
> 	}
> } else {
> 	name = sb->s_id;
> }
> 
> 
Thanks for your advise, this version looks more intuitive. I'll apply it
in next version.
> 
> 
>>
>>
>>>   	sbi->s_kobj.kset = &erofs_root;
>>>   	init_completion(&sbi->s_kobj_unregister);
>>>   	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
>>> -			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
>>> +			name ? name : sb->s_id);
>>
>> 	kobject_init_and_add(..., "%s", name);
>> 	kfree(str);
>>
>> though it's still not such straightforward...
>>
>> Any better idea?
>>
>>
>>> +	kfree(name);
>>>   	if (err)
>>>   		goto put_sb_kobj;
>>>   	return 0;
>>
> 
