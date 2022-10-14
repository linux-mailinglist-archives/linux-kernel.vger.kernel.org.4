Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B205FF0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJNOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJNOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:51:51 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC9617C57A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:51:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q18so2612120ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmPYNAZyKnnwa+ukepIR2Z6PR5vn1ERX8lO7JMd5uLY=;
        b=aGucy2TnF+A2Omll/iMRIvyJLGJ1dclZF6D3iWjcuDmMyZDpbLkjWMv//YEiDJAWzi
         8pSPlVhPnQ1QJesjJIJ9c8J64t1US9jgALcvTiGj5Il7EElk0IwU1O0b06+0d94WYpOX
         8+EBt1MhQy0CQNH9VkIf4E4zFWy6Ubo/adBGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmPYNAZyKnnwa+ukepIR2Z6PR5vn1ERX8lO7JMd5uLY=;
        b=qaXgm0WDCXSGNlVxG8xRgbrExNFno4+pm0sEyk0XrcyUyaFeA1+mNOxx2IdaXdsbB2
         bOxSARtRPDDVT0r27KHkd44YbQ+zA1BOGQk3BZ6EiDSJlAuaB0rnCqaj3Qi1Nov2BW9q
         uGhv5SMx56m0JLHIjonoLZmPT7hf1nHs0LFetvU+pxlHL6S1fAtgNR/iAoPdfhfRDu+E
         YgQCawdTWCsB8f82KnB/37TOhyqCtCo6uXAWsWsJRH+45T4vRXhmdHW89cS9SiF/eMe7
         8GsbRfgxT3uTxRilMwZtaIvH7J/voKjBG43RF87eu7eg+d7SveyQUmoTQWTbQYKPMUVS
         zJPw==
X-Gm-Message-State: ACrzQf0g6UHkcUPHimk5kWJHlii00M1XpDpf0w2jEpbxqxyOI8cKQaZc
        fbt2GkpzenQPnlsU0bv82qWdRg==
X-Google-Smtp-Source: AMsMyM7GeOcqtQD7n3BYzmmFiRsHJ4LOntu9PPEgZG+3Ctz49UTpwxhBQI/dCpFJ5oVQsQrAmXgNDg==
X-Received: by 2002:a05:6e02:1605:b0:2fc:405a:d04d with SMTP id t5-20020a056e02160500b002fc405ad04dmr2605050ilu.320.1665759110121;
        Fri, 14 Oct 2022 07:51:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a71-20020a02944d000000b00363b5d4e701sm1171537jai.167.2022.10.14.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 07:51:49 -0700 (PDT)
Message-ID: <183d3125-1791-29d1-cf0d-ec5d1df8940c@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 08:51:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6.0 00/34] 6.0.2-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221013175146.507746257@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013175146.507746257@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 11:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.2-rc1.gz
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
