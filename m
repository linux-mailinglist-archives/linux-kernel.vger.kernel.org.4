Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31441719697
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjFAJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFAJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:15:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C412F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:15:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75cbd6f9577so51298585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685610900; x=1688202900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VZ/RMuFKexJ1Cfo5ulRcQQpOh7G2Ep/EVHIDxZhnvc=;
        b=ba7YVJjMaRpSHul98ZKjmohQ4xGSFjtLGdo64xoWHMv+z2OXsd8mOIhBRN1Xv8vyfl
         Bj2aA+8RwQSCnBD4j3t7RJigCwhWaHUIe9BIBmHa6140kONncl+9jD6JvzRkC6rodkWF
         T0cPHstmPOPptCyUpXnv86ginHs0iTEjhZ9wqJD3EkKAXfNZboMT6yDIpRMNaU+wBfGn
         8kanZ/kPnIhXIbOfDK2LRGl5tiUyI0YNvaFLDq2amtU9/L6xDkAszTgTLpqKJ0pSNSFl
         OiW2DJOyTQ4247lBOY25PZcA0EMgmcse+nqc8OZtS4RQg5HwiwKX6Sa35fbiVPnRsTSh
         JFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685610900; x=1688202900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4VZ/RMuFKexJ1Cfo5ulRcQQpOh7G2Ep/EVHIDxZhnvc=;
        b=b4UOBftKdC3Su1eH90gHXPIkxZJRmed/pfAtN+Km+wJ5Juo0BtE6PN0MzaLC69e895
         uPiJi3WxnXrSHwtXhk3nY3if+WE2WbgqxOJKQ+6buFlVSR/bWCfYMlQT60RGHJqgT+QG
         BAGvCXbw5BfQ/u5adFRIn35FQ3/++KotLnnLrdMUlbUZcvv1gR2iHzPUALVrfdqXCw78
         golqrqRPA0lYeK2cghE2cawGih6qnWnFpJKUJ2pjgqWOfd/UrdNTDNxxMYa3I766qhFQ
         RE+HVNvIbFjJKwEdg7sK0ZV/hzdZ+Byp5DVfp0pqsom/7macqPdxANCmi9eqnFQENOgu
         If2Q==
X-Gm-Message-State: AC+VfDw47ORqg0b+7qrHXH0oukcuZhwtsvuq7wmoIUDhjHT9j1vRCatV
        WmCj8EEO7KSYbhc5CN5328j2PA==
X-Google-Smtp-Source: ACHHUZ6YgbyQRDgtu+kdVanjVID1nx3mhfz1ONNV/aPM7IZyZ61Kwd1WAqHuKkm8YYPWAzIbEbq0XQ==
X-Received: by 2002:a05:620a:4624:b0:75b:23a1:8333 with SMTP id br36-20020a05620a462400b0075b23a18333mr10513533qkb.46.1685610900279;
        Thu, 01 Jun 2023 02:15:00 -0700 (PDT)
Received: from [10.85.115.102] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j13-20020aa78d0d000000b0064398fe3451sm4522658pfe.217.2023.06.01.02.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:14:59 -0700 (PDT)
Message-ID: <10132333-17e9-01a2-afd6-e7c07860bc15@bytedance.com>
Date:   Thu, 1 Jun 2023 17:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/4] Fix some warnings about rq clock
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20230515063848.77947-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-1-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping, any comment?

Thanks,
Hao

On 2023/5/15 Hao Jia wrote:
> These four patches fix some warnings about rq clock.
> 
> Patch1 fixes the warning of using the old rq clock caused by
> missing update rq clock.
> 
> Patch2-4 fixes the warning that the rq clock was updated multiple
> times while holding the rq lock.
> 
> v2->v3:
>      - Modify the commit information of patch1 to make the description clearer.
>      - Split v2 patch2 into 3 separate patches.
> 
> v1->v2:
>      - Vincent Guittot suggested using rq_clock_start_loop_update()
>        to prevent multiple calls to update_rq_clock() in unthrottle_cfs_rq()
>        instead of removing update_rq_clock() from unthrottle_cfs_rq()
>        and updating the rq clock before unthrottle_cfs_rq() for patch2.
> 
> [v2] https://lore.kernel.org/all/20230510083450.62334-1-jiahao.os@bytedance.com
> [v1] https://lore.kernel.org/all/20230410081206.23441-1-jiahao.os@bytedance.com
> 
> 
> Hao Jia (4):
>    sched/core: Fixed missing rq clock update before calling
>      set_rq_offline()
>    sched/core: Avoid double calling update_rq_clock() in
>      __balance_push_cpu_stop()
>    sched/core: Avoid multiple calling update_rq_clock() in
>      __cfsb_csd_unthrottle()
>    sched/core: Avoid multiple calling update_rq_clock() in
>      unthrottle_offline_cfs_rqs()
> 
>   kernel/sched/core.c     |  7 ++++---
>   kernel/sched/fair.c     | 18 ++++++++++++++++++
>   kernel/sched/sched.h    | 21 +++++++++++++++++++++
>   kernel/sched/topology.c | 10 ++++++----
>   4 files changed, 49 insertions(+), 7 deletions(-)
> 
