Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9B65171A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLTAP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiLTAP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:15:26 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3F5B2B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:15:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 3so5598245iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEQPu1QRux1iIPM35x4m5jzmYu/g4JZLFKiuIXDXQ28=;
        b=F4x29rRq+hPI00FFP4bfwSof6lgiNiGxv6lkpKG7UJiWZ14qJorEfrCg8Eckz3REJ5
         5ELTaLvEIfGDrMbADoiXxtfk5NvKzq2bNdcLhWXvovRFgVir056TMfKi3YOuw/EtulH2
         23sBmdxesZE5qtwfHHlISgy0oatUazAsllNKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEQPu1QRux1iIPM35x4m5jzmYu/g4JZLFKiuIXDXQ28=;
        b=JVa9NK+zMwQCfhQyF9zRH/riUSKoQU+Vs1mGy7O/ETgn+EelWJCpJuvqzUUMrQWXDA
         LwyarBcKVQHG7y3ZLm1eq5Ao+H6TVLGFuTv7aP7AyjH3sJLQW2NfmHbafI3BY3QTD8dM
         EkEz0KxqDkjnrTkTTKcMCRLn2belKWHWokdqFv6bcvJHmTbTWi0N4bOxrXFYMSXJMEze
         wxxs2v3V/rKQrYwfUuWCrDs7FwOXawa70nCkdw/psZ/l7E+G/TkcWapBrnxV+418RMiX
         Ty2zZTKLS9Xpo1gaqCoHQNKPaIjSIrQW4g4XPQ/uTNDGy9DVFgRwD/cLFzPANSR+d0Xr
         R90Q==
X-Gm-Message-State: ANoB5plly7XOjbS60HtzileZ4lstW1rK5h+s/84DK3dcy0JFV6v6zhkT
        qIMy/qgRP469zRAMDf7p+6OwXg==
X-Google-Smtp-Source: AA0mqf50mJjUyE1Yl3qexKRIRZwHhqNBO1peEbcNowZm3x9fOm29mWcZTJmnhkRzjC3+7jEd74/7iA==
X-Received: by 2002:a5d:8b06:0:b0:6df:b991:c03e with SMTP id k6-20020a5d8b06000000b006dfb991c03emr4542417ion.1.1671495323344;
        Mon, 19 Dec 2022 16:15:23 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w16-20020a02b0d0000000b003757ab96c08sm3959429jah.67.2022.12.19.16.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 16:15:22 -0800 (PST)
Message-ID: <114ad88c-b8e1-fef2-4429-c030a40c79e4@linuxfoundation.org>
Date:   Mon, 19 Dec 2022 17:15:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.1 00/25] 6.1.1-rc1 review
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
References: <20221219182943.395169070@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221219182943.395169070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 12:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Dec 2022 18:29:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
