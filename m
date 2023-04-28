Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D966F20C6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbjD1W0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjD1W02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:26:28 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A5C40FB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:26:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76656f3568cso1954239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682720786; x=1685312786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMvHiA5X/oFoi0HiHbXPC2hzPgPum6tdmBFydzRayP0=;
        b=eyseTRqHRpSKV9M4OhAJH1pTy85+2t7aWEAj0j9QrhQ8rpXvm6PpsRV9Yh3nh0XWtK
         VXgvI4oLoqMOqT8lSi7+QkL+dT3wekKd1YevUQ6fCrVW9dciWJOcY9nuYM7ZyAKKOOdD
         nT5KgKyPWIAYDoYnHc5ieUYHZjdEI5B6s/7rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720786; x=1685312786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMvHiA5X/oFoi0HiHbXPC2hzPgPum6tdmBFydzRayP0=;
        b=KnEqEK6kKRhwv8bnUsEdDYu2PvJ+oJngO55wEoN3UwCb+J18WLDZefo1gzK+F4IMC9
         p1OI4SwTyLAAx2ltu/UO0uz78m18+Y2wLHlrUx5Vosg//GxO7OnfPOA3cac7wshLHqXz
         w57ZeSV38uadpglKYfSFb7KSwysJbitCVXR3CDuz4zs9LltX52g4EeZEA7wZmWYKcyzf
         aH+aI6hCBtw7wadRoilQA/khCDlndkDYawI9fQFJEMmb5yBt6yXf2oucUqY/aTdHF3OW
         /navmzDUebVcfm/dnW+c26nxkftO6Dgbr6SXDiZZMyO7q0+eiXbwGRcPYV0YeAIuuLhe
         Tkpw==
X-Gm-Message-State: AC+VfDyCim+lF7T33t9n8IPnsdagBfNFRfXH0Y33MNbgrRFlEpx61UxD
        0W1KMZ5TwUD9aiKs4lnKEk39wg==
X-Google-Smtp-Source: ACHHUZ5POQEvt+GzKVYdai0dY9PRC8C8XT0gUZk7LwFjM+90UNMY/bHThyhcW1UoqDSrssf6s5LEbw==
X-Received: by 2002:a05:6e02:1d1d:b0:32a:dbbf:5707 with SMTP id i29-20020a056e021d1d00b0032adbbf5707mr4167596ila.0.1682720786620;
        Fri, 28 Apr 2023 15:26:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e28-20020a026d5c000000b0040faa68e7adsm6378810jaf.119.2023.04.28.15.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:26:26 -0700 (PDT)
Message-ID: <9625e834-a7d8-d595-1f7d-01910533fd57@linuxfoundation.org>
Date:   Fri, 28 Apr 2023 16:26:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
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
References: <20230428112040.137898986@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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

