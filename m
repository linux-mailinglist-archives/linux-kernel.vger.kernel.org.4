Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDE6E6E22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjDRV0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:26:44 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E139779
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:26:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7606d7ca422so20050939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681853202; x=1684445202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aYlPNSrwMSPih/Iug9fotKivvMNK1l/gBB6zZEMqg4=;
        b=Au3zxZZMxkQk6R2qMv5e7MPRGJ47vJZO6YOb782cgLRSFq+BNkL+MoybuAfq1oXcDW
         zJE4BD33vPL24PipOOhLxaxKrO8RId3XgIJ4cYV+W5d4WNjekbJmBMdkC9ciWLm0Gdk4
         rKuYnI06M5kEfCJCCXcLZu2kmEDNj5XmPWKUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853202; x=1684445202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aYlPNSrwMSPih/Iug9fotKivvMNK1l/gBB6zZEMqg4=;
        b=KVVe5e8JJ2+Z6BnQ2KQZIIbXUq+d442wqe+DNrA1m3mfhVfvitZ+O6QKEhaS3colck
         9diiQgz650pxkCXmVFKr/m5UtnE6aM1o4zqri8rZEVAGYw0ycct3QV+yVwcowDQSdBLX
         HuhidGzzgTj18/3FwvoXqI2zHHi0R4rgZzBbf4Me9TmrOk2FBTtKYz/yDqwDTNIcKUGf
         i/I0vZx2FCkO5xU5SMIsxcqxfsYAwM9bf7DXm7htKno3nM+K70514HrskwcVbjob+9DW
         +C+GwDNZOEorU8KbzirwpUJ+dlFna+Yxy+CZ0tP0vqgRPv+tl4NHnVLcEMNqmBsrMU5+
         3lOw==
X-Gm-Message-State: AAQBX9fPUgVpgRboNsG8gOB+A6UF06f0B6yzFflHpRLf+EdNt5L3Ic69
        TmXIKVO4HwM99H/kDWbZdTKmpg==
X-Google-Smtp-Source: AKy350ZzaX/hCp9X1YLLSj5lTWXJAeuU0i2KxZICu/wiYEz9CT5zgQxUN0cq+h/za6i6gq+ShyOmUA==
X-Received: by 2002:a92:c5b0:0:b0:32a:d06a:356e with SMTP id r16-20020a92c5b0000000b0032ad06a356emr7351486ilt.1.1681853202546;
        Tue, 18 Apr 2023 14:26:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id az30-20020a056638419e00b0040f9ed959e3sm2551448jab.13.2023.04.18.14.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 14:26:42 -0700 (PDT)
Message-ID: <deb9c419-bf63-f1b4-1714-5ab31d3a0db6@linuxfoundation.org>
Date:   Tue, 18 Apr 2023 15:26:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 00/91] 5.15.108-rc1 review
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
References: <20230418120305.520719816@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230418120305.520719816@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.108 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

Note - I didn't see any build errors.

thanks,
-- Shuah
