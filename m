Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D29716E90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjE3UVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjE3UVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:21:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF168F7;
        Tue, 30 May 2023 13:21:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d24136663so3372556b3a.0;
        Tue, 30 May 2023 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685478068; x=1688070068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=of/5JX7VoIfv2vkTLNC734+oWn6zTGlkdNIC+/hQkxs=;
        b=YbF1y+09eGaHy2Xl3Ml8zXD0Azdj2fIUxummi4R9sae43co5UZJ5o6SAFb5FnXnDv2
         ci5trNLC0NwMjK2jgf3mOKrzILCOr3zKzwlL1FKL4LD0jiTLnJK7Kz7X5owrDFF+9Ida
         9BiU+PsPOcrbbEwhU14LBf1b1YcEBx4rEgIzUIfoCAtayRN8v6YHWFjUZbV5yCAKS2E5
         2yzLXHTSWPR5ZfGvv8K1UlQg9Oa0eFqCoXQz87nHMxOKFCS5DZw9A8pbx/X7iwqSNTDb
         1P8YCWI9cqJp7AvLlNr7IsND8MRXSqZB/7KqkCttiHtstpRCAdt5iVBV4Co3wdHMFxds
         FlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685478068; x=1688070068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=of/5JX7VoIfv2vkTLNC734+oWn6zTGlkdNIC+/hQkxs=;
        b=I9+QFWFIClNWC/lwAIZnE1Gd/HmY6px/QO15BPYy2yUkIlenu4oJx1Y8UPU62kMzpt
         HZPJj4HWgyMcHmZ0GWfIPxb1H8X68nYBEZWHVU6eLBRAkfAZOV1mpOyBWI0i6ZB7d7pO
         lAY14Q5vk+y8SZflxmwtKIB5mCIrlcOrVnw8fPNiEN7a85mb05H2EA7mNP29wKqB3Tpx
         EITicPvoMRyGwdSYibcnCRDT631sgRDl1XYBHUj8ov6CVuBYB3J4RjX3+RGkMWZ9MSOR
         IqMzOK4tMeKbMXlvYrLKN+fpeVqau40YnsFeoNn9OzUu3c2zEnsVK3w0Yyi7IUOsAK/E
         t+AA==
X-Gm-Message-State: AC+VfDyA7tz/OeOc5TW7uSSbOvvMlm+c0OMhWLlPekU0CLCE21w8MplU
        Mi4E+h7pCLB2JgwSvG5MRAHGfeyMV9Dddg==
X-Google-Smtp-Source: ACHHUZ7jRcRh4P3u2z+95acFIKMHna4RlASa/Q0HdpnihncQw9jnZvn54oSpx187GKhPpaYM2PW9fg==
X-Received: by 2002:a17:903:1110:b0:1b0:2658:daf7 with SMTP id n16-20020a170903111000b001b02658daf7mr4010622plh.36.1685478068122;
        Tue, 30 May 2023 13:21:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id iy11-20020a170903130b00b001afba6edc8esm5645126plb.166.2023.05.30.13.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 13:21:07 -0700 (PDT)
Message-ID: <99bac91c-eb98-91f0-cfb5-c198b1c747db@gmail.com>
Date:   Tue, 30 May 2023 13:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190836.161231414@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
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

On 5/28/23 12:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

if there is a need for a rc2, mind picking up:

https://lore.kernel.org/lkml/20230530201955.848176-1-florian.fainelli@broadcom.com/T/#u

Thanks!
-- 
Florian

