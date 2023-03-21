Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37F16C2DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCUJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCUJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:27:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA59399CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:27:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so56975003edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679390868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWnJgjQ93w6SrSZybnW5oYGdeemUGWJuHANAQYKsgF4=;
        b=dbk+75smRmsWu0FSXEBoOJG1l2lc056LY+WiF9fHove/PNNgOAVxaYc3ckvgEFQgMc
         XAQnt9w2eP+Q6/CXdCMkv27x86ukbT19efJaNc/4vytaEcO9ZIPZI74nVr5llv2AcIMf
         0XrpPSTvHEUYB5Sh+UKANDObBwhdhEUtmt75Mc8gW7KE5Zn30mBnYV/Hk6CcSuzOz8vc
         vWgpf6nLBVffKQhbfi0LaDTlcnzaJPAmkru/I4xTTtLJrdmXNgVUnP6AGB4spn4hLNZN
         95yy7Iv+LPBcKLzzqeWul6pYxq3KU4b32phh2V2T/Uusl1ikW10kS1xlBMZ93nYZJqNC
         3K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWnJgjQ93w6SrSZybnW5oYGdeemUGWJuHANAQYKsgF4=;
        b=1E15pEYbkd4qKBo7E/AL61gDf9Go5QinCy87yiCJAxRavoefxLG0QlJqq4kUWs0lfI
         1rHGXXKIAvAAvs6bGk2RGdPA0L+m65QW3v4riGWPeADjzETWKDG49Axy1O1SLduZhu8t
         FdtJ8pbVGd86xQCvWsVUOjS2HhL0N+nbKqaSNhF1F/L7rPFNJ+6O5UWL1c0Mlx5NwZl4
         TduOt74BXxct1+JYCVAkA09KICVvW9aiN8WA/AliR2sTE71MBgrdWgC36ZKB+GuHHLld
         Wk+DM4KL90ItW6rOByDWmcAYk08r+lCJX1CsxOMkvJnIw9uB2t62I+wo2Son6Fu++id/
         gqAw==
X-Gm-Message-State: AO0yUKXyyZL0SeeXyik6f5Q3eNlN9PlYml6li4SPXmbA90ts/mVHvx5o
        Ph2sf04QXEJxh8XpGAhhtirSvJKskMTK64IXp48=
X-Google-Smtp-Source: AK7set9IAb32eYYhvr/A+7YQlOXbQM+FDcyhVUzEyLR8kJMqn6AaqKtnfqLG1jd9E146iV3S2BztsQ==
X-Received: by 2002:a17:906:d287:b0:8b0:f277:5cde with SMTP id ay7-20020a170906d28700b008b0f2775cdemr2246537ejb.32.1679390867791;
        Tue, 21 Mar 2023 02:27:47 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm5511732ejb.74.2023.03.21.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:27:47 -0700 (PDT)
Message-ID: <9bfef283-e2ac-b2ba-386c-6833e9cb1283@linaro.org>
Date:   Tue, 21 Mar 2023 09:27:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] misc: fastrpc: Fix a Use after-free-bug by race condition
Content-Language: en-US
To:     Sangsup Lee <k1rh4.lee@gmail.com>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230216014120.3110-1-k1rh4.lee@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230216014120.3110-1-k1rh4.lee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sangsup for reporting the issue and sharing the patch,

Sorry, for some reason I missed this patch.

On 16/02/2023 01:41, Sangsup Lee wrote:
> This patch adds mutex_lock for fixing an Use-after-free bug.
> fastrpc_req_munmap_impl can be called concurrently in multi-threded environments.
> The buf which is allocated by list_for_each_safe can be used after another thread frees it.
>
Commit log can be improved here to something like:

fastrcp_munmap takes two steps to unmap the memory, first to find a 
matching fastrpc buf in the list and second is to send request to DSP to 
unmap it.
There is a potentially window of race between these two operations, 
which can lead to user-after-free.

Fix this by adding locking around this two operations.

> Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> ---
>   drivers/misc/fastrpc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5310606113fe..c4b5fa4a50a6 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1806,10 +1806,12 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>   	struct fastrpc_buf *buf = NULL, *iter, *b;
>   	struct fastrpc_req_munmap req;
>   	struct device *dev = fl->sctx->dev;
> +	int err;
>   
>   	if (copy_from_user(&req, argp, sizeof(req)))
>   		return -EFAULT;
>   
> +	mutex_lock(&fl->mutex);
>   	spin_lock(&fl->lock);
>   	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>   		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
> @@ -1822,10 +1824,13 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>   	if (!buf) {
>   		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
>   			req.vaddrout, req.size);
> +		mutex_unlock(&fl->mutex);
>   		return -EINVAL;
>   	}
>   
> -	return fastrpc_req_munmap_impl(fl, buf);
> +	err = fastrpc_req_munmap_impl(fl, buf);
> +	mutex_unlock(&fl->mutex);
> +	return err;

How about moving the locking to ioctl:

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a701132638cf..2f217071a6c3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2087,7 +2087,9 @@ static long fastrpc_device_ioctl(struct file 
*file, unsigned int cmd,
                 err = fastrpc_req_mmap(fl, argp);
                 break;
         case FASTRPC_IOCTL_MUNMAP:
+               mutex_lock(&fl->mutex);
                 err = fastrpc_req_munmap(fl, argp);
+               mutex_unlock(&fl->mutex);
                 break;
         case FASTRPC_IOCTL_MEM_MAP:
                 err = fastrpc_req_mem_map(fl, argp);


thanks,
srini
>   }
>   
>   static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
