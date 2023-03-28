Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337976CCBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjC1VD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC1VDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:03:53 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD51FC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:03:16 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7585535bd79so7996439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680037396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxS2l3vfPyYI+uPgd2j4FBDvdj2gidL4a4k99YKhl6o=;
        b=S+28QqXBwG9DhSdrG+yetVYKT5kyZTQWwWgZP+P7iQoSyBUIal2Ic74ZAJ+uA429oH
         6P8Lu5DxZJN2VbzF7e4WrL1OpI916EiTdimnki9j1FdPLKd5Ca59Dwro34Ghd9JcOfi1
         jFPYYWahA/VI028MwNkJeAOJ1jfVhaJCcHEMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxS2l3vfPyYI+uPgd2j4FBDvdj2gidL4a4k99YKhl6o=;
        b=Gp/xZ2B+hlySp8y8FUcbtZr4FNMpJinhFc2f1R80unV/sA1ia3eJzE1wWVMMUIbQHC
         HSpEQdb91En12wnSkeF0+R3GZanEpYb0XmXhVbT+kA1p8FIYoiG1vfJPygIZLQBgx71v
         Uohzw7ZTpV1Xa/EUKnJ3DbkvyqqbbqdPnlZo1QK5+09Ro7lUmH3SDFjMmJI3Ke8Qvj5B
         Epe8vks+rZOD9hJq+7XdzwnNgnOjvdiKwFg5OJRQsFZbf/5T9Q91bxuSDw1W71J/WKaY
         MT8IA+IxTMUwudUlWFgxLJ+56qzpUnngefj1EQqUSZ5sml1w+5yxozNX+QnMA09uaUDs
         sihw==
X-Gm-Message-State: AAQBX9eNGBcIU8vPgUfekyKS+IvR/SHmFrqfaq1U/4xXTMYEiXm6MEVh
        k/pYaacl3zIDXISvyHitjXkr6w==
X-Google-Smtp-Source: AKy350Y8aAF1wzrtazHLnm0TqfbX4ElxAOAb5jPrnCZ/3wdvoSEu6F2k+A/JPgTmm/3rtBNN9A5LDg==
X-Received: by 2002:a05:6e02:1543:b0:325:f635:26c5 with SMTP id j3-20020a056e02154300b00325f63526c5mr5957759ilu.3.1680037396197;
        Tue, 28 Mar 2023 14:03:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m19-20020a056638261300b00408e5ce41f5sm4378981jat.163.2023.03.28.14.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 14:03:15 -0700 (PDT)
Message-ID: <e1bbfa5c-a8ca-4bf4-7e34-7c5c61649691@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 15:03:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.2 000/240] 6.2.9-rc1 review
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
References: <20230328142619.643313678@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230328142619.643313678@linuxfoundation.org>
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

On 3/28/23 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.9 release.
> There are 240 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Mar 2023 14:25:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.9-rc1.gz
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
