Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180F46C213B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCTTVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjCTTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:21:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55D49D2;
        Mon, 20 Mar 2023 12:13:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so9038641pjl.4;
        Mon, 20 Mar 2023 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679339599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7s4+d2xWt406APG3wRaoC6OPOVdCpVfU3Vzs0598DdE=;
        b=nWIhlpdVn9X/rafBumS94oat56jB+7pklSvZnGj8qyNxhGHhJaQmaKMZwaGI7dmLWf
         N1DZ/eyMLh/k2XkMLrz+YWkUaN/AJaUVzMfED8I+KJts1bMf3Ic/521/1lwuVmrfJVym
         K0gneeVelf0mfmAKHSxeXIO/fz21j89Hx9QoLQBQra5HYHMBjjM8Esl6ou5SgzSinu1G
         NeKlk5pOvB0FBQiXL4d+uZPJkI5jkFSIFoLqBOoBCJ3i/KXpSe55mYzKnP9XDaxTOk3Q
         1xQ9vfCLrTAS5g9ZlwZPirvIJ/IfwrOZoK/TaRxCUp9VbXzimPaEsfXVE4xSEl+uo0V/
         uZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7s4+d2xWt406APG3wRaoC6OPOVdCpVfU3Vzs0598DdE=;
        b=tDp64iKmw+WzIsmgrCkaoz+2+MeD6KiH9sV3IuP5ygJVx8byzH+bsmffCn6XgypF04
         rh6kRtfiQRDlqbjq9tuCMJaeGlPnPpQjrkwYBWJCz1n7YEAftADmmryvlHm0stt88BzY
         8A6AluGk39m25usImPqEsLILPTz0rEn8g6nUbnB0kyurs85mqIpgPbsIhMp7xTrY5Ig8
         p/veKw1lMu+74HP0g0FQ41Xwd6sM/1D9H6NxegucgxC/+xf1Lb50n9xkYpVqTx7mfd+W
         k0foMrqQhO5RooIVsGTzOVS2W4F78/EImhNrOHRqKd1lAlzfo1qgxpAsqk7s5EH/aeyC
         2WoQ==
X-Gm-Message-State: AO0yUKVyxddc5JNWFlxcdWTL4j7a8Qkhcg+CLnNLarpIKAKehT+SR1T6
        kEW+VHDHtxNXsA8KzueBtfnKo+Xj2gA=
X-Google-Smtp-Source: AK7set/om+UCx0oTBIvEc6pC8uk/9sYk4ebSnIZZLGaZ/Qi2rk9tEIfP5oc57UH1akcWeHNeolR7Pg==
X-Received: by 2002:a17:903:5c7:b0:1a1:d219:eaf with SMTP id kf7-20020a17090305c700b001a1d2190eafmr4258951plb.5.1679339598744;
        Mon, 20 Mar 2023 12:13:18 -0700 (PDT)
Received: from [10.69.67.31] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001994fc55998sm7032001pll.217.2023.03.20.12.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:13:18 -0700 (PDT)
Message-ID: <a0ff714c-5d75-953e-3ce5-31ad2b116965@gmail.com>
Date:   Mon, 20 Mar 2023 12:12:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 02/15] mm/cma: move init_cma_reserved_pages() to cma.c and
 make it static
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-3-rppt@kernel.org>
 <8a461e44-7d24-5b5d-db04-e7fa85beeaa7@redhat.com>
 <ZBg/SCbVBAqNCU+F@kernel.org>
Content-Language: en-US
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <ZBg/SCbVBAqNCU+F@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/2023 4:11 AM, Mike Rapoport wrote:
> On Mon, Mar 20, 2023 at 11:30:20AM +0100, David Hildenbrand wrote:
>> On 19.03.23 22:59, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> init_cma_reserved_pages() only used in cma.c, no point of having it in
>>> page_alloc.c.
>>>
>>> Move init_cma_reserved_pages() to cma.c and make it static.
>>
>> I guess the motivation is to avoid letting too many subsystems mess with
>> pageblock migratetypes, managed pages, PG_reserved ...
> 
> Judging by the git log it just ended up in page_alloc.c because
> set_pageblock_migratetype() was static back then ;)
>   
>> So it kind of makes sense to have these low-level details out of common CMA
>> code, no?
> 
> I don't mind keeping it out of cma and folding this into "grand move"
> patch.
Just an FYI, this conflicts with my patch:
https://lore.kernel.org/lkml/20230311003855.645684-6-opendmb@gmail.com/

So it would work better for me if it was folded into your "grand move" 
(assuming that refers to your patch 4) and init_cma_reserved_pageblock() 
could be retained as a wrapper there in my patch if we want to still 
keep set_pageblock_migratetype() out of the common CMA code.

--
Thanks,
     Doug

