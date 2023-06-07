Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F6727174
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjFGWUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjFGWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:19:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591B526A9;
        Wed,  7 Jun 2023 15:19:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9aa383527so27970361cf.1;
        Wed, 07 Jun 2023 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176350; x=1688768350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIgA+P7f4yCi2//4vLetDTH19rWaTG6QenjxMKj5UEM=;
        b=gz/Avg2DZa0mkWMnclQQHqpjltVHceBf4YG1kLo2+ktQ5UXiVXN8rg5SGNL7Z9KzqX
         4+waSR2CALIN7sFwAkASQxwAXr+a2PfHKRkcUWPq1PwQ3nG4s1hMMXVcq/5w9IzkvcJT
         Ykgsx4zEHAUZH36A8xQG8bSAzu1n9G0BxfEWHDgAXPoc/O9ZU7mocG77K4SVNiK5eUXE
         lzs1jJp4brDGhaK5KpoYS/8nB16YFtgMwCGFF4cnlp+QqLV1MlACmw4V52lBhMDLCvPr
         7ai/Aj440WFYMvIIsGyBWVXsc8D4X7AyXM3VS66daVu6/r82xaZLgcrL3eosXB/Yh+Q6
         Y4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176350; x=1688768350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIgA+P7f4yCi2//4vLetDTH19rWaTG6QenjxMKj5UEM=;
        b=aG77ULoF7hZBpCix5cp1jJbsqyqM54x6Uq6jwbYnKGpb/S5X9FaZ1hDYRYF0KJWFqn
         ut057U2LL1NY5N0ypixjyR5oYdV9MORD6s7JIiVPMUw2AbXJyi7pf0U84gZeUATRdP+B
         PjBeP7MfsQM6DvV49nkhIatQ8S6rfqr7yQ4+4GpC/kcWf60jnVvs3QsoN1MvVPS1XKRn
         ruxl1421V+Zzafbq0v2CLauztqNuWxQH0V3xLYJuKGmoFB0b2BUlJgOGu7O0653GNhHu
         lqg5J70UVpoRJbIGhPWHHdsyRN46oS1d5o/2wqvLbEeSb7uSXY3y19Mtt8a9bhoaUCRl
         R5Ig==
X-Gm-Message-State: AC+VfDzLHBBl+K+PsdL8k2B78WLBeYJqUUx1OGVF8SMJR/H+djs3pM48
        pefQ9KK7t8RuxtXZsZj+rTk0ve+FVn8q0A==
X-Google-Smtp-Source: ACHHUZ6rHF7ySirc4pbFlDouMFKi3e2FuMyqXAfP00bgd0iRloaj39fFZFnIWrwyOq6XQzJ5j6BD6Q==
X-Received: by 2002:ac8:7f54:0:b0:3f4:dec2:76c3 with SMTP id g20-20020ac87f54000000b003f4dec276c3mr5780582qtk.22.1686176349641;
        Wed, 07 Jun 2023 15:19:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fg21-20020a05622a581500b003e69c51cf53sm230151qtb.72.2023.06.07.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 15:19:09 -0700 (PDT)
Message-ID: <202b6f78-c43c-65f2-01ce-83406ea04260@gmail.com>
Date:   Wed, 7 Jun 2023 15:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230607200900.195572674@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

