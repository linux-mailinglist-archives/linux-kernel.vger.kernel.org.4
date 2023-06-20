Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B47363B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFTGjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:39:34 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB85CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:39:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b58351327eso1411020a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687243172; x=1689835172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auJ6EJaNEhBlb5WUEu9u5pzfD1n3KesDYvPGRacKRpY=;
        b=Q0x5ZOGt4/v3wQppV0vu3j4kjyVREZuzdlXMoLL29N7NXduun7x+/qMKtZI9/fJvkE
         uXAJEwy/vwqunPx2kBUjpJnwRZJYHPKEU135M3wz8Lbji0KHP6SAo8dzYCyUA91hD2hK
         qQFY1wwfxb6zZ2hcn39cy6SQgMduj6ZO6UnIgFsg/LsEwb5s1ohxYtTnc3+lnKX4c4up
         9b0HQQSe2NnahNMiG0Ue1NNNiQHRN1pqAwwNk3vqHBW6OZsxoTORWGTDR/hX/gVasPBI
         RgeSOvQLSLXUsLXt6N2Sx/C/uwmT3Q+vwAAehP4zPVzFD3vAPrUxgSq1xPAf2WLJ68Is
         nDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687243172; x=1689835172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auJ6EJaNEhBlb5WUEu9u5pzfD1n3KesDYvPGRacKRpY=;
        b=MgdgVKG0DZ3+EJCL9hZf2AljPAHyEcbqEQ0kRDXzXLAi56K6CCw7LbWkn14ao7+N0G
         JhlwsvueFrhKVOz98k+6GgBy2tFb8gJvPLarInU2Mqllur5YDpOs+A3eW4fHhwkyA/eQ
         AmpQAbnIyKfzhmcrQ4A1Qr0XOTXb0ivDOgcYKY2Ku7pRe/f8ghvI4y8YUTIr8YjwZn4q
         lzowKs2W7E3q1QzV+2EizLAD30cBeqppctm70IwYDWvCjlGcG/iaE3Ux1wLQe/DoYBxR
         C+72CmgHbytzAeOH80ro355Qb6UKXKSg0YFgqxMAJjlwSlU8xiOYGbdhJF+IO3MxZya6
         hvow==
X-Gm-Message-State: AC+VfDx+A8LPefond7vBmoXykqwjSUB/1a2PkOrvqNa9Lm2ixM2tfRO1
        saOlqBzwd+vV1IBFxLWDOsmFqQ==
X-Google-Smtp-Source: ACHHUZ7MXbwUUZMP5G5VW1Wv8zl+x/+Um3sJyQyvUnyO9ywOp/LLZEb0Mxk8lkxfS1aPkLdMl9HoVQ==
X-Received: by 2002:a05:6808:198a:b0:39e:deb3:e1f with SMTP id bj10-20020a056808198a00b0039edeb30e1fmr6248467oib.40.1687243171988;
        Mon, 19 Jun 2023 23:39:31 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001b679ec20f2sm843151plb.31.2023.06.19.23.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 23:39:31 -0700 (PDT)
Message-ID: <8ac1034d-4ddf-86a6-a7dc-769bc5080fac@bytedance.com>
Date:   Tue, 20 Jun 2023 14:39:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Re: [RFC PATCH net-next] sock: Propose socket.urgent for sockmem
 isolation
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Eric Dumazet <edumazet@google.com>, Tejun Heo <tj@kernel.org>,
        Christian Warloe <cwarloe@google.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Jason Xing <kernelxing@tencent.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
References: <20230609082712.34889-1-wuyun.abel@bytedance.com>
 <CANn89i+Qqq5nV0oRLh_KEHRV6VmSbS5PsSvayVHBi52FbB=sKA@mail.gmail.com>
 <b879d810-132b-38ab-c13d-30fabdc8954a@bytedance.com>
 <4p22vtjrpu4obmbjivgpe635gbpjmhsfisnxghgsson2g6yy5r@ovawhchw7maq>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <4p22vtjrpu4obmbjivgpe635gbpjmhsfisnxghgsson2g6yy5r@ovawhchw7maq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 6/20/23 1:30 AM, Michal Koutný wrote:
> On Tue, Jun 13, 2023 at 02:46:32PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> Memory protection (memory.{min,low}) helps the important jobs less
>> affected by memstalls. But once low priority jobs use lots of kernel
>> memory like sockmem, the protection might become much less efficient.
> 
> What would happen if you applied memory.{min,low} to the important jobs
> and memory.{max,high} to the low prio ones?

I might expect that the memory of low prio jobs gets reclaimed first.
Specifically we set memory.low to protect the working-set for important
jobs. Due to the best-effort behavior of 'low', the important jobs can
still be affected if not enough memory reclaimed from the low prio ones.
And we don't use 'min' (yet?) because the need for flexibility when
memory is tight.

Best Regards,
	Abel
