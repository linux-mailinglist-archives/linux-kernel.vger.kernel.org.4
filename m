Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A56A13D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBWXcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:32:01 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B1D5AB4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:32:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id t129so2614837iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677195119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyIeyBryi+yhauAhwwFawA2z6cP5sXH4pUcK8IFs2AE=;
        b=bPy644GfIaOOOc10/Rs26frvMcI3dhK1RUvMhRPlw2m8VdbASF4Kibt63D3DVCP9PG
         U1pMP1jrme+ifTk2eWfkwxSHPrO/rYvXvj96PStwL3Fob+ynXmOFg4JeY780tcd+NORt
         Snl/oc/4qk8UwRIxa7b7P56EFYHiyuc7bCfA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677195119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyIeyBryi+yhauAhwwFawA2z6cP5sXH4pUcK8IFs2AE=;
        b=1Yb71AHBaN5ribR8qstUOkOhQ385J1aWM6IKjacoN6jU4mP9WodoQ4S4TGpqqiaEGk
         9V/2/ZHJYM8m8dIsgtLzdUDh4BEZVgiYvJBRyGEmcshMY+iKAprBWshKPYgCahNYDnNN
         9XUfwrfYK/GbIMpR5uTWesZic2rm4mGAcX00E16iILhZ8qbvHuaSFtjJySjcC5/Khv6A
         T9EamHjFY3QXNPzUFj87wzG6gDxecttg2mc+zwtX59B4GS+t2PtGHP7NAQmUVd+sMjxm
         KNsBPMwPzJq4PWnD/W+ZDmNVG2IBgeAc1cslYSsLueMBesxsgHKPbUBCcSIiY+TP7y48
         TRwg==
X-Gm-Message-State: AO0yUKVAHm2lbCWl9iW9q/VDNx6o/PNQvXI+maLwWbTWV9wkfktnFYDU
        6dOMUIz3gneXQxVV78zV1GnzTQ==
X-Google-Smtp-Source: AK7set/hXUVxXyif8mLIBAsHQeDvpW1mt0LvgboM2uPhHYzyJVXPgi311z0/1ab41iGINi5AYCk+Sw==
X-Received: by 2002:a6b:8d45:0:b0:746:190a:138f with SMTP id p66-20020a6b8d45000000b00746190a138fmr7395194iod.2.1677195119341;
        Thu, 23 Feb 2023 15:31:59 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 14-20020a5ea50e000000b0073fe9d412fasm3304295iog.33.2023.02.23.15.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 15:31:58 -0800 (PST)
Message-ID: <e78f73df-e62b-a33c-77c8-75d1f946f6ad@linuxfoundation.org>
Date:   Thu, 23 Feb 2023 16:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.2 00/12] 6.2.1-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230223141539.893173089@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230223141539.893173089@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.1-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
