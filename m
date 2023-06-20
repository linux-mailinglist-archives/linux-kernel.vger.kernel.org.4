Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E356737660
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjFTVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjFTVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:04:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810C10F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:04:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77de8cc1370so57942939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687295054; x=1689887054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjrlNog9VUmWQ4CeTJ0zT3GopxHeGj3HfK3FziRfHlY=;
        b=AiSFNVi74b4/QYZ++fP27D6qMecoPP9WELi3ff1Q2o9+DCQogAAyxG66lKIKFcVHKs
         nytMo+5R1dIiwtoPClgLLft/vhlnEFVC4um3B4FMQchpQqhbeggkLpX6rBaLWQCJrMHI
         nNu2vQK93jk03Y+mVFkt2YWFGAhW9i7nXFp6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295054; x=1689887054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjrlNog9VUmWQ4CeTJ0zT3GopxHeGj3HfK3FziRfHlY=;
        b=EuHtANM7W8grSSQUkIYLVETo8aMHqxjOqFMyk/k55TcidQFNSXFzkznxpdXU7kgjLf
         ZR7uF6V+6wbt3bQAwf2TAa87MJZrlz4UDx6orXliy/PqU+r3Ho3YErFPGmOTbzKeHu2c
         VnH2/RxNaDYoISNs4M46SWHwLu+/LN7Nx0JjfR+6RCZER/0qahE2p5myWoeZPceaXytU
         rL2joyS0dUDQaHQHjwKPTaCprFT/1oKSYuZqwwU/tfWmWZ9MT6EiyxbK+v0X9x7Z3pIZ
         WK+FZMWrX8LHiyDfrssipTSknQoAtsQQPNB1NmNBFtJ6Lq4vef5+7aQiGjFYbEbJRl4W
         5sNg==
X-Gm-Message-State: AC+VfDwzui32rA8AYggNPMGGEQcy1QbNX57DydOcbBnc7Y7jf14Xau2k
        2gb/ora37Us8LkHDTRhzMCAY0g==
X-Google-Smtp-Source: ACHHUZ67pM/+HD6HxI1DKWKKG34tNljc5QMIctdDs8pRmiKA5LIWM3veIBSPKOLJ+4RyySUz/FkMKw==
X-Received: by 2002:a92:7c05:0:b0:340:ae63:38a4 with SMTP id x5-20020a927c05000000b00340ae6338a4mr11589087ilc.2.1687295053815;
        Tue, 20 Jun 2023 14:04:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c5-20020a92d3c5000000b0034202d05fadsm831865ilh.72.2023.06.20.14.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:04:13 -0700 (PDT)
Message-ID: <f7bf3aa8-f1b8-a1b5-8e51-46d51d002633@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 15:04:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and boots, but doesn't get to login prompt. Keeps running
into NMIs and watchdog detects had lockups.

I am starting bisect and will keep you updated.

thanks,
-- Shuah

