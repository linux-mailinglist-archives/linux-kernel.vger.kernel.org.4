Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3C658925
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiL2D1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiL2D1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:27:15 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B2013D5C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 19:27:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id s186so16280943oia.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ume60yuS4x+mE+BLhmcB1fRz1PiHMSqP5MxjdySEIJo=;
        b=Qsxuq2GoXCMpJrHvOFEeW67cYFWD4hm0rATXL1WzQ2zZSm4OCRcLqpnx0OMkf7GTu0
         bAW7RKOd67aY0K3osSexeAVlF9ygVFwvl4hPuOoGFCgpRCYFTTPH6q2f7Fi0pvNdWyW0
         mVFbarT0PQxaaqr3Ls6rpnR+A3PTR1RJdl7KZeXFNIJIb9cQ3dbkRCpkJK9g/pSY+XGc
         6B4dTCrq9SMLDdHs38DX6428gyW8EQKEcnwMJFqnQ56q/s401wiYtRG1bmqfOgM/VC2B
         3CHa16nrcInu4Wsesq2WqHIf9nH/Xs1p4EnUsKFSxu5v3AdV5/AaACxKDQmgkX+SN/hX
         Te1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ume60yuS4x+mE+BLhmcB1fRz1PiHMSqP5MxjdySEIJo=;
        b=zZTgEPYjNTYMokhDySnssW4kqryPRVNCrL8/iKi5MAoz1nnPVYtO9kn0mhjDfNp0rA
         W1603ktXljEjzNLpayUlLheOkSzL5x5QDQ6SAP6OMfos0SY2taAAOejn39XnmuDjP6xD
         4V6jvxU3ncE+xee2XvPKdj+I5n8lTm+V5+vSXHD7BBQT2kbhFQNg/2MlDse3UZC3CYjV
         X7WhyxazfcIZ9oyo8NR0jPkMuzrTHHGb/e4J37GFbGqo+f1X1SojwaVzfeiwSU+ga/11
         EIAbSuj+SIGC0bH9uC2aHjfiXthimv2MVa0zeNbFNYHuoicguuMUjWpxzKGKFgY8eX7o
         gBXg==
X-Gm-Message-State: AFqh2koqc3IFkEqGfcuB6XtalcvrAirygyMhk2fM46/U0tkRd2Z4SF98
        SMW8jNSe4CBJyz5hxcCDK92qDw==
X-Google-Smtp-Source: AMrXdXuCg8kFNsWR5lvVSgV6as5oJfuYPEbVQyU9jccM+jUhvdTCNej0glEW88K5/gnhQBW1YvDVyQ==
X-Received: by 2002:a05:6808:1993:b0:35e:9090:2969 with SMTP id bj19-20020a056808199300b0035e90902969mr15074149oib.13.1672284433908;
        Wed, 28 Dec 2022 19:27:13 -0800 (PST)
Received: from [192.168.17.16] ([189.219.72.83])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d62ca000000b00660e833baddsm8630907otk.29.2022.12.28.19.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 19:27:13 -0800 (PST)
Message-ID: <c3c2ef47-b46d-b446-5475-366867954528@linaro.org>
Date:   Wed, 28 Dec 2022 21:27:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6.0 0000/1073] 6.0.16-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20221228144328.162723588@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


On 28/12/22 08:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.16 release.
> There are 1073 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Dec 2022 14:41:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing the following problems, as with 6.1, with GCC-8 on allmodconfig on the following architectures: Arm64 [2], Arm [1][2], i386 [1], mips [1], parisc [1], sh [1]. With GCC-12 on allmodconfig: arm64 [2], arm [2].

[1] Problem on 32-bits:
| /builds/linux/drivers/pwm/pwm-tegra.c: In function 'tegra_pwm_config':
| /builds/linux/drivers/pwm/pwm-tegra.c:148:53: error: result of '1000000000 << 8' requires 39 bits to represent, but 'long int' only has 32 bits [-Werror=shift-overflow=]
|    required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
|                                                      ^~
| /builds/linux/include/linux/math.h:40:32: note: in definition of macro 'DIV_ROUND_DOWN_ULL'
|   ({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
|                                 ^~
| /builds/linux/drivers/pwm/pwm-tegra.c:148:23: note: in expansion of macro 'DIV_ROUND_UP_ULL'
|    required_clk_rate = DIV_ROUND_UP_ULL(NSEC_PER_SEC << PWM_DUTY_WIDTH,
|                        ^~~~~~~~~~~~~~~~
| cc1: all warnings being treated as errors

And [2] problem with qcom_rpm:

| /builds/linux/drivers/mfd/qcom_rpm.c: In function 'qcom_rpm_remove':
| /builds/linux/drivers/mfd/qcom_rpm.c:680:19: error: unused variable 'rpm' [-Werror=unused-variable]
|   struct qcom_rpm *rpm = dev_get_drvdata(&pdev->dev);
|                    ^~~

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

