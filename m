Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C748F71A074
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjFAOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjFAOj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:39:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078DD1;
        Thu,  1 Jun 2023 07:39:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-65131e85be4so415477b3a.1;
        Thu, 01 Jun 2023 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685630397; x=1688222397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vAtDJ4UZJBm7+uLnpiZVzFRiwuCQbc5zdoMX8rHHbbU=;
        b=qt7Q1bUpshWH93RKlnxUNBqecIEtKUcuPoKkhnCZxE2gPC4w/HAKWUFxEhX0tLVXUe
         S8jOYv048Br31vztTF78G6zqhLr8ZEPx5/MKGpurvWErugkg8dzfAeAbWdJ76CQksWXA
         CU9Tv319FOi24XK7aa4QW3qGckz/P6VC3W1qVM3iwms5RpwRVU63bVis1PVsnpvXKrem
         edL1YH8fqp3jMwPd8JW7/49rfG68WADIhR6IW6rdnueZ6RtHH4sV2CrJH8ytApV6AGtg
         sHaN2TVVIq71aSbOvo6wPhcghG2/LZyY8TkSYspa7TsfklM65Mrm3PEcsA9ZbAsaX336
         Orxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630397; x=1688222397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAtDJ4UZJBm7+uLnpiZVzFRiwuCQbc5zdoMX8rHHbbU=;
        b=JBBkWnyyDwnYqU0zZeXM4m3ASW4WWfOsTVfTbug3gYCBpzJI1udRyOq32BrHMafjcF
         xRNFzTHGCGvSavH5eXZTpB5xTNNf+RnDir1iqF0db2IHN/v1Huzwtc+G4AznKnxD6VCA
         5blPxKRpJry0krf6PiCetvx5DFIEa79vveZd4VWTxEtrn4idx0+vRGwROHUyjwcoVDxU
         wqhfWTI2+IRWm1wfBfEqX7Uk8FcHX2MHGu/s5UdVW3PbZqR/ARpc2S5qvxbmuz12KZfm
         lZdG9j9I7BnkCSI2xh4Tn/UB/akGbW36F3N/hYIM/KkyNOWi3jSBaQ/SNs//n5QG6Z3A
         llCw==
X-Gm-Message-State: AC+VfDxYifO1nLVyAjcn8NSsF2dqgi7HZAOabaFg3iXvx7VwIWmMxfz3
        aX4I81dypsGtk03LvhrTm2U=
X-Google-Smtp-Source: ACHHUZ6Jv02LlEGCNcPy0HmfO3xCPRrdohvyHO41n2g1iUckmlF9UBgI5AF/WMluGfIiSqOD4lOFXQ==
X-Received: by 2002:a05:6a20:604:b0:110:9210:f6b8 with SMTP id 4-20020a056a20060400b001109210f6b8mr7456893pzl.35.1685630396922;
        Thu, 01 Jun 2023 07:39:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7900f000000b0064d6b6aac5dsm5143732pfo.73.2023.06.01.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:39:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e7f9cbd1-f19d-2f08-8876-45163910ad93@roeck-us.net>
Date:   Thu, 1 Jun 2023 07:39:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 00/42] 6.1.32-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601131939.051934720@linuxfoundation.org>
 <CA+G9fYuHjNhe-5TboAbrOeZrL3xL-CYYSaEnL=8onebLUqDt8g@mail.gmail.com>
 <2023060101-coconut-smugness-4c7a@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023060101-coconut-smugness-4c7a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 07:26, Greg Kroah-Hartman wrote:
> On Thu, Jun 01, 2023 at 07:41:08PM +0530, Naresh Kamboju wrote:
>> On Thu, 1 Jun 2023 at 18:57, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is the start of the stable review cycle for the 6.1.32 release.
>>> There are 42 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.32-rc1.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> Following build errors noticed on 6.1 and 5.15.
>>
>> drivers/dma/at_xdmac.c: In function 'atmel_xdmac_resume':
>> drivers/dma/at_xdmac.c:2049:9: error: implicit declaration of function
>> 'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
>>   2049 |         pm_runtime_get_noresume(atxdmac->dev);
>>        |         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/at_xdmac.c:2049:40: error: 'struct at_xdmac' has no member
>> named 'dev'
>>   2049 |         pm_runtime_get_noresume(atxdmac->dev);
>>        |                                        ^~
>> cc1: some warnings being treated as errors
>>
>> reported link:
>> https://lore.kernel.org/stable/CA+G9fYswtPyrYJbwcGFhc5o7mkRmWZEWCCeSjmR64M+N-odQhQ@mail.gmail.com/
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Ah, the .h file was added by 650b0e990cbd ("dmaengine: at_xdmac: add
> runtime pm support"), which isn't needed here.  I'll go add it by hand

Really ? Some of the dma patches seem to fix runtime pm support, and
"dmaengine: at_xdmac: disable/enable clock directly on suspend/resume"
is even tagged with

Fixes: 650b0e990cbd ("dmaengine: at_xdmac: add runtime pm support")

Why do we need to fix code which isn't present in 6.1.y ?

Guenter

> and push out some -rc2 releases for this and 5.15.y, thanks!
> 
> greg k-h

