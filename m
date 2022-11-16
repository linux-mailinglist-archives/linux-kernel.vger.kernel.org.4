Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6462B583
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiKPIsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKPIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:48:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756B38BA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:48:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so1720741pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5CSYviWjndhtRR1/spb9kOtNaz1AcaNCxufebNDzwA=;
        b=6MtvnPq0Dmi43D8/ZKkfLvJy46lTg9V59hcqJj4JOCGSP71c+tKO1a3g+2fAyTyHyO
         vSnHyGe68Ul+6v5pGWmUU40MqTXUr+ezN+TAkeW1fgnEWvqqKNvWr/b8DE1uLxfHFa+i
         VzUjG0t8UoTXHu6Krr6EM5SD5q+Q43NSy/0xt9ortczZD+7kZLRHaGR4bs6m+L3qHdnZ
         FiYsqdDGKAESw/ZmQZt4sBLj0+l5r7LssZExYLmClEpkt2/3GgOYagiAOrMFzh2oVa1n
         sM41T4uraXdsCK1qY97PhHLJTsWdTAG9eKLtnft1j/AWyY5hXdTn45Zgj4FZtAeo6fOi
         kmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d5CSYviWjndhtRR1/spb9kOtNaz1AcaNCxufebNDzwA=;
        b=BjjBbqBrSslJc4ziLKtdmmfVB3Q9BC5dEd1k+Fp9HtVRSRBPxZhFlX3GpM260NMYB7
         undU0GqRCxpjKmt8A9RDM2hQwKZNhhSKnIUgsQRbsQ5ur4ltftbCmGQigMZiF+25AMLp
         Zmgk1axvJxzWN9BUX8nLHpE/qtpz9zWL41aNdnbYSAx2i7lTofAk64wIQYFhEapEXvMm
         0oidasJdy6wQ7DCgbT2MSC1u/hEMf8Z634pG4ItMmUJGOc1xPyqNQNtOKYvipocj57ga
         xbd2nqiXoonneHfbf3UNIH/eEnaAv0JtX3OeQqIvfMk6ZVBLWc6x90J0u5kAGdknme17
         18hQ==
X-Gm-Message-State: ANoB5plhBS/M650jM5KjVAfnzqY0S6qdphVxj0jabtyBXEaRIOoRzqru
        LXG4TUX2MVcFkSmbRyeRjFfJYw==
X-Google-Smtp-Source: AA0mqf5jwpNiZ4ZbTKTidHlLl3NsyawgKO68KrxoRXVBUtP/A/PFI0rrVWc4Dop9Iu3lHCidoD5QKw==
X-Received: by 2002:a17:902:8344:b0:186:8111:adff with SMTP id z4-20020a170902834400b001868111adffmr8045164pln.81.1668588531294;
        Wed, 16 Nov 2022 00:48:51 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b005360da6b26bsm10233258pff.159.2022.11.16.00.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:48:50 -0800 (PST)
Message-ID: <cbaf57d2-91bc-cce6-de9e-6e0e39f44794@bytedance.com>
Date:   Wed, 16 Nov 2022 16:48:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH v2 2/2] sched/core: Adjusting the order of
 scanning CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
 <20221026064300.78869-3-jiahao.os@bytedance.com>
 <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
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



On 2022/11/14 Mel Gorman wrote:
> On Wed, Oct 26, 2022 at 02:43:00PM +0800, Hao Jia wrote:
>> When select_idle_capacity() starts scanning for an idle CPU, it starts
>> with target CPU that has already been checked in select_idle_sibling().
>> So we start checking from the next CPU and try the target CPU at the end.
>> Similarly for task_numa_assign(), we have just checked numa_migrate_on
>> of dst_cpu, so start from the next CPU. This also works for
>> steal_cookie_task(), the first scan must fail and start directly
>> from the next one.
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> 
> Test results in general look ok so
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 

Thanks for your review and feedback.

Thanks,
Hao
