Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C526D6954CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBMXaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMX37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:29:59 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9430F0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:29:58 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id j4so5130756iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Cwe8TQmFe/rUFDtgs1SxhTk4ybDkZPmjcfR526N0XU=;
        b=dKFE6QdbXx1b0hQOma4xe41AtUH7NUWmml0V1/RkULxMVEi1aSuP+oCQTXhmiBzeFe
         1ocHZUIGkF4rNfhOReOh+QdVvt+nMA0yEewAYO/MWLO/mi3URz24drdNI66uOwHx75IJ
         Cj1D2tqxp6QN94zm8sMFjwvTWJZkYrmyE+4KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cwe8TQmFe/rUFDtgs1SxhTk4ybDkZPmjcfR526N0XU=;
        b=qYeUV98LN/GREg+Os6Cw4xWbiAYfE+sTVqlTuukJizLSIa/JtyMApIzWaXKTn3+63Q
         lm6M9xYdQskxmdwtxXvNNBYrDsuFs3tdIOrt/hT5nC14nikhy8BmXFGTroXWVDtIxZ75
         OdHuO7O3OnOauhEVFoVRO2RZhsGmNoH2eClCq4Jm8DycyUadpwTUsr3cKNUSQ9XJagvP
         ENW83LRkn45vg9aJwVbEX+Ad5tFyrBc+DdqOj0VKIg9ZCIlisvbfqvZ+sea4QKpzDgor
         gby1L8HVEk4GJlyzxPNMCT2x9qOKpzIJE2a5ax2yKV1b3MyKEMia9k650m7COu4XQaAv
         3Oug==
X-Gm-Message-State: AO0yUKUUmVhnWLM0DI4RT4QElj+TvwUQ8kRHygthMEf291gFe6Gb0MhQ
        LYZw3zKlKxIWSq5LXZqAOqRpGA==
X-Google-Smtp-Source: AK7set/rcIla65D1El+4zWMkyPxCuk9NaXHwE1vk7xxZgfms3UrRLruERPKtkpfhLZZofRuxj1Ov3Q==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr174928iox.0.1676330997986;
        Mon, 13 Feb 2023 15:29:57 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i18-20020a6b3b12000000b0074065ea4c2asm194328ioa.55.2023.02.13.15.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 15:29:57 -0800 (PST)
Message-ID: <8f76fff7-626f-793a-b7c3-fdae0a3d4677@linuxfoundation.org>
Date:   Mon, 13 Feb 2023 16:29:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 000/114] 6.1.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230213144742.219399167@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230213144742.219399167@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.12 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Feb 2023 14:46:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.12-rc1.gz
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
