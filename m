Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8669C02E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBSMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:30:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF7F757
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:30:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id en26so1427989edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uA2O9ktk2ao2MoVvIowjtkT1G30AdjFZwnQ9dFlWAfE=;
        b=mpOk4Ty4ZUIkG4/dK7XI6MlytDBnUbFmPeZn6A3Qj37jIisxWaZjHvUgadRxP67gNU
         hzTozh4tG5X5SqOrEAwpYPgoQy3lfmgInK9kTkIwxgLWG6imGVl9FCUaZpYdefYnAkm2
         xsVZRkpK/iiw5RNTfVMFrUv4NM84fZyAi1487y7kc6lPRf3y8R5oBto5kjQhSnuwoWPC
         AnGecz0mG9U349Vvf5quCWR5hguZMwi7qAX9I4n/LMA9HzUEBIVNy8vk0T3Sz1H7MIG1
         QRpIcPAjs5E9rV2CNSNKg5pb3ZS8IFYsGEZpenLgRZy1LrATl/wadfSSkRqpBkq/zThL
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uA2O9ktk2ao2MoVvIowjtkT1G30AdjFZwnQ9dFlWAfE=;
        b=EFbgUymfeCdDSfGkpffKwak0l8a9gffGJbQ8MG+ZsYrTKm7BqksTdXUDj1WS6EDCLC
         4QOMQFNmoLLG/mNyAu9a2adp2/IHS5bt+KpFZd2YFvOaARt8axgWBGz2yw5ub+Nyhxyf
         XGC+9OnibEIfP28K5ssRKNY3WnQ1CeHxzpg47okLCJH1TE4ybnMcGcTOV+s0CJnXc0Qd
         7BrRpdIlEjo0GmDAxkKiwNF+saHaQBl9j9c0jn9m+javgJyt4yMRMI8gAn1RA6t+adkG
         DuMRckhKUPc0RoDADcAHBEzuZvacgsBF9quzDVcCXw6BbkyyHtB0xJ0EudValC2RSJzw
         aYlA==
X-Gm-Message-State: AO0yUKUB6JRZwLcbT6bRz01HcKhViIenHzO78SHVtXgXHeVLcwqtGIKi
        L+LK0llv5szVs2pVi+cmbluO1jvX8Ic=
X-Google-Smtp-Source: AK7set/VoCRze86Kw5QwPVdNm2X7n389ZGBB5GnpypfZTT5i/2aChufl1ahql6sYbglAlY6Kzvfe3g==
X-Received: by 2002:a17:906:f205:b0:8ae:e82a:3230 with SMTP id gt5-20020a170906f20500b008aee82a3230mr3999898ejb.70.1676809843115;
        Sun, 19 Feb 2023 04:30:43 -0800 (PST)
Received: from shift (p5b0d72d5.dip0.t-ipconnect.de. [91.13.114.213])
        by smtp.gmail.com with ESMTPSA id bk26-20020a170906b0da00b0089d5aaf85besm4404354ejb.219.2023.02.19.04.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 04:30:42 -0800 (PST)
Received: from localhost ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1pTinA-0004iz-1b;
        Sun, 19 Feb 2023 13:30:42 +0100
Message-ID: <cb4b3498-f543-2cdc-d959-5bbd25a9e205@gmail.com>
Date:   Sun, 19 Feb 2023 13:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
To:     INAGAKI Hiroshi <musashino.open@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
References: <20230213132351.837-1-musashino.open@gmail.com>
 <d8e6135f837462a7f7cdf59e20bfc449@milecki.pl>
 <93a02a4c-9cba-4b39-4b3e-406a30a8e094@gmail.com>
 <1276b70d-9461-4a4c-08f7-2bed42557fd6@gmail.com>
Content-Language: de-DE, en-US
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <1276b70d-9461-4a4c-08f7-2bed42557fd6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Hiroshi,
On 2/19/23 05:45,  Hiroshi wrote:
> On 2023/02/18 2:30, Christian Lamparter wrote:
>> On 2/13/23 14:37, Rafał Miłecki wrote:
>>> On 2023-02-13 14:23, INAGAKI Hiroshi wrote:
>>>> This patch fixes crc32 error on Big-Endianness system by conversion of
>>>> calculated crc32 value.
>>>>
>>>> Little-Endianness system:
>>>>
>>>>   obtained crc32: Little
>>>> calculated crc32: Little
>>>>
>>>> Big-Endianness system:
>>>>
>>>>   obtained crc32: Little
>>>> calculated crc32: Big
>>>>
>>>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>>>
>>>> [    8.570000] u_boot_env
>>>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated
>>>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>>>> [    8.580000] u_boot_env: probe of
>>>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>>>>
>>>> Fixes: f955dc144506 ("nvmem: add driver handling U-Boot environment variables")
>>>>
>>>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>>>> ---
>> Hmm, this is strange. The kernel's u-boot-env driver works without any
>> additional changes in the le<->be department on the Big-Endian
>> PowerPC APM82181 WD MyBook Live NAS.
>>
>> Is there something odd going on with the WD MyBook Live, or is it
>> the APRESIA ApresiaLightGS120GT-SS that is special?
>>
> 
> This additional changes are for resolving sparse warnings. Of course it's 
> working fine on my device with the previous changes, but due to the warning
> it wasn't merged into the mainline and needs to be resolved.

Oh, yes. This could be why! I was wondering why any additional endian related
changes would be necessary. But no, they are not. This is the patch from
October/November last year.

I now remember '[Patch v2] nvmem: u-boot-env: align endianness of crc32 values' too
<https://lore.kernel.org/lkml/e7ebabf9-a7b2-6155-cdd0-5dafb6bb2a7a@isd.uni-stuttgart.de/T/>
and back then I provided a tested-by tag as well. So there's no difference between
the  APRESIA ApresiaLightGS120GT-SS and WD MyBook Live. Both will need this patch.

Cheers,
Christian
