Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274435EB4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIZWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIZWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:48:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132EA3D45
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:48:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y141so6473400iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=38Z7giVIplZZJ1lV21jaV5dNmGNLpaVl2kG7pznFZuE=;
        b=hiM2Vh8VRTuk5sv5LPVPIQ6uIBcpDQT7Tesiukm9A5qJZ6GILd9k5pK8eVQuVSt+Pb
         sDnoFDfNYvgM5sHQMa1oQi7WT7dHL9iX7m7iPH1SwDnEYm5G7+gMSln+fsvQuZajcbXA
         IZ11FrKU7mtXvGouTS/n8rmwIr3G02/08/9Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=38Z7giVIplZZJ1lV21jaV5dNmGNLpaVl2kG7pznFZuE=;
        b=ffUcXrocOOyp/FXQFOzHzkz8DJvFI2fahQC6aWDpa7ol/emlHho7qC/EsOPoD5CDZS
         iJ5FhrceC9ufEjg0a1o08oMGR47L6/CbIuC8cVRnb1u7XdGUuwMGlQaH9R0yW1OTLipq
         hStj30kTASunOo59Yz06yfnk+qjNQZRxXdsb7ERmUGTRgSmXoj0QRgqbNoMq8rqPGKHI
         FYPWxw4BCsESARr/4FCMcpfrfN7uZDXl7l0w/uJQZNmRuAE79H2gT2s4xA1gobaZ1Oi0
         heHzXq1tIZQ/chnWlnHcAUkPSr9H1TtS0O+o4TZbkFAWaRFXfgS/AlyRE2H0gjO534wi
         9iJw==
X-Gm-Message-State: ACrzQf37FhnKyUgDBuk+T1mfvPq19l0q5w5k0K3qitEmWu59qwumHgWf
        C9EmvNq3A0Igv5XsxaJPeiz+cNDj2PM5IQ==
X-Google-Smtp-Source: AMsMyM4IhDkSEwyeFjG3JALuMlJh60lExcdrX3D2A9eN9EYItnafYMugT87y+lRaTX2EFdCAwYYwCg==
X-Received: by 2002:a05:6638:3398:b0:35a:3da9:fc7a with SMTP id h24-20020a056638339800b0035a3da9fc7amr12976259jav.87.1664232519411;
        Mon, 26 Sep 2022 15:48:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u24-20020a02c958000000b00356744215f6sm7644730jao.47.2022.09.26.15.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 15:48:38 -0700 (PDT)
Message-ID: <804c6db2-a541-657a-a84d-271bd6e95d19@linuxfoundation.org>
Date:   Mon, 26 Sep 2022 16:48:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.15 000/148] 5.15.71-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220926100756.074519146@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220926100756.074519146@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 04:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.71 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Sep 2022 10:07:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.71-rc1.gz
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
