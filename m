Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B438663557
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjAIXdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjAIXdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:33:02 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED70DEFF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:33:02 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1441d7d40c6so10485886fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PXuRCJmN2e9yMm+caG9paZKXvo2Sxw9/jMmHB3iKxrc=;
        b=MiQnd+hVBOcducMI5nqSxJ3SZ2aqH1iMi/Kw7JjYvV4vVykwsfoW6FBjNVdCHMO6px
         b3hwyG1M0vToTwABAKGMry2aoVxR63HQG/0yqr8Q4/0/AyHwFFVdWF/PyVMAF/2xODO+
         yZ6R7woHQOAPioh9W/vw4V/g7ZlWWb2Hdyz8/pf1y93yjmZ6OH34GFU1QzlNYZ0wL6Un
         vozjlRcBzoXLF8MRqiQCEe+WIKadHYDc6sdlg2pmEOJr3tqb7UOXYhUbVdMadQGPlY76
         2thWo7pFhZ7fff0BcIFs0wN1aLrIko9nPJ5J3QZxcmg6eO2LzwgfsUHLKl8ZJ95Z2XHH
         auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXuRCJmN2e9yMm+caG9paZKXvo2Sxw9/jMmHB3iKxrc=;
        b=47CRufXDzj2lrBWn7ogIm6JgUHE+0jpTR27qq9HWSWwE283myAb/t23tlGxE2W4B8b
         Z7tRi9S2jtyNufhmAqFdBrENcBdf251qV8DcSBz4Xtw7G/Z62X0dZ4I2nna25XIG2NDZ
         PXUFYYGH2k7IU2cGGclYEE//ktB7N8VVz8J+9WQg0gKMwtXuUD2O2KO8TUM2jLTYXlbI
         4fB+BGakHPnSAByQmxCNt+kI9i1EgceLRrvarGMhCS5sL/oiTdfI7Td7iuyLiLSJawss
         K0n7GR1eRsh6HRWPeHXQwE64we1b3aB3Idsx8Mn5D7QQ9ahFgLL2wJi086nigXJrXkXW
         MrKw==
X-Gm-Message-State: AFqh2kphlc928flhOx9p6xnEykdBor87iojBt94F/hiq4ernZ8cwY53W
        vuQE1clmXMMHbwmSYckUdEk=
X-Google-Smtp-Source: AMrXdXus2vASmVI2MT7r7RoON0aRQ61Y85dbEOTktIw5Jdvu6Rj5gK9re6geHI07xNeSS1Nzct7GBw==
X-Received: by 2002:a05:6871:4212:b0:14c:2aca:ac11 with SMTP id li18-20020a056871421200b0014c2acaac11mr31858104oab.29.1673307181358;
        Mon, 09 Jan 2023 15:33:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0013ae5246449sm4852719oac.22.2023.01.09.15.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:33:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <38fdb883-307f-f86a-2e04-80be7480c5ff@roeck-us.net>
Date:   Mon, 9 Jan 2023 15:32:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Linux 6.2-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net>
 <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
 <f39c266c-9802-71a5-8f1c-2d0a1340f59f@suse.cz>
 <CAHk-=wgg0hqiU5M3ExJdSNjx+BzDEC_fH7H_Rb0h_uykavg=Fw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgg0hqiU5M3ExJdSNjx+BzDEC_fH7H_Rb0h_uykavg=Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 15:14, Linus Torvalds wrote:
> On Mon, Jan 9, 2023 at 4:43 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 1/9/23 23:18, Linus Torvalds wrote:
>>>
>>> Does anybody remember - what was the compiler version again and what
>>> do we need to disable?
>>
>> Guenter reported that "The problem is seen with gcc 11.3.0, but not with gcc
>> 12.2.0 nor with gcc 10.3.0."
>>
>> https://lore.kernel.org/all/20221227002941.GA2691687@roeck-us.net/
>>
>> Kees said it's -Warray-bounds, already disabled on gcc 12 for other reasons:
>>
>> https://lore.kernel.org/all/D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org/
> 
> Thanks.
> 
> I added a GCC11_NO_ARRAY_BOUNDS symbol to match the existing
> GCC12_NO_ARRAY_BOUNDS one, and to half-way document this thing.
> 
> I obviously don't see this warning myself, so my commit is "blind",
> but looks completely obvious.
> 
> Famous last words.
> 

Tested working.

Guenter

