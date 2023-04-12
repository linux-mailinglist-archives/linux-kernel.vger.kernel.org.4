Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8526DFD20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDLR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDLR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:57:29 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1E55586
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:57:28 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32879965ac8so393165ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1681322248; x=1683914248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+JfcQnfDefc+Psf+afOHei8O95xNSiyrdp/ELOZ4PA=;
        b=3kbYTETYXAQSV9vY1gYz7myUGQ+D6nAuLpuWyAOUsSijyxQ5cMmBGmv7qogj7bwbv7
         EghnWaGG6xKu+HG7xnuo+oALMNCzz9xxKQ/lPP+MNklgmgUyku8FwUWDGC6wzD5jVRCJ
         KHGZhl8LCvheb5pJPL04bCvI07ECn0PLLcb2PB9LK72BdAqmoL77fY6JeLmoRXYU2NZF
         p4lzYeBirSpT9Z8MPo04RL3EI1TmTACJQsnJDCEPJWM+WsOHly00C6PlN+ezknHc9Xpw
         sn+0XgJE6/HETR7nyqKpufhq3qCz9kN1P9p1lpWXaFd1cIW3sIL+R6CMnEZ7VeDkYTm8
         niUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322248; x=1683914248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+JfcQnfDefc+Psf+afOHei8O95xNSiyrdp/ELOZ4PA=;
        b=FGH51eiE9zwbDM61ycEEJhvTQF43MrhPKfUHoA0P+GQDMRajb8Q5PTD2JErRtOpXL3
         OcU5kpf3ukuBZvWNZIuldLFHtcmdAqVdpN4wo0GdcTs/tu2ejYjJJI4tFt7A0KC+r5JS
         5GzvjD7M/ipI8ZQN1UvDcSWQQurkA2T1J9jeq7/COyk0m6NYoweAKkklWv5HHDDnE40W
         XWQFcrQu1ssBZTqg0aQVBCm2OCsVB+cHjuMYWeG2APzzbOV+H0P9R0NOkMK6K8aHY2UE
         BVsp21MqtA7HmPGUlNO9SXQAquKHpHmdzzSFmc5TEMVmEFUfEMIMOZHmU25B5KkWJBWJ
         RkIg==
X-Gm-Message-State: AAQBX9f99fUBReTo4/2AkKqeyQJhB80ifI8XH7iNhq+pT8VUxl9xGmdC
        2KhlrJPYX14J81XOUYoKSOU4bQ==
X-Google-Smtp-Source: AKy350Z5TOBnvkzsZq1FgaqrsbzisLEdIqlkr3eMx0gI3S0ZnzGoWTBZwMbT2Bo2IEmx3gb+uKeD0Q==
X-Received: by 2002:a05:6e02:964:b0:319:5431:5d5b with SMTP id q4-20020a056e02096400b0031954315d5bmr1671496ilt.1.1681322248227;
        Wed, 12 Apr 2023 10:57:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h11-20020a056638338b00b00408df9534c9sm4913369jav.130.2023.04.12.10.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:57:27 -0700 (PDT)
Message-ID: <a70e8da4-167a-3730-be5f-01429b1f1df4@kernel.dk>
Date:   Wed, 12 Apr 2023 11:57:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
 <20230411215518.u2fgi7napfcwyuce@treble>
 <4959d0b8-96fe-7fe5-8b36-7e0a266d1d17@kernel.dk>
 <20230412001400.yraku5fwsjdchxvk@treble>
 <20230412114400.GB628377@hirez.programming.kicks-ass.net>
 <20230412162517.gji52t34zlvcu5bh@treble>
 <6527c6fa-8908-1d8d-2f9e-bb7636a27874@kernel.dk>
 <c4d8e079-91bd-62e8-7725-b03802398c83@kernel.dk>
 <20230412165652.umuiemo7ifnhr2nz@treble>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230412165652.umuiemo7ifnhr2nz@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 10:56?AM, Josh Poimboeuf wrote:
> On Wed, Apr 12, 2023 at 10:44:11AM -0600, Jens Axboe wrote:
>> On 4/12/23 10:35?AM, Jens Axboe wrote:
>>> On 4/12/23 10:25?AM, Josh Poimboeuf wrote:
>>>> On Wed, Apr 12, 2023 at 01:44:00PM +0200, Peter Zijlstra wrote:
>>>>> On Tue, Apr 11, 2023 at 05:14:00PM -0700, Josh Poimboeuf wrote:
>>>>>
>>>>>> Peter, what do you think, should we make track uaccess state across
>>>>>> function boundaries?
>>>>>
>>>>> So IIRC the goal was to explicitly dis-allow that. You want minimal code
>>>>> executed with STAC and hence disallow calling stuff.
>>>>
>>>> I guess I was wondering if we could make an exception for calls to
>>>> static IPA-optimized functions, so we wouldn't have to scramble to "fix"
>>>> compiler optimizations.
>>>>
>>>> But for now, yeah let's just keep it simple.
>>>>
>>>> Jens, can you confirm this works?  I added __noclone instead of removing
>>>> static.
>>>
>>> Yep, works for me.
>>
>> Want me to slap that patch on top of the branch that has the commit
>> that causes it?
> 
> Yes, please.  Thanks!

Done!

-- 
Jens Axboe

