Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2E71EEB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFAQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFAQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:22:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C74133;
        Thu,  1 Jun 2023 09:22:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2566e60cc5aso758365a91.3;
        Thu, 01 Jun 2023 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685636557; x=1688228557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFU/5Iv9owlTTt86pLJPmhqgSRLxIfPlWHSZUPcuZc4=;
        b=d+NEA05T2No89c3k15b1IHVESm59uCdSRC8Juyn95Dz+Bnd9r7QpSoj/JLeMofTquf
         0/M8aU+N7lfs37n0z+ecYD64QED2a0ezIizANK2jaAaz6RWUnTQnzfH8HGQJA5duLh2N
         kc4PAGywyZGT053Oez0OooMP3+y7uPDPFY4bAFBV41aa/2nglCzVZpjQqFiXwWgxIBmW
         oRwTcBLIcFHQ1iqhYBu9EudNL5IDVGn63BZqtv3oCp1Y84uUY7Fb0DjGO4WAORHcoN6W
         ieVhnA+cY10zWZHpvl2VXJC54+Xvl89pXS7sWKQ1E+SsXPUw0lkZ6ALm754k7xGHDZOn
         TpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685636557; x=1688228557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFU/5Iv9owlTTt86pLJPmhqgSRLxIfPlWHSZUPcuZc4=;
        b=RyHiv1PR3JvQw5bfr39+wK90e5BoWO6AwnQBCpR0G8Qxm+CdXbKm1pDrxBkV1tznKW
         XenmT7vzM5NVNJvEO/GwaFM65J9V6O86es54dhlZze5mFxNnIoZzZDfJ2ji9lBlcMmhd
         gcs4LThlrTd1aJGa5SdWaOLejCL1iZcZ010jac9z5DNKIrk7WJxoJabt6lsqKwz1LrtX
         KCVewdgebnA0iLqJy+iwoCmgLKnbCSvhEktyQKg5/NXweK4bBjQWMmQIEnibDjBKxccI
         W28Y5Y+t6Yy3ejIm+b8Jb94UwgTkg1u886SsHOBF/n4aQpv+b0Q2b+1yXJhHoLquej2J
         8mfQ==
X-Gm-Message-State: AC+VfDyxssVXb7IEp09kX8SiX76bhCgJSdpi4WZB/xuR9NRM/t242GtH
        UWl4wuY5EXy6yKtAzB+GiE/dVcbqFaqxuw==
X-Google-Smtp-Source: ACHHUZ5MxBd74DfWqf5JtmxcE4FhjBn6koOuiM99hOW3cotRFG8LyaW/sttp/jZrwO8St8jDqZMkgA==
X-Received: by 2002:a17:90a:ee8c:b0:256:959f:3443 with SMTP id i12-20020a17090aee8c00b00256959f3443mr9903062pjz.25.1685636557273;
        Thu, 01 Jun 2023 09:22:37 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id fa2-20020a17090af0c200b00256353eb8f2sm1651166pjb.5.2023.06.01.09.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:22:36 -0700 (PDT)
Message-ID: <2c22b77b-3f35-0810-ab40-595c07451973@gmail.com>
Date:   Thu, 1 Jun 2023 09:22:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.10 00/22] 5.10.182-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601131933.727832920@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230601131933.727832920@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.10.182 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.182-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
