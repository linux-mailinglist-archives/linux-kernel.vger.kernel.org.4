Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063762393A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiKJBxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKJBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:53:22 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740132CE29
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:53:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id 7so354301ilg.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yC4dnHY7IX8JIC8XVQZbHumkUsZcQ/kWMRWgfr+JpBc=;
        b=cPu+0IEV9d0/djuPjK0FdyVGoNNNd5l0fDueRZ2ZuMZUktABBeyR+AM7VzWDbIN/os
         7htA7QbLFMA/m8eJr9eeYwvKnIZ3z2Cdah5aa/rAnCZ0WXgIdMgtTU1iGmrTS8nscfm9
         o3Q97lu1YnFe0o9Xs3kcxPq1vcbUA3hL5tIe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC4dnHY7IX8JIC8XVQZbHumkUsZcQ/kWMRWgfr+JpBc=;
        b=J3XxDur0K/XHxh3BqOIOL6IMUxf8hMG+J8TIaIUtl+byMd2rUVgDqrSOPEjLSd3JzE
         60IAWi4gApvyFuVg8VfKshASxKS7qG2nexj6tTRacupZUAybH2aWZnY3JEkTjXVwZlkc
         MX0uYyLlVmnawszeGNI/kOlA7yKoGAOVkr95Wl1K5TjU/b1ygRbYZZjLOpLSvZP1gbqs
         Xk0oYM0Rsrpq4dOLsuZF3qU6J8gFmhkFiMF6ZJHJjqIiCJ5gFYomq5uZe3N3HUUFOtCr
         Oqq16gBD3aJ9qPgZMvq25fpNYmQyjLZDDNhSMzyZ80keU9Tq/hGcEcN6J4B4Yb1zJheF
         8p1w==
X-Gm-Message-State: ACrzQf3fGIxUFuq2uSMweIR1eP0pNB7VGCuetnWZhKmcA7kdD/X/SU2K
        9uMU0Rl+PS6kfdB2aAB0L8nDdQ==
X-Google-Smtp-Source: AMsMyM5tS49qktlapJt5vQ4mFB0UbdrVhfHSaPbzXiuGVqR+4AlIi2XLTYN6sOTOsNOqSqYisyJ4aA==
X-Received: by 2002:a92:8e0c:0:b0:2ff:c5c8:792f with SMTP id c12-20020a928e0c000000b002ffc5c8792fmr32280658ild.313.1668045189839;
        Wed, 09 Nov 2022 17:53:09 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ck22-20020a0566383f1600b003636c5dcf29sm5235167jab.176.2022.11.09.17.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 17:53:09 -0800 (PST)
Message-ID: <ef6bf02f-f0e6-fbc1-ea95-39a097974c2d@linuxfoundation.org>
Date:   Wed, 9 Nov 2022 18:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.10 000/117] 5.10.154-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, Shuah Khan <skhan@linuxfoundation.org>
References: <20221109082223.141145957@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221109082223.141145957@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 01:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.154 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Nov 2022 08:21:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.154-rc2.gz
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
