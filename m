Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DB372211A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFEIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjFEIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:34:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA10E3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:34:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso3354982a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685954070; x=1688546070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2TZNl5uXZLERatZxawVlXcspibbKzrKFt5URrysKFA=;
        b=U/Hst64/q7IHCQs/aCEtc3h12jUOv/3Y2satYoV0hCyFNe9CWPhRhu183waaiEP5uR
         aZmQTEH4L6MF9GYV+hyLL1o8qbBVOKnNoDNnpLn6KS7JaqGyHAkQYz5hRbiyeGR2QSNT
         Pnu/K7PjQrckFxYiLZw2zoQdNuymJbpeIcVKUdreIIWWmokWZDWZBGq5+fpFIFaZcJoF
         lAks66nEknd7hFtUXWchztjRFSMISb7BU7WRaUqN2jz429GQjfDgbCE/PeMek2nIjacq
         R1tCcKNfK8mh2cNcAuY5v62xB7lAK3mmKNguLr2Kbx/HHTGlQVSelgbLfQUI38crs4zX
         aUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685954070; x=1688546070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2TZNl5uXZLERatZxawVlXcspibbKzrKFt5URrysKFA=;
        b=g/0bg6qys/WNcLJt7dihmg31cWU7Vi2YtRWkNN/JRiWqr0zzkaxl48ucZuq0jd4KF5
         FPsJVtepm6axo9XmaK4WSOS9JZor03mI34NSQOtuCieah2pJxp4KA8i6KKAt16fMvGQc
         pRWJs2wCD2Et1Y+4Uqh2NrmTqsXzwQ9faXshlaK0uwdngzz3qFjviMiuTgEyI4g1DsVC
         RO3qB5d4+WmD5uaSaXgcj31dzbfIX8cNytH8+5pjoAUF5uHI1FjE1pDexuIOgppRMWhj
         y+K2wSyA5QG7zjm/YRByuSj7SdVV6egzn4ayCwZ8o2vHepQ+395qZBvqOsRUJZqCunC+
         GpkA==
X-Gm-Message-State: AC+VfDw2xz+OPnD4Q26Rl+zKAtUwxN77+uCX9dUwNGpqNukS6ocpF3A7
        dDtbf6NXNZ+KEaU6qfiuhBlCWA==
X-Google-Smtp-Source: ACHHUZ4PbxKyyybXkFhXOU8snOHUbX6N/OdELnYxGRQYMXDQmzf3YRGHDlx3rqjSBqpZRzpwjz2IKg==
X-Received: by 2002:a17:90a:aa08:b0:24b:52cb:9a31 with SMTP id k8-20020a17090aaa0800b0024b52cb9a31mr7733828pjq.22.1685954070502;
        Mon, 05 Jun 2023 01:34:30 -0700 (PDT)
Received: from [10.254.80.225] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a4f8500b002563e8a0225sm5697304pjh.48.2023.06.05.01.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 01:34:29 -0700 (PDT)
Message-ID: <c35446b4-5e7f-3c3c-6d42-80e9721e5169@bytedance.com>
Date:   Mon, 5 Jun 2023 16:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Re: [PATCH net-next v5 3/3] sock: Fix misuse of
 sk_under_memory_pressure()
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
 <20230602081135.75424-4-wuyun.abel@bytedance.com>
 <20230602205322.ehxm2q2mbg5laa5s@google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230602205322.ehxm2q2mbg5laa5s@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/23 4:53 AM, Shakeel Butt wrote:
> On Fri, Jun 02, 2023 at 04:11:35PM +0800, Abel Wu wrote:
>> The status of global socket memory pressure is updated when:
>>
>>    a) __sk_mem_raise_allocated():
>>
>> 	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
>> 	leave: sk_memory_allocated(sk) <= sysctl_mem[0]
>>
>>    b) __sk_mem_reduce_allocated():
>>
>> 	leave: sk_under_memory_pressure(sk) &&
>> 		sk_memory_allocated(sk) < sysctl_mem[0]
> 
> There is also sk_page_frag_refill() where we can enter the global
> protocol memory pressure on actual global memory pressure i.e. page
> allocation failed. However this might be irrelevant from this patch's
> perspective as the focus is on the leaving part.

Leaving prot pressure or not under actual global vm pressure is
something similar to what you concerned last time (prot & memcg
is now intermingled), as this will mix prot & global together.

To decouple global info from prot level pressure, a new variable
might be needed. But I doubt the necessity as this seems to be a
rare case but a constant overhead on net core path to check the
global status (although can be relieved by static key).

And after a second thought, failing in skb_page_frag_refill()
doesn't necessarily mean there is global memory pressure since
it can due to the mpol/memset of the current task.

> 
>>
>> So the conditions of leaving global pressure are inconstant, which
> 
> *inconsistent

Will fix in next version.

> 
>> may lead to the situation that one pressured net-memcg prevents the
>> global pressure from being cleared when there is indeed no global
>> pressure, thus the global constrains are still in effect unexpectedly
>> on the other sockets.
>>
>> This patch fixes this by ignoring the net-memcg's pressure when
>> deciding whether should leave global memory pressure.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> This patch looks good.

Thanks!
	Abel
