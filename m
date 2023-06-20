Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D37375FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFTUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFTUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:20:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A8CC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:20:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-760dff4b701so68517039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687292421; x=1689884421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAU0bCQDfaWeQQcZMARHMr/mQ05K05NW42OZYQoDD9I=;
        b=NmtnABWAabO8gsDl2yLzFJTJkqCqcpLEXRaRCjfnQdF25iwNWkicyBt1KrmG7AcZbD
         YRhZx8fhVqQovtYz7hdLW0amX7knX7flOf19kghho3QxRdV2uaVAo4YeNVsoPv+YZHM2
         xbR/JrKYxrBpxi7eI6DRr/pTQKzx7XxY72Qtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292421; x=1689884421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAU0bCQDfaWeQQcZMARHMr/mQ05K05NW42OZYQoDD9I=;
        b=gs27wO5REG9nPp5L0Q7s0d0E11sRHv8AFbAG+Jzzp9CHIKx0y/5hHPUUso+MJIxcCZ
         NAr1/MF9kXou5qXRk9raGmUdBKlBZz19UWz6kVYSUdXOX18HUydLJ/hY88tULPYfm4KV
         UP53MhJLf561qC55hCGdWRYyrkiSGYS0FhV24EwwfTyuYNKZ1hYeYHY6y31PTjvtEvzd
         L3QCHX67oslB9Yhfu7b/o9mV64knY2I79nPl3f1j/xDVOJtU+nA3pwzJyu/m9Y8th+hh
         YjddPewLmiblBaenwAlXnC7IkbKtu8BzPf22yw3/ggfvrC+hd8N6yTFnPwFT333AD+hE
         3BqA==
X-Gm-Message-State: AC+VfDzY0BEfEjKD7uJNND2Vnw/SJVQWlrX3Zsd1TtN+qvRjFvLK8xU6
        GgHaKLf2Pfe+ow7UCnbtcNlfRA==
X-Google-Smtp-Source: ACHHUZ5qLF5YGtIgsIFZ5nLQufIMRoj7oggdbC461d/Lt7J56XQo2v5v7dhI2WolDYlcP83BlamFUA==
X-Received: by 2002:a05:6e02:13e2:b0:341:c98a:529 with SMTP id w2-20020a056e0213e200b00341c98a0529mr10102365ilj.0.1687292421399;
        Tue, 20 Jun 2023 13:20:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y7-20020a92c747000000b003383276d260sm795767ilp.40.2023.06.20.13.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 13:20:21 -0700 (PDT)
Message-ID: <249cf242-ca56-77a3-a775-172951f1d0bb@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 14:20:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
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
References: <20230619102154.568541872@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
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

On 6/19/23 04:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.35-rc1.gz
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
