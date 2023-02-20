Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23969D351
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBTSxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjBTSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:53:00 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E531D913;
        Mon, 20 Feb 2023 10:52:24 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id b10-20020a4aba0a000000b005200c0d4a2aso312529oop.11;
        Mon, 20 Feb 2023 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kSyy+U7cu1LPbqgpCpin3fJJtVi/1m0uqsRr+auPk4=;
        b=QpNtCuZPGEJs0I4yZ3n4dgQoPfmjUqwjRfDsMgMAFDkQidCYNUKU/JPhxhQW/txmF2
         3MHLcEYMr88+IlDKT+2k2inB9aqIxeCqwxxMn9voIl6uRd49RabOvFZKsii5ESh+RjHl
         Mccoo2HNMCjORLf6Q66Q0KbGqTmXU8lREyP2Xa0gkwysXsnVu/1DS1mz2tnZkSxYhXi5
         ZAPEJ996E3ya75wkehCiU0aIGgAjAVzMnLuYSJO+1IuTX1R3tA9Ld8ovppiyTRp9LuZs
         dHISbs1df3u492eiIZbTosZOGCzpUfFVMTP/rxcvFSK0jx2aGHn1Js3T0I+DUy4Tz3XN
         S9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kSyy+U7cu1LPbqgpCpin3fJJtVi/1m0uqsRr+auPk4=;
        b=sbD1Rug1Rd0tz8RjJ2GbCurzufVqNDoNCZ7FaXnfBH86H/65bd+MlxI20eFeV3/YNx
         mSTIr1TlXBziRcAt1hKYOlFnCCC4PgkWfwNQkX++qfQsummywjPs2A9ngKEoAVGrbOFP
         x8jlq++88z9FaaG4j5AC44oHB042hkC4fB5J5YMd3ZDjJmPug4WtCgNaZIiN4Hz9tCe8
         yzegadrpbHG9yLRm/dz64jbNZrDCC2VR0fqcKqAPFpx0AVumg65hS8P8FXa9RXc996+S
         PWuJ9BAit37IjXJ5dil+Yr5CIq4Z1zjr6kGtdy8cVih3/gqAbvoD7sHnls+B0Wz0KCFS
         sgmQ==
X-Gm-Message-State: AO0yUKWdCPGb/3EN40YAoECsEPABgtkixQI71z4he64hcVavsR4o7gTH
        TUycxFSAuC+NtSendMalch8=
X-Google-Smtp-Source: AK7set/IixUsaZJiXQrA0Fu5hxRMPw1FVqsCuIQLUyI88RICuVveP6BPVLjE9kU1PZxGiuLD8A5PMw==
X-Received: by 2002:a4a:7649:0:b0:51f:fa7e:3804 with SMTP id w9-20020a4a7649000000b0051ffa7e3804mr1077984ooe.8.1676919081756;
        Mon, 20 Feb 2023 10:51:21 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:e458:3986:a974:9501? ([2600:1700:2442:6db0:e458:3986:a974:9501])
        by smtp.gmail.com with ESMTPSA id w23-20020a4aca17000000b00517b076e071sm5076854ooq.47.2023.02.20.10.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:51:21 -0800 (PST)
Message-ID: <8abbd126-7c76-0c35-10e3-3bbb06c0ea5f@gmail.com>
Date:   Mon, 20 Feb 2023 12:51:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-2-frowand.list@gmail.com>
 <20220624141320.3c473605@fixe.home>
 <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
 <20221011092654.6c7d7ec3@fixe.home> <20230109094009.3878c30e@fixe.home>
 <907b6b75-55bc-b38c-442b-4ccb036a3690@gmail.com>
 <20230110091206.72c3df24@fixe.home>
 <defd6445-a6e3-8d81-c9e7-f1dd343e7875@gmail.com>
 <20230220121538.36abab68@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230220121538.36abab68@fixe.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 05:15, Clément Léger wrote:
> Le Tue, 24 Jan 2023 08:34:53 -0600,
> Frank Rowand <frowand.list@gmail.com> a écrit :
> 
>> On 1/10/23 02:12, Clément Léger wrote:
>>> Le Tue, 10 Jan 2023 00:27:16 -0600,
>>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>>   
>>>> On 1/9/23 02:40, Clément Léger wrote:  
>>>>> Le Tue, 11 Oct 2022 09:26:54 +0200,
>>>>> Clément Léger <clement.leger@bootlin.com> a écrit :
>>>>>     
>>>>>> Le Fri, 24 Jun 2022 11:44:07 -0500,
>>>>>> Frank Rowand <frowand.list@gmail.com> a écrit :  
>>
>> < snip >
>>
>>>>>> Any news on this series ?
>>>>>>    
>>>>>
>>>>> Hi Frank,
>>>>>
>>>>> Do you plan on resubmitting this series ? If not, could I resubmit it
>>>>> after fixing problems that were raised in the review ?    
>>>>>> Thanks,    
>>>>>     
>>>>
>>>> Thanks for the prod.  I'll re-spin it.  
>>>
>>> Ok great, thanks Frank.  
>>
>> My apologies, I haven't done this yet and I'm going on vacation for a week or so.
>> I'll get back to this.
> 
> Hi Frank, any news on this ? I'm asking again, but if you do not have
> time for this, do you mind if I re-spin your series ? This item is
> important for us.

No problem with asking again.

I am actively working on this.  Almost finished.

-Frank

> 
> Thanks,
> 
> Clément
> 
>>
>> This is one of the three items at the top of my devicetree todo list (along with
>> Lizhi Hou's "Generate device tree node for pci devices" patch series).
>>
>> -Frank
>>
>>>>
>>>> If I properly captured all the comments, I'll have to implement
>>>> Rob's suggestion:
>>>>
>>>>   "either CONFIG_OF_FLATTREE or CONFIG_OF_EARLY_FLATTREE will need 
>>>>   to become user selectable."  
>>>   
>>>>
>>>> -Frank  
>>>
>>>
>>>   
>>
> 
> 
> 

