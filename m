Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD85FC87D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJLPhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJLPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:37:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD5DB746
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:37:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2453647pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2jK+cfoyd0vz00QrrKo8s95SUmryHgC+6RpgzWjESk=;
        b=eBOd2UuSqlSwTb9yRs9MMfT1V1SiZQCHtOSU7F47t8ziFbFGFkZ0e+tyi8d34iv6kx
         rNiNK6avWTnnQAJPDLH4IigRS/GKQpsADf2ZVslAZWUtPjkAhKXq1jbZ03VrRiEbbSND
         uUTGKNymB7vWRPisBFi1DL1Skav+Jl9aYtJKS1bKVWfb4QpkQFYdZP5m/PQgIvYhoIe+
         EEv91h8hfg2OtLZG8daMrXcavSz5o6sk4gmJC4hEzo54R5H502um6hiR15oFAjpxaqo/
         pv+PIGKJ/BbWfPqLow1394L7tX3huIw84EcSY+Cshm1tMxGTQ3BDD8lvKInGHSikIY3x
         KvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S2jK+cfoyd0vz00QrrKo8s95SUmryHgC+6RpgzWjESk=;
        b=KJyxEORUBFvvH/cMtbmbT77VQR8hiaWkBy1zkdS2gf/HlxnkgJ5e5DCYerGVrMfoip
         KVWbFey7fER3Gg/IfRZayTHpdSPq86QcJkP+QYhLzDMghPFVpVl7YEMwN90CPe00hdyq
         2Ai8scTOmg2ts1jbg/IAEktD5mIawUmYzZLMIBZAwN+Kyl/oxsJ5DXru7M4Cmhf2l458
         Piw7mN4xMklB+ANjUzH5vwL0PxAM6/HykEIT8XghyGX5IRMZ2AyAFKuViBEufCz/b1gJ
         lIp4u2TX0slBt4BBoLKn4K8iya8r5k8G9/2GYJwsk2OMBMaraSCjEQVCVMth8Bgjbep8
         5W0g==
X-Gm-Message-State: ACrzQf0z3EPbQLSexw6yTTjjoBHBYUNx4CP8dD2aMw1WlifqrFfAMumk
        d/d9ufBiupmR+BuRKuQ5buHydQ==
X-Google-Smtp-Source: AMsMyM6zMT5rB8y6CsFFXm1ViiLl06XxlM+uWUoIAm5MYoVEUa8Qy5VJ+MIob9kOJV5FH5dzgSaigA==
X-Received: by 2002:a17:903:2411:b0:184:7159:dce6 with SMTP id e17-20020a170903241100b001847159dce6mr4224709plo.101.1665589057095;
        Wed, 12 Oct 2022 08:37:37 -0700 (PDT)
Received: from [10.3.156.122] ([63.216.146.190])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a650b00b0020a821e97fbsm1664306pjj.13.2022.10.12.08.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:37:36 -0700 (PDT)
Message-ID: <c6f5d729-2083-817d-fe7d-b01bce27e39f@bytedance.com>
Date:   Wed, 12 Oct 2022 23:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [External] Re: [PATCH 3/5] cachefiles: resend an open request if
 the read request's object is closed
To:     JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
 <20221011131552.23833-4-zhujia.zj@bytedance.com>
 <28d64f00-e408-9fc2-9506-63c1d8b08b9c@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <28d64f00-e408-9fc2-9506-63c1d8b08b9c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/12 15:53, JeffleXu 写道:
> 
> 
> On 10/11/22 9:15 PM, Jia Zhu wrote:
>> @@ -254,12 +282,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>>   	 * request distribution fair.
>>   	 */
>>   	xa_lock(&cache->reqs);
>> -	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
>> -	if (!req && cache->req_id_next > 0) {
>> -		xas_set(&xas, 0);
>> -		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
>> +retry:
>> +	xas_for_each_marked(&xas, req, xa_max, CACHEFILES_REQ_NEW) {
>> +		if (cachefiles_ondemand_skip_req(req))
>> +			continue;
>> +		break;
>>   	}
>>   	if (!req) {
>> +		if (cache->req_id_next > 0 && xa_max == ULONG_MAX) {
>> +			xas_set(&xas, 0);
>> +			xa_max = cache->req_id_next - 1;
>> +			goto retry;
>> +		}
> 
> I would suggest abstracting the "xas_for_each_marked(...,
> CACHEFILES_REQ_NEW)" part into a helper function to avoid the "goto retry".
> 
Hi JingBo,

Thanks for your advice. Are the following revises appropriate？

static struct cachefiles_req *cachefiles_ondemand_select_req(struct 
xa_state *xas, unsigned long xa_max)
{
     struct cachefiles_req *req;
     struct cachefiles_ondemand_info *info;

     xas_for_each_marked(xas, req, xa_max, CACHEFILES_REQ_NEW) {
         if (!req || req->msg.opcode != CACHEFILES_OP_READ)
             return req;
         info = req->object->private;
         if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_close) {
             cachefiles_ondemand_set_object_reopening(req->object);
             queue_work(fscache_wq, &info->work);
             continue;
         } else if (info->state == CACHEFILES_ONDEMAND_OBJSTATE_reopening) {
             continue;
         }
         return req;
     }
     return NULL;
}

...

  xa_lock(&cache->reqs);
     req = cachefiles_ondemand_select_req(&xas, ULONG_MAX);
     if (!req && cache->req_id_next > 0) {
         xas_set(&xas, 0);
         req = cachefiles_ondemand_select_req(&xas, cache->req_id_next - 1);
     }
     if (!req) {
         xa_unlock(&cache->reqs);
         return 0;
     }
> 
>> @@ -392,8 +434,16 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>>   	wake_up_all(&cache->daemon_pollwq);
>>   	wait_for_completion(&req->done);
>>   	ret = req->error;
>> +	kfree(req);
>> +	return ret;
>>   out:
>>   	kfree(req);
>> +	/* Reset the object to close state in error handling path.
>> +	 * If error occurs after creating the anonymous fd,
>> +	 * cachefiles_ondemand_fd_release() will set object to close.
>> +	 */
>> +	if (opcode == CACHEFILES_OP_OPEN)
>> +		cachefiles_ondemand_set_object_close(req->object);
> 
> This may cause use-after-free since @req has been freed.
Thanks for catching this, I'll fix it in next version.
> 
> 
> 
