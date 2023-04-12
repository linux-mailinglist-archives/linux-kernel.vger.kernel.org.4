Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9D6DEC47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDLHL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDLHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:11:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0F30CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:11:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a5266d204dso3157695ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681283466; x=1683875466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLGUazJtYuXNZ/gdbOuxu9qvl+KvyH/wz0PlYDvCPAU=;
        b=coF0kl41Le6es6uTX7Gf3pTlxqhFLMtFc51Ue8V9snX7EH41bjsJJrKOhXELF83DXy
         tJpldV69gmrncNBokRJ/1f5Bby+jCAw/Om30yy1H53vht7WUh8/kwonLc50p+OYyY77G
         HWjahoJWRNjUR9SOSKqEj+lRHrWwUqqWoAT7Qjnij7rEayiWeAVzgYFrOpojKoRJSCTw
         HJPzHibaWzCgK9unAE0g17KAzNDAF/sgH16AVMoS2nvyCSbL9xBBGkHNgCcieGcD3fBQ
         76sZURkRJTwXGxgFzLWrTysRzWMmvQquStOwnyHEF5myu2Fz2z0MY33vzirBWdwc2T31
         igMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681283466; x=1683875466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLGUazJtYuXNZ/gdbOuxu9qvl+KvyH/wz0PlYDvCPAU=;
        b=V6MZ43ZDjOr7mJpn96egwbYuwtfGoRN8g7yG5/R1fIl8lsKtx0exoGKHvyLPayqiwd
         OMWmpRKyLhJTqAQXMbyyh0+NV3JPwX1H/GepVcwq6SG1Gg5/cC5+zJN0pbT4eKgRjbsh
         10pw0GZPXmo4hSI5mhcgxPSW6Mr14f8s/H6rF7ayWCc5Bfs2W02MUvN5e0TaZsaQNrbJ
         ptoP1uTKHqh9R3TeoRzqMTedvuIVYQw8XUiK8yOAk4e6ySiNuB2LANmC8/VN5sPTiGUs
         biGeEgF9BLrzHv678Z3VD1SVeJcZNUK7nYJhYGUljPuvYfaisI1iRJWEPBSso1AnmFRg
         Vqeg==
X-Gm-Message-State: AAQBX9dfx8CJ5nBquKxVknH98mr8ocCp5b0ZQHLh26XNuCrYVn2O+yDG
        eBoqsbjBAjoq8QZTdg7NgpDaPw==
X-Google-Smtp-Source: AKy350Zcf6huqSI6JAKiN9shVFOT2KZvt+JkXhRLAN5PySc5WmFG11ZVkLfV7zm1n1O15zJhsrIUww==
X-Received: by 2002:a17:903:22cc:b0:1a6:6edd:d143 with SMTP id y12-20020a17090322cc00b001a66eddd143mr1047658plg.6.1681283466471;
        Wed, 12 Apr 2023 00:11:06 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090270cb00b0019a997bca5csm10802172plt.121.2023.04.12.00.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:11:05 -0700 (PDT)
Message-ID: <e41a58eb-c950-acff-0880-a693515aa650@bytedance.com>
Date:   Wed, 12 Apr 2023 15:10:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] x86: make __get_wchan() use arch_stack_walk()
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     peterz@infradead.org, keescook@chromium.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
 <20230330081552.54178-3-zhengqi.arch@bytedance.com>
 <20230408050822.ezdbhc6j7zuvutrm@treble>
 <fffd59ff-eaa8-bba7-03f2-9fc27620bd1c@bytedance.com>
 <20230408221206.mi7nsquoxklgword@treble>
 <4aba3e74-a205-5dd1-69bc-9186c04e733d@bytedance.com>
 <20230412052037.nz75jeoeqibx6otr@treble>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230412052037.nz75jeoeqibx6otr@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 13:20, Josh Poimboeuf wrote:
> On Sun, Apr 09, 2023 at 02:30:23PM +0800, Qi Zheng wrote:
>>
>>
>> On 2023/4/9 06:12, Josh Poimboeuf wrote:
>>> On Sat, Apr 08, 2023 at 01:36:06PM +0800, Qi Zheng wrote:
>>>>
>>>>
>>>> On 2023/4/8 13:08, Josh Poimboeuf wrote:
>>>>> On Thu, Mar 30, 2023 at 04:15:52PM +0800, Qi Zheng wrote:
>>>>>> Make __get_wchan() use arch_stack_walk() directly to
>>>>>> avoid open-coding of unwind logic.
>>>>>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>
>>>>> Can we just have a shared version of __get_wchan() for all
>>>>> CONFIG_ARCH_STACKWALK arches?
>>>>
>>>>   From a quick glance, I think it's ok, but we still need to define
>>>> the arch's own get_wchan_cb(). I will try to do it.
>>>
>>> Hm, why would we need to do that?
>>
>> Because I see checks for count++ < 16 exist in __get_wchan() for some
>> arches and some don't. So I'm not sure if this check can be discarded
>> after using arch_stack_walk(). And I see that this check is retained in
>> arm64, see [1] for details.
>>
>> [1]. https://github.com/torvalds/linux/commit/4f62bb7cb165f3e7b0a91279fe9dd5c56daf3457
> 
> That difference seems to have nothing to do with individual arch
> differences.
> 
> The 16-check limit looks like some ancient cargo cult ritual which was
> copy-pasted decades ago, presumably to avoid some kind of infinite stack
> recursion loop in scheduler code, which should never happen.  That
> should definitely be removed.

Got it.

> 
> Another good reason to unify them, to get rid of cruft like that.

OK, will try to make a shared version of __get_wchan() for all
CONFIG_ARCH_STACKWALK arches.

Thanks,
Qi

> 

