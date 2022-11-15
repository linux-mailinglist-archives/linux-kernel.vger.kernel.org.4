Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B958E62929B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiKOHjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiKOHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:39:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA66BBA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:39:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q9so13377106pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrKxYxO/T/9+ij5BpZ+ZeE91vTMifnc8qboFL3OM2PU=;
        b=H01TrKGhQrD5MzuM4fOKDD5uVKMwHmW0a2HUiqcgBfGdx+x8fahWBZgYIaWZbJeywr
         fZSutuU7hMyabiDX4PvQFlJRZG/NI9FZMGgbpxMXcpHWRQgP9FTvHDRCoqq5IZfLXjk8
         a7kRqownJt+7uXXfEMcRzLwDYxVIQkoCjcgSBODuxOJddjB3/9/SG1h7Qn04lglhLTo6
         LWhgRHFBV5vIiK+qSGNXeYd+FJn90lIJOGwqQS7Rgul0LkJYgkXu5mpUSBrvKz7/f5u/
         CmLFjD/T9aAY77w4gyCmSRQeaOirfaoTEdXZz6f3GR+InFg4D/xZAGJlWKqqTg77tm1x
         39Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qrKxYxO/T/9+ij5BpZ+ZeE91vTMifnc8qboFL3OM2PU=;
        b=7NowbSnxLgxyNA3eC4c+L5xUkKd3znCBlLxz8nmdDiqw1j7MkwI/j5UskJCWsJeVSv
         AScwXK6ONBecfFVVl6pZwSDqY1XQ7xJlXXKj01C2sVS9BTxaeNMG66/BYNgJ2B1y2gfg
         lInoXlA3C+h9OjHlN9v/z6rYPzFNAkS1iyXwi8VTUxB5Oo8K7ZJ9qwvl6OJbULGNdsZI
         VascgqRYOyCrxre2Hw70RKaVnvG+PiRho4B/tlV7hppbyu/tbfI5L7tOa7lNZGQ9fgc7
         pBLo5PvjuAUj9ChvPmDcJHey4J6upKfnd9oeJztoON8BlXdcfEe8mcXIpmJjL2KGFYNt
         paUg==
X-Gm-Message-State: ANoB5plTiFipe36Hm2vxPQmoXDhpWYes46U2MbOjvKO2zFAqSULV+7w6
        JWrWTzWyeWdlTicSUEsrMSff6g==
X-Google-Smtp-Source: AA0mqf78gRM3zma7ZP3Cy070W+sbXWWKNNRsCbOy5Iv8juBkB9xy5KIhg2Qcr76QN4KCFo1dK8075A==
X-Received: by 2002:a65:5908:0:b0:46f:1e8f:1633 with SMTP id f8-20020a655908000000b0046f1e8f1633mr14878101pgu.556.1668497947573;
        Mon, 14 Nov 2022 23:39:07 -0800 (PST)
Received: from [10.68.76.92] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n63-20020a17090a5ac500b00200461cfa99sm10894663pji.11.2022.11.14.23.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 23:39:07 -0800 (PST)
Message-ID: <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
Date:   Tue, 15 Nov 2022 15:39:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> We shouldn't really rely on mmap_sem for this IMO.
>>
>>   Yes, We should rely on mmap_sem for vma->vm_policy,but not for
>>   process context policy(task->mempolicy).
> 
> But the caller has no way to know which kind of policy is returned so
> the locking cannot be conditional on the policy type.

Yes. vma->vm_policy is protected by mmap_sem, which is reliable if
we want to add a new apis(pidfd_mbind()) to change the vma->vm_policy
specified in pidfd. but not for pidfd_set_mempolicy(task->mempolicy is
protected by alloc_lock).

> 
> Yes this is all understood but the level of the overhead is not really
> clear. So the question is whether this will induce a visible overhead.
OK,i will try it.

> Because from the maintainability point of view it is much less costly to
> have a clear life time model. Right now we have a mix of reference
> counting and per-task requirements which is rather subtle and easy to
> get wrong. In an ideal world we would have get_vma_policy always
> returning a reference counted policy or NULL. If we really need to
> optimize for cache line bouncing we can go with per cpu reference
> counters (something that was not available at the time the mempolicy
> code has been introduced).
> 
> So I am not saying that the task_work based solution is not possible I
> just think that this looks like a good opportunity to get from the
> existing subtle model.

OK, i got it. Thanks for your reply and suggestions.


Zhongkun.
