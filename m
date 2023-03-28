Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B356CCBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjC1VHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC1VG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:06:57 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2C10FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:06:56 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso8062739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680037615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hanuyFiFhVc/3RlCbpgD6fgmr+rE2YPGOnPcwJgKGQ0=;
        b=LYeEAX/3D65jXOQjO9a4EZnrh4gNd9cqsx7Z9HeeHrCaYw/KDOSjx5JiZDr6BlBmuf
         JJ6Qt/QFydNGJykAO4T9vXIa+AfX9zDdPbNtaK4z3T7QxARh29RHlhVsUHZnSMMVseWu
         DxkZmbiMzO0lcmUqlg3hYDP4Z/CbAsRNW9xxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hanuyFiFhVc/3RlCbpgD6fgmr+rE2YPGOnPcwJgKGQ0=;
        b=BLq0qtSrcAP2M70gZ/v7D+KS0DkdBsgmnjC7QCRFRjjxDEGtiEyTM//fK+JyI+B8rC
         D8DHc+/CBK5N+rKV5UGmyZeEdJfA8PgRAGL3aun3WMETMWNQNtnyKVKxZV9JmNN9nidJ
         uygZMLujNPAUyBKm5DzMSdvAYF0bJZvL8YS7v864NKNu35CAoU/14C19or2SiK3eoTZr
         UbH4zd+/TRefpX2y0JVM9i/Cm9eIngaQ3iz3CWOZplQA/REDnz8f2cQ/KSCkRQstrw+A
         ck8za4PPjSo1nkUx7ucMersaTMXjmB9AQ/z/3okN7BqNH507EnTebjGIjbOT+v0F08GA
         kkJw==
X-Gm-Message-State: AO0yUKXklW2iVaA82rkqvQ6IBVBhJ5CCsOUCtRM7/7CipXYRWEBNwT1G
        h4KXxn90kl+e7uHbF5HVyMnYBQ==
X-Google-Smtp-Source: AK7set83tp04y3GJbPyEa2LtGOuxdx88tQRQq5+ZfqDKh8TFASHi9M2UIhXhFGmabMnwCbzzKSnmZg==
X-Received: by 2002:a05:6602:2d87:b0:759:485:41d with SMTP id k7-20020a0566022d8700b007590485041dmr10044879iow.0.1680037615269;
        Tue, 28 Mar 2023 14:06:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u19-20020a05663825d300b003ee71bccb7bsm9903752jat.158.2023.03.28.14.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:06:55 -0700 (PDT)
Message-ID: <0b0cdfd6-07da-f146-3d63-c7b3e3b508d4@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 15:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.15 000/146] 5.15.105-rc1 review
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
References: <20230328142602.660084725@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230328142602.660084725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.105 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.105-rc1.gz
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
