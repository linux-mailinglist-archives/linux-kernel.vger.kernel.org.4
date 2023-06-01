Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97371EFC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjFAQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjFAQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:54:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC4194;
        Thu,  1 Jun 2023 09:54:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b04782fe07so5625985ad.3;
        Thu, 01 Jun 2023 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685638440; x=1688230440;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NrtU5RuYBeuBi2r2ar6tM9mhHcon49dtHwYky6B6JIU=;
        b=clOYmIJ3HQKANIN9/t2d/mYEqaT268+J8yLmiK4mVGAzAw0qNYC6Bl8ARLobf9ruoo
         1mUDr/40MYug/7AJz+SdzToLazSvrehF8Q9i45818fr0fo97tj+qkbroNAHVtKfW1UrK
         HZ50rGJxToJa4KM3iaXlyjdPqYCcmnjhYzr17mYdEamw+Kfyy8dCSQ7xKlq8Wx0x9YVU
         CguTnPSyWoElDsJx1wsXm+1h1PhNO5ggyfT8//NF3LvL22uFXq5t/jNOlJ/PfowiPV6/
         PCdqCHQl/rIiwjYIOXU43AenRwWKAL0ODPHLUGYLCvtJ2HKGVb+xrU+8W47/kxmAqpIU
         kvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638440; x=1688230440;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrtU5RuYBeuBi2r2ar6tM9mhHcon49dtHwYky6B6JIU=;
        b=iIjmGbxp8eW4U1hiKPT//VQxU/8+MjruB9RrRQssrKOynqbnrsJCHQqLe+a1o5tg4d
         BZm/kE+IzTshRjPZz/Lxk2rhJ7rib9WqIfhaeFvhArcuxk556S1u0XEHIu9m97MjlyIb
         19o07rfbroLAq2hqxabdI8EMDYr5v223c6RWNLwkwLFjGn19XiKqdf/mSRg1rt5qbUVE
         4YyFThueL3VrhNGrDdkAnKw19obAIVtkRWP8UVd8sy1dX+/C2l0AYwSwO75jh59epkaU
         /93IB+b68ijVd7IgvyZsdq+VjLoA84DpqwUhKT7S4J+oKL/wuIYzVaMoqZHSW3RfHY/A
         whkA==
X-Gm-Message-State: AC+VfDwdPaCxfZQpwjVXq8IL2OoMRXPMFxHawYN3yKg9PtXlBQHbGMWR
        On1WeVARnlIAV+dB9o9nALs=
X-Google-Smtp-Source: ACHHUZ6m/1qrRK/zsv9YPJV86YK+Z5z95pxtrYyl6asUoeYoyHvmqH8fKisn2sC4XM80ysZXgBsorg==
X-Received: by 2002:a17:903:442:b0:1ad:f7d9:1ae2 with SMTP id iw2-20020a170903044200b001adf7d91ae2mr6313209plb.55.1685638440333;
        Thu, 01 Jun 2023 09:54:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 2-20020a170902c20200b001b06deeb319sm3664116pll.300.2023.06.01.09.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:53:59 -0700 (PDT)
Message-ID: <cb644201-0fc5-063d-9a23-e5d81da7542f@gmail.com>
Date:   Thu, 1 Jun 2023 09:53:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601143331.405588582@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2023 7:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

