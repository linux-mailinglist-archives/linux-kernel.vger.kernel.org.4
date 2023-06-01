Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25571F3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjFAU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFAU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE768E;
        Thu,  1 Jun 2023 13:28:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f8008cb772so10616171cf.3;
        Thu, 01 Jun 2023 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685651280; x=1688243280;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1RjFi/W1f7sgl3paboD1lV9ocRDdeU8mWNevIj8PnI=;
        b=deIrJkmBVMrCX40M5BJOR8iYCSxiDkZCKsrjkZAKVj0r8UQdByGpzDeM/bV5KhJwc5
         G2rJBNBXvoHfKiDq/vJ4mBaLAbWgApmJlv4PMIiPIyLMDXn0wDTN397aCNEU4uaIMVb5
         OehkcgwugDIc2WKH4nkTw1JAStW52LI2iyfiYZ6LQfkNVhlJ4BK95jG8jAq7IbZvMWMO
         gby7vu47BDCyThVfV/z7qMQ2w+JhUIjCRUIB7P9viu7vZ6DiMDt36PQ3EnmypY6ipFtT
         24Kdh7NWFwb9uitqYhcKaETGC//PPHKwBmy3HPidL0YFbqh/MrARoaii2DBFb2LlDPCh
         kc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685651280; x=1688243280;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1RjFi/W1f7sgl3paboD1lV9ocRDdeU8mWNevIj8PnI=;
        b=d4S7byL5ga9yaUgIfuQFUC234Tj1ZW9rAyRx1N2W3L0vVOgUy8PG+DGJoC4FEMI4O2
         n3JbEgMFM4axMZ42nBvnfH0nI72GoDEc50B4f2htacCzO65D9aYDq0iHcbtvvaoSAb/j
         bS+oSUr4Gxn50GxtWAoTfuCGX1QeZ0nkq+weRf8vnpflJ+gyysM+jE1+GYc6rHqodDhb
         VIEcl2WxE1p0ljpZ9OxHfQ6iqNs1abigCTIVV3C63eFJyHHIeAoqDc6Mw2No7EW7MT2H
         iEehmwt5ElLvp5TNHF7SF+Lvy7e0s0dIYP2s52xf7Rdi3VRr3+ZUjqahdOIut6ZEAFG3
         YUgg==
X-Gm-Message-State: AC+VfDx5XjkwDtOxpAzX4S/aqmxsuqy0C5O6J848SiUVxCNVWNc3aFWv
        979g6DOoADh8p7UD4eFoiVk=
X-Google-Smtp-Source: ACHHUZ5/cvGVkwLNFFlRJq3DKluDvjqrm8soF6cmznHhcr5TQ1rvyJj5G879SQbZZ7w/u1z+fbL2Iw==
X-Received: by 2002:a05:622a:188e:b0:3f6:aff0:6df2 with SMTP id v14-20020a05622a188e00b003f6aff06df2mr13578861qtc.31.1685651279861;
        Thu, 01 Jun 2023 13:27:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l9-20020ad44249000000b00623819de804sm7918165qvq.127.2023.06.01.13.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:27:59 -0700 (PDT)
Message-ID: <4a25a67b-ed2e-02fc-5f01-ddda7234c9f7@gmail.com>
Date:   Thu, 1 Jun 2023 13:27:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601131938.702671708@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
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



On 6/1/2023 6:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.6-rc1.gz
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

