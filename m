Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9668A76B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjBDBEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjBDBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:04:43 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B84F677B4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:04:42 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r6so2622026ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 17:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEiHHmlJSzJPx9D+kEWk3DrlaKBm5JKbFkxKskYpgM0=;
        b=OOrGrY5SzRYWa2GOMolAOdtd9Cg9icVaoG4FLxfREIKbbZj6AAQxqLashDieu2Re+e
         X1Dfn8mHHYsKxi9pQU4vobVG58U/fzYu9UzXj8Jrex/grJAo5aLEtWBGTYTfZdGA+7gf
         zv1diuthFKOHnGa0V3Nc6Q/dVRjHET/eV2gQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEiHHmlJSzJPx9D+kEWk3DrlaKBm5JKbFkxKskYpgM0=;
        b=uAh5vkUf0Zp9O6Tj1dfcJK1/0QxKK8GSQCXo2/i2SBpzrKz3JjGCgTY2oDFnH3Q5A9
         zuitOJ0CmYijctpSNmSGbtwKeEpBPIhG19dBmn1fiCu0FMvZfNcykP0+fPVTYobuLLUS
         Cx12t/MQQjSjoETZ8ttOROpvL7NoiQVH1LfsaERNx9/YKeXLJIu9+ODvIRbGoWWqCTvw
         K4SdFQa7XwLC1/jdKuuvPZe60r+xpM339x6+loicjSAKZHNgyrkghD3W6DO8Ky/xUIzf
         QzOpNrUKkzf3fSKPc43ER0k7ecWFyQ7I4GNDQsQq3yF/IdqQo6iE58MGi6EvuLcUvW+7
         eb4w==
X-Gm-Message-State: AO0yUKU9m6QjZzU9Z56uffKoMOMj77nJ1sKu/91GzEmkI2C4RWP5Bw23
        UpUnvl7l/XNceGV8bwb5cLvoBg==
X-Google-Smtp-Source: AK7set/KM7BVz+ZipCrscdb43Q3Z/bGz4avXrcHLm/gozrthyz0wZme6CloNW83PhjeyFk4tEOagjw==
X-Received: by 2002:a5e:8307:0:b0:707:6808:45c0 with SMTP id x7-20020a5e8307000000b00707680845c0mr8256875iom.1.1675472681339;
        Fri, 03 Feb 2023 17:04:41 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c15-20020a02c9cf000000b0035a40af60fcsm1340823jap.86.2023.02.03.17.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 17:04:40 -0800 (PST)
Message-ID: <8ec8c5a0-8935-631c-fb44-864c6d1b9fa5@linuxfoundation.org>
Date:   Fri, 3 Feb 2023 18:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4.19 00/80] 4.19.272-rc1 review
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
References: <20230203101015.263854890@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230203101015.263854890@linuxfoundation.org>
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

On 2/3/23 03:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.272 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.272-rc1.gz
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
