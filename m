Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4586C255C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCTXEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCTXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:04:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011052D16A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:04:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h83so6186347iof.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679353454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yUZjR/qMJXhLe/J3/juEcp+ow37U+EJGerSZ99l/M8=;
        b=M5xX1vVFGXpdmwonnZsBel68/KmGTna+nV1/sEkix5WjqyckVYhqzPt++KEvWoruWb
         b3jN1dk1o/dnO2+PJD4yydMG+ffei9JmdnSUeEqxY8+tHLnUWIUYN3D/1FPgmipPQUEC
         mhqR4rMO63F3EYiDiFPKy6KdADejymoPMfShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yUZjR/qMJXhLe/J3/juEcp+ow37U+EJGerSZ99l/M8=;
        b=poWlEcmJFuqkMWpzilSq5U5SNlnDKP7oEve5YCw0EUU9jGhmSICC2gHWQf6NFWa2nc
         QtTD8jMfUz9wHIy1CpcPGEzOUPeefYryLCTbk5P2duny6NT2X6Kl2ZlNSzURTcWy7Yik
         a0Sc9nm5KDkDSYE6VBluZpo2C8PXywFd7hE3/aH3fGRAqBvQbbEH9V5aUqhQmikelgrf
         nEc+7ksbieV4j1jf25ICD/+/NhB14L0tF5s16DD2TfOGjVvzVVe+MTf1WljmW27LLayH
         x3ZL+CqBf4fngv0q/PjFmifSozvXaoBfnaFv+OgJLYwdbjpOvMCsOtXAy5qcJ1f2KjWQ
         FokA==
X-Gm-Message-State: AO0yUKWPBlOVg3ihNbs3UHUczWP9ILlHNFQGkgypgEUce6MtOCHh5kDU
        Q1CN7i28UyqSvRIrbplSjLaafQ==
X-Google-Smtp-Source: AK7set8FRrJRIFI2f9vGCO2q/0xoYAKI0RO3PmBHifIG/3tMLnp2titgv9yXro8S4Zb6MB3lpk9kFQ==
X-Received: by 2002:a05:6602:2b95:b0:751:d1c9:92bc with SMTP id r21-20020a0566022b9500b00751d1c992bcmr639690iov.1.1679353454249;
        Mon, 20 Mar 2023 16:04:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c11-20020a023f4b000000b003c449a192cdsm3496941jaf.73.2023.03.20.16.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:04:14 -0700 (PDT)
Message-ID: <de25435c-8478-7d4b-a09f-26294168b729@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 17:04:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.1 000/198] 6.1.21-rc1 review
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
References: <20230320145507.420176832@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230320145507.420176832@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.21 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Mar 2023 14:54:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.21-rc1.gz
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
