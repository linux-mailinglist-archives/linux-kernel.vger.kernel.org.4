Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB585643B64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLFCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLFCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:40:38 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C00B7DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:40:36 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q190so3800531iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C11bscbOmfUbhUvDY9IHufEbXEW6Jlvs+hg8vJ4XBWQ=;
        b=f59DNAZDv+rfnYq/BEXcLH/B/MQhjC0omavNBDw+annfUJyQJAWvnSu3+WdD7NbAw8
         tAfq8Fi8S/PUUaEfUc3hXJ20OkZcfFsGgKwNhqHDNrj9uDU8K/Qo6oPreqvdCrtJBy1h
         9FFZfq9H2BaFX7onn5O1jYE8S6iLWzSjwHi+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C11bscbOmfUbhUvDY9IHufEbXEW6Jlvs+hg8vJ4XBWQ=;
        b=PoE/mD/2bWX0Siyff9ePfhqdNZPWUU6zY1az2RM4iH9o7ewjFzclDuwQ4ano718k98
         /cN/T4FGQThHwlntVHWcF4Uz4qlIOAD4kaH7Aa9wSr4Cy0LGp/CRI74mZK8j2QpVv3lO
         jvErAoItMGvTfBlvb/bnFH/dDyoxE0s3kSC+BVnpgvi1N9QdhSg33GRZU7wj4nijLCF2
         E4EjaBGtQDm7P4/mFmF3I1dvYRyXDW1iDrpAbUpr12+8Bgjb1VMtSTtuGysdF9Kcgkuj
         yrM49KVrgOxgMqBaDlA9HfKawhLkBHVz/GCa+iq67gc/AmEENErvB/92vwcJrO6TaJpL
         ATgw==
X-Gm-Message-State: ANoB5pktTSG5NFWPXiW1YJ9v7JTUCTwDHGmKUUIZStauizGuXSZuY4TE
        iahcHIP29wmSa8WTbbSw7QxZGA==
X-Google-Smtp-Source: AA0mqf4YJZkgLRAm/eqUjaca7IMExUKaYAKkSir++EWeQ1/+b3ePm4WZrqEU/RxxN00PMn6NhEQ+yA==
X-Received: by 2002:a05:6638:440b:b0:374:fbbe:2da6 with SMTP id bp11-20020a056638440b00b00374fbbe2da6mr19160646jab.163.1670294436002;
        Mon, 05 Dec 2022 18:40:36 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p18-20020a056638217200b00363da904602sm1549786jak.13.2022.12.05.18.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 18:40:35 -0800 (PST)
Message-ID: <91eadab1-92bb-6361-7c43-193a8e348045@linuxfoundation.org>
Date:   Mon, 5 Dec 2022 19:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.4 000/153] 5.4.226-rc1 review
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
References: <20221205190808.733996403@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221205190808.733996403@linuxfoundation.org>
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

On 12/5/22 12:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.226 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Dec 2022 19:07:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.226-rc1.gz
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
