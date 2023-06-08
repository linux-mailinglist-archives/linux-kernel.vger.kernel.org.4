Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED3727571
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjFHDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjFHDGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:06:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7592119
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:06:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-777a9ca9112so718539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686193598; x=1688785598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/A8b6iF5sDA3+NoxQXVIUbsxw4l3iTn+tTmjMZOtLo=;
        b=VAWd+EgzvfPSWbzp2m3+zw/d4oi/GznSJnYpQch+bSWRGmBupUwVeUMJoVYjI/rTSS
         dC0iH7IlZyQ4qb1y8i/rKKZ1Cs/sDiGZDOWu6G++KqQMezz8FUN0Nno42otdfl2ILyRk
         iNz4pX4sBQfqh+cz1VZ9oN7VBtzzy6nfOnvNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686193598; x=1688785598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/A8b6iF5sDA3+NoxQXVIUbsxw4l3iTn+tTmjMZOtLo=;
        b=Iuyey9EeQCwaDJx7DZo+NNn+VuRug/0mlhiP27H0iykYfqL0wv4Y92uvGZltfP86P+
         wbrSOz8UIyb6zAAbRSxLSmDnJe1bOjtAmxlS0qPoXvY7flq8w0i7NXeh+VWlAUKCgV+E
         Og6K324gjyFkFJBBLYVnavrh5Zmax1z6714fq02jiAssmlFPB8VCMD1nZAzIyiYyCMYh
         ye4OqV/OMizqlDSnr0WD1MOGpDQ7Xn8AVrsdc6qhxudqMGDY3dq3bV635mPXzoRngxCo
         uOy8X8mh6TJmQ/sx/WqPjkw0Xm4rziLKdabcxdgaMqKHCUX6SwcUraoWkKrtiEE82UuJ
         fwGA==
X-Gm-Message-State: AC+VfDxjXWlgr5tpxMTIV3cmCD4gbO6kU2dvbvgGyF5pizCzVtNjR6ll
        pKgMM9+xpV6Nl21/YEZs8IbEig==
X-Google-Smtp-Source: ACHHUZ7z2yhs8NP/M1HRy2LLVSiEVgweThLUygA3O/SFZAA2gmzDg4fgwSs0PNR1/1MjJsHpzRqu+Q==
X-Received: by 2002:a5e:df48:0:b0:777:a94d:a362 with SMTP id g8-20020a5edf48000000b00777a94da362mr2559580ioq.2.1686193598348;
        Wed, 07 Jun 2023 20:06:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c5-20020a02a405000000b0041848ea6594sm12972jal.34.2023.06.07.20.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 20:06:37 -0700 (PDT)
Message-ID: <c2d8bcad-cb59-7f6a-591a-3fbb15586bf2@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 21:06:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 000/120] 5.10.183-rc1 review
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
References: <20230607200900.915613242@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.183 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.183-rc1.gz
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

