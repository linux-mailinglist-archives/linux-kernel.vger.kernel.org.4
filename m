Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009145FA6FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJJV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 17:28:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81D7A745
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:28:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i65so2594919ioa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdL6kfa8b0XyeI6gtsl/tuZiLBl4Dd5LE2CJt2nQatw=;
        b=ZVOt7bhQh/GEtzL8DpUUkVvqzV3ZTcHGPJj6Dtl4CnGflw6gvp9fcjA36GmaW1ZkEy
         l/2q+oeP6waSZ/V8sMrwywisiAIqy/rfOkDLWEVe9KhkmN/8X5fYYMJ2JdMoOWS9FAob
         XtFZHm0WvrxZuTFEUk2UZsx9hGct682e4GeG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdL6kfa8b0XyeI6gtsl/tuZiLBl4Dd5LE2CJt2nQatw=;
        b=z7wtZNX5m0cjNHF4QCOrXj/V+2wUcFCFfO/Sb+fPs9BA0OTRgyYJeD7gzRpBuGJBJ4
         gkUUQXbMpyFMVPw6M68lh68pRsYj9soEMLWbddK+Rxpgio02S8WY2MY+uerQacMcm295
         WOvCm5c2K+OARo0OYmsBdrt/EHBL3eZ/08GftpR/CH3c9DpZUi8cPJMExs4jEX/zGgCn
         jQpwlAp/NBiRFWuNFwGHhWzRayNzFELDTH1mGE3vECbBklW1Da6hbuKRurnaPNNk1Rjr
         zEoWM98UCuz18z79RmfgFlq22GhSoL8KYVVMS3wvE9+cICTwDIIri6MJr2PKz5Xd6LnD
         BRdg==
X-Gm-Message-State: ACrzQf1ipZNZfr4cMte8qq4m1wB+8irFLb5A/6L9HH3PMQ/yCdvUbOJF
        Yf8tB0+B7KragEjTIHA3PnG81Q==
X-Google-Smtp-Source: AMsMyM5buFux9wyKoCQO+PBABswf1EPIw/7hPvZwPhwnFQ477Tdf2cQMWZ/hF8b5WL3Br53XBjChDA==
X-Received: by 2002:a05:6602:491:b0:672:18ce:8189 with SMTP id y17-20020a056602049100b0067218ce8189mr9718190iov.170.1665437337684;
        Mon, 10 Oct 2022 14:28:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l12-20020a92280c000000b002f611806ae9sm4149573ilf.60.2022.10.10.14.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 14:28:57 -0700 (PDT)
Message-ID: <71865e9e-e133-2efa-9caf-47fad09ca792@linuxfoundation.org>
Date:   Mon, 10 Oct 2022 15:28:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.15 00/37] 5.15.73-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221010070331.211113813@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221010070331.211113813@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 01:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.73 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Oct 2022 07:03:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
