Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC663E6D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLABBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLABBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:01:03 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6C54451
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:01:02 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i80so158375ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MbZk1EQS0naue0fy+q0SetrpsCu4ne1vofyUElP1nc=;
        b=Le9a0reLSGyQYXoEEGzKeu7YFE1RZ5o++3+ModHR60uAjs6YxBvFCVyfYL0uCDZVPQ
         m6zy4uP8anEBVymi6E+cDoPoBrObof3LUTnUlV3GS2rdCBZ5fz75N5L0XovVY9l97axA
         0Yi7BvVl3xdf8qklCe39n0yIYzWrFPb87BeGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MbZk1EQS0naue0fy+q0SetrpsCu4ne1vofyUElP1nc=;
        b=mw3hSDya+bmDm84TRlNXt7bFtGWQ6GNBLlN3xW4DoNY7iFfyz+0unEDE0Uol+9mdId
         IZoeF/RKd33Iu159gvdNRi2s7lv3T8HLtu2pSYB979BBiTyI9Eq+G1brlRr3DVgJyr4L
         ssLUKO8Tcs3G+YO1QX6A/mOtypDw1ScvkxPXHkbQmho9wb71vcjNzoXjZRObLUhuJLXG
         J6YgxNyyUsI0OG5KCxZ9zTmgUSWaQu9SAlnFLZotGAKo87o0AmL7rWJZPrcUWkh/wWbf
         jm0mnM1Emml9GDA1zGjORbQoumVUfi73AKbuBJMjSbXPdgIPerLQ66EOk9uWYDpeA93S
         RRSA==
X-Gm-Message-State: ANoB5pm07YDNobuOgrQOL44nIEgMPCoFvi4a8CfhVUbswGRDt5qVR+Zf
        GhEG1V8CgmlZNVLP/alyMET2SA==
X-Google-Smtp-Source: AA0mqf4SIEwf8xMYbdxYnpQ+UqUcf0Qsg+SjEPv++PDc6zckNWQOHGWCubhPP3YC+WuM8bEXSE4DFg==
X-Received: by 2002:a05:6602:3793:b0:6dd:cb01:28e1 with SMTP id be19-20020a056602379300b006ddcb0128e1mr19989191iob.143.1669856462182;
        Wed, 30 Nov 2022 17:01:02 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o5-20020a92dac5000000b00302f57dfc57sm1035374ilq.30.2022.11.30.17.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 17:01:01 -0800 (PST)
Message-ID: <161805b7-cf01-cf1d-f8e1-51c1d6a85f6b@linuxfoundation.org>
Date:   Wed, 30 Nov 2022 18:01:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.10 000/162] 5.10.157-rc1 review
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
References: <20221130180528.466039523@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221130180528.466039523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 11:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.157 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.157-rc1.gz
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
