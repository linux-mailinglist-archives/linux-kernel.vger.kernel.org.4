Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499125B9419
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIOGIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIOGH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:07:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EE89809
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 23:07:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d82so17031435pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 23:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=ibO/wc2BrsXme6DE9SPHSIz2siu6/IST8u9oC8WZEquf/PZPbSZhvpQXmnHJvCRxY6
         P3P650X4Z6WQWqQoseR9qY9nnLo2AX/7WsCZeowWK7NL/MKoQUumTE1nOIeRMnp5zKJU
         smkb/ahHd7vLyMjcyF5Y3e3uyg/PPasvZb3VP2kbqY6flS59cC38dMMbusPYVuZb+bk5
         no4MQLvhxUIAOZ9XCgipS5DQkvNKO/ku8eGAZV07XkW0stvUSLsIX3le+noyLTfEi1b1
         8C293LGqPosYXxLNH7Ul8uZtcnn9FooQxc429gR5PnN650ZUBD6On+R+icpBcU2wzHJ+
         DEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VQwNXHpMcNzMWvwc/Da6V70id6z3bbhtKYXslcr+kJo=;
        b=0VzoqA1jSynEzEw4bq5UatXYtAZotfWyg4GCubvVmqGvhKXWXwqL9Al5rJu42UQRXq
         xJvgdKR7poBJbZgWzFL1KY9+9kIf8pO0p9x3pS/40/SElXrmzoVWYPevM4XJPZLZ74oA
         F16leYyH+CayBtJRSds96OtdtKAO3lCq11lIDYRam5AOsPQzD+dvUIyS3CcE3bUOz3Wk
         +pNKqj4u0lTYtCMZYyTi+zWfvcgmnsQCPot38wTP8/Fkc/68vY/D/1HzA9R/eOCIvJqx
         YJQ6Zv0DCMxpSH7aj6tUmbgXthGRiCoV65YujO+dIp20DFwyW7CTV88Uwx+/ap67UUi+
         p0SQ==
X-Gm-Message-State: ACgBeo1eMl/QBhDVoXOGHdpbRgxVL35arSads5+GhlGgG7Thek68Zx9a
        M6fkdvcrtCK/cvg3Sx43OBcWXQ==
X-Google-Smtp-Source: AA6agR5KvTTWQBLOtQc+SAEQY+Ih2ccYRNJQUpPrsBPvLtYvYnw1Qsqe03kAV4U82cJFEsw36KS0/A==
X-Received: by 2002:a63:1e11:0:b0:41c:d233:31f8 with SMTP id e17-20020a631e11000000b0041cd23331f8mr34969128pge.228.1663222075779;
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Received: from [10.76.37.214] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u197-20020a6279ce000000b00540e1117c98sm11247458pfc.122.2022.09.14.23.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 23:07:55 -0700 (PDT)
Message-ID: <6da8b963-610c-9692-192f-aa611e64ac82@bytedance.com>
Date:   Thu, 15 Sep 2022 14:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH V3 1/6] erofs: use kill_anon_super() to
 kill super in fscache mode
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
 <20220914105041.42970-2-zhujia.zj@bytedance.com>
 <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <b8d9aaac-6e91-f760-c9bc-ac270eecefa6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/15 10:28, JeffleXu 写道:
> 
> 
> On 9/14/22 6:50 PM, Jia Zhu wrote:
>> Use kill_anon_super() instead of generic_shutdown_super() since the
>> mount() in erofs fscache mode uses get_tree_nodev() and associated
>> anon bdev needs to be freed.
>>
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
> Thanks. You're welcome to use "Suggested-by" in this case. The same with
> patch 2.
> 
OK, thanks for your suggestion and review.
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 3173debeaa5a..9716d355a63e 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
>>   	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
>>   
>>   	if (erofs_is_fscache_mode(sb))
>> -		generic_shutdown_super(sb);
>> +		kill_anon_super(sb);
>>   	else
>>   		kill_block_super(sb);
>>   
> 
> Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> 
