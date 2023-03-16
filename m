Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CF6BC1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjCPACE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjCPACA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:02:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10E925B81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:01:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m22so75885ioy.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678924913; x=1681516913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dakV7OvXKZeanAvpbbYmcrxTn/kj7HJQ+TrMFJcLTAo=;
        b=EMpk7PFeUuQgaKqFTJz1ZEWW8aqgEuX14pjy1NyeN7N2H5fU0AfAEEe+RWXvKRoBrv
         1draL4jbeUAiwR4deHZl6sOe1QNxqc5OmcnkM2kRdiKidU6DbiRVxQrE4oP659hLEkUR
         1uiooJWvUV6pxFd8N0p8sMHQiYts0ICxxo5oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924913; x=1681516913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dakV7OvXKZeanAvpbbYmcrxTn/kj7HJQ+TrMFJcLTAo=;
        b=eq9FLnxPqPJ3NxsMtOSEE+q8k55tpBST1V/lRCkdf4Qqt5pjp5kra9FxC+UH+GfgEy
         TE3Tal7oDz4oIHJ9/Oxpq4hXTBC/IXL7QGemvJkBDofPGT7bezDUEBjRG+/hRVo7fFUr
         8RXJXaQH3zQvI1cf8vVqd1Mqd6eOsr7boRBcweWBlKPaA6WSBaeqxgG6ykCKST2NpeKn
         AZZe69g8BcK2RyjhIrRN1XPp8STFMffik+vAYro11dCi0uhjJ+ZJmlZR+rqsoKUju29g
         8v74QUUvnOKjCowJ5RsDARjaDTQo0QMmyA4kNGD1hZJ48bFc1Nx3rJA9OwoR3ePXrTtv
         lp+w==
X-Gm-Message-State: AO0yUKVyH3PePAs9/4m+AUQadAFeX996VYSnAC86bf8/gT7wvW3Rsvzx
        ZwpwiQcdyiGyTyjVAzT/h0tZZg==
X-Google-Smtp-Source: AK7set+89kt1gXLpBnZ7BzlENiScErzcQtGQv/MbT407oj7oBcEUkqJgz9N2JPNoZ/O1CfyAK0Utgw==
X-Received: by 2002:a5e:a70d:0:b0:752:dcbc:9f12 with SMTP id b13-20020a5ea70d000000b00752dcbc9f12mr697211iod.2.1678924913279;
        Wed, 15 Mar 2023 17:01:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h21-20020a056638063500b003fdb5b32bd0sm2077924jar.101.2023.03.15.17.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:01:53 -0700 (PDT)
Message-ID: <4a547162-7fa1-fda1-5867-1f5a2a2a9597@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 18:01:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.4 00/68] 5.4.237-rc1 review
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
References: <20230315115726.103942885@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230315115726.103942885@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.237 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.237-rc1.gz
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

