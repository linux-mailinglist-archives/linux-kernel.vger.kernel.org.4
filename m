Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31C6A13D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBWXc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBWXc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:32:26 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BB58B48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:32:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o8so3709016ilt.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+G2MTwAb5c58IsGIh6nnFDVKJAUHbH8B79n2LboROs=;
        b=AAJ1dD8S3VP0jBzZV6iOx1rkPvP+p4HFWCv3Bnm5HuunxwlhFTA5AlPOAyju/NQySC
         jXUR6YlNj2i5TGKuDkYpqRnKo9fHR3TIic1jNudpjJS0/vloxG9O5QH+3DJf2DE4Bl5e
         mq/5xGpEp675jDW5hf/hHrjtIQI31gqVloal0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+G2MTwAb5c58IsGIh6nnFDVKJAUHbH8B79n2LboROs=;
        b=XeIsUG+CDy0euszpFv4UUPwtqTQtg2XxcSUSP1SdqhjrHzdzxe9uAnTBmB0ZcDxold
         lxzeDHrFH/8u8I1qRINmK8Qt4sdixe9IcCzblJpTQaiB8g49Z39NtOgkNkpYpPRlrtnu
         Eddj8sB3COPd+IlUF6XP/GIPIjvEoCQxgX9GqJ5Y1zKGBfV3Sgbdjfh0VgUdozKNgDuF
         PyMWvRozMSQcD1+uI24FPsRjEAcKrnRSTtkT1QnZPf+G+3Fq6O7mvceQv9DkQPQEBRYO
         DjSgZoqCA5Liby/65OLKUa5sa7ZJHtoGt3KiPXwp5n7o8sAFQaV0mCkK2x4j92sBYh7v
         5Gzg==
X-Gm-Message-State: AO0yUKU1W6IpT46FhlZHw0QdlfTFbGQhCzisptjeNDvjP9HI3HfCW2OV
        HqwpFTOnJoxqeA7Z2WmeBfIBMw==
X-Google-Smtp-Source: AK7set/yx0QA26JOwJPCRq2sSPXrVUEmIqbLL3ZCyuaJfwyvd0stgO6BHyYRqcK7MmqBN5aw0TJCAA==
X-Received: by 2002:a05:6e02:174f:b0:315:e673:e7d6 with SMTP id y15-20020a056e02174f00b00315e673e7d6mr9554380ill.0.1677195144552;
        Thu, 23 Feb 2023 15:32:24 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k9-20020a02c649000000b003e43da36e1fsm1719151jan.12.2023.02.23.15.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 15:32:23 -0800 (PST)
Message-ID: <e37ed568-cfa5-9928-9b3c-91125801d00a@linuxfoundation.org>
Date:   Thu, 23 Feb 2023 16:32:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 00/47] 6.1.14-rc2 review
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
References: <20230223141545.280864003@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230223141545.280864003@linuxfoundation.org>
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

On 2/23/23 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.14 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.14-rc2.gz
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
