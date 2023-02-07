Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E468E2E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBGVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:23:24 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB33C26873
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:22:47 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m15so6591872ilh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pWtMDHlChNZpBVUhtxKeU61bbziVZ1L3zQXJ9Q/ELQ=;
        b=iGG49ZGHPzcvfk5FpC/wPCPjp3eRBlDLnfbucFVpWLpsl2Z8RzUxLQhMjaoGLnVgBq
         xjeqRsYNHx/x1cXl5gl7p7O8mwLBteNJy4e4Jt0xmGTfls523cXFG6Zp+e76SIzupePC
         DseNoGGv79jE/4Z6vcZzHYWFK5W0bjBjcgF6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pWtMDHlChNZpBVUhtxKeU61bbziVZ1L3zQXJ9Q/ELQ=;
        b=ODxjR0thYV9ETR3jMWyWxA8lQFhPIQRp6rp1YhWYuI58PaJZJntvOfVIU28t1Enkyk
         Oqou5s8u6m0/qwyiWLT9eCQ6RvfVKuYgIaAOTE9XpPctfr77XlSmO0bxdZanb6UzFsIM
         DMs5qD6e6UF6dYjB9JPBAYW2hLkBjEc+f85CEeyrzSjiZgX92ACgXGkX7NKaC0gz9Apl
         mDmJitmLPIy6szRO4FoFUQ8R2pt/UozpUQmIN5zSa20elZ5J6LQV0/g5Wq2BZh2RO/JV
         ryDiUdy0U3dPPRGM07EM2JRxpGMRK05nZsafw4afVBEzrtX/Nyn/giM3kqm5ijzzkhhu
         uCRg==
X-Gm-Message-State: AO0yUKWomwyzeyrCYkmP0uSSLFgbsGDpIsYvX6Nc0lbr7q/aADeCqyUB
        faW1wpuxL9eK+3MvbfKyhOhIVg==
X-Google-Smtp-Source: AK7set9iKHCEqTPRQ6Y+u1bMD/+Kbw88A5WZcUuyVysTNoY0Ai0/BDNKii8NCmibzYRgz4gqOf3llA==
X-Received: by 2002:a05:6e02:12a8:b0:313:d901:82e6 with SMTP id f8-20020a056e0212a800b00313d90182e6mr3726764ilr.2.1675804896995;
        Tue, 07 Feb 2023 13:21:36 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i15-20020a92c94f000000b00304ae88ebebsm4375569ilq.88.2023.02.07.13.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 13:21:36 -0800 (PST)
Message-ID: <8ca9283f-36ff-8e79-c168-c59f8e84f7dc@linuxfoundation.org>
Date:   Tue, 7 Feb 2023 14:21:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 000/208] 6.1.11-rc1 review
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
References: <20230207125634.292109991@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230207125634.292109991@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 05:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.11 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Feb 2023 12:55:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
