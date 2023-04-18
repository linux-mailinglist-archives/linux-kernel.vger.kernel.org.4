Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096586E6E00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjDRVWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjDRVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:22:46 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCA9ECC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:22:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7606d7ca422so20026739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681852954; x=1684444954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcviQLFSJefqWXQI0Sw/y5jsQNLosOLMfA9+eAP1G5k=;
        b=Q7Y+AFM+IJbRAiluK3jPNhW0uEV87BtRxioYeEjB4pTcClisZZ+0pmFGx3CwuswAk6
         p3LZ1YzvQNF5msNQdZ4ehbMwOf5ob85a/6xFLSAD32m8Gx+vCHFm3hKUuCTiX+UDHE0m
         +LisCc/XWXxpBDrx6llIs9zIqMyOZDczq5taQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681852954; x=1684444954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcviQLFSJefqWXQI0Sw/y5jsQNLosOLMfA9+eAP1G5k=;
        b=RXp+eEPKRzsN4G1FjgKyiJ3SjrgC/Tyel5RXWDrrdecggrU4oJ/EuxfhujkP7pAGv+
         +zukI/DZcZslB5234pIktjycWQ9+jeg7dWwY/7//KpXM/aPi2mexGwR6V5V1HmPUiC6F
         dmrlXaCowwRgZ1+CDumNvHUlhjX3przlGZ4DTBqqs4iCWB0+WCNrKJR45ZlrozIrEYAC
         w/5N/a595jYsu3qlmMntJK+/kLyspbbgpRqSoVcuNaL/f1PTymhCXXHlrLnfUsKr7Lnn
         hF+STiKbQJ7wubB5hRjVFnuPf0d1t+v1Mb9tW4Cz0v3QPYVLHrc+bN4QKsMImZGaGFm2
         HfLw==
X-Gm-Message-State: AAQBX9dSPXO+L+kQ5PpPFH+J6aOatW76YpBwJiP0BbhwcZ/uMWXUR61z
        v2w2UXoCzzKN421c2gtTLb2ouw==
X-Google-Smtp-Source: AKy350aCvYFGp8Vv3l630pIlNlO5+37VseErc9/L/VQKFbLy1X6omO7RRHvHHa1RwX01iQV0M2GSgw==
X-Received: by 2002:a6b:14d5:0:b0:760:ebcb:957 with SMTP id 204-20020a6b14d5000000b00760ebcb0957mr6750240iou.2.1681852953733;
        Tue, 18 Apr 2023 14:22:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i4-20020a05663815c400b0040f91082a4fsm3040680jat.75.2023.04.18.14.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 14:22:33 -0700 (PDT)
Message-ID: <fedb0259-3e98-15ba-3af9-cc3729bf48a5@linuxfoundation.org>
Date:   Tue, 18 Apr 2023 15:22:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/134] 6.1.25-rc1 review
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
References: <20230418120313.001025904@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230418120313.001025904@linuxfoundation.org>
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

On 4/18/23 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.25 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Apr 2023 12:02:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.25-rc1.gz
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
