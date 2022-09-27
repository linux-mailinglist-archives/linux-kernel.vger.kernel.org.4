Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5575EB89C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiI0DWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiI0DVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:21:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8CF8A1D7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:21:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s26so8251653pgv.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 20:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gJSpeC3acOdE1deb6CRGlYyNAu45L1g+bIJ1h5Tmd0Y=;
        b=8EkLAgwZLfVvgJvVIU7PCfEIoNhZ6TzqC/Im9C6pJdGo7ONY4xK2NNh2/Oqm83SkCm
         3CDCMXfWyd+dHuO4OBUDuasbemAK/ulf7HP5hmd2qrfRY1MNLen0L9IxkoS27WB/50YE
         PCeWC8Ww+2fzTnWS7OsR93tlHW2UozCqDK05XFzcmUgFKhTQHNwTRtY7GIPitdbkTJIf
         pXbv/N7umBU3OuI2V2HtOzZIqmsi8zYjtbBJXrJ4PstJbu6nxM4l6CeYizM2NmTt9KSg
         gi7ybENpJOffa18GybvGaN97VsqzSiyrn2EKhEnenU1aNOJ0XrBkQ/UCvKRSsz9ava2Y
         5NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gJSpeC3acOdE1deb6CRGlYyNAu45L1g+bIJ1h5Tmd0Y=;
        b=aSfJghU3FKSGuLIgpU2A7vHJwosD0MfxXfDnwjzwkm5qFw0btWoi3buIBWWcBoMOsF
         iEtCxnBNvxARLtauHo7VkRrde3aW1MXfqJMPdcwaeH0sOISfr1C11fuqKE/To6kxT71A
         XRv9/L+VnauqUzST5vwaEV69zq1365gyhVwARdsYokUet/QDObb302kAWP9+UlEhHsyp
         i/N0tvwVU5jwtmUWN9ZzbgFLB0e6DLjPHUzWmIgFqoTBDuNiHKXlN5IiC+nTX5A+R8h/
         Fn//nAQRS8MOZiNV0DqPRhsIqcbzxcQ6CLuBF6pt6njR9rqzjClI2E4mVUOvSSyRrZf8
         nrkQ==
X-Gm-Message-State: ACrzQf3f2GOqbbX9vythUbdGfXXRGGasIRobtXFYKdR/PSN07tgh3F7B
        q13y8YNK9ItaYeyMTCcj1Cz+fA==
X-Google-Smtp-Source: AMsMyM6UNlMWxj+4hK+7MEVtLFzHUlsUqma1gXOwIueoKn9DvqI+ZL4yPxyRpb4Kijt2V67UV2LZgw==
X-Received: by 2002:a63:91ca:0:b0:436:64db:c902 with SMTP id l193-20020a6391ca000000b0043664dbc902mr22917146pge.87.1664248859946;
        Mon, 26 Sep 2022 20:20:59 -0700 (PDT)
Received: from [10.255.19.83] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b0017870f471f6sm185074plg.226.2022.09.26.20.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 20:20:59 -0700 (PDT)
Message-ID: <7ac9abce-4458-982b-6c04-f9569a78c0da@bytedance.com>
Date:   Tue, 27 Sep 2022 11:20:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy type.
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
 <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal, thanks very much for your patience!

On 9/26/22 10:08 PM, Michal Hocko wrote:
> On Mon 26-09-22 20:53:19, Zhongkun He wrote:
>>> [Cc linux-api - please do so for any patches making/updating
>>> kernel<->user interfaces]
>>>
>>>
>>> On Mon 26-09-22 17:10:33, hezhongkun wrote:
>>>> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>>>
>>>> /proc/pid/mempolicy can be used to check and adjust the userspace task's
>>>> mempolicy dynamically.In many case, the application and the control plane
>>>> are two separate systems. When the application is created, it doesn't know
>>>> how to use memory, and it doesn't care. The control plane will decide the
>>>> memory usage policy based on different reasons.In that case, we can
>>>> dynamically adjust the mempolicy using /proc/pid/mempolicy interface.
>>>
>>> Is there any reason to make it procfs interface rather than pidfd one?
>>
>> Hi michal,  thanks for your reply.
>>
>> I just think that it is easy to display and adjust the mempolicy using
>> procfs. But it may not be suitable, I will send a pidfd_set_mempolicy patch
>> later.
> 
> proc interface has many usability issues. That is why pidfd has been
> introduced. So I would rather go with the pidfd interface than repeating
> old proc API mistakes.

I can't agree more.

> 
>> Btw.in order to add per-thread-group mempolicy, is it possible to add
>> mempolicy in mm_struct?
> 
> I dunno. This would make the mempolicy interface even more confusing.
> Per mm behavior makes a lot of sense but we already do have per-thread
> semantic so I would stick to it rather than introducing a new semantic.
> 
> Why is this really important?

We want soft control on memory footprint of background jobs by applying
NUMA preferences when necessary, so the impact on different NUMA nodes
can be managed to some extent. These NUMA preferences are given by the
control panel, and it might not be suitable to overwrite the tasks with
specific memory policies already (or vice versa).

Best Regards,
Abel
