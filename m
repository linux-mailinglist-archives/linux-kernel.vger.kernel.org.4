Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A8170CC07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjEVVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjEVVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:13:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271249D;
        Mon, 22 May 2023 14:13:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75788255892so321541585a.0;
        Mon, 22 May 2023 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684790002; x=1687382002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pirlIKRk0YFkFPvt3TGZITFMYEgVbd3UZflYXO33MyY=;
        b=eX4x1LueFEmA7fupeRW3aT2J6as332T4g+to1tbNqe6efJilCJQ+/hSbaYDsNM8xPS
         YARrBSDq11eIK+Qal84odTy8SLnrxHErlCjmi8e5coiq85O24BwaLumCK3phr42OFpFK
         P2mi9FEkusGHgiYWAp4okeQehm73FfB2un2iQAgA2qy1eYISj1LOJsrBdU4wqQsFm6RU
         1UBTwEwWNBkAWHF/rhxzuIwqan/JrTM/KZiuJMnj8a2eNZaNay/QWIaryOTEbD52tjQ2
         S5tbvCpyovzNJL6W6k6E0O50/yhD4+DecxRR54a42zqStBzEGZjgs7Zh3oZ12sTP8gV0
         rTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684790002; x=1687382002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pirlIKRk0YFkFPvt3TGZITFMYEgVbd3UZflYXO33MyY=;
        b=E34tPS2RcXxBYDh/+/JhZkGD9f+a2nFcT309VkLCHzIQEVNyh52WvMx1QDCFr/aonq
         eM9niQuCvlDcIDZxAjq3UNkJUwttrRTuKq3EmE3T07IPl3fxS35rH9CZme4TnPhVUtxA
         jMRmT92maBFOx3iWgvmqXqP4lfNqEBzZHNEZkFvOybBrSDKEnYlTik5LKAn/4fHv5ehf
         YAtWDgD5e6LfzIysjR+p4AKJdMbYlW5RiWMqGVyYu9kEDmQH1gmDFQwLCLvsHD6rJxgi
         /kcUNg2iIX3OdboPX7j56mcTBRBCqyoDpNdQhXOLxVsH11E0LMLaHU2lz2BquBQ2s0da
         wJIw==
X-Gm-Message-State: AC+VfDznsO/S3+160KBjySyr5LaCp19m1jXjgjOuu9KaqkjyNgn/Z68c
        pvVSUm6DbflU6twrGrUmURE=
X-Google-Smtp-Source: ACHHUZ6othM3EBxe/OnAH9E+ScL6NySoHr1dsxLW5fztmVa8magR6kocLfM+wXp7RxgptIxxVhrbtw==
X-Received: by 2002:ac8:4e94:0:b0:3ef:231c:cee7 with SMTP id 20-20020ac84e94000000b003ef231ccee7mr20339879qtp.7.1684790002192;
        Mon, 22 May 2023 14:13:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d17-20020ac847d1000000b003f38ae9e5cesm2359829qtr.33.2023.05.22.14.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 14:13:08 -0700 (PDT)
Message-ID: <c35411bf-4fbf-a39f-19a6-7a8949626f6d@gmail.com>
Date:   Mon, 22 May 2023 14:13:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230522190405.880733338@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
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

On 5/22/23 12:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

We would also need this patch from upstream to be backported into the 
stable-6.1.y queue to avoid:

[    0.001228] Early cacheinfo failed, ret = -22

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3522340199cc060b70f0094e3039bdb43c3f6ee1

Thanks!
-- 
Florian

