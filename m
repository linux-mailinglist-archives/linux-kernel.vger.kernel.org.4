Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181C364016A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiLBH6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiLBH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:57:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5F5BD7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 23:57:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id h33so3756448pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 23:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uaty77MzZY7lsyZLRMmVZ/Dameh2HjoJMvJoMCuT6aI=;
        b=qK2s/NbMmT8JUINg48LZkRksiuXbIgxcbwPThoBhxQVCpsTzwrsyndkWA90/g3MFAY
         Lhan41rk2boKAQuWrrdpstM+o2Q/QrKT7apPo+BujQPdTqUHhlXZ9KbbVshTK2+4jR6M
         i3L7lpEclfflvQVlpbky5Rcz/9RSoDfCJ6/W5tyRc6kuAkLn3jXlEaimC0++ygk92JrD
         xx+Onfj+hv2IkntTzyfXiYOybEOvT2ei3gK4lCVVDfKWiH2gloL19UgXZuuWCZv3w3ci
         v+iFo+4uBcx4Cla0o60hHBRlJRTpGziMrEw+5FToJfQXVd4KUMnl/VuPbbQfmNw9p0ei
         q7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uaty77MzZY7lsyZLRMmVZ/Dameh2HjoJMvJoMCuT6aI=;
        b=Oc4fVqsTb0hF17+/LPr1Z9fhUJ2Xit7GPp+jHCiYzebH1NFUqA1cQQVIA3SlmVNyk0
         nYXnmmFCs4pIMlgQvnKERVP9AqZvawtwEzKlEu08qL+iJzZbHd8VCbwB16NNvix6CkaE
         s0ThHGV2t331NpApUMA0IUyrhrnNB6YfSlTc9237xukxRh8xb0erkWRiwDwvyygoE48f
         Ise+mGb+FW+v9ZUCSPsSxWGGtIYY9I3rmefpCdQsGDZdyiMFUYRRwrUoRhMF7ijB+I0J
         FPuIJ8cz9KsqK7wYq2hn8Fhumzjt5dm7Sxij9iUAH3u8QdpsOnHmxYdNV4ZAAhIPktxA
         sgkQ==
X-Gm-Message-State: ANoB5pnXQSQ6b0lGdFd5yx7EDMrQ6o/3jiC/FJfBecZJwE3WY68fcW46
        K2HqFpS/1HST7Q9tADGeQAyA2A==
X-Google-Smtp-Source: AA0mqf6B4GgYKWQ1o4Pufmc7iCmMCGrhpF+fp/uoBu6OXA9kksUjd7THXvnHJWUiHIuQnUVNK0XwLw==
X-Received: by 2002:a63:1965:0:b0:464:a9a6:5717 with SMTP id 37-20020a631965000000b00464a9a65717mr46692703pgz.584.1669967877063;
        Thu, 01 Dec 2022 23:57:57 -0800 (PST)
Received: from [10.4.98.208] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e4-20020a056a0000c400b0057293b17c8bsm4477855pfj.22.2022.12.01.23.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 23:57:56 -0800 (PST)
Message-ID: <13d9d01f-e80d-b7a2-80e8-d1e076cb8057@bytedance.com>
Date:   Fri, 2 Dec 2022 15:57:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3] sched/core: Minor optimize ttwu_runnable()
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vschneid@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20221112033910.73273-1-zhouchengming@bytedance.com>
 <Y4mq44pyzVqkedBp@debian.me>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y4mq44pyzVqkedBp@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/2 15:36, Bagas Sanjaya wrote:
> On Sat, Nov 12, 2022 at 11:39:10AM +0800, Chengming Zhou wrote:
>> This patch reorg ttwu_do_wakeup() and ttwu_do_activate() to make
>> ttwu_do_wakeup() only mark the task runnable, so it can be used
>> in ttwu_runnable() and try_to_wake_up() fast paths.
>>
> 
> s/This patch reorg/Reorganize/

Ok, will change it.

> 
> Also, please rebase and resend.
> 

Ok, will rebase on tip/sched/core branch.

Thanks.
