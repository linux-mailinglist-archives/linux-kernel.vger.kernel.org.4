Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D566412F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbjAJNEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjAJNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:04:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1274843A02
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:04:32 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b17so5588491pld.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC1N0zDVRrEUMnl7qa4hp0ujGuIbzlwigMVf18Gbago=;
        b=aPCmqohW0pkZKbT9sslB9zB/Kx/g7PMaYHMRjhO47q5AQGM818B6IJJfbx8o0Ukpa2
         ZhPWh35/tvX7/r6STzkjWDrHhdoLkKJOHYsg1kx76d4lnc9ZJeDcmC3KsfHNHbz2h1Ap
         0+AFxefCnKAoIHWUD4LSHk+2p452udlAfPYDEsYOc9fExxZSZio82kE24mfh3njp39Ih
         Xuo7qXLHGVB+D6KbdG+MCciszZLl+8fzZX+jaGSCSehgPSYHNvpTcDNNjD+UuxiDdjdW
         hYwERr0zFOyPb/hHygZfgT+4j6/D3tu2e99pjH5a9PepIpqzokcyqQSdccdhjKY+mnTS
         BPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OC1N0zDVRrEUMnl7qa4hp0ujGuIbzlwigMVf18Gbago=;
        b=db+PFEoFL5ZwFz7mG8Okhv7P//9/NYgvZw9XOKHuiuRdbDasFpXL8t1AozuqMZT5sg
         ybKfonmHOXOPeQ1iQz2X3GU6n7r71n8hTUThVObK8/vKQXUwMX13FOLXnsDbOoncvPsX
         GSmLAcvz2t0va3ptOK3dx3PqVey3xwByws70u1Wk0g952v+IlRVebFu2c9rypeOmiqWD
         +ekdJk877Zdsj3vNV9snan5kAD8pB9mIFbCHeJxLQKuR8pCZrMMfxhUUhxtsezs0nBVg
         Xj3objIq60n8PS+JKGVRIbh5YKrIBHuUt3F8Vpx+87YqWGUqe4HCNEXaFq7THLTMnxRP
         vgHQ==
X-Gm-Message-State: AFqh2koOS5ZLbgfTFt6VWZb1IjBztQOxkPfGZLNw3Lhpc97Erfa/H+CE
        5fxBMCD8jb5mEMGOpYKqcB9wNnp30BQ=
X-Google-Smtp-Source: AMrXdXtZipRfWeSpYd49vaZcYyt+J6x+51KsjfRINXVcxGqWraXoR/k1HRDA7P1Vzt6WgJCtlZfv/g==
X-Received: by 2002:a05:6a21:3d0a:b0:af:7939:5fed with SMTP id bi10-20020a056a213d0a00b000af79395fedmr89645452pzc.43.1673355871562;
        Tue, 10 Jan 2023 05:04:31 -0800 (PST)
Received: from ?IPV6:240b:12:500:6500:cc0d:2cc8:cb79:892f? ([240b:12:500:6500:cc0d:2cc8:cb79:892f])
        by smtp.gmail.com with ESMTPSA id s6-20020a63dc06000000b0043c732e1536sm6844475pgg.45.2023.01.10.05.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:04:30 -0800 (PST)
Message-ID: <9f627a03-56ef-3c93-091b-f863a6909e2a@gmail.com>
Date:   Tue, 10 Jan 2023 22:04:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20221012155133.287-1-musashino.open@gmail.com>
 <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
 <e8932e3eaf1bd9a690e2f41aad8faf3a@milecki.pl>
 <d0df69da-e881-46aa-da51-eb3b610dee57@linaro.org>
 <0857740baa7bd7fd2c3f5ff5a5cb911b@milecki.pl>
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <0857740baa7bd7fd2c3f5ff5a5cb911b@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

thank you for letting me know.

And for all, sorry for my incomplete patch.

On 2023/01/09 18:52, Rafał Miłecki wrote:
> On 2023-01-09 10:48, Srinivas Kandagatla wrote:
>> On 06/01/2023 19:15, Rafał Miłecki wrote:
>>> On 2022-11-11 18:41, Srinivas Kandagatla wrote:
>>>> On 12/10/2022 16:51, INAGAKI Hiroshi wrote:
>>>>> This patch fixes crc32 error on Big-Endianness system by 
>>>>> conversion of
>>>>> calculated crc32 value.
>>>>>
>>>>> Little-Endianness system:
>>>>>
>>>>>    obtained crc32: Little
>>>>> calculated crc32: Little
>>>>>
>>>>> Big-Endianness system:
>>>>>
>>>>>    obtained crc32: Little
>>>>> calculated crc32: Big
>>>>>
>>>>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>>>>
>>>>> [    8.570000] u_boot_env 
>>>>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid 
>>>>> calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>>>>> [    8.580000] u_boot_env: probe of 
>>>>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>>>>>
>>>>> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot 
>>>>> environment variables")
>>>>>
>>>>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>>>>> ---
>>>>
>>>> Applied thanks,
>>>
>>> has this patch been lost somewhere in the process?
>>>
>>> I'm quite sure I saw it in linux-next.git and probably in nvmem.git. 
>>> Now
>>> it seems to be gone.
>> Yes, I had to revert this one as next reported sparse warnings [1]
>> with this patch which were not addressed.
>
> I missed that, thank you.
>
> INAGAKI: could you take a look at this, please?

To be honest, I'm a newbie in Linux & driver development and don't fully 
understand the essence of the warning by "kernel test robot", sorry.
As far as I have seen some similar cases in the past, does it mean that 
the type of calculated crc variable("calc") should be changed to __le32? 
(Maybe I'm saying something off the mark...)

what I assumed:

__le32 calc;
calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
calc = le32_to_cpu(calc);

