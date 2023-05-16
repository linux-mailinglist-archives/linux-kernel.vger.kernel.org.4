Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575CF7042E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEPB1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjEPB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:27:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B119BD
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:27:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-334d0f0d537so3962455ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200461; x=1686792461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mfy440XZZquVybeHeN5/Vllk8Tzfg+uX4nOa1McqWU=;
        b=ekmB/8vNU3QSpAIUMl1+mxhdwsW26ZSwYDTkONfimoIEUsjtOpuCYQ1FPhlnUhhCkH
         ImSsEd+Ou2M11vgm32Wry9+RuA2dZczprNZpRS0VX3MivDgpWJiDdiUmLSGPO9AwFCrG
         OwD1SXUsq7n0lNP8qhZqZiP2E0sKx6BbnFe0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200461; x=1686792461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mfy440XZZquVybeHeN5/Vllk8Tzfg+uX4nOa1McqWU=;
        b=IHgHiv6iCNPxnNKERLGQU2LLJSWtvDVXL0jwL+WDIiYp0sQ/A3SY1B7n+KAIxeCkhs
         gMg7MBOFJ+m2DYKc4mZsQTMzUXQWYpIvv/t3tV6Sqh0HbLKW8PdIHiRkWyK8cMicopUn
         zACtljjjpeA1iKFcAV1jE9QZFYGIOtJfSF/jp/IUHz9nGL/Qt40w3+4xAU5dgy+KIgwJ
         XSEINCQwNSQ296gCqBZTzHlxBU9A7RlNKG+hms9myFrby9YZH5O8PjD/7qnHj+iW7Hxe
         0rUeOhTDV3BKuudJoNbYjWWOBKtHea3zYED2KyqGzPYf9scTKOvs6K3B2Q21RVJ1+toq
         5J0A==
X-Gm-Message-State: AC+VfDyfxHeqEsOpapGloxEjYv0HH8g3/RZ1ycjTpQi5kG8bLUjJnF+9
        i2sLLbOyUgF5f0GKyRbzckG04w==
X-Google-Smtp-Source: ACHHUZ6YsqXHXAoLYymvp8ew3qN8DsNWYSQtBStpfN7wcnXAd3ofkE8VZPdu36HjpLC5+HqRr/1okw==
X-Received: by 2002:a05:6e02:178a:b0:325:f635:26c5 with SMTP id y10-20020a056e02178a00b00325f63526c5mr776044ilu.3.1684200461436;
        Mon, 15 May 2023 18:27:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z68-20020a0293ca000000b004183a18ca45sm3434541jah.123.2023.05.15.18.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:27:41 -0700 (PDT)
Message-ID: <f84238b8-1530-fd1d-43c0-98942a413489@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:27:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 000/134] 5.15.112-rc1 review
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
References: <20230515161702.887638251@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.112-rc1.gz
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
