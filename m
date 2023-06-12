Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2F72D458
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjFLWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbjFLWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:25:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F510F2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:25:29 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33db502bc30so2565455ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686608728; x=1689200728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMJQMMSjzlha9re6bGJiDvNT3DtRinbFbhGXkPE2bPw=;
        b=KRNKWdxNHOks9UtRA0/RJ4zCLDd5/d9bqHLQHe3rukKgmx778AzKUBYE2URQV6u++P
         +JANCMtdVec5reJF/YUlTjk4Dn6uEOac9ZcjCUoyT9JqvcQfsq8pDuKlhl+3wSkwP2xM
         YZ8iyvt/5+/mgl1uHSADlSe284DO20kLrPvr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686608728; x=1689200728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMJQMMSjzlha9re6bGJiDvNT3DtRinbFbhGXkPE2bPw=;
        b=GX8+NVXe3rvXnR5hHEmz50R9eqOtEDqKnO+DJDyjOAzCw8anpvO5eZ4Tej2z26fio0
         RxFQTfphSQ2Ka9BJ/o3SXPmsC894Y7u9G3/YG4BM/RxYKHCu7Pyjyvt2guk4SJ+RhO/U
         2hlQFjYaXg6DiFDVviB4bzBfjivtKJVGH/HikdVxRrgwf5qvzHz3ESLrAwEq+Xjz1Zk1
         fuPCFtlSdxhGTgoUrz+wswipbw0TcECPxUb+sPOndps3x4mbRKFjaJHsptfbj40OHnQ3
         Tdj4iOSysCMyf3nJ7KFJP7DH0vy4nEc5JhgFamFiPe1GdeXgMTav4sD/9BwXKZRYWTFD
         z0Lg==
X-Gm-Message-State: AC+VfDx5LPRr9YTybiCsl+myjrbf3qZrPUJFGWSCHdNnPErsCAb+SeFM
        IXLdRua+Z3UM88kf5YaXZpFO5g==
X-Google-Smtp-Source: ACHHUZ5v8L+4Gd+dXffTSdIXzZdLM0+tZ3lxkMJ2QmzgXUxQYl/fypc7IlPKu4El9nvFTxtcF7R7BQ==
X-Received: by 2002:a6b:5019:0:b0:774:9337:2d4c with SMTP id e25-20020a6b5019000000b0077493372d4cmr7409681iob.1.1686608728537;
        Mon, 12 Jun 2023 15:25:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dx7-20020a0566381d0700b0041d759c451asm2996607jab.166.2023.06.12.15.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:25:28 -0700 (PDT)
Message-ID: <b76078b0-1bb0-221c-5382-cbb16e2b6ee0@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:25:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4.19 00/23] 4.19.286-rc1 review
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
References: <20230612101651.138592130@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 04:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.286 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.286-rc1.gz
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

