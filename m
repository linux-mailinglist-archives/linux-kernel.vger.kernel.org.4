Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30343737662
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFTVEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:04:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D610F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:04:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77e3c55843cso38255239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687295087; x=1689887087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYujz9veDd2CO7G1dpy8ilcu4Kv8MRTtnNHN6uTYZNQ=;
        b=bFwYNvAcJpiZD8EVOOpBW5NIKQDuzbimB/glzhn4+Ek0kY8SC1Vwvg9f/WYcymgYl8
         77/0YR9JD6p04MQhaSDTuXAnTX2cHGkP8SG3V/9AUEpfNhcwKWezrAAljEdegUiQ1XTX
         wkvvQe3+pkn1UVl6oOgsqcGKpcf+fWI5aRdRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295087; x=1689887087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYujz9veDd2CO7G1dpy8ilcu4Kv8MRTtnNHN6uTYZNQ=;
        b=ONh+psECsLhVrZFf249mff799YHZVBJjbZz+cbaEp6v5bx26TaUFHsGKbZ6AYObK1K
         H6YBQnVSQkLFAhJGrCobZVJPMccakgfuoA65nJR79XUb9OCaVnV0MTXSFUEky/vJLfrm
         ajz5xFbNoFCXvgSuWCoKMqNUVSsCfjUNi5WgokzR02lMfTF1XStarAKYo1Ctfov3g7W2
         t7Pz1z2HEIhUfh6HB6J44B2vEsaPEuRScO5wGkVGrVgjx3XOfENnUecdXLP2G5RTz9F5
         WYhoZDg2xvyWS9WrnzX2HlyaZCGIqdGjaQPhBuG4oMiEDL+kKSyXCHrydN0NysYQDSlK
         J+jg==
X-Gm-Message-State: AC+VfDzp2yQhgjvjPhHZUd5h9GDtST7FNwWS64YnKL5ypQ5AHehntHEj
        JVQMWzMAXOztP0fkpBaHvP/ZbHWyo4pDDhRc1B4=
X-Google-Smtp-Source: ACHHUZ4VTwsl8aTrVK7Amfm6wbtGoXnbQw0L84oWsJQMh4ZBwhsU57quym3SYzHuZcgpSWwry4grjg==
X-Received: by 2002:a05:6602:3998:b0:780:a83a:7684 with SMTP id bw24-20020a056602399800b00780a83a7684mr2493834iob.2.1687295085634;
        Tue, 20 Jun 2023 14:04:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h1-20020a5e8401000000b0077e35ffac2fsm903309ioj.32.2023.06.20.14.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:04:45 -0700 (PDT)
Message-ID: <facbb44d-5f33-fc8b-84df-c191bc7effb1@linuxfoundation.org>
Date:   Tue, 20 Jun 2023 15:04:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
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
References: <20230619102138.279161276@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/23 04:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
