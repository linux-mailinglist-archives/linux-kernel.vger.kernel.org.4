Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F074174E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjF1RhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF1RhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DFC1FFA;
        Wed, 28 Jun 2023 10:36:59 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b5f362f4beso5560191a34.2;
        Wed, 28 Jun 2023 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687973818; x=1690565818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4nyR4pSQ1cteEH5hMJQ2lOpFk/1iVCMplDzpJI/rgU=;
        b=HybE2rOXJeX6a7CJ3taZARLGZRRck4BEmCG+kDi3YXvLZOKUe5uot0NEyl/MeWNeeW
         +QLyNO+1/jfnCZNLx0sMuEAlFwKPmEO7aEyA+rWkRxyAUJYhK1omBC9V0jWzQ1WhhhBQ
         XR4avZgKQAAVYHwa9rAQoMHzd0jpAxmvST1iWpxr7seRaE0PuCcAdl5d40f+QUzPFmJj
         XVOacFs3Yui7ogpDa2Y1h1yQ197nCl8g2vnvgTq4QxCqwLBIa+0ignDc5G/GW8qt6D2/
         JK8WeVdo5occXkAu0Ud9BrDfGYXZHIL0YwOGbcxa2exL/+qexqcq+p6yEEeP9Px5nLVW
         X9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973818; x=1690565818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4nyR4pSQ1cteEH5hMJQ2lOpFk/1iVCMplDzpJI/rgU=;
        b=PRjEGHAZZD2+3aCbYID7UOlJEZp+pmYWaQtLk2qp1dvr7k0VhNi+xD7+ksSrIM6e8C
         fHo03z564WgEW4IL37/7j4KN4k4pmXaAFIByJzvjRmkJeNyZuQ8wYTGYd9vFpwlo/wyf
         eDIv0PZHxUjdYbek7l1aMEZfzNHTKzIYSBUp3U3z2ISSE8csCtHY7/uGQQ4GnP3dKmiv
         7mCz6I/Rsfc4feXiMOR9odTNux5Su4S6V1Gk5KZeMz5noP/U4oJTi3+pQo+X3uul8PAD
         nqXVv0pGQOS1Qk7Y2T8KoZ+bgC09Fis6eYndvO6rj6qPOVSrhLeiljGzOvGWCsTgwpvS
         pSvw==
X-Gm-Message-State: AC+VfDzQdZXT9WhxFu5aFbUX3zn0V+mPgGDunRafHW6IRK2Gacp1VDV+
        AZQRt5+vMGg4TL64ZtqL+tlHZy2HasqkM96xfXU=
X-Google-Smtp-Source: ACHHUZ40l7rmNzki0dFjuYCz9aKuE4ayaRBINwCHQepH9gXpXMG1yQ2RY979sUBcI0v20KKd55sfoWty+P/YvIq57GU=
X-Received: by 2002:a05:6830:2089:b0:6b8:6a83:2b17 with SMTP id
 y9-20020a056830208900b006b86a832b17mr5354604otq.33.1687973818470; Wed, 28 Jun
 2023 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180800.476539630@linuxfoundation.org>
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 28 Jun 2023 10:36:47 -0700
Message-ID: <CAJq+SaAjMMsaVmFar8ON2UZmH0qEt=ffCxeJzij-9X8zOsw0fA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
