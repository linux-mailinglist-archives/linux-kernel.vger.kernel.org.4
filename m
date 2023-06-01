Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA1719F56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjFAOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjFAOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:12:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3639186
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:12:44 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6af713338ccso757404a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628764; x=1688220764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pGewkI3ZGhs7NmIEmWJMKJtAyCliT7h0BVcktsJwU3o=;
        b=iLrGKN6wIAPT9VVUhQldt4cxeaEohbI3mrUxqNSXhhr2+olaCXGHGoXXI5YMjbDm5/
         l5cS0i7lU5vrj8y3EhX87F/ubTpnrEk5/NjdrLdlZtTVPGGANkVz9hLdBLU7I3lVbRHS
         aWnjfKhtA8uD7/hVWFMo7JN+iMtB7RgB1maLxPHR/TaZs9FzNIJrG+BJSXUlZwFM15of
         9eccft+2iGMn8SaEcqR2360vFutF1hMMiTV11K6/w66te4YQo64OsCir4ihzPRWuziYO
         rIjfd/kA4SXGjfIHPalzJP1pc4jpbMlcYWq7JmeQEr+9XeScn/KMdpBbEtFHKjpXnSat
         Hm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628764; x=1688220764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGewkI3ZGhs7NmIEmWJMKJtAyCliT7h0BVcktsJwU3o=;
        b=Pdo2ZrS1ChgC3b45MHO05xXVfNZsamOu/gGmCn5/V7nrYZuBPRGHAFpBGi+ShXXvvq
         FE/WgqqtxuMKezoy7D+8fADHq3i2FlJO2AXjVSU+2hczNsvWFyAd8EWvs88D8wGOtEeR
         YN/GxbzRKUS7x0JlJVqAKl2UwU9FcTh+KK0qrM+8zE4VtyOfpi+DzJk/J9pn+dxGIayz
         I0dK5/YXeVlHWvKysxtkdqLJdBQgJfb+IKW+hsr5835tEydxjKuFPegInyrCeZcxTwlV
         NGaMuMiq3pkLn8NBXk+KnAqI2iMdqXMRlKYmQxzhiJVMpEB4KNDj5YoR+PhxDX3f3GOs
         FzQw==
X-Gm-Message-State: AC+VfDzgCYMnGNq9q3kELBgZAzbnVJlIdM31HOrNRmH8yCUITHL+r6s5
        EOWE5YpMTCCrGr10gZdvTAPwRLWNBZrymm1g1AZRig==
X-Google-Smtp-Source: ACHHUZ4wquHJpPIxqvZcCQ0uKolewssm+RvOtOWUpV4z+7UxM0U9tgUV5c7HdMpqTP2Z1ClfiwF8GrWs42/u2xrYFnI=
X-Received: by 2002:a05:6358:4322:b0:123:3346:593e with SMTP id
 r34-20020a056358432200b001233346593emr3701190rwc.6.1685628763883; Thu, 01 Jun
 2023 07:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230601131936.699199833@linuxfoundation.org>
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Jun 2023 19:42:32 +0530
Message-ID: <CA+G9fYt9d+bZwao0ia_7kp1maKLWepci6R4gUnb_FN2OjCSjyg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/42] 5.15.115-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 18:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following build errors noticed on 6.1 and 5.15.

drivers/dma/at_xdmac.c: In function 'atmel_xdmac_resume':
drivers/dma/at_xdmac.c:2049:9: error: implicit declaration of function
'pm_runtime_get_noresume' [-Werror=implicit-function-declaration]
 2049 |         pm_runtime_get_noresume(atxdmac->dev);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
drivers/dma/at_xdmac.c:2049:40: error: 'struct at_xdmac' has no member
named 'dev'
 2049 |         pm_runtime_get_noresume(atxdmac->dev);
      |                                        ^~
cc1: some warnings being treated as errors

reported link:
https://lore.kernel.org/stable/CA+G9fYswtPyrYJbwcGFhc5o7mkRmWZEWCCeSjmR64M+N-odQhQ@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org
