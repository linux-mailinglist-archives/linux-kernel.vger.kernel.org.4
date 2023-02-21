Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1CC69EB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBUXsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBUXs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:48:28 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CBC2D158
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:48:22 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z3so2640205ilm.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0Zj9qsPEta1dJVgHoolt9moRX61OkvAGX+yWAl5/d8=;
        b=JPexqCfts0gatHhRq6QS/9ZpsZt742wfnp5Ki/v3rA08jkIoakkD+lnr12v8IPqmBl
         8FOEH2meNj54mRjkPBNsBrxHf7AQJtTqzqnpqViqX+Md7tWd2VVGSRUugGFifiSBVmyf
         aySYIEFJZQJM7Qndr2CK7nYS2gK9h3Exw3o8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0Zj9qsPEta1dJVgHoolt9moRX61OkvAGX+yWAl5/d8=;
        b=kPvoYI6Ng0tRvDpnXjpepF4zPSiteL2mlDpWYOQPQ+AT3gZiBb8HnJxVBFzepeaYd0
         UHtEnJrfjvcfhiyDhLzWi/hqQuJqdBRV1xOeZ6tZ7AazvBDBV0+7maV5W1HXzZJdsrg/
         D70INwwJNrCXAhuj2Vvxmdnw/Dy0TPl5/jfVwH2eGqzdY/WHPDcgWKOwPpL+/CSKH5p0
         hYtWg8QyrLgdwy2bkSCJl6U1a+6nFUsPmdCdd1H2FqbMK2z3Ni8hJKYvZMOHpckRPXkZ
         x0mmoste2O3WVVehGv2Tjnlxw7wkYGswy8yDDR0Tkb0zP2ra0gcx4H279gPK+z2fFb+6
         TeFg==
X-Gm-Message-State: AO0yUKW9WS5rmthjYsldE24qXSsZDu4zlhY4QjuM0XkAbX+YmJe3bpwN
        MZlTCSaokLDDAoapP8d1jGQQMg==
X-Google-Smtp-Source: AK7set+yh5GqjoklnZ8UoLLM6gr18wbzYtUm8b2tDmJNTTOp3AoWYpXYCp5gW93z7YKEELn7hMCF1Q==
X-Received: by 2002:a05:6e02:2165:b0:314:1579:be2c with SMTP id s5-20020a056e02216500b003141579be2cmr3477310ilv.0.1677023301911;
        Tue, 21 Feb 2023 15:48:21 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k9-20020a02a709000000b003b443977af0sm54720jam.7.2023.02.21.15.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:48:21 -0800 (PST)
Message-ID: <0b0f9456-85ba-45c7-1466-946414a28e80@linuxfoundation.org>
Date:   Tue, 21 Feb 2023 16:48:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5.15 00/83] 5.15.95-rc1 review
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
References: <20230220133553.669025851@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230220133553.669025851@linuxfoundation.org>
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

On 2/20/23 06:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.95 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Feb 2023 13:35:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.95-rc1.gz
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
