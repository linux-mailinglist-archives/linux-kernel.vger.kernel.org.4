Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A76A7923
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 02:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCBBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 20:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCBBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 20:44:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9E0457DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 17:44:13 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h10so9572294ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 17:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677721449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wn0GhLKfvndtXTBbWz5QIu214kxtRlcBtnzhbmKAbw=;
        b=Wy7KOhXqkaoDoBgSms5p/icdqbwn2o0tqPwG37KM0Jubxew2owaE3mGCi80QpNN1/7
         PXY1r0Xq1D7G4jgVPnXkTip8jqQz2YIZFYlhGb4EQy+dbom5e5V/KT6QihayK6RYMhrd
         2YONx+0xxOAz0fQXlnyLDFfYyh5wskQpU0w4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677721449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wn0GhLKfvndtXTBbWz5QIu214kxtRlcBtnzhbmKAbw=;
        b=Y4DpS01rs8LTVAOyATRn7TPggIoCwVaOv1XStVgCHJoEza6jAiDErVvnnFvw+amgAu
         Bk3lDrVpdyF2XG99Bwt0Z/sL9uHSrKDC54ljgC/AHyLWFWuKm3b0YRm4xFVYUe1Eser0
         eB379c9zdZ5vyd6kxxOnnOaiFdaKpFBVqf+fcyYWYSZHOR4ytMgRKM64Q9b35QEQS/Zq
         B4LY1c4JX0SWUZZ16dcsNGaGMrw/GYQ6a6dltwIXztFgrfbrZi3eeILhi1xAsJImzXal
         ep3HUwsHXfw6bwOXSTuNl2MFb78KjdIjgqLs5tCPUcQ6OfqEP1hdddI1+GZJaaXUQZu0
         sFDA==
X-Gm-Message-State: AO0yUKWcsfNu1e+nE1Vi48nKduaUMdilkQdJAZQcsnJxe8SqpGg4Vf3p
        kJ+IzBDy6KQueCLAIrilUavyXw==
X-Google-Smtp-Source: AK7set/9FFT6a9C3NXius89Sc64bLu+bFZ0TVFTj+E4Su+lTvZDyEUaN+DUAA71wzjxV5X0RQHd5Ng==
X-Received: by 2002:a92:6c0e:0:b0:317:16bc:dc97 with SMTP id h14-20020a926c0e000000b0031716bcdc97mr5585168ilc.3.1677721448794;
        Wed, 01 Mar 2023 17:44:08 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u23-20020a02aa97000000b003aef8fded9asm4224833jai.127.2023.03.01.17.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 17:44:07 -0800 (PST)
Message-ID: <d77cfb98-1135-d56a-9199-263ead73eee6@linuxfoundation.org>
Date:   Wed, 1 Mar 2023 18:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
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
References: <20230301180657.003689969@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230301180657.003689969@linuxfoundation.org>
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

On 3/1/23 11:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.15 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.15-rc1.gz
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
