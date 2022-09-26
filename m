Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06845E9C37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiIZIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiIZIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:41:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23A9BC1B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:41:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a80so5982402pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z6Fq3OQCzJNYUdQqn+SR/VBV1Co8BIFxEWqJxINS4/M=;
        b=bDq3IyrPTsWd9r6LS5HxCwPJQneldvZPVfwMB/Dn8FmtJsn1I4s14dFuM9I0j2gVLF
         3str0e1Xfdbb5ZY9OP//q4v/wv6rrYAuHCzm5sfFf0TG8wCbS1V4yso7uPj7bDWxLmwo
         mekcXiEuMUM6BNNFwEiVpyVAgNr4Vln6AWDHLBaqV9HUETk4UPogZKHRyhKqQwBIDi40
         ngAIbGOvnc8x8pm8xyr8LHTYhyM0NPycNBiW8LWdlnknTWGsbCGdqEw8RVpdy0+rYlQ3
         ZX7AsaowB9FTgR8y8ajnBBr7+io7CnToQPSQSATPdp3Golp9LKIPL6iXJxhhujahMkiz
         OyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z6Fq3OQCzJNYUdQqn+SR/VBV1Co8BIFxEWqJxINS4/M=;
        b=MrvHCK+k9nw9h1VB1GMnKNXkuxDiag5pwev3lUVM5PYhBi6zwXaRNk0xq0MoxfAWru
         U90HXSLhCgL5PLGChPUqIxvytXT+92EvAv6SXn2UyH+Q0znneeG/yGnMxcXfiJ2jfGQT
         1JR99CwpqBBcUxl/xNjrpsXoTZ6ntG7mHRiFCHJCaaYVmEOtbE05g5tU4JMt5pjNxRtA
         QWzGONwPPXn6NZ935XFB86t5Dbgw2KxMkqQ+w0Gp9w1+mLfN3xZrjagfY62EawmFzsM8
         PxnFrp6yRTGbuEuUCkEcJodLNHy2n6tsoztrU4DWU1OOd+d0i1yIb7QeS3q1Fj1xcx5J
         GbfA==
X-Gm-Message-State: ACrzQf1kIVV9E2aa4MfJHtJKINQ6N2Jzy4Ejbg9bhZSHx6GPpMzQM8qr
        JeIQUeWjAMo8HnmMs8OQno7zamNqGAoiXQ==
X-Google-Smtp-Source: AMsMyM6BiW8KXOMc7a39E2aNr7acYfpjT5DKBwiJ8WaZ6unGoXNteQX640BwRTnho0Ze0V8iXOd8Xw==
X-Received: by 2002:a63:50e:0:b0:438:d16d:e8c1 with SMTP id 14-20020a63050e000000b00438d16de8c1mr17853167pgf.505.1664181687415;
        Mon, 26 Sep 2022 01:41:27 -0700 (PDT)
Received: from [10.255.6.155] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b0016b81679c1fsm10594020plb.216.2022.09.26.01.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:41:26 -0700 (PDT)
Message-ID: <e1a6007d-24f2-5153-5382-f66391cbd0cb@bytedance.com>
Date:   Mon, 26 Sep 2022 16:41:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH] mm: fix misuse of update_mmu_cache() in
 do_anonymous_page()
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn
References: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
 <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
 <48590f80-fc58-bf67-5acf-082880a607b2@redhat.com>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <48590f80-fc58-bf67-5acf-082880a607b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 16:32, David Hildenbrand wrote:
> On 25.09.22 03:43, Muchun Song wrote:
>>
>>
>>> On Sep 24, 2022, at 13:32, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>> if PTE entry exists") said, we should update local TLB only on the
>>> second thread. So fix the misuse of update_mmu_cache() by using
>>> update_mmu_tlb() in the do_anonymous_page().
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The change looks good to me. However, I am not sure what is the 
>> user-visible
>> effect to xtensa users. So Cc xtensa’s maintainer and the author of 
>> 7df676974359
>> to double check this.
> 
> And if there is one, do we have a fixes tag?

IIUC, there's only a performance difference here, so maybe there's no
need to add the fixes tag?

> 

-- 
Thanks,
Qi
