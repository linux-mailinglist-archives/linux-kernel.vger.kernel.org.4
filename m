Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536136F2287
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347141AbjD2C5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjD2C5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 22:57:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC532D61;
        Fri, 28 Apr 2023 19:57:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-5f45fad3be1so6492876d6.0;
        Fri, 28 Apr 2023 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682737065; x=1685329065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KWgSfBRX4/7Ituj2OvAS+wvcAoxKFvLr9noXKYmqF0=;
        b=qe1x6DYNj8cmuducngKhKijZRivuXW9ENdmsbnUVee3sr1OZJ26XE+Vx2iih56yhDn
         mvh1/+MWmRzjttCYFjwIjWAGn3x/NgCdWhxfWS9hPelwhgrsClS7SY8yw8LYWsmN+fLr
         XX5G4Hk0AaIRDdb/XNPNnNe70ndj6br8ceZjF6AVyMNkaexllAYrkz+UKg1ce0XkkfTh
         EVLaf3sdd9jL5i1F98ro7XSvOPDlxaDGFWxF93i+z9LHR6GRsCxCHqmuZwtNOEQhadAK
         ATeD4wrVsK08c1gbmXIckO/wOvjMM+xTEDXQ2ktFfg4IXhGYKNpbeC6n8Na93DzTGrdh
         lmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682737065; x=1685329065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KWgSfBRX4/7Ituj2OvAS+wvcAoxKFvLr9noXKYmqF0=;
        b=WKcgBK8Kze4Xd34no2QQ6uGS5xn0QBYy1uLO4GOV+5a/ol30bRs9XDUjCyL838127f
         3TAOdC5N94x9licGY8uUS1PhKBXj7rK8oLMbpq7ZIWisKHvcSH9Z9JUsoSIkNlWO/BZd
         hvgIQoJG2/5eg6KY6C3go1RiVzZB/Gh0r1dKesSn6Q/vwXOYIzXGlMK+elrvi41oLu/T
         XvIyFGZ1166BVOUAQIFdiIpc7gQlcbhNq+2pu2AmQH9zcIZeN7pzg8g3Lku3dGn4UuG1
         l54qW45hfS7wJuWRuEhYD4lHRyrhfREYTa1APYmDE+siwIiLn0aMSCfwTSmWhljIMDSA
         fkXA==
X-Gm-Message-State: AC+VfDzm5hI6T32j7qxfz4Go3lOkGwbuN4Dcv7vzjvv/77SO6y2t7QFX
        SGU98adaYOGQzmmJgl+7qXg=
X-Google-Smtp-Source: ACHHUZ5hKNuG3+lGMBBMI9UZfGmHUBdYfDexhwTC921xD9e/LwzTr4ussOkGLZKqH2IhBWqgupsybA==
X-Received: by 2002:ad4:5ce7:0:b0:5e5:c00c:8189 with SMTP id iv7-20020ad45ce7000000b005e5c00c8189mr14011833qvb.10.1682737065031;
        Fri, 28 Apr 2023 19:57:45 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id n16-20020a0cdc90000000b005ef589381a8sm6840396qvk.52.2023.04.28.19.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 19:57:44 -0700 (PDT)
Message-ID: <637f3669-c6d8-0556-28aa-6599551f0849@gmail.com>
Date:   Fri, 28 Apr 2023 19:57:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230428112039.133978540@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2023 4:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.110-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
