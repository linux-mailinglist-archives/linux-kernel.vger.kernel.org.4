Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B26A5152
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB1Ckp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Ckm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:40:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95AA1715D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:40:40 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h8so5638782plf.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1677552040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er0wiiBkQdwOG2u7UEGoJlR0ZlFwp2/vH39oGy8P/R4=;
        b=fA1Z/s75eS1borChXO4aytMs1rkzmmjmTG6QPuJ5gcDH6TviWQRBJO1GQPBzY4aMWr
         /3iPp/0VNobFzlclieU+mWKwo6RMUcnc8tHnNs4QwKxR2UFwHCu4ZpaJnJhkPleyugyI
         YQvuqLOMCHgNtsgMNMBa0AJ5FnX6GVy6tNV2BjDRCxq441lmSNZeczQSR43GFIw7vt2j
         zhbmbDSPOAgGUBw1TyLGShquqLWb06HdsePHMntFPOqkIj7NwBU4wTa8M5yb/eF+ZIYP
         QI1pL3D/mealJ7pNbYXBeuXzW22XRiWSTCiyiHrHxmAzYimj93wqt8sOlSnoVtzodJwp
         msRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677552040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Er0wiiBkQdwOG2u7UEGoJlR0ZlFwp2/vH39oGy8P/R4=;
        b=CMq5uv06+1SKPtmxT4vtp8eZ9bDqK4M/JzJH1zw4e3JeuUqjU/ibBgSPYZWoiAZgA4
         pNPrIpJHVx9hABgOBTpU8aLweC5jp0zFoGN0p2uY3PB9zh+RZETHGCVHL/YkRlct//vS
         hwVugLJyYjpLafI8H1krWEBq/U/LZn6aegEYgiHM7zBUTSTl6/UNQ+6VzIQd3ighABCX
         YcgMugUva2IyWmLJ1wIoqo+yHELCiD72zoqzW9X8TLWwQs+ajKwzlaXc+fpE07GVR8ES
         WfRjdiEMNo7bVsj1e9Nnbl8nqF5xSVUH10rAJglgn/gRTg3XPNjgzBhV5oa/RXoL5ES4
         gqEA==
X-Gm-Message-State: AO0yUKWrKy8hi7UHcLhV4ocMgiyOg53Ex2vaJAomVctBt+f/zg3WpLYU
        J0nrBe9xeA9JIq6h6zr6BXowUg==
X-Google-Smtp-Source: AK7set8G1TvRtTwvO7FHLKuWq9z5Fh7I0YrV/BsgKo9K9H42mGvzGIhDwQszGK2XvWd+/aOTMc6+zw==
X-Received: by 2002:a17:902:e80a:b0:19b:afb:b92e with SMTP id u10-20020a170902e80a00b0019b0afbb92emr1356669plg.40.1677552040262;
        Mon, 27 Feb 2023 18:40:40 -0800 (PST)
Received: from [10.54.24.141] ([143.92.118.2])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902d34a00b0019c93a9a854sm5206307plk.213.2023.02.27.18.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 18:40:39 -0800 (PST)
Message-ID: <0222742e-3c31-b75d-6027-3b6da2be16be@shopee.com>
Date:   Tue, 28 Feb 2023 10:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] cpuset: Remove unused cpuset_node_allowed
To:     Waiman Long <longman@redhat.com>
Cc:     lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230227080719.20280-1-haifeng.xu@shopee.com>
 <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <9953284e-05da-56b0-047d-ecf18aa53892@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/27 22:56, Waiman Long wrote:
> On 2/27/23 03:07, Haifeng Xu wrote:
>> Commit 002f290627c2 ("cpuset: use static key better and convert to new API")
>> has used __cpuset_node_allowed instead of cpuset_node_allowed to check
>> whether we can allocate on a memory node. Now this function isn't used by
>> anyone, so we can remove it safely.
>>
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>   include/linux/cpuset.h | 12 ------------
>>   1 file changed, 12 deletions(-)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index d58e0476ee8e..7fad5afe3bba 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -82,13 +82,6 @@ int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
>>     extern bool __cpuset_node_allowed(int node, gfp_t gfp_mask);
>>   -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>> -{
>> -    if (cpusets_enabled())
>> -        return __cpuset_node_allowed(node, gfp_mask);
>> -    return true;
>> -}
>> -
>>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>   {
>>       return __cpuset_node_allowed(zone_to_nid(z), gfp_mask);
>> @@ -223,11 +216,6 @@ static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
>>       return 1;
>>   }
>>   -static inline bool cpuset_node_allowed(int node, gfp_t gfp_mask)
>> -{
>> -    return true;
>> -}
>> -
>>   static inline bool __cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>>   {
>>       return true;
> 
> The kernel convention is to add a "__" prefix to a function name if there is higher level helper without the "__" prefix that uses it. Since cpuset_node_allowed() is no longer used. We should just rename __cpuset_node_allowed() to cpuset_node_allowed() and get rid of the unused helper. A bit more code changes are needed for this, though.
> 
> Cheers,
> Longman
> 

Maybe we can still use cpuset_node_allowed in __cpuset_zone_allowed? If so, less code need to be changed.

Thanks.
