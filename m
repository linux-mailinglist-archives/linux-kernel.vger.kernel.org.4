Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C271A37E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjFAP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjFAP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:58:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF91E4;
        Thu,  1 Jun 2023 08:58:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b0218c979cso5715095ad.3;
        Thu, 01 Jun 2023 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685635117; x=1688227117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tdo1BT7zY5jhyUPqroUtUjnXkFXuc+CaZiA5H8uHP1k=;
        b=W6AMR2wuXVBEF216FQyc9671QMNLxsrZsTY226oQf/776+kGNZoLb8A0hLHNHh3e9r
         QG4m9eCwH3SgtU+75i8LiiZTAsbRChN6hnMdTi5l91dl93mfSqjS6kkAxxn4iPN5lScA
         LdiYRt+gVDNIvmICvNEGL8lLD28zW+JkteVL/0OBDgeURBy1DyHc54c7TvIdxfvwtj+z
         2q9ouj1ExOD139OWgCecEMJ7Z02mRUMPXoa+eS7bhctpvYbAok7BHNTs2WmyLwb8G1/r
         n8SoQXGGu+5WxjPWHScusd6tMGyMD/XV8fFO4qzwBUrMVheh+qbSf/n4pVonROlrez22
         NT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635117; x=1688227117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdo1BT7zY5jhyUPqroUtUjnXkFXuc+CaZiA5H8uHP1k=;
        b=exC4L++3J7qi6eA53rUMsl6DInAnGAa34zzWSh2ClVSBKr1lZL+8tjnLH7Oxt8salJ
         UB/kxn6UOuGXSoJJO0nFnymRhnOqYKpQ99Tjmewxcyxim+lMYY9+4ZYiADjJyoko2Pv5
         5HJw7+rRL3xJsUmUIVa+h+3EAc+KL3mzaz6+B5z//3K4t/lU255aq9wSLbxY6O1TluzH
         80bzYImrvcJc3Dd2GArNJ8WoPfOgitOYzafFXHM/rNm7o0sVJFVEs1fdtXPEffZdNxog
         SXwRfSykuxl842LyO1Aqc1836ua0DTv49mbhl4IDThzGiA2ZIryWU2TcDZT4ryj6WVjs
         y1HQ==
X-Gm-Message-State: AC+VfDwEI0T1HxVpiYJ0k+0wbVgEV5f9IaAHY7eTZ0XjEGO36r314uzL
        XSNq/e0gltVq/3Zp54RQtw0=
X-Google-Smtp-Source: ACHHUZ7o1nsP0aRLIFzpNb6EDRUCEYYUOY9hg2FCBv7jz3JfpIdh+lwJy9xTpEbcaZktUxLUvEI/HA==
X-Received: by 2002:a17:902:988d:b0:1a6:45e5:a26a with SMTP id s13-20020a170902988d00b001a645e5a26amr5354940plp.27.1685635116641;
        Thu, 01 Jun 2023 08:58:36 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id ik8-20020a170902ab0800b001a194df5a58sm3712243plb.167.2023.06.01.08.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:58:35 -0700 (PDT)
Message-ID: <09f64b6e-ddbe-61d4-b229-95a31b2acb50@gmail.com>
Date:   Thu, 1 Jun 2023 08:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.4 00/16] 5.4.245-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601131931.947241286@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
