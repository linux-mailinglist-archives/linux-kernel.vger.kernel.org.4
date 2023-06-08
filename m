Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D7727438
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjFHBWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFHBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:22:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3177D26A6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:22:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c304efb8fso96239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686187328; x=1688779328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96LPYa4rPY61ZT0Qle5XVCxhRcsZk/6e//tpKYlqeX8=;
        b=ak0C9ZSNtWRAsQH9s15NmoYCsH3cCKTQQW+lUdAJgJU0HqfQfolHg7/BFoFYM1ri6r
         99G/x8HuHeNTpgDcBcCT6ZOOJsn6398hq6BMCBvalDQNySQbCqzu344jIDdgGi+92SZS
         yt54g8852HPYcIuU03+qSyC21Od/RAq0VVSMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187328; x=1688779328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96LPYa4rPY61ZT0Qle5XVCxhRcsZk/6e//tpKYlqeX8=;
        b=flfD4a2LigAZtWdLbA/ObiuH+MZCPEwS72DtMZSQlS0FADT5JwnDSujcmCZsIjnYzz
         OsIGJwZXv2Wx51UlftzBWRSm6SqdjurhdCv8IFK5mWh8/3pfDwZHDTIsGDaI4xqhh4h7
         8YGVUwpeqv4XV55EXXXgG61g1bj9/lx1uwUAB/yZBXTvIzfZ/0wTGJ6HSK55FdiUGjar
         hocAFIWDdtdE3mCzGmrmwdfxVw0E9xie3LuKtU0kmVSfrdwsVidlKYVep5mpy1/DTt8q
         2UHPQflV7WbEOfaczvE8XAZuQlQTCiv6YhYiSys+vc8jp0RvU4xkTqxey1a7/ydYSP7b
         E9eA==
X-Gm-Message-State: AC+VfDxOZ5Bbh6l5JQhQwoGo7Q0jZ0ueLOSolBYmXzNKt3LnSieO9CF1
        lFvAO1fI5soDci8eefAxrLUtnA==
X-Google-Smtp-Source: ACHHUZ5O8eRRXv1pKn7duaMD+ut6V7e8TcsdzBtuZtExJKd0hsR1DkMzLOvbfhjpeqMqJir8cigMog==
X-Received: by 2002:a05:6e02:1281:b0:33b:3a14:c14c with SMTP id y1-20020a056e02128100b0033b3a14c14cmr1926474ilq.3.1686187328555;
        Wed, 07 Jun 2023 18:22:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w16-20020a029690000000b0040b1ecc3ec4sm643834jai.11.2023.06.07.18.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 18:22:08 -0700 (PDT)
Message-ID: <204fea70-1021-f6d8-4fee-589f85533bdf@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 19:22:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/225] 6.1.33-rc1 review
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
References: <20230607200913.334991024@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.33-rc1.gz
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
