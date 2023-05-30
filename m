Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6202716CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjE3SxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjE3SxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:53:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2BA7;
        Tue, 30 May 2023 11:53:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b050b75a1so302359385a.1;
        Tue, 30 May 2023 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472781; x=1688064781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RL9pdM2o2z5T2G6D8vKneXdh0c/zBkvXlO/Xd4J2Dvo=;
        b=DGgqnQd/dBiyyqsSxI+b2XTa+20cfxjVDJaDl2Epu6HDMH7RF4AeYJTD9iPfaUwL3w
         iAY5W7YZ9rivRl5OuGSRHcY6/yINZLmUEFlzhu9K02PMfLF67tj/gAOWMqMHqqgZXkDy
         /J81plLJ7DELb92OJxLfTMrCHnZ8Wg62yKwIMU4YOfITqdjChrgxsgHHMHjVDgPWbIfE
         x2inywZXeRdPh06LntO61d5faRcUgT3uTRCfgMW8avu7wrOiiYgNBQPGgJeA1qECtlKi
         b3D20uG/j0drXlLl1wAE9kGB7Z8ndbXCNpzpfvQLBpmwxN9EpHdxj9ldWFvjHaunRK9u
         8ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472781; x=1688064781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL9pdM2o2z5T2G6D8vKneXdh0c/zBkvXlO/Xd4J2Dvo=;
        b=ZTYjwVDvhwdF3iXB4jEtmwpZ/5I6DCnxk86S2RkTwEYcTEML8JTBs47jkdJssE9rgT
         DjwYx9Aw+U8ns/c+D6TtjhIfnwzUXDR3Wv+HoFD9WysORUXBDgEzhI5pciuyxzClz3CK
         LL5RqiLsRcAzSkVqXCRRLEmGKlQfZrXqsKBzFSe14VFvZVdkMwuWJtyyp52H95pZyM2N
         t5hylNIgXU1tQmTZhn3ATLf6+hRzaa/wrzrM1KQxSeOn9BeyRhQIWhKcD4eUgYKRx2gC
         AKX8/loiZRRwIo71h0a0oT3Q1yi6Z/eoBE/oRVIpEA/wJTYc97RkJNSiOEa/6jdclO/q
         FafA==
X-Gm-Message-State: AC+VfDxB5ahAy3wocF+fmTH+uLhdyzFVFzWlNu3eKxGoPYr1hm0eIDy3
        qzi07nwkGbcCs4DsQfk+COU=
X-Google-Smtp-Source: ACHHUZ6s76j5kRhXWMwfpodXJ9vyN0EYG6XWzpPvY+UVc5uwXrLtoAlo4bG9Ra7fznbwLOtrZ3SLvw==
X-Received: by 2002:a05:6214:c4c:b0:5e3:d150:3163 with SMTP id r12-20020a0562140c4c00b005e3d1503163mr3754919qvj.20.1685472781325;
        Tue, 30 May 2023 11:53:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f16-20020a05621400d000b006262d158ab9sm1343897qvs.124.2023.05.30.11.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 11:53:00 -0700 (PDT)
Message-ID: <904bcc86-71a0-021f-55cd-bbef94b13801@gmail.com>
Date:   Tue, 30 May 2023 11:52:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190828.358612414@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 12:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

