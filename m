Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C572772D448
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFLWRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjFLWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:17:14 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C65131
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:17:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-777abee746cso44150939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686608233; x=1689200233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=turarmRsZsKnFTASVKXbLd/oQFYI2Vru5D/pwWXxLfc=;
        b=Fv4uU03lO0dwiallZIjzmXx+z138lR+3e5J6GyRz+Fvl9Ff9JsjmriHTETcky72Gbq
         BZGc8Ftx1HKLQ9B5x/5DI4tNbP6OgwmsjFg7m0I3WRXJZeXWpHPbKSxzOd9Y/le2vh3l
         po4q0roSYyIyb3ohJAe3YZhjM4HlKgtZsXoB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608233; x=1689200233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=turarmRsZsKnFTASVKXbLd/oQFYI2Vru5D/pwWXxLfc=;
        b=FjW2pPqDC1RqvMzU9eDamWMd0Z5b33/yPfmQkCrnqauACNr0sRX6PnkYKU37NyuKUA
         lvKvNT0gKx2VGinKmzHcZe4EkGczsTskO+TKLQ7POfL8gVw2cX+Y9Kit0HY6RQHqWKtP
         R065H7GPNMMM9XfQclAD8RajCAQxdPN2HSJPH0Y+jBMZm13aDxC7fbtKAts5Y7iwB93I
         hdMpEZYyLoTQtF5RUhVnx3MXXyrcOK9Fl29gLObUNQ1rP0h7zQy+DNUhQJUU198uQmTT
         QjJ4l4dMC3IUnoozwYkZjQd7dPvAoMHRgQaCd8vIpa6KmZ1fMFiN5HNNmWzg9wJJ4Gmz
         fO3w==
X-Gm-Message-State: AC+VfDx9z9PU+I/uJpRL6uVCx2rIS49KYveGENLK85fXMnZWVpmDuToM
        /anb7ANOgW6zmqZSSYa7S2nzjw==
X-Google-Smtp-Source: ACHHUZ7ICV0+J7+a5LSH67kSoE3rDJzDTt4KW/USTzZKC3F0s5HN/hqcP8mdiYd+82J4lI6xoaoPbA==
X-Received: by 2002:a05:6e02:144:b0:32b:51df:26a0 with SMTP id j4-20020a056e02014400b0032b51df26a0mr5650839ilr.2.1686608233372;
        Mon, 12 Jun 2023 15:17:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o14-20020a92d38e000000b00331a5fcd648sm3477499ilo.68.2023.06.12.15.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:17:13 -0700 (PDT)
Message-ID: <7a9f55bf-8fb8-d953-42ee-fdf49171cef6@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:17:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
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
References: <20230612101658.437327280@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 04:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.184-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

