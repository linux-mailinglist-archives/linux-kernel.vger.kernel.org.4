Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88869EB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBUXqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBUXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:46:17 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D392CFE4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:46:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i24so2609275ila.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ivk6iO2FEdJoiIGowkm1rg844yh34+pQEG2+qwMK8ms=;
        b=fmq7xTiP4WCijOT13mImOwhRC+hjxrJUHYnc/K4z+jhQOiMsTT33KN6dTZ0MmKmoSp
         Mw4J6TFYIXswfGioEFWoYSFu+dMSE+IrR7DPYMsE4KEg77os0CRHd9DsapoqWLU7rdIl
         6DBb8OfJIkzLMG4fhphrJ1kfbn6Pw314GSSxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivk6iO2FEdJoiIGowkm1rg844yh34+pQEG2+qwMK8ms=;
        b=1cYaOIPvBthyWJ1SjarkPugsl/CRxpNkMo6BX6SKiXU/EMYDxJ2zfREQXWTq5VfJDk
         za7278guwgaImlyXSFtEqhb6T65AB/MrJM6INAyq2WJO1l4L47MWJo1ibvVatiXmiPRd
         bZDDte5YBNsroO2wPhfPzVKJUfqhCtAIDj9tWI9ee2hbwoG/4pvIYx2N7ONTeYPi39Ih
         7hkLWFRwXk3CedcBBnDi87dGNAE2OxlTXYbdDrCaLjKMbZcMse0Yn9jLcc9SxZTq0xKk
         FzJCFqBlm3x1gNQAL8CTBEuDGYdK1A9Kig87vcpwvkr3UtvP1OopFDiew+8JG3cAko9S
         dd0w==
X-Gm-Message-State: AO0yUKWNJOfct16occOTayrmzUv48ZbO9TI5nUbh66wNmqPXYddl5jlF
        akZNppWsDTDscmfM8q8eFlFPYw==
X-Google-Smtp-Source: AK7set+nDLAJo96Q8kN4foJSmTlcJ8nXZR1X2MjJDNrNilr4N1kIrvbTMO3Nlc2IMR5vD3LJEZjj1A==
X-Received: by 2002:a05:6e02:1605:b0:315:2b2a:f458 with SMTP id t5-20020a056e02160500b003152b2af458mr3635171ilu.3.1677023175255;
        Tue, 21 Feb 2023 15:46:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z14-20020a02ceae000000b003c48ba8f772sm869889jaq.151.2023.02.21.15.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:46:14 -0800 (PST)
Message-ID: <a8eeee3e-6594-7adf-85cf-961f8c59c91d@linuxfoundation.org>
Date:   Tue, 21 Feb 2023 16:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 000/118] 6.1.13-rc1 review
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
References: <20230220133600.368809650@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230220133600.368809650@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 06:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.13 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.13-rc1.gz
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
