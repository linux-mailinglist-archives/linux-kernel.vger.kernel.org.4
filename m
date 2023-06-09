Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F6728C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjFIAG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFIAG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:06:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AAB2733;
        Thu,  8 Jun 2023 17:06:55 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1223096b3a.3;
        Thu, 08 Jun 2023 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686269215; x=1688861215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6hN9wMbwSLIBDVcm5SJFo8XQzYymvLuNabBXcg6nBo=;
        b=lMuAe2pfiTlWHpbbqlhaUJ80LV3jx0RHi/pmv0Tp6XhcAKCxhOXrRwe4/wGcMQ+gnI
         RycsIGbbBD2Gu6I1doizkO1fU4gOLLQc9vKRUgPxu77Gmr/Jow2aFk0VwzBVroQ0ok04
         lChqQoytYgOWPGKBdVPU2Fb8ye5GGdzHXmIKLYpCVPw/2x8H0SNz8NNnUmo+QGSO+WgC
         JFNCZMWoLM18CdWJZJiE9fAV+PvAbl0yw4DjxBtUmAULqXlaPwwRrcJMasww4ck+zwfV
         OSJikGzFaQzOb4LLZqA5yRfQ7voB9I8Zjsohu+5zYCoOn4yTvUdv5SJCi83WiGRlQAtV
         WFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686269215; x=1688861215;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6hN9wMbwSLIBDVcm5SJFo8XQzYymvLuNabBXcg6nBo=;
        b=OYFoZJJvkOIlJY1jYc/cdN5tDJ49n0yyPTvHjNp840Hl79vi807R+wHMbJzpZ9VVWd
         pdLs4PlJurxkTDWm9aFJEn98Q5eB+IqgKDqvStkv673mOyDRDS9VcZXpTbKxV04a6N9O
         0uGBj7AmjknrGSBilLJVsoL7rAZ1/cHMD1UbEiu7NdgRKi7bHZiMQgUX+3NiVHxx4tBR
         +3cAzfXjnAWnqAcJ75ecfYyMeOYhJRQ5XUvR4deMmoixR849O/YsmSCU5/6IeGrqIj/I
         l+WZmgCHCfUIZm1HGly/kur8Q8N+019c46b3EqMMdNQnKQcvRW2WKW/a0M0j9D31h+dI
         6OBQ==
X-Gm-Message-State: AC+VfDxkVNFfzB4PS3vlRsTh7MmEDGyU/csrAsdSCRxqE0r1qmbLJF2j
        BZpz11K4o+2Vt7kBG1v/bDc=
X-Google-Smtp-Source: ACHHUZ5SaA1jNX1L0MT2FtY4lXGt69R0JbYE7bx+vfgGKpSfIxkre59gAPAChXVOrqUpwqH+OBDH4A==
X-Received: by 2002:a05:6a20:3d21:b0:118:e011:5e44 with SMTP id y33-20020a056a203d2100b00118e0115e44mr3766465pzi.48.1686269215264;
        Thu, 08 Jun 2023 17:06:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79211000000b00662610cf7a8sm1606588pfo.172.2023.06.08.17.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 17:06:54 -0700 (PDT)
Message-ID: <d37368c2-1800-f4ed-427d-ef1da822fba1@gmail.com>
Date:   Thu, 8 Jun 2023 17:06:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/285] 6.3.7-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230608175722.489602717@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230608175722.489602717@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 11:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 10 Jun 2023 17:56:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

