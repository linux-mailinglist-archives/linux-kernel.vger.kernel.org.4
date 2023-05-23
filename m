Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D996C70CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjEWAkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjEWAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:30:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846241AD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:21:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-772b5e664c9so16451139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684801269; x=1687393269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRFXlgXqQMif9nrEGkoBNsCSy0LwutHy0WRVkrR+E6w=;
        b=WlcUP3WVgbUHJQoC7PtFlFyVnD5zH5f8zdyRMWatTe1mFVYOwK7qeYbzVBQdfyGGQI
         rftjHNbopiQKa6nsWV8ZqMUUMyOzSFNwkkR5h+1SUVZUa3k1TfvVS/S1G6YVEuHmKO4S
         gf+Ac04PFHqb0PQDIyC25HjOebLwsF/+mLgXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801269; x=1687393269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRFXlgXqQMif9nrEGkoBNsCSy0LwutHy0WRVkrR+E6w=;
        b=jD6cc+wRS1C07WWmy0oVu7yYbkHLT8dhKz0zc8xVpvPPSIt3wwr0/dkvyTNT2Do/93
         nRkU8X++VCBKUm77QcdrVjn8CXVcPR3GCvQUKYJFclMKAWvsequ0jfz0uB1b2Z2tRHXX
         taUCibQjbzfS+or5R1k08G0OD/wnfVVV/Eq2vkUDTKRsl604mTsMF3E9jKtppSbpfl6c
         /9R5Di0eznunPioxKikAalBOlNcR5IShSM9IwjaCbi5dGBbiIX58Eg4pFVIOSoQnixFF
         rQguOw0uhoLKDfBn7l23bBEE5he49sksvCIeoQ4YtwuLAzlIiYbVW3bE8ApQJt6WCimH
         qDuQ==
X-Gm-Message-State: AC+VfDyItNS4AO7oUanmJGj80hzejkqYcnkH5cO9ZFxjnywGTZQQolZ4
        vpyIVWmHWWuij8VmWBxQTdA60A==
X-Google-Smtp-Source: ACHHUZ60Ia7zbZE8PgUpAPNdPWJiuAdXYd7zgT7guq5W/LEHzbR2z7He3IYx2okds6kq4Gb7OXySpg==
X-Received: by 2002:a6b:5a0c:0:b0:76c:6fa4:4df4 with SMTP id o12-20020a6b5a0c000000b0076c6fa44df4mr6196582iob.2.1684801268807;
        Mon, 22 May 2023 17:21:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n13-20020a6b590d000000b0076c81425d9asm2290113iob.49.2023.05.22.17.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 17:21:08 -0700 (PDT)
Message-ID: <a8713c0a-8fe1-88e6-107a-fd9a94ac7e78@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:21:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
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
References: <20230522190412.801391872@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 13:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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

