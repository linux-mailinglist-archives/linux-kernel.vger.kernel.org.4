Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B626FCC86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjEIRS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEIRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:18:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CBE70;
        Tue,  9 May 2023 10:18:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f38e1142d0so14635831cf.2;
        Tue, 09 May 2023 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683652705; x=1686244705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVBbbB0GLPur6nb8BO1G5j4FrYFhbeRvMJQv2Lu3H0c=;
        b=r1h3BOoj35Me96v3doCTbYqW9CU9k5NRI42HMg/sFrmebAnr/K/iyvDPg4PO0umWXt
         +yaXnnvdzLAUO0wGsGh7AGtvzwVBNop8YVEJGU2w+EKRHZ1out5p9Np1o3Txnvp3p0VK
         Ay0PA39d3RRy03s2XS14MYe8r+eJ9C3tgKQilQIlLKFxApkupOBPMHfMrwCo356h02Sr
         xqN6k5sXp9izPD6sRd95qG/jQ4K0hV+d9FScIszYaNuIDebHs3LSHYPCA0cEF2uoTUOy
         nKqsN3jtuHXw6DOLZ3vD8GuvKmhNZ4s1UeJfV8w7jn68zQ1YD12pvetOJIKE5+fLr+lS
         zXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683652705; x=1686244705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVBbbB0GLPur6nb8BO1G5j4FrYFhbeRvMJQv2Lu3H0c=;
        b=bhOVKLtcM9k/BvNQfQzOD2dm5FKEXw1nRcM6m2I3lg3Nw9Nw/xRmEglW0voZuRZOh+
         9xzt7MgKAOYjSvAMnBE7jMBrVSCUE1PEV4CaDwZtwjIkws95iqr3r2HNx+enwAFDzEmo
         0K2w5TCecAvDQklbPxAX6XL1isIOnDwh/1eObdjgcDP3OwVsG3gPyiplRz5pPdlTZ770
         f9J4qhyaGiXMaXesfrK8padW8civYGJO/usEuJamPXPdc7PAsMF7VFVC8agb+41o4BkB
         ksSkoF8qLMJGxncjkRpZ+kEOiuMUB4zU1/KswgmVugP1hwtyD/IrpnrLoF49n9aY1YXc
         7z5Q==
X-Gm-Message-State: AC+VfDz6kjF2VJarD3PMgRBt1+xaUOrNXr/6lKUZOSIoQZK/7AsYBtHZ
        +K0q0HyZzeT7/gStPeh6HB0=
X-Google-Smtp-Source: ACHHUZ5SpdGSyrpJy6yOhe77d44bAgI5Hwu7cBtxx7aYFRM+x1Evag7WZNyyD/Ry/uq8lvt6/u7yYw==
X-Received: by 2002:a05:622a:1353:b0:3ea:bac1:a5a0 with SMTP id w19-20020a05622a135300b003eabac1a5a0mr21342715qtk.37.1683652704712;
        Tue, 09 May 2023 10:18:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05620a144200b0074df2ac52f8sm3416388qkl.21.2023.05.09.10.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:18:24 -0700 (PDT)
Message-ID: <010cbf15-676f-e6f2-e750-ee4e9e561f32@gmail.com>
Date:   Tue, 9 May 2023 10:18:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230509030653.039732630@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 20:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.28-rc2.gz
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
-- 
Florian

