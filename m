Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA2620719
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiKHDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKHDBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:01:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D012F67D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:01:22 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d20so11911013plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 19:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnlkmyXMF7E2L0FumtTNtxhIz/1ywkiZzaKApLE/qOk=;
        b=VDfVOnI7nS0OJzsBV4AV8ZXarDvqUSTUe73gSFNJxAi3jokZJFfn1/sPSbUw8c4TwH
         H+YCpOeIlIY74Ir+WXNzGQI36SBTX6ZYlKOEHZEEgoPgEwDyacnn+Qe9GCe6GhdHaKTe
         +D68+JV8NikMBPZvjEGJJXjWlxuXW100QE2wvzyCI63DR2MuTPto9kBjsyruO9ugkXgp
         FVLrB8htToXOGuUN6Yg+up24f9G75SDbZnhfhhQdAvuJc6wExHDlhGPa27WhruKQG3ao
         T9FeqEW7hKeIDNMMcWjbG8en137/vlNGZIZCAVek4Bji4iv3khwAdlP8qAigOHa9HSTY
         2N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JnlkmyXMF7E2L0FumtTNtxhIz/1ywkiZzaKApLE/qOk=;
        b=n76o3eHymAd9rdzTj6vCFPYUM5XiOSdaizMM3UsEkCXyCHMdOx1g5JgNIa7DLnIrdc
         CnUk5hFS6cc+81lcYTyE1jrPR0MXm3XLruAypL8+aEGE+L5wcWLGkjraPoWFUcOuyljd
         O0tCHZ7TJIEkEqTUyuQ6Nr5KU8t9wFGMXlkn1li4CGXEVOGbIiBm155TTvfesYehWgww
         4apRGqj9p9Ukovqe7dDBLDrHYFk8VvG5uYdnVnkDfaG4vs3rN9RC8g4XE0RKB/9cgUaw
         L950/XChOVUEP3Cl+gmutW5IWwF+BjrIY9nksIxcxEbK8wgnli90sTv0X+vtYCORSJLL
         Y6Hg==
X-Gm-Message-State: ACrzQf245cWhdxXIcMuDoh1i499nDq0Ih9EsLwk2CM//rzsDsGb1z+vV
        LD7kMnEga+uEHjESuGhNdCZ2qg==
X-Google-Smtp-Source: AMsMyM77nT066cGL2qStiCQAVAKFDcIj2DcRJGJTPqq0ZVAnblUNRxkVW2sucbrGtnzinu1KmXjbQg==
X-Received: by 2002:a17:90b:4a43:b0:212:fd76:be5d with SMTP id lb3-20020a17090b4a4300b00212fd76be5dmr57015822pjb.152.1667876481884;
        Mon, 07 Nov 2022 19:01:21 -0800 (PST)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id pj14-20020a17090b4f4e00b0020b21019086sm19180080pjb.3.2022.11.07.19.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 19:01:21 -0800 (PST)
Message-ID: <276c9d81-12b3-9cf9-2a5f-d42fd75cce95@bytedance.com>
Date:   Tue, 8 Nov 2022 11:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/2] Clean up the process of scanning the CPU for some
 functions
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20221026064300.78869-1-jiahao.os@bytedance.com>
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


Friendly ping...

On 2022/10/26 Hao Jia wrote:
> These two patches clean up the process of scanning the CPU.
> 
> Patch 1 stops checking for a new idle core in time
> if an idle core has already been found.
> 
> Patch 2 tries to minimize false attempts by adjusting the order
> of scanning CPU.
> 
> v1->v2:
>      - Simplified patch1 code and add
>        "Acked-by: Mel Gorman <mgorman@techsingularity.net>"
>      - Modify commit description to make it more clear
> 
> [v1] https://lore.kernel.org/all/20221021061558.34767-1-jiahao.os@bytedance.com
> 
> Hao Jia (2):
>    sched/numa: Stop an exhastive search if an idle core is found
>    sched/core: Adjusting the order of scanning CPU
> 
>   kernel/sched/core.c | 2 +-
>   kernel/sched/fair.c | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
