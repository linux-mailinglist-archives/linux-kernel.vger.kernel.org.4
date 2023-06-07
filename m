Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3F872737E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjFGX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjFGX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:56:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C962682;
        Wed,  7 Jun 2023 16:55:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d54faa03eso572998485a.1;
        Wed, 07 Jun 2023 16:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686182155; x=1688774155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYhFANAzyXu9CA9iibCEU+U1cngp0/OUke1pKcFWOtc=;
        b=heQ4IDcAnFQZvPRwgvKliopuoKlTnUvSTXrz7RNjydYPzgKZqCQUW+bwrPVWwSIVd6
         tpv/Kr5ROkPrkvhov3E/oYNeHtyBxZsxu2iRCokTHNHz9lRxnAbYS441rC/sttU6BTC6
         kemG8+mwqfqyYhrU0N0ofrXBFT+OTrau4MRoT5PZSs851LCA3RjjAgjHxLjB1GgVQgHv
         NYmCjr1UkDsCF4D1BvAO/Gl/6pvCV5MXWgVRGabPZeesFnS092eTwkxA2ihxX0dpoJUd
         oer0i377g+OurlGjGv/GvdMvY8QrTyXTJn+iyNgteJxVL9SOrucseeJibMCmwZdAUIwA
         /w/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686182155; x=1688774155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYhFANAzyXu9CA9iibCEU+U1cngp0/OUke1pKcFWOtc=;
        b=LA+lzFCt+yQ7Ua9TTh/Zau5K0tnZQgw5beuKNf8j9FZYOhof1K3xgl15ZkvhSncKZ/
         /ipNOnebUmsfuk95woa6VdmGx/jHuxXx/AslxJS1J/c2yxQxEYLea7+QTj0c6KiiBOQx
         tS0dZhkegge2lnEJa9inI4+GZifdafbUUyhMNo+Vr1W07pDwMJVZAeLmRYZ58f5Swr/y
         VScVHySAhCZ81z+tGMHNP79YxQnT/xOV2rH0mGh8SCvGFKgz58wyNnkUprTumg+WLTSl
         pF2s/bCo8Ba/Nobp3ea2rTKlfQC7MseOCp1Vh2iflCYHUxAAWlD7BnM3YKox81ZzLryJ
         lM8w==
X-Gm-Message-State: AC+VfDyWxgVfxKawQhNF9kAvldwmlXXLbb9BRQ52eGZblZjJryxEzMi1
        u4j61iRm8P+HEcmGJqvzxApYlfnhj2Ok4Q==
X-Google-Smtp-Source: ACHHUZ4qwuDixFk4U1d7Gyrg9n/EKGFw4ckTEhu/S2awuI5QH6bsKsHEGKy6w2y2KKEEgR+F6g2c7A==
X-Received: by 2002:a05:620a:8082:b0:75e:680f:857b with SMTP id ef2-20020a05620a808200b0075e680f857bmr3845741qkb.73.1686182155054;
        Wed, 07 Jun 2023 16:55:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u10-20020ae9c00a000000b007593bf6e345sm229163qkk.113.2023.06.07.16.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:55:54 -0700 (PDT)
Message-ID: <5d0364f2-8525-2d6d-ddc9-409c32b8147c@gmail.com>
Date:   Wed, 7 Jun 2023 16:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200903.652580797@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
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

On 6/7/23 13:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tseted on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

