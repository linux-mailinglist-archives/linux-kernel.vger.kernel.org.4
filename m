Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBB6FB9B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjEHV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjEHV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:29:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA90173A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:29:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-76c56d0e265so1527739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683581356; x=1686173356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7j3j99LnhayE2tjFufPEFdNc8DYyO9ySk1bd20eGs4=;
        b=EcmO0t+AT4stpwhfKSGaH5aY1gmlk67L/84AUvUBymhE3/i1mqew+1VU3PhmUHEdOl
         P66vitqhRWIbVQl9Mn6FLhaJAQ/oK5rO+AbM0LExBdAtQeOvX1oNEre1YMa1Zai4Fvrc
         aJpqHV4yF7LphbeEyra52n0ugfrEoqukkSljE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581356; x=1686173356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7j3j99LnhayE2tjFufPEFdNc8DYyO9ySk1bd20eGs4=;
        b=f2LTk7je6setDpfYxpQGm3eWTTLFbybRUgdf6yHAYGk+qcJZTc4/nYPUpetCsmGVst
         0qjUcC1rUwNKV6tM/K7lvRAjPp7LD3L+rpQyyYq/TJGGyHcXewg/PA6RAHiboruihg1L
         5q8DGaTGTNcDKEdABagzEeDfmpmWMieINTKGh088a0GH4AXiBU2kIvSfddq8W0Ztqoo8
         tCQSUnpJwmUkYKNyVytr2eF/8u0IXbtyHBOeMemJLhWjet2wpVGa+W32i290OVGZHVxc
         FuhZ/ZyGCXqe24/PsBa5ps6Fb1PYDV9/0rkb+cVhpkRjSHYzuX7xcS8/kLN1B3+u2FBh
         79Ww==
X-Gm-Message-State: AC+VfDydfhLrdPsNm1xxO5t5fVKe1imw1Yp/H3tcO5JlSQGZSfcLYuO4
        d0jvlGn6h0GcnX9JK7ajtTFhig==
X-Google-Smtp-Source: ACHHUZ5pnEXjGo7+oJPYrQgNCtPh8fY5eYaY6ozuV9aPsNmizygrFjxKt7uk9B/IaoWJOOQxIg3+lA==
X-Received: by 2002:a05:6e02:cc4:b0:32f:1232:f5d5 with SMTP id c4-20020a056e020cc400b0032f1232f5d5mr4885399ilj.2.1683581356456;
        Mon, 08 May 2023 14:29:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 18-20020a92c652000000b00335717785ecsm393780ill.63.2023.05.08.14.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 14:29:16 -0700 (PDT)
Message-ID: <bb06bab8-d906-108c-c829-cec82bd5d35c@linuxfoundation.org>
Date:   Mon, 8 May 2023 15:29:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
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
References: <20230508094421.513073170@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 03:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc1.gz
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
