Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E672742E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjFHBUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjFHBUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:20:21 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF75269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:20:20 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-33c20462fa3so3406485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686187220; x=1688779220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ztIMjiY1892+uWC+MiOMXc3d3Q0L0tPjie1ITuSUPk=;
        b=cS1oyTIu1iEoMyDNP1M4EtW40MAfhRyvTeMko0nIXLIDFIjgf2I1Il936iRHzEDiS+
         qcLiC985xeiz24VCft/PGoqxcIHck1RHIR9xAHo2+mdQ6swmf19Zb4qFJ6PrKKRED60t
         tdnptwJBthWqJtbfoFQ4TH6wCBCgXpqvw9rqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187220; x=1688779220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ztIMjiY1892+uWC+MiOMXc3d3Q0L0tPjie1ITuSUPk=;
        b=VyMtswKEK4XVGfFNOOBQpjVW6gz+1APc0hIsStATFdaOZoTbU2gG6QJrKj76rkgx6F
         9ZanpaNXwgSWVpT/SZ6cs6nZNb4ZZeKf/p+a/7+CWeHxUeNkDIPqs5WJukkc6wbCV0WF
         b0VYuxixC08OH95V8BFBa1usOOgOpxo3zg3pUur31AgAylDaEfdYZsNzsXHAgLw9raQR
         +WbGU+rTdBB3bzxj4tFn4MGhUHN6i/3IMj72Vq/7Oe5ZcHKT0g932BY5aV34+NkFOtJ3
         f8RqH0oDmhVmna+iArGo+vA0yM6u1OVvTlmnoQH+q8vsaNqxoFe5F6ulguKmQrpUmw5K
         kqNw==
X-Gm-Message-State: AC+VfDx39QHIptSBYfUUoMB+uEUct2+a20ANEzG7gI5eAkmIMtd2LGEP
        xcwhZSNlq28Dd1RA4e2RWJ1IkItTwc8fVNUTEnE=
X-Google-Smtp-Source: ACHHUZ777zOZxFcl7hbAZzXrEVfFIDPhy3HgFhE84piCrixW1K29KA/1MxoF4PYQeD5fgQZ9PNBYnw==
X-Received: by 2002:a6b:5f1c:0:b0:77a:b7b7:acfc with SMTP id t28-20020a6b5f1c000000b0077ab7b7acfcmr2998161iob.1.1686187219862;
        Wed, 07 Jun 2023 18:20:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i3-20020a02c603000000b0041a9022c3dasm3726523jan.118.2023.06.07.18.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 18:20:19 -0700 (PDT)
Message-ID: <f531db6b-d8a7-031b-d457-2cffc41c7857@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 19:20:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/286] 6.3.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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

