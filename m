Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625906A7930
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCBBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCBBvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:51:45 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED51C4AFD5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:51:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y140so6186816iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677721904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hETqS31jtez34Vx+PJneRBWTwEiHVpbkTOh45XfvhU=;
        b=PSWpq600DFbrfyZl5Hz3u2UNcx/xhDiKTnVJrBfY4Rlme0afK7zmljqwzXOKszhF+T
         atptjPitVtPkjZ4+9GJyOagquRRUu5fgutr84qZlkjat0OI3HTpHnSJ9213YTssUbMgJ
         aGdc+ekbcoE7sUSlh7eZd4lDUrQHeekrpAmsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hETqS31jtez34Vx+PJneRBWTwEiHVpbkTOh45XfvhU=;
        b=vmdssxgNT43+RtF/4p7c8RFvl6Ls+WAlN289auYtmLBmNfAQR1F9KNZKAhP4Pcvrr1
         rmBt6SiwaSAwtjek06Q5AqXSH2UgQPLDKk/YhtJBjvD5tX1sPTk3DUUYMtAx8dE9Rn7H
         WYWsoeq8b9cLH1aUgsuYMC42WNtDnHz/prA7NDxnHOoYUsX/QcPWpleridRzKq0fxc5c
         W3bBnybBKTp7pb0haTGMrkyPqHBGi3gGJGPUR8fl4M3JhCjhkrshrtxFKYvaCA3H7UEU
         udtqAcOGfMbA/exaJwISkXuMWMXB3f/lyMrqOWAQ1wFIzApKZlue8sCSKjMXL67jtxHq
         99JA==
X-Gm-Message-State: AO0yUKVtD/ZCVo3ZTHBT3IZfWO0ooQrtWu+v9tIsnuuvM0l8PeVMWj+A
        /MJQWKfsS9nujG0DFEI78OgW7g==
X-Google-Smtp-Source: AK7set88HYv0gRNcGf53HnxRXgV7y8VJpc2bcM3djSJoEIOCR+rTD9Nfpr6PfRUtvbgk0XaPR64I7w==
X-Received: by 2002:a5d:840d:0:b0:74c:99e8:7f44 with SMTP id i13-20020a5d840d000000b0074c99e87f44mr5158648ion.2.1677721904307;
        Wed, 01 Mar 2023 17:51:44 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k20-20020a5e8914000000b007407ea5d07csm4226997ioj.51.2023.03.01.17.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 17:51:43 -0800 (PST)
Message-ID: <e62e64bd-d4a8-a2fd-ff85-27d85dbdaa5c@linuxfoundation.org>
Date:   Wed, 1 Mar 2023 18:51:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4.19 0/9] 4.19.275-rc1 review
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
References: <20230301180650.395562988@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230301180650.395562988@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 11:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.275 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.275-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
