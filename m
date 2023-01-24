Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FF678D27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjAXBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjAXBOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:14:04 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29678728E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:14:04 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i17so6842005ila.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCYNt7URGQ7oBqyQbd15UA8FF1tOX4zB7NKqLZYoh5A=;
        b=E2Nhqn0AphtGOlrnMlqIO1XTLWnQ7WRtNvzoix1QfdqN9k5oRhXWRE1Cm3waPhsYyJ
         DqhhHSL7w+GSMIgoha11/5DyfGkXAyHJpcSH4VtXOJu+lnIbNygUyfdHRkqUWw3OxT1O
         8vB/N0GlGP0u8Avm3q4EfdOYEVACxKvCMQC6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCYNt7URGQ7oBqyQbd15UA8FF1tOX4zB7NKqLZYoh5A=;
        b=yxgGXaP7SkMCbm8NlxpYnx7d4c3dNhVcGLep+rSfL4ryoTJk67Gab1URyvwx2AHOpB
         iAvo0GC2FpWkDl/Jkw/iCD0EZ+8fUKyw75AnDxlx653rUSKt/Rf5VxSm5jNl6rKIhQ+Q
         NHqKArK0p4aFTWsjbWxKn+xwJriq1tX2QLojqKlvx5XwljwCBQekp7TYWS+qre0heuwF
         JCak8QvObErF2bPMIzR2UU4iHyQbHKGmD0heedVUrWcbQsdJXqfZhePrlBjD8oOF+zgs
         U2O54rQC/VNElZCBMWr5ujh14rkWQTqzjU8clRsP02aqIxn+9Eoya0fymSBmnrYXFgjz
         0+ng==
X-Gm-Message-State: AFqh2kqQJ0K4jAd42VucD794HGsAi8vfE5ofiMpoCZtoceRPG8BMBYNT
        IvvvtPY70r5hOw4n2lLLPOSsuw==
X-Google-Smtp-Source: AMrXdXtg98qKzdHR3i1QLOOQbNk98aeenCp4sK3eBWGTI5KRfYQw404brU68awG65sVmE4XWhrahyg==
X-Received: by 2002:a05:6e02:ed1:b0:30d:c502:a9de with SMTP id i17-20020a056e020ed100b0030dc502a9demr3957277ilk.2.1674522843415;
        Mon, 23 Jan 2023 17:14:03 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e32-20020a026d60000000b003a174bd44eesm236174jaf.81.2023.01.23.17.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 17:14:02 -0800 (PST)
Message-ID: <d94fe79e-e7f2-a4e1-131a-715426e5d21e@linuxfoundation.org>
Date:   Mon, 23 Jan 2023 18:14:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.4 00/51] 5.4.230-rc2 review
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
References: <20230123094907.292995722@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230123094907.292995722@linuxfoundation.org>
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

On 1/23/23 02:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.230 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.230-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
