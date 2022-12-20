Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9996523D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiLTPm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLTPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:42:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71C4F46
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:42:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so30034761ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/ge45M+uLmbjheub/WT6HdLM4XPrSEquSgTSYE+1+s=;
        b=g+CrOS8T/Z1uS8VZcpmQln5szwk22w2uuuSXfVzD1rGmZFrYXZjBz98w9dSw4HbwVn
         T27TcRabPTfkSzGB+1yrXoZ4vm7S2vJl6NUffdrX8iXoANBQdeN0peVeun71lqvO5iyw
         86RnFQs277o3fXX4sWWMtKwngKuTOds6nkgtbJ5WAq1tWdU7BtHbNCJpnZwzlYJM96MI
         OZWj93EhiSWq+JxUCpVsFp9d7hF2uifb5FyidjSe3TkN1Nlxu/yzRLCBlJTSG1a5T38r
         ul7w646UGnNB51wnyv7YYYqBdbYTYTO4oww0SxhPQyd78tmXuL5TisbW4i3Dg90cbCSB
         dqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/ge45M+uLmbjheub/WT6HdLM4XPrSEquSgTSYE+1+s=;
        b=SBymK/h6zPOd5FfUZMcYtS7aOnzPIkx1NSofxVfVaWV+SUOs0+EkjLk8OGulE0Qqgm
         XkmGIi4l47DPYMjsd3zWF6lU+PaNRhxCH95L1HYLA5CmvdRhiJ8qPU05iTjTcseu4m9o
         OcT/RnfHVyF/p3drBGFyK4HVslA2mFeqns0wPj0tlGOjht8Vs3zDhmCmOexVZlAYivVd
         a7IIB/hxhOfhjR2L5btKQknvthJh6N0Ttrs67X1Jdsq0vt64guhQ+UZcbplKnaUzP4sH
         EI+hCmxOico+T7xfJxxLSFTTj4XFp/sgL9w5l7lN8sO/vFO6WM6l3YPz7odC77MzCTFK
         SVhg==
X-Gm-Message-State: AFqh2kpCGkrIxOIeLLQ3On/tjfv0hWIKHO6Q/rPhkq0D8ZDashBRo73d
        dMBM383rasdpuHsuF/SpWqBEUQ==
X-Google-Smtp-Source: AMrXdXs7Md1pBd8/t2/TfHBR9r7u2xCDkfkmIpR6Y2C7FNaB7lyB34N5hlx5URjr382clso66ViGhw==
X-Received: by 2002:a17:907:8b92:b0:7e8:cf25:4b9c with SMTP id tb18-20020a1709078b9200b007e8cf254b9cmr14902492ejc.59.1671550943513;
        Tue, 20 Dec 2022 07:42:23 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id bq15-20020a170906d0cf00b007933047f923sm5723277ejb.118.2022.12.20.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:42:23 -0800 (PST)
Message-ID: <947527a5-f345-b7c8-6938-9a8d2863fbac@linaro.org>
Date:   Tue, 20 Dec 2022 17:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        joneslee@google.com, linux-kernel@vger.kernel.org
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
 <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y5suEZgZn6JNIKxm@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gao,

On 15.12.2022 16:24, Gao Xiang wrote:
> Hi Tudor,
> 
> On Thu, Dec 15, 2022 at 02:58:10PM +0200, Tudor Ambarus wrote:
>> Hi, Gao, Chao, Yue, Jeffle, all,
>>
>> Syzbot reported a bug at [1] that is reproducible in upstream kernel
>> since
>>    commit 47e4937a4a7c ("erofs: move erofs out of staging")
>>
>> and up to (inclusively)
>>    commit 2bfab9c0edac ("erofs: record the longest decompressed size in this
>> round")
>>
>> The first commit that makes this bug go away is:
>>    commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters
>> (fully-referenced)")
>> Although, this commit looks like new support and not like an explicit
>> bug fix.
>>
>> I'd like to fix the lts kernels. I'm happy to try any suggestions or do
>> some tests. Please let me know if the bug rings a bell.
> 
> Thanks for your report.  I will try to seek time to look at this this
> weekend.  But just from your description, I guess that there could be
> something wrong on several compressed extents pointing to the same
> blocks (i.e. the same pcluster).  But prior to commit 267f2492c8f7, such
> image is always considered as corrupted images.
> 
> Anyway, I will look into that and see if there could be alternative ways
> to fix this rather than backport the whole multi-reference pcluster
> feature.  Yet I think no need to worry since such image is pretty
> crafted and should be used as normal images.

I guess to backport the multi-reference pcluster feature is not an
option for stable - just fixes are accepted. If you think it is worth
fixing the problem without adding new support, I can dive into it.
Let me know what you think.

Thanks,
ta

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> ta
>>
>> [1]
>> https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a
