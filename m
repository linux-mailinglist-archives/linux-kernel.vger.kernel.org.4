Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E17481EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGEKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGEKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:19:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B0122
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:19:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8ad9eede0so6197525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688552395; x=1691144395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u7+5Xqy66HQP6SQUF7U4sC21GcgKDOqOTXMNFMXNXA=;
        b=rPJPIfq/R6OfaG/YEW6Yp+yH3ApXrithvu7h+TjIopWJTbDTlq9JiGu/+38Nj3lViT
         wgn8vySnMiJWgLRaBS69ec3yC24zcrqBWhjMWcBzVcB5cgQhUVMEGNr2cURwoXhMM/uk
         +W6md+t5FMV0Skctm7On6nGznnQ9WYyj9IClRs09KMKBGU6ZrVvZ5DBz4PSRszHpemqD
         va5sKn4kbXL/McNsgVQ27pd2wo5osf7Lx0kq7n5m+kVSwku7O5xVcwfJ3HKsrvxdgeqb
         yi1eDhXE2k4NW9CEBxhMyv8qfP/9yBTxGZNIt9AU8Gk/b9mwAwqolIiCmND6lXXyE54H
         WVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688552395; x=1691144395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3u7+5Xqy66HQP6SQUF7U4sC21GcgKDOqOTXMNFMXNXA=;
        b=Nh6aFjm0uiOWhJ9CRwAGEjONBW0bGG1NKIQV0x2PTzy1tat3aFrs+7HH1sjWJa4dAr
         lKwoiXR5Nzt3QDDSN8w3fPtC+EA2sSAJ+L0v+KO1qe6wFbTfu3QKgATaRP325OkdYAIV
         UpKNu8ZRI+Yyf46syvj5qcxC8rNeRaP2WbLbKzmBerJSZLlj7cNjn15J6QH36VUsQLnT
         UsQWD6CnvcbzVYNPWY8GUvawj/a0XvdDEtf4haoA4a89mSzLgapp8LoOkYS17HoNP+eY
         eIIjS7UALuKKs4CNUMyKUgSMadFPpKIXsC1BmLn3gu5+sVzWORrEIIjA9v6WEGb3PZ+u
         dBxw==
X-Gm-Message-State: ABy/qLY+2hUJs/W9VsCxMnYoGYo8r34GpYNmigv1LhVoGefOO0Tl3tYT
        6+RjyOG9Bt1aztqTwdXakE8=
X-Google-Smtp-Source: APBJJlFtq8pH3qACwgrVuzhtaF6Tf1EaeFvnte7cgLrY+EcS1al3gR2FZfJH7jks15BP5NnNrlkZNw==
X-Received: by 2002:a17:903:1c5:b0:1b5:219a:cbbd with SMTP id e5-20020a17090301c500b001b5219acbbdmr19318373plh.3.1688552394645;
        Wed, 05 Jul 2023 03:19:54 -0700 (PDT)
Received: from [0.0.0.0] ([5.180.77.117])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902b20a00b001b872c17535sm8947975plr.13.2023.07.05.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:19:54 -0700 (PDT)
Message-ID: <741ac150-5913-7011-31c2-15292df8061c@gmail.com>
Date:   Wed, 5 Jul 2023 18:19:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD
 size for the direct mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230704121837.248976-1-alexghiti@rivosinc.com>
 <20230704-emblem-rubble-e4a3a87cb98e@wendy>
 <CAHVXubikF36Tc19vv9osVz3ZvEyKXk-+74YBpPAZQpSt+vFkQw@mail.gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
In-Reply-To: <CAHVXubikF36Tc19vv9osVz3ZvEyKXk-+74YBpPAZQpSt+vFkQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/4 21:16, Alexandre Ghiti 写道:
> On Tue, Jul 4, 2023 at 2:26 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>>
>> Hey Alex,
>>
>> On Tue, Jul 04, 2023 at 02:18:37PM +0200, Alexandre Ghiti wrote:
>>> So that we do not end up mapping the whole linear mapping using 4K
>>> pages, which is slow at boot time, and also very likely at runtime.
>>>
>>> So make sure we align the start of DRAM on a PMD boundary.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>> Obviously correct me if I am wrong here, but was this not reported by
>> Song Shuai as a regression?
>> Accordingly, should this not have Reported-by, Closes/Link & Fixes tags?
> 
> Sure we should add the reported by from Song as he did the proper report :)
> 
> Reported-by: Song Shuai <suagrfillet@gmail.com>
> Closes: https://lore.kernel.org/linux-riscv/20230625140931.1266216-1-songshuaishuai@tinylab.org/
> 
> And yes sorry, I thought it was there before, but it was actually when
> I retrieved the first 2MB that the problem appeared, so:
> 
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> 
> Thanks!
And you can add my tested-by:

Tested-by: Song Shuai <suagrfillet@gmail.com>
> 
>>
>> Cheers,
>> Conor.
>>
>>> ---
>>>   arch/riscv/mm/init.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 4fa420faa780..4a43ec275c6d 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
>>>        memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>>>
>>>        phys_ram_end = memblock_end_of_DRAM();
>>> +
>>> +     /*
>>> +      * Make sure we align the start of the memory on a PMD boundary so that
>>> +      * at worst, we map the linear mapping with PMD mappings.
>>> +      */
>>>        if (!IS_ENABLED(CONFIG_XIP_KERNEL))
>>> -             phys_ram_base = memblock_start_of_DRAM();
>>> +             phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
>>>
>>>        /*
>>>         * In 64-bit, any use of __va/__pa before this point is wrong as we
>>> --
>>> 2.39.2
>>>

-- 
Thanks
Song Shuai
