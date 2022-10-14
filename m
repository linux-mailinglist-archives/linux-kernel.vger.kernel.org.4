Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF15FF249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJNQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJNQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:33:48 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D001D555A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:33:45 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o65so4305639iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sk39sPjwjLClLOzHRsyhefSvJRjFMwjF/fKpEM/KKeo=;
        b=YfHqr2AEAy1qbadFsfaJUrlG0PA3W0Y3GaBiv5y7t+5Lg/HVwx7Z1C9BsFRBFS5bWS
         QqwzH8fRuxXHn/y47dorpake/X4m/Gi70hqdmA8sEeKryMGAyylxwdJhKo7eJWhlCL2z
         O8UHSiKPQYf6rl8ov0CyfPvEI5dh3b6G5L4a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk39sPjwjLClLOzHRsyhefSvJRjFMwjF/fKpEM/KKeo=;
        b=MVpqI0Ue9Kt7ms7jfTzw5p6kntjS3AINrvbzD7JKK13YD2nZHzrJjNE8V7ipUJK+1l
         QmaW66n/Im5Jp1APnNINblpUfGF7iFC1Doivbbvb07gUqsUKycp6zYCGVjzNqOShuGZK
         20wMhFQmlU6BmwIPxKXG0Miguq2xkqchTYi2mI4FPhQZwIr187NLxn/dNw4AiPIWnlgl
         lBqNkI1bUsumFlfyrqtaJo8IVqQ1gNSFF8bZ9ofObhMZlBibK0nLn5y9Z2g3lIwO4db9
         cHf1tDMq4/wjN+RSi5xOIG33usBV9gDafbbNMBpEHJJ1JBlItOvMp/vsRduJLypZVxMp
         UyJA==
X-Gm-Message-State: ACrzQf34DyIp1JcN7k2lJ9FNjSejnSEMqoLohnqdRKczFBcUK/rWqq9O
        7apzsovIj3s5sVwXRL/6H/j1Tg==
X-Google-Smtp-Source: AMsMyM4B0LFkRSo32YKuRV+1PSyClhFYcsDJjJapf3AYieYYSQ1o79KJidNFeUaJBsCPqOJVUBtX6w==
X-Received: by 2002:a05:6638:470d:b0:363:b953:3f18 with SMTP id cs13-20020a056638470d00b00363b9533f18mr3397005jab.116.1665765224468;
        Fri, 14 Oct 2022 09:33:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g18-20020a056602073200b006bb5af55ddfsm1074856iox.19.2022.10.14.09.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:33:44 -0700 (PDT)
Message-ID: <f944f720-1ba2-0b12-5369-3dca17b48be5@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 10:33:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.15 00/27] 5.15.74-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221013175143.518476113@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013175143.518476113@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.15.74 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.74-rc1.gz
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
