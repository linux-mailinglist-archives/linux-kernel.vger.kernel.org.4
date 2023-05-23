Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885370D227
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjEWDEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjEWDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:04:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF690
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:04:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae8ecb4f9aso25986325ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684811068; x=1687403068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFNNihuBrXSC701L37bPlsyjHuGUOLaLQwRdUI1QSrM=;
        b=IYn1Lsfyd0/h3pNjHVrIaDJ1pbFjPR3XxctiNvG+P4ElqouoVNhCq8TIGhxSB4tn2+
         +8azudD9VJeI98Lm3g+ir7kOQ+kn3GpOasu2KHaoGvq4MUnahgXyYdcN5oAZ3E9f3l2P
         wG/HiJ61SGhzQxT3nEuEF2kvJA+IEfTnQgMXonzZLr7jRdo4KsGHbtoPYm6TtOj3cHhz
         7wnKRMIFEl0cgsPqrgxuvVlvybyMfNY51vgnE9aR1fI8+JBAXg2ETQ6x2jWk3ufts7fD
         r6skFVysonK39GJ54Oovn2lad4/lpSh84YMgxC6r8Je4lGcQJVhnyAdJwiVJnBAwir7g
         Xkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684811068; x=1687403068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFNNihuBrXSC701L37bPlsyjHuGUOLaLQwRdUI1QSrM=;
        b=VYlpufZ5JZJ/lKLX9K1QEPnTH6CRdhlftEu5PjIrBsacF7mjnelUBe36ciU2fIFB7X
         1k/SXVp/ROl5GNsjDk3qgZRd22cjG4lLgD25xTqo6Jdezq5cBjoLoY1EiK8K5tsFb/GU
         d476nB6ZKMijutRQy50ulT/C52jsBonjv+KtqqolKOqzWoVXJRdjy4vHLhoEHWguxh2V
         WX/t+F3hh8Oe+fJKJA5+asglIQQyEcUB7TvwJQlLy50JWx/SiI7NVn12CPQO7SeC2JwF
         YBmgNGwpvFrBvKIaX0xPnExNs7dH7y+axpb4+Kn18suXMkqqre7cN4R5erNX7Rm3wpLD
         ybGQ==
X-Gm-Message-State: AC+VfDwvtFdXp4H9xNU95ZStDS+wD6nikc/MlF+JIP42ZztU8P0Aa9EU
        zfVR0W/dGpoB1LBsRHxAKL4DDIvVv35BDY1SXpA=
X-Google-Smtp-Source: ACHHUZ6yQU7ZG8zePTbfq80ocZHL60v6iyIxrqH8T42ih7vJQB9zJJk4bGKeFrDgtNX3xO3GkT31lQ==
X-Received: by 2002:a17:902:e80b:b0:1ae:62ed:9630 with SMTP id u11-20020a170902e80b00b001ae62ed9630mr16141107plg.15.1684811068270;
        Mon, 22 May 2023 20:04:28 -0700 (PDT)
Received: from [10.255.25.150] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001a804b16e38sm5550294plb.150.2023.05.22.20.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 20:04:27 -0700 (PDT)
Message-ID: <59a250f6-d38d-9fae-8835-4fd1c501d913@bytedance.com>
Date:   Tue, 23 May 2023 11:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: Re: [PATCH v2 4/4] sock: Remove redundant cond of memcg pressure
To:     Simon Horman <simon.horman@corigine.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Glauber Costa <glommer@parallels.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230522070122.6727-1-wuyun.abel@bytedance.com>
 <20230522070122.6727-5-wuyun.abel@bytedance.com>
 <ZGtmH/0ytVZkkmCP@corigine.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZGtmH/0ytVZkkmCP@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon, thanks for reviewing! I will fix the coding style issues
next version!

Thanks,
	Abel

On 5/22/23 8:54 PM, Simon Horman wrote:
> On Mon, May 22, 2023 at 03:01:22PM +0800, Abel Wu wrote:
>> Now with the preivous patch, __sk_mem_raise_allocated() considers
> 
> nit: s/preivous/previous/
> 
>> the memory pressure of both global and the socket's memcg on a func-
>> wide level, making the condition of memcg's pressure in question
>> redundant.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   net/core/sock.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 7641d64293af..baccbb58a11a 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3029,9 +3029,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   	if (sk_has_memory_pressure(sk)) {
>>   		u64 alloc;
>>   
>> -		if (!sk_under_memory_pressure(sk))
>> +		if (!sk_under_global_memory_pressure(sk))
>>   			return 1;
>>   		alloc = sk_sockets_allocated_read_positive(sk);
>> +		/*
>> +		 * If under global pressure, allow the sockets that are below
>> +		 * average memory usage to raise, trying to be fair among all
>> +		 * the sockets under global constrains.
>> +		 */
> 
> nit:
> 		/* Multi-line comments in networking code
> 		 * look like this.
> 		 */
> 
>>   		if (sk_prot_mem_limits(sk, 2) > alloc *
>>   		    sk_mem_pages(sk->sk_wmem_queued +
>>   				 atomic_read(&sk->sk_rmem_alloc) +
>> -- 
>> 2.37.3
>>
>>
