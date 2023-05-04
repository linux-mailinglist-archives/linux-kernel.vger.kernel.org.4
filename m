Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A86F721F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEDStd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:49:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89659E2
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:49:30 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-769a4e76f30so5192539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683226170; x=1685818170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9kcL+3M6NJvfy54LjX3dnhh7Nym+CG7fFN3PBfZdWE=;
        b=BkD0g3OktUdUzdvtWkH9kHpU4KaHW6X8zuAsqIf8EK27lsgkPick729168wcHcghRF
         5eHYMs/4VsOt+3+66+i8wh93uXlFlkMqNGYjKeVyFf2xoS4ThTsu5eNJPmZ0kl2k+LUZ
         4RvJRICBeiDIWa8y8R3ZHQIl36I3IGAZSw4zYJ5vYyMgORcFJeniK3nJXTnMgFS7GEYv
         qW2dzOvbmaRLn/fBSqsdzVIgxjs4ixG/epnELSDqT7ogamQEma31cJx+wM6+Y1gvGIb3
         zFUkZ2QG8JqFDpkILsKUcYbYAgt5JhV75lCJJngDBZb+Z678t3bHnsp0qjgQyz7Xpwk6
         uTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226170; x=1685818170;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9kcL+3M6NJvfy54LjX3dnhh7Nym+CG7fFN3PBfZdWE=;
        b=dduNLeKku6GL9wXoV/fCGkMjBt6Oc9ZVXmDeQeX/myWQ9ao8HfVYEW0qK5PVagogE4
         GvAFarHYTHwwzSRd15CNUaXJ5ueiESrTyKiJai76MiYwa6Jquao6UxKNgNcCyAp03+Y9
         dVdBVtZrkEdYVASGddf40mAAeZms7fH5AipIWoaH65VwK6H3h0jyWLecu8Oab4q39V8F
         lp9BNoBXd4TfxhEL2f3N9ONv/zQY5g+fAbs8SVuTSs17QZ4mRa7o+8HZfVTbuDJLgA5h
         Wbs8isr5brxTWKYKkQxtsAeHRn4Wgg4PAu+yIfIFCYySemNe9hd8EL+kZJIUQTltf+06
         Uz9w==
X-Gm-Message-State: AC+VfDwURSoqgVLF9XuCp4o/Y4Sc840BOA/cXudBrCAu4yQFnmUqgTCE
        hYxBtVPSPsQWHfqCvHBUVB5eyQ==
X-Google-Smtp-Source: ACHHUZ4g3Xvw6uZVVf/SjiMlyL7AfQPISwMzpaot1MvFRZXSG4N/osvma/QdeH/Bjg1/7z0W4A0RMA==
X-Received: by 2002:a05:6602:5c5:b0:760:ea9d:4af6 with SMTP id w5-20020a05660205c500b00760ea9d4af6mr10968220iox.1.1683226170183;
        Thu, 04 May 2023 11:49:30 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h6-20020a5e9746000000b0076356c2d1acsm628878ioq.52.2023.05.04.11.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:49:29 -0700 (PDT)
Message-ID: <a3ef2259-2614-4f6d-d64a-6079e7205b77@kernel.dk>
Date:   Thu, 4 May 2023 12:49:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US
To:     Raghavendra K T <raghavendra.kt@amd.com>,
        Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <835c3de6-7460-226c-96e7-839aeef6064e@amd.com>
 <b9acff08-913b-55cc-75dd-4a1bbe63e330@kernel.dk>
 <7368789d-e2a8-ff1c-f224-b9f1b7896877@amd.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7368789d-e2a8-ff1c-f224-b9f1b7896877@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 12:48 PM, Raghavendra K T wrote:
> On 5/4/2023 10:14 PM, Jens Axboe wrote:
>> On 5/4/23 10:38 AM, Raghavendra K T wrote:
>>> On 5/4/2023 5:19 AM, Ben Greear wrote:
>>>> On 5/2/23 21:46, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 03.05.23 04:31, Bagas Sanjaya wrote:
>>>>>> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>>>>>>
>>>>>>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.
>>>>>
>>>>> Just to understand this properly: you mean after the boot loader said it
>>>>> loaded the initramfs, not when the kernel starts using it?
>>>>
>>>> I am bisecting...it appears to be .config related.  If I skip enabling things
>>>> during bisect, then I do not see the problem.  But I copied my original buggy .config
>>>> into an otherwise good kernel commit, and now it fails.  I'm manually bisecting
>>>> the .config settings....
>>>>
>>>> Thanks,
>>>> Ben
>>>>
>>>
>>> Hello Ben,
>>>
>>> (CCing Jens here)
>>>
>>> I was facing same issue too. Surprising I did not hit the same on the
>>> guest VM.
>>>
>>> After bisecting, found that Reverting
>>> [9f4107b07b17b5ee68af680150f91227bea2df6f] block: store bdev->bd_disk->fops->submit_bio state in bdev
>>>
>>> Helped me to boot back the system. Can you please confirm
>>
>> Can you try and pull:
>>
>> git://git.kernel.dk/linux for-6.4/block
>>
>> into current -git and see if that works for you? There's a fix for that
>> commit in there.
>>
> 
> Jens, pulling for-6.4/block helped in my case.

Great! It will be heading to Linus's tree before -rc1.

-- 
Jens Axboe


