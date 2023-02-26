Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E4B6A34D3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBZWxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:53:33 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEABB9B;
        Sun, 26 Feb 2023 14:53:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id a1so3074378iln.9;
        Sun, 26 Feb 2023 14:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5jgNfCvYzvN77d+Vnzv3F6iStq1dV6fR66liem9uZWY=;
        b=XFNJv98AaOxc5miUbXWdMakI26ttWvj9IoHwxD91yr2wnQKOpfyWa+wYD5eI0WEiJ/
         UUqQVtGftKKpuqWXU5X6bXHrU7XZcn0u+tUYQuCEUf9WvT0NsjL5SNbus5rfZDVslmTj
         YToBNCFuRm/slk/o4sWhYz9WwnPSf7Q8rIK6WFyn0mnGL5+GSbwr6ruHTsPgmeF080zg
         ok28nGEoSfk4dcWEXxwNta+aSpQ1Rfd7YeOtq6E6XMldLLx6gwutOqZPsr38MS4e0TJT
         bfX5r0J4H2RXipbltc0gTpeZc3WtuvrR63gd7nov8G+t8kDjz7tLS+qL0OM1bgQBRw5u
         Gaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jgNfCvYzvN77d+Vnzv3F6iStq1dV6fR66liem9uZWY=;
        b=7ZE+q249VOB6SVKTq7k9XZshP7wtuel9z7DDioimj52+7D7zPa/P3o9d+bqChDQFyc
         ZZe6iIk1FL1FAjsN0SDuGxqUwQDW+zmqDZzsigZHE4X5vJ6Wt3ltFD9iAsbMKt26lHi1
         Ytog/yvTjSDoFtQTlVzN9Ew66KziOcQrQO1qxQ6hxPpz76HNCCn1xPHbbIQWz6OC1oo5
         MmVsn/dlos5O7o0m9rScL/RUwZlMczJOUsXjad6hqD/iaOkkp3J4rkD4g+cTJgZVSJM/
         5q+rD6WfiGSEIiZbk+0s0f3GQ/y0l/7xksJ2cWe7aLZAcAXkTQ2oC1Ql5VJrE4q6Fjqq
         uPaw==
X-Gm-Message-State: AO0yUKXWSAEmTYjuVKR7rLjJqyeAmpNqDrlH9C7kljrOyE/63GEGn+oz
        19HnXr7lFrksdgOiLuc2ABs=
X-Google-Smtp-Source: AK7set/szAq8J569eo93vQZA9bbPjV2Usxi5VS/hbbkVQEnsIitb7UupEy+TPH0rRm+2GeDHTTUOeQ==
X-Received: by 2002:a92:1a4b:0:b0:315:56e7:7f39 with SMTP id z11-20020a921a4b000000b0031556e77f39mr15954171ill.2.1677452012220;
        Sun, 26 Feb 2023 14:53:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13-20020a02a60d000000b003b39dcca1dfsm1603138jam.170.2023.02.26.14.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 14:53:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d4260bee-2bec-40e4-b07f-3a9fa18c3d72@roeck-us.net>
Date:   Sun, 26 Feb 2023 14:53:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme boot problems after merge of mm-stable tree into linux-next
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-mm@kvack.org
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
 <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
 <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
 <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
 <20230214172040.60657882@canb.auug.org.au>
 <07c870d3-5d98-ca51-5de8-034abc631673@roeck-us.net>
 <02f796c7-c1d5-2f2b-3385-e72298f5f470@gmail.com>
 <20230227091423.3797ba8e@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230227091423.3797ba8e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 14:14, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 14 Feb 2023 14:29:29 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 2/14/23 13:49, Guenter Roeck wrote:
>>> In next-20230210, the crash happened after the merge of mm-stable.
>>> In next-20230213, the crash happens after the merge of mm-everything.
>>> That means both the merge of mm-stable and mm-nonmm-stable are now fine.
>>> So I would suspect that something in the merge of mm-everything
>>> interacts with the rest of -next.
>>>    
>>
>> OK, thanks!
> 
> Did this get resolved?
> 

I think so. Either the offending patch was reverted, or it has been fixed.
I still see various boot problems in -next (and most of them are now
seen in mainline as well), but none of them are nvme related.

Guenter

