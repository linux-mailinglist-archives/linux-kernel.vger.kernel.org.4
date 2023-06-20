Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C1737666
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjFTVF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFTVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:05:24 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF210F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:05:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77e3c55843cso38278139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687295123; x=1689887123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaunI/80Lr5c/6cpZUQwWrbl0e18AfNucYFl8k8adXY=;
        b=eVLBt7sa2AqscCYtkHCn0ejkmn/J6wMN0J2fpY0kG9GMqES8FtI6tznQC5efCWKGqF
         eHot6FQ23ohxqfwW9RqQuUK9587cEOO8FY27zwsNYI1n+wTASbwXMiRrgzWabtiK3O++
         oICFkAIJbd80/44v6/wpZcwHSB0moJ1KytsXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295123; x=1689887123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaunI/80Lr5c/6cpZUQwWrbl0e18AfNucYFl8k8adXY=;
        b=OL6PlXtGh7hnIl482MauRjsd06wcs1bkZhjxzoezSPsOosWiGaNA+8FwIRK+ng9gjq
         9Zr80B/Fy0fRqyK9e5yAwLH5C5u0/OOuH8rfcGnu+guQSBLzwAFiCp6HYhZZewZ4edUE
         SJP7hHv+xEtoeHzYOvqjizc62SwP65nXF4xDvuBgHnSQdOCaLN47JR8gznzX2boAHRPA
         Yxwxu2is5pvua49WhKjgI/v4JX83/YtlzIWC8ArYqu9dW46QrakzxCVERCNvfs14lFef
         xgR9b3xkLt9zsy5I211r81BMKMaFsv7buBMQCNG9gEVncKHNgU4b2gE5UWCXh0ziziAc
         NRBQ==
X-Gm-Message-State: AC+VfDxjecAjNXFHwHhMlAWFVGWRy8BurHgwxZhn6s+3x2/2PuTT4x07
        /sP8UC9oGWneVRVKQu/ZXmzeIA==
X-Google-Smtp-Source: ACHHUZ4hcR63xRl9TDyH8gZxquZL08MuLMnqHhuiP7v1HGTXAVw6AScWkzPvl3nUGCeg4ux72atd1A==
X-Received: by 2002:a05:6602:3998:b0:780:a83a:7684 with SMTP id bw24-20020a056602399800b00780a83a7684mr2495810iob.2.1687295123060;
        Tue, 20 Jun 2023 14:05:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a12-20020a056638018c00b0041f4bd6f285sm874213jaq.37.2023.06.20.14.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:05:22 -0700 (PDT)
Message-ID: <911a8d41-b52f-2471-8878-d6e5a4712bcc@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 15:05:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4.19 00/49] 4.19.287-rc1 review
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
References: <20230619102129.856988902@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 04:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.287-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
