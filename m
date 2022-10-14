Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B575FF134
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJNPXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJNPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:23:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A421BE92D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:23:15 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id q11so2673163ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpyWMdE8YA7ElrvMEgG6lqITIjvsFxbpQdJMs8VogKg=;
        b=SKV2N/aIFh4a8y8v4oFgwTySgtHTUcIKdQr6lpjwYtE4/jcc0LlJ541JtoecXLKcJ8
         NjTQQE3I6iTTzixKPyLY6W9PUnhOdUPwfI24WnVMBt8Q2YAFOFu/aSMz4WdrO2hfQTqE
         yzNlwou85EgxsKm6iyWuE9Xjabji6WEMkVpc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpyWMdE8YA7ElrvMEgG6lqITIjvsFxbpQdJMs8VogKg=;
        b=SakdopOqg7cEKaAF8Er0CRwn03umTDm0Mc1eXkyWPDg+FRUyGrm9Vv/54T3ssq8Hae
         eS0QRw0yaeKbDVamQL0imHexpxhPQQjeHOfhBjOiCiPKJbaJ+d2R9QXHb9cEW67a11zd
         eBGKEarznnYHKkbJ1FOG4i1K5MunwpkL5c3p2zqtod3iF5zA8r//0pY47CyJmLKhFet1
         IvpIwMwadmVD857l2gQYQXPN4WApgZo6Fqaw+RVoHfyoGEC2lDWFhsPSA9y+btBYKulg
         uSexxPgRhWRuvA3XekWJk/agmbgLf5K0/Rlf4dzQ/CkX2I/GLSAcNE1hf+9R0UBytEK2
         A7wQ==
X-Gm-Message-State: ACrzQf2xIZpSYVjHAujsMfd73DiGhc/TNI+VGi2dyzYfmFBRawh5umWe
        hAA7CIYhPw3IMhtRGQMCfoAFdKass2hQNg==
X-Google-Smtp-Source: AMsMyM6U6qZAkMWjvlBr8A9pVSYj8yeSrpLaQxZdU4YqTgnPnacwtWl35ATI1Tox24VlZb9QwVbxyw==
X-Received: by 2002:a05:6e02:219d:b0:2fa:629f:ed0a with SMTP id j29-20020a056e02219d00b002fa629fed0amr2890124ila.76.1665760951558;
        Fri, 14 Oct 2022 08:22:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c1-20020a056e020cc100b002f6028e31cesm930404ilj.61.2022.10.14.08.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 08:22:31 -0700 (PDT)
Message-ID: <fe5636d5-42d9-e64e-35d0-ee390e15116f@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 09:22:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.19 00/33] 5.19.16-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221013175145.236739253@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013175145.236739253@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.19.16 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
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
