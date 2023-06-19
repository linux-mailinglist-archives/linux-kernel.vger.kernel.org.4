Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D7D7358DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjFSNqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFSNqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:46:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB495E54;
        Mon, 19 Jun 2023 06:46:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-66654d019d4so2997035b3a.0;
        Mon, 19 Jun 2023 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687182368; x=1689774368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIvdumOuZ+uzm//Q8KqLv/f6YpyXoaXW/Ro3RALrI/U=;
        b=i5JwtQKBWoT7sFG1Fz+c1EUCLWTvAE5jMeEASpHbMoh01TnNF9UmqC2IPXAoJP3aR8
         T9nG5bTy8MNs5pFbNnJO0d7O4Npy4u1KDkoS50uNjPKsZeI4z+GimUX8CKsCiTQGwnkH
         +n+nheztzivYSMXB3JK+ska/rRsTrVT7DfqBa4KyQJ2f8Lf2StTw3dRogxoaLCRVqfNk
         AWm/wdzOf2D7piok/Dx50jXQswd6N3i2ky37qnyE8Bu8H2+Z4xpg48EoYammTBZw7ult
         oBGG5az58ZqKgK5ySnWWRo+kew80XKrXC9acPnDI1b42S22npEJ77dGiDPlfzHRP9ygV
         PO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687182368; x=1689774368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIvdumOuZ+uzm//Q8KqLv/f6YpyXoaXW/Ro3RALrI/U=;
        b=QJPUH3Rmho+BBjjduRq45BmabvYxm2JQACy1WMX2J95917RaHEaDkQ+eoby1cjrWeR
         JHjNmCMLjgvSfBpt6UNWIzfHM2urRmcWTU6Inz8qa8PvdZsZWOkPe/nlGVTWq6OfGkMs
         vGxrG77v+OKVdu2HZKnzU4iVanG+tL04WrMDAbC2VgKkhzisIRdzK0ci9SpYA329C9lT
         IYmoHTXHlru6Vil6/auDJhEnVm3a8kku2vTZvZh959fHIKRe6BNHi8RAE0woTVoLp2ML
         xOGnEgLtMRsYn879Xqf2HsCD1LbiWLgtZ9coX9KtPHnU+SXhfctYjYeF0ZLiYvmvlvlV
         i2YA==
X-Gm-Message-State: AC+VfDwdZz6SVG8HVwELm+x8ilcGOX8WdfLzOzjUqdVqhmhP4Wl8Ijp+
        tP8qukZjmvDsN7/zgKt8x3o=
X-Google-Smtp-Source: ACHHUZ6hVtaSRXVcpARz9bDj143Ijftd/mu+PCLpAfX3sCeNiBfBb4EpdXjUvSU7RP2RZrry2BXVow==
X-Received: by 2002:a05:6a20:8424:b0:103:b436:aef7 with SMTP id c36-20020a056a20842400b00103b436aef7mr20689920pzd.16.1687182368045;
        Mon, 19 Jun 2023 06:46:08 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 201-20020a6302d2000000b00553d42a7cb5sm1177513pgc.68.2023.06.19.06.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:46:07 -0700 (PDT)
Message-ID: <c8fd738d-cedc-9a2f-f093-0a5b49ab0131@gmail.com>
Date:   Mon, 19 Jun 2023 14:46:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230619102141.541044823@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
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



On 6/19/2023 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
