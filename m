Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0836F2565
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjD2ROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2ROe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:14:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1711991;
        Sat, 29 Apr 2023 10:14:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so963469a12.1;
        Sat, 29 Apr 2023 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682788473; x=1685380473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=has88WGRnfc3o0+f60isvuPYmLEVsUerTy3zu8Pzwho=;
        b=EWusZYCbFV2qABjpF9fGwR6nUhkKJwaXEMN45SJ3x8WPABPKVDKZBoWN8CnQTlpk0C
         PKgCq4n/YgPqmXpnuuBXPDUt06SIKuBiOUEhuuZ4QrOPtAXh/Mx2Y0Tm7vk/rYqzI7lz
         QrkFjxC8f8KbHw4I63rKuzQOUCtz4ngtvltpVpGA0VKnuXDmLrAStKDOeCVkWMNiOUiJ
         JsxdPqe9hWuhBnuTjhhOnDeh5k3IfYnsHdqzOyxTs1iCff8i2SdSSgF1SXg6pvAW04ei
         G3SK8nR2x095/7fsj6fu0ms+c4vZEjgocCIoaRTq6fycQYnMKBhSw5n7UlUQ0xMWSlSm
         /7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682788473; x=1685380473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=has88WGRnfc3o0+f60isvuPYmLEVsUerTy3zu8Pzwho=;
        b=T8FWkLbbzeNQ0J1GDUJ5ZRP8cqu7qfyGjIMX5wkBH3O/LlE0cGSvOR1g+RL/D4MXjQ
         0QRKL3s0LDA4d5k7Xu0fBoPO6i2wN/o8O62iWRUnMM7qGh4NbAG3lLnRHcaga3GqDeAP
         OoYLy/ZkPqo9F2VVutBc16wsV4tdXsmUbyAe4r3KXCmBC555M93ZPHZKZLQ9d+ZZWLPw
         N5q7l80GyRG+h3ZfRpkEAGBFKxJgaD60Be8Rm8t6A8i67vR/iTss54cVwTNgr0Fmc8q+
         mF5sRmQ5mXbYaZT5+fTX+paK4OfE/qOEkBLQ8SRr/z5tu9H04adSdkMmYvNYGML/M3c7
         ARnw==
X-Gm-Message-State: AC+VfDyWBYMrlnMGae8jjijQRawO9C57wurd9lWeTB1kq986QbYWk6dG
        fJrLc7YuwOfUF8QIlTWAr0M=
X-Google-Smtp-Source: ACHHUZ4cpovANW6NGSQ4jBVaGEP80A3EOktzp9rOq1Q0WFsIqaaVJ/+/ZPx1/s/n1pnJoJE+ctuopw==
X-Received: by 2002:a05:6a21:6d87:b0:ed:1d7a:3339 with SMTP id wl7-20020a056a216d8700b000ed1d7a3339mr76045pzb.57.1682788472940;
        Sat, 29 Apr 2023 10:14:32 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:1c98:2538:93cd:aefb? ([2600:8802:b00:4a48:1c98:2538:93cd:aefb])
        by smtp.gmail.com with ESMTPSA id i5-20020a6561a5000000b0050bd9c8c53dsm13293006pgv.23.2023.04.29.10.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 10:14:32 -0700 (PDT)
Message-ID: <ce72b375-7e33-de77-eb2c-47200bc1936c@gmail.com>
Date:   Sat, 29 Apr 2023 10:14:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230428112040.063291126@linuxfoundation.org>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2023 4:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
