Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FBC5F37DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJCVeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJCVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:34:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40F17A94
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:30:10 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i9so5684081ilv.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GuvWtx0dm7LPC5ol2oLdRALGrQDEsJrdHlyh83t0IvM=;
        b=dSRQTFR71uRO8bz3HOUdASSr2GwOsA2q6Z2HVcwpPE4OQuiFrgysp3xfGDF7HN5SFb
         8pCS+GLk4B6ELMgPE2UV46Y/rWDw+GHc7eUYfTWKqVUaJG81/ATx4aSpJ/IB8qD/4eKg
         9qdkyuuME0+UNWotJ2jRdtveT+776Gg3AVudE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GuvWtx0dm7LPC5ol2oLdRALGrQDEsJrdHlyh83t0IvM=;
        b=jLzy1f2kQY8qnFt1IJW4KB8BR5Di7BaUvxgL4iQm6jp+WF76okjvq7FI0ElQT2l7Jw
         gEct69QI1yfqK8PjwRo1ubPj2wxx8KA5FUCUxzKZsFD8/F5S2ImiVCMiqVCFDg6yejfc
         ULdF3i7RNzGUM3jnwstqea0aaDxScOaofsn78rSIWDJc+ei193obOIgTGwTpy8+RkVUS
         VVIiTJeH/u6rZYVySx6gsDWOlmYB/xAW2KZtq4yjTY6pYibItXYFW7GJOj7QBsJ9LdCF
         f9Lf3SCPEmp8CKY+q9/JoEd4mlcB8Vfp4zVroADxLnX+j3l7N2uPiSVw5ZwAKmE3qqMd
         AdKw==
X-Gm-Message-State: ACrzQf24avJH/2FGPI/DEv0gVjJkkD0XsOv+36E+M2Ysh1F1ROcrI8Yt
        Wk/Pb+OxFQK73qvcsk05XmHZ5g==
X-Google-Smtp-Source: AMsMyM4SEwAg6ufglkCCwzGIKm4vHlVH5rBftWsUvVZJhxUoiXQljVbwXA3VJM+0KlugHaWg6HjWrA==
X-Received: by 2002:a92:b009:0:b0:2f9:91d4:6d47 with SMTP id x9-20020a92b009000000b002f991d46d47mr4893197ilh.158.1664832609754;
        Mon, 03 Oct 2022 14:30:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u7-20020a92d1c7000000b002f90ff8bcbbsm4209963ilg.37.2022.10.03.14.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 14:30:08 -0700 (PDT)
Message-ID: <4e95484a-2d47-b3c1-52bf-f3b9a27884e2@linuxfoundation.org>
Date:   Mon, 3 Oct 2022 15:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.15 00/83] 5.15.72-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221003070721.971297651@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221003070721.971297651@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 01:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.72 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Oct 2022 07:07:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.72-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. I am still seeing the drm related
regression and didn't get a chance to isolate. Will try to do it this week.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
