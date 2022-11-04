Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8A61965A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiKDMii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKDMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:37:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C32D770
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:37:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so12831586ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bjorling.me; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMwNYpp6IfQSczWvUkHLD5pqC9pvJcuYiA9/8H6nV4E=;
        b=WNLlP8VNM+/KSac50oJJl3QvBf3rQ5avRCyPVI0bXJf9zcwM5KH5HNdg9lAXkHUxOq
         N/BIvehR3jBnRjcjEZCoXcn7jk6MjjlUUFJ/eF5wtuPkJyH1OLHbi3s4uck0UtsqYubM
         eAl+6I/okViZBIgZT9nHeg9NG97i+36i7fPDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMwNYpp6IfQSczWvUkHLD5pqC9pvJcuYiA9/8H6nV4E=;
        b=fsmwRIO6HfyCILjjxqDkEHxEQYeDt4G920E2+Ef9MtjUmeXUPlu5ko3Yy8k5MyQasx
         ZrXVFDgGrrDMH6ljaDKGh3jRyrdbv6bpEtMEaDFAKcv38tFZaYkLgeHo/ueNjg69ZRzG
         A3mRv2Wje0KQ7GjVOPX4S+nWKnF3YX9YIfeDCOa2EK9Ai9XGdcZV3KpCUcGq3yF+rqqi
         ggmiHQtcM65Jjo4mKg2VtZskkAAy4zrxNlT9Kv7oWGJrRCpJggsBElO0td0TW5pMegEA
         nerncZEhCDeT0FI3KLHeIjibYjLhoWM3sm1TIIsl0raVhSQH4VpvwD7gCIdV0qdWbOEL
         DJEQ==
X-Gm-Message-State: ACrzQf04ddecGfWuIJFTrMOzN0E387LpzBAqdZUg52Mu2Cq8ZcWJCLQk
        J13BtL487rVilpv5Un/96YnWeg==
X-Google-Smtp-Source: AMsMyM7tKo2kktI2MVBf2Ew2/7xph1uzc1PduX34Hppt3qiG6dJm8eyCzPX9sZQxxjuZXje5oirYAg==
X-Received: by 2002:a17:907:9495:b0:78e:1bee:5919 with SMTP id dm21-20020a170907949500b0078e1bee5919mr34149157ejc.701.1667565444385;
        Fri, 04 Nov 2022 05:37:24 -0700 (PDT)
Received: from [10.0.0.144] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7db1a000000b0045ce419ecffsm1888637eds.58.2022.11.04.05.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:37:23 -0700 (PDT)
Message-ID: <878ea44b-9616-e7d0-661c-82eae23b1b35@bjorling.me>
Date:   Fri, 4 Nov 2022 13:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH 0/4] Implement File-Based optimization
 functionality
Content-Language: en-US
To:     Juhyung Park <qkrwngud825@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <Y2IuhG8nBJj0F1fd@infradead.org>
 <c5948336-19fc-ddd3-bc34-aba2d1b02302@gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
In-Reply-To: <c5948336-19fc-ddd3-bc34-aba2d1b02302@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 07.11, Juhyung Park wrote:
...
> 
> Is the idea really an utter madness? Majority of regular files that may 
> be of interest from the perspective of UFS aren't reflinked or 
> snapshotted (let alone the lack of support from ext4 or f2fs).
> 
> Device-side fragmentation is a real issue [1] and it makes more than 
> enough sense to defrag LBAs of interests to improve performance. This 
> was long overdue, unless the block interface itself changes somehow.

There are ongoing work with UFS to extend the block interface with 
zones. This approach eliminates the mismatch between the device-side 
mapping and host-side mapping and lets the host and device collaborate 
on the data placement.

> 
> The question is how to implement it correctly without creating a mess 
> with mismatched/outdated LBAs as you've mentioned, preferably through 
> file-system's integration: If the LBAs in questions are indeed 
> reflinked, how do we handle it?, If the LBAs are moved/invalidated from 
> defrag or GC, how do we make sure that UFS is up-to-date?, etc.

If using zoned UFS, the file-system can use zones for LBA tracking, 
eliminating the mismatched/outdated LBA issue. f2fs already supports 
this approach (works today with SMR HDDs and ZNS SSDs). It'll extend to 
UFS when zone support is added/implemented.

