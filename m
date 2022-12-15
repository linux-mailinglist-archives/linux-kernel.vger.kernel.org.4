Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F764DBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLONHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLONHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:07:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318672B187
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:07:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kw15so52072637ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QFzEy6ygu6+EnA8RiBrWi9hFfhLWiA1Ff3mZv4dGig=;
        b=aEAvO1gJxJkZFGke3o022BxYr48P8bsb33jOZ9q/EHRptP9G/BWMTC6SaEFz0v3HJp
         43y0z68NhPCxRuNlEBVI/OKLDsyQwz/2IGiqhMZom/uY50dOTq4smAr25REAREV55qSB
         HM4W+to/xAqtEv66jYA+bmKKrZIrDkDVM87afFcztCSm+EsTmTV3ZTJoViRft3Mj/grE
         mMAksBooIULXPlb6fTynbipJOFWpyeXDhKFaDRSZ1lXMh9e4tLy+OP6RuAcoV4mKI3Vl
         TcUY0yUL2Y8rsHgGq2AYMG3aTc4iVMVno9iZRfBNHrRXLPcgNXrJA6MGWvp13mCv4QhU
         iybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QFzEy6ygu6+EnA8RiBrWi9hFfhLWiA1Ff3mZv4dGig=;
        b=VX3+Xj4lzy48QZkQFIQpYGdMjinEDg7Bn739G1NMgkm2LIvTLMxz+lgLhVKvKxL28N
         VCXwDMKZVKcg1QS8hNOzQzlqBFgeW8MgePbnY4ebS1/qyXLiZD2rPLdp0ySbgoRXAHtN
         KNaet8mKZG9sgyze9F4jJ6raNpndvr29iQaIqN1zdQ7Q3ZJLfawyVkG7VeaA+6KKVsX7
         SEm+R3t+gJ+imFwY74d+9xXF8m6Yb1e9FyYM5fINPJlc7VnT1k7NpOQp5oTiMvm6fcde
         4muhXZ4KaVQIFiigO1PeCb2nBMINxTQ6JJRgmCUPG335gtNMzJR+NX8uGBb+wgEUk/bx
         JhvQ==
X-Gm-Message-State: ANoB5pkHcUC6T8wkVb1xQpppz7eU6MRNkDkoloFdeyfpzqltrvpHXrRk
        Kz8H7JWnBZN5IOtxnJSSapxyrg==
X-Google-Smtp-Source: AA0mqf7BqVPFeZfBhRmTFPRVxGKxu1eSmXVKjjsRo7rhRJn2pIg8XI6NMtsO6llc14PPgs/m0g+Wcw==
X-Received: by 2002:a17:906:8049:b0:7c1:6040:2318 with SMTP id x9-20020a170906804900b007c160402318mr9939275ejw.35.1671109667726;
        Thu, 15 Dec 2022 05:07:47 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.55])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0077a8fa8ba55sm7003673ejf.210.2022.12.15.05.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 05:07:47 -0800 (PST)
Message-ID: <68bae3be-9a98-83b1-a378-b7c7c12f74c7@linaro.org>
Date:   Thu, 15 Dec 2022 15:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     joneslee@google.com, linux-kernel@vger.kernel.org
References: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
In-Reply-To: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.12.2022 14:58, Tudor Ambarus wrote:
> Hi, Gao, Chao, Yue, Jeffle, all,
> 
> Syzbot reported a bug at [1] that is reproducible in upstream kernel
> since
>    commit 47e4937a4a7c ("erofs: move erofs out of staging")
> 
> and up to (inclusively)
>    commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
> this round")
> 
> The first commit that makes this bug go away is:
>    commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters 
> (fully-referenced)")
> Although, this commit looks like new support and not like an explicit
> bug fix.
> 
> I'd like to fix the lts kernels. I'm happy to try any suggestions or do
> some tests. Please let me know if the bug rings a bell.
> 

There's something else that may help. I enabled CONFIG_EROFS_FS_DEBUG
while at
   commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
this round")
and I got the following: https://termbin.com/4bm8

Cheers,
ta

> [1] 
> https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a
