Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7446122FE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJ2MmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJ2MmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:42:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B35A2C3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:42:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso12175570pjz.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ce250joL3iqDn2xbwYnkLhofwJ7IAaSStzyPW5mbUM=;
        b=FP58HsbJhZJQ3Dvhh3Y3k9SwtypgSUMezdeYmDn9yQ1FH2AUB+b1/lD5oJDZScUtIH
         tIpZQ6Sa6DpGIgpvJvURJVa4v/xfdKvmzwbsNKhUSSI6RvYwwO26d+GD7ZgiSTlVAYlR
         YO/mhHjQzahnauhRDFutBnEIEwsRLiBwyOdBEFAtUhgbI+dFM1IcfMJmyCTf09w3X6WA
         UIVMEn4Va9RGN6AyhT2PIhRSb51AWNb7D9UD0D+JOIs0VP+iW4tjOIBJxwNXqE1E1xIA
         ESY06oJnhqs1zmJMN2/BacaUCrXmuep0pgQF3q9nP0Vjey5n8MrhIsyjqmn5/FLZ1oZc
         xUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ce250joL3iqDn2xbwYnkLhofwJ7IAaSStzyPW5mbUM=;
        b=TWVK85CCbYEyW9GHQc1DyXdKY33Tu3HjdgNPFQ+tG2eCIRjSlPgBwNWJoqtjIkeUa1
         e9g4J1n8IFnR4GToybBfzsdaXO1ygG4uj6ezsrMZ4eUVr6X94AbPgH4su0upmGxwk5uf
         rZSG9RMAgtvKrMRMURgVuHhgTXuFD5ahfRkqhdk7IltS5jsgn6WXBMG6/EvZQZMSxJva
         SztRAQvN4r26NRz5OguN0Aq2S/ypIDMrMIqT76hMNT3ePOeoG4/T341/h/JIeiYjqBcB
         OAUtUq4NamLtLgZRZXKKSuxKpnQbn6luskUlajHw3OxS5ejuKclZJ0nTbw6dNVYM+Uhm
         4KYw==
X-Gm-Message-State: ACrzQf0MQx46P0CCNFnEsaOoPb6DTmayby4lAxShaSt/Sv+3w2RRqIij
        prGy87mku01kZ8teESm2Y6xFIA==
X-Google-Smtp-Source: AMsMyM553KStNWLnmeOyGVfUgwhZ+WLhrO04SI5G9pzlGFYkdz02fQ1DOjWotg8joGpr2pAAoGsDCw==
X-Received: by 2002:a17:90b:3b8d:b0:20d:5829:8d97 with SMTP id pc13-20020a17090b3b8d00b0020d58298d97mr21229797pjb.105.1667047333974;
        Sat, 29 Oct 2022 05:42:13 -0700 (PDT)
Received: from [10.4.223.2] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0056c06d583fasm1125660pfg.219.2022.10.29.05.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 05:42:13 -0700 (PDT)
Message-ID: <6ea3a2ca-85d7-b338-f516-c91ec5e7a128@bytedance.com>
Date:   Sat, 29 Oct 2022 20:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [tip: sched/core] sched/psi: Fix avgs_work re-arm in
 psi_avgs_work()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-tip-commits@vger.kernel.org,
        Pavan Kondeti <quic_pkondeti@quicinc.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20221010104206.12184-1-zhouchengming@bytedance.com>
 <166693932887.29415.17016910542871419770.tip-bot2@tip-bot2>
 <f990a324-e28e-6de1-acb0-ba764808a56a@bytedance.com>
 <CAJuCfpHOt1Vfc=ZtAYt_2QamOujfuFtNHAdJe7iBMmDgTLGtyw@mail.gmail.com>
 <Y1wzVeCYDFSO0KYe@hirez.programming.kicks-ass.net>
 <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y10UpNIGtffsZHXr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/29 19:55, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 09:53:57PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 28, 2022 at 08:58:03AM -0700, Suren Baghdasaryan wrote:
>>
>>> Not sure what went wrong. Peter, could you please replace this one
>>
>> Probably me being an idiot and searching on subject instead of msgid :/
>>
>> I'll go fix up -- tomorrow though, it's late and I'm likely to mess it
>> up again.
> 
> Can you please check queue.git/sched/core ; did I get it right this
> time?

I just checked that three patches, LGTM.

And would you mind picking up this, by the way?

https://lore.kernel.org/all/20220926081931.45420-1-zhouchengming@bytedance.com/

Thanks!
