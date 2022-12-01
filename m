Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB02D63E6D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLABAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLABAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:00:06 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB24E6B6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:00:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 135so124100iou.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKpFb6/jlaeH7F8uv4T9zwnKFkBq6SD8TT8AzfJXYiw=;
        b=XpCF7ey4k8U6+L2Vy6Th3///Gdku7SiVUm+VDShkmzrHdgxlUSuyaPG0P6Oft7FeuL
         UphY9ztPeYjA0ZNrk463cTwV2gG72jUDpm6ro/BXLPT6n+ixeC7QGDTm6mrwK5dNWBoN
         Fw32i0GV/YzVhUJGdvpOdxe8VujMcicEUryLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKpFb6/jlaeH7F8uv4T9zwnKFkBq6SD8TT8AzfJXYiw=;
        b=M81pqM0179EwrNUzFOC3Cmr0Gj1qih67dCy/SGXWEbDQQ/XEiZzblGYpO74i+p4N5Y
         uMVHawT84JQdGv0QVCAdL2uPLpwZZ1gZ07f118tRBeTOppEP12/0fISefMoCTbk/UBHr
         b0fdW4C9N4wQgg/RkacI0xWzhLuE3FEQYJGlgzvSohQW4egu1+QycS2gxSgl16DWp85L
         ZUavn4iA0vT6X6qCq71ieyo5hEsYnBRerrfgwlX2xT1tD2bwFj2LbVKpZ1Vsv3GCugz+
         zVFmNfU1In+fo5biO7yOPwadzTQwJXuBeSwZDz/VSXtKk5ST1US1URB5TNacdL8KVKhP
         kq0w==
X-Gm-Message-State: ANoB5pkyKFUUjC4XhzuOp5wNFcQV9ZBcLKFpQYvyDKCVEHqUyGrAkdbf
        xEBuF4AdL3WFPCJ40dxiUhAd/A==
X-Google-Smtp-Source: AA0mqf41TEBl48geLh1CMchiDPpIgKNU9buz5NwCnp6hEefNdxo8QFhdXuKNdPLlQSHN0XL72OsBWA==
X-Received: by 2002:a05:6638:4410:b0:363:aec1:9a04 with SMTP id bp16-20020a056638441000b00363aec19a04mr30680397jab.78.1669856401180;
        Wed, 30 Nov 2022 17:00:01 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g20-20020a0566380bd400b003734c4d01d2sm1127219jad.61.2022.11.30.17.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 17:00:00 -0800 (PST)
Message-ID: <45ea7769-42fc-a77b-c323-ca1c2f065f5d@linuxfoundation.org>
Date:   Wed, 30 Nov 2022 17:59:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.0 000/289] 6.0.11-rc1 review
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
References: <20221130180544.105550592@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221130180544.105550592@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 11:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.11 release.
> There are 289 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
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
