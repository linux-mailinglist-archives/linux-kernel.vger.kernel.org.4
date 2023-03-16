Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE34E6BC20E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjCPADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjCPADE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:03:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8680927
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:02:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j6so103487ilr.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678924954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewEZHYKYyayjtDE60f5wirtIHx7w+sAb+7nO8rKjDaA=;
        b=U0oBYfwYL1MFLsWjQab0gE03Oaosk3GhZV0eup0X+tGzP4FsX5iD7cSFwVV1JpyiIM
         Xbwwn9/rd9Q8skESRwHR/FG7nqA+PTSpkokIkUjjTLHOrCv+nGlHiDHVWIl7pSpk9Ivd
         XhUBp7PIFmmuHMNnGmHLk2yFgYQAUGuKfxUx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewEZHYKYyayjtDE60f5wirtIHx7w+sAb+7nO8rKjDaA=;
        b=hDFlTQ8nNcRwFNoP0ncFUl3+p8HAuThfGLzUS73LRQqgpvmAN/Uu0JaHfK5U4BJQpz
         9b7GuiUbgyeZFkhJ8b1t0n/16w56qg3R6Zja/9nM7x1exxJONCCyvTu4+1LzAcKiNFQN
         7cziJIrUzPRukvqONLEBDdgwBFlO+n5/xW/Bge+PvjEr784MvYHUAoQNTQSl4N5qE5UQ
         kuF4pjY03syFoTja0rwItB7nC3HMzgFKmZMcylxadoxgfmxkDaiztx0GxO8keTBwQz4y
         nHgN5T6e7s7+3T2TLGM2BKw/3MJx0LnpbdDGbZR/l2pNNylKmi1Bcb9v0m7jGBM8PfSi
         JOvg==
X-Gm-Message-State: AO0yUKXK7S2RDCnM2GOKvvyY3Ytnvm4nHXpygnA+9dXeKydUrYcgaSXR
        /h74rYDJKDm+AYw4VMbareIg0Q==
X-Google-Smtp-Source: AK7set9m7SzRy4yIcD0dGRkOHxuO7alCUrysveLliyqqS7pMcmMfe4np2GopkDSCaDlGlwRIWaukAQ==
X-Received: by 2002:a05:6e02:1ba9:b0:317:943c:2280 with SMTP id n9-20020a056e021ba900b00317943c2280mr699417ili.0.1678924954094;
        Wed, 15 Mar 2023 17:02:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a92c6c5000000b00313b281ecd2sm1959030ilm.70.2023.03.15.17.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 17:02:33 -0700 (PDT)
Message-ID: <b1945aaa-978c-398d-ba9b-103bedab9095@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 18:02:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.15 000/145] 5.15.103-rc1 review
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
References: <20230315115738.951067403@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230315115738.951067403@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.103 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.103-rc1.gz
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
