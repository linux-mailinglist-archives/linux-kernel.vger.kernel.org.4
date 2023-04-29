Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554D6F2567
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjD2RPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2RO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:14:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762681BFD;
        Sat, 29 Apr 2023 10:14:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63f273b219eso801998b3a.1;
        Sat, 29 Apr 2023 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682788498; x=1685380498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1ACuy/osQdCjo/PWg2MRsM2W3CTWTDNQjv55mAPc0g=;
        b=FJvRi4nCQ7TyhpaQDMnrGMSJEze+SpsPv3qSPMGiXK40WBKKbacnkQErP1I3JpGqnA
         TYFmG4mUT34g8+ygzmSjS0BIED2isLzz+rNQOeldkxPAZhJBACWpysNAQiaSfrgOWyd5
         qXcLBtmBcSGbm36C732DDV7Gi2pg6jyQIZONy99YKglr1UidvN2paQ+TbLKj00+MIS2u
         EFv5yR1Y7v35uJc+MYAiXAD/DPncNYn9AHD4if1WjuDo+K1e9vHi8tNBNN0zgXuwlTCn
         b6Nnd9yhjXvVyGbbrjzCu6EO3OGnS7pgqKMgYqTetJOlr3w57UWa93QsR2E/NhNDrH+/
         al8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682788498; x=1685380498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1ACuy/osQdCjo/PWg2MRsM2W3CTWTDNQjv55mAPc0g=;
        b=Fd9mDWqWI9jFBnTb79z5F9ZiY2R+7EOc19p9BX7M+SRNTsFbbrmNXXzHoQDYWLGH1a
         mtaL9rr83NHLSdoDdztWyAhcCy+duIo2ihe+6LImTFIO+7z51+NgjNuTr1KrWibultFs
         P6ZJ4CGy6N7Jbyl/3AXiulhT8xHetrVZHvZAyVMDkz+kw64azFmsL64G4E/KQblpAiDH
         HXxmNy6hmqPT1lUNsYTD/BP1EGJIm70hXWrz6cywygxRuIUKP2MQxgCa/a8QCHvc8MwM
         tr+wAZaI1n3Iy6P+p/xxQyjhytdA1/rmkcdykgwDz1OqZ2SnvyJ6GsLwSkh0KWFuSlsm
         1BMw==
X-Gm-Message-State: AC+VfDwOS+qBVROnKemnFpk4rA0mZ28KEN1hRmG8yu+mML7ERoLu9vb7
        djhInfHSDGJGhvuP9OU5Hio=
X-Google-Smtp-Source: ACHHUZ5/zMXaqvvU2ATe1Cd0nE38gDYHd34xkMfhwXouXnro4NcP/N5HAywZopxkIQ05jz+jswqTPA==
X-Received: by 2002:a05:6a00:2344:b0:63d:311a:a16b with SMTP id j4-20020a056a00234400b0063d311aa16bmr11895723pfj.23.1682788497815;
        Sat, 29 Apr 2023 10:14:57 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:1c98:2538:93cd:aefb? ([2600:8802:b00:4a48:1c98:2538:93cd:aefb])
        by smtp.gmail.com with ESMTPSA id i12-20020a62870c000000b0063b7f3250e9sm17072699pfe.7.2023.04.29.10.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 10:14:57 -0700 (PDT)
Message-ID: <4f7efcd3-df6a-1140-e60a-736c56966059@gmail.com>
Date:   Sat, 29 Apr 2023 10:14:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230428112039.886496777@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
