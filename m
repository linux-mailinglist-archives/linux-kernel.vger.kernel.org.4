Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A4727D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbjFHKw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjFHKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:52:04 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5230F6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:51:36 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-39a3f2668d5so323502b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686221494; x=1688813494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps3xEBUlTo7f8loMCsGDyMpKyduVCzzLK5zLOAo2FgA=;
        b=Kag095czxCEU7vOdxKYZ/d98TyXJFonRNM16ghzk2PL20EnQiixiPr/iWa2l47tliV
         XkK2Rb5wLA9XE+C70klonvxLrh1G87LUxWiGl/fVQBaXJaRuSMDXdDyvDNhk0lwtZZYR
         UcO8IQH2bctkoF24qDUkRYolVPAAuiqnEu6h2El5B+9dr0rlHZiB9AnM8CjfC6ELmr2Z
         AhqLj1MbQEmyJjq4L4Vy0nISNYXu8gf/9pEWSFFOZZYA5J+qLzDmXijxrwX6dRqTOc1v
         4R9tw2hDnepnF0pRQqSW4aHVn2Z58L3HNVhU/OyC+xhgmDhHKi6AfZhTPuTefdy0TTzA
         MCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686221494; x=1688813494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ps3xEBUlTo7f8loMCsGDyMpKyduVCzzLK5zLOAo2FgA=;
        b=j/qBND4U6+UW95HbLaKNqCDsfI3ZwYwUCYY2rscP3ISHltLr5cS6B7rYXc3UeoA5wj
         SMbgt7dvUEImVHw4TfPx6Bx5BHyG4L2NrP1NPqwTFrDz1PvKGfmUgFhlgPlnRO/KLg3o
         Rm0fEvvXGCkAgUcZNiamyZOTPV4vb09IOBcCc/FEvsDJh2k512l6UChnincveTtBLYnL
         ftM/3MMqqZktwK46KURNty8lf7BK/3Bt1YY+O+cY0vojjRTtrO5WeFZAGlWagwOG9lTs
         sswxykm+8kwwsS+waQEdRuDxYk4ygJ8D79MBZ1JJgfmdfCevoepMQb7WEF7gq9c3Zxdk
         gVag==
X-Gm-Message-State: AC+VfDwIsA6Er6viG4FT60eg35zadDkm4acDsiZQVcnozs/OEUkBBrjD
        sf1B1//73zh5S+JyppdMdJkvtA==
X-Google-Smtp-Source: ACHHUZ72N291wzl0vYRQgKoDRSxdlp+HNwZWEHyWBr30AaBo6mZsWxlOZiVzilpKC0RImlSen5qXSw==
X-Received: by 2002:a54:450a:0:b0:39a:b7a3:7d5e with SMTP id l10-20020a54450a000000b0039ab7a37d5emr4820536oil.33.1686221494459;
        Thu, 08 Jun 2023 03:51:34 -0700 (PDT)
Received: from [10.54.24.10] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090a010f00b00256799877ffsm1059500pjb.47.2023.06.08.03.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:51:34 -0700 (PDT)
Message-ID: <a369ca46-f2c7-7d84-c67c-7006e13f1ada@shopee.com>
Date:   Thu, 8 Jun 2023 18:51:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
To:     Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
 <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
 <ccc68b26-0896-2f2d-ba54-038f34e9eaa2@redhat.com>
 <34f32148-24c3-09a3-8bec-9515139e15b1@shopee.com>
 <ZIGcyku+DN5IHtwp@dhcp22.suse.cz> <20230608101340.GI52412@kernel.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20230608101340.GI52412@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/8 18:13, Mike Rapoport wrote:
> On Thu, Jun 08, 2023 at 11:18:02AM +0200, Michal Hocko wrote:
>> On Thu 08-06-23 15:38:48, Haifeng Xu wrote:
>>>
>>>
>>> On 2023/6/7 18:22, David Hildenbrand wrote:
>>>> On 07.06.23 12:16, Michal Hocko wrote:
>>>>> On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
>>>>>> If freesize is less than dma_reserve, print warning message to report
>>>>>> this case.
>>>>>
>>>>> Why?
>>>>
>>>> I'd like to second that question, and add
>>>>
>>>> a) Did you run into that scenario?
>>>> b) What can an admin do in that case with that error messages?
>>>
>>> In theory，dma_reserve shouldn't exceed freesize, so the error messages can remind us
>>> to verify whether the configuration of reserved memory is correct.
>>
>> I am not really convinced this is worth touching the code TBH.
> 
> The only architecture that sets the dma_reserve is x86_64 and it sets it to
> the number of reserved pages in DMA zone. There is no way freesize will be
> less than dma_reserve.

Yes. From the comments, x86_64 calculates the dma_reserve in order to set zone watermarks more
accurately. But berfore init_per_zone_wmark_min(), memblock_free_all() has already recalculated
the managed pages. It seems that the dma_reserve is not really helpful to this.

> 
> I'm not sure that in general dma_reserve has some value now, but that's a
> completely different story.
> 
>> -- 
>> Michal Hocko
>> SUSE Labs
> 
