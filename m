Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDB716A59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjE3RBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjE3RB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:01:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B101BC;
        Tue, 30 May 2023 10:01:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so1384501a91.2;
        Tue, 30 May 2023 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685466041; x=1688058041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0qR7smAkK4kDLopfJWgEbFX/81Ri845pzZXPCnDXIM=;
        b=TlQB0g+aA3Uzr8Ge+7dBgVQube+GQqQ+9O945+kHFjPAmP1pKvggR6ejjw64IuOnho
         Xt/vuMKzO80foYf1HHi05M/aZdyM6g69fVgvYHHyYyEXPYZknDHr0nOAyVHana2fRLZD
         ffMdVtAs0xmYahUI+rsVO6ZABNzFxqY/KSmrupxV83cJPtFa8l2Pa2pDd1Z6dtEbpSEe
         rKyeoQgo30Vlkudh6c2qaP4GXalR6TR7+eSXoaYr16m6LZPDPKSRFzasZBGX0CZhk+Ru
         +BtGlLBJ2GWQJM1JB6X13jCvk0P9AvcEjyaa+di8IejClb3JZu2qK9rVOtTzH5apNAWe
         fy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466041; x=1688058041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0qR7smAkK4kDLopfJWgEbFX/81Ri845pzZXPCnDXIM=;
        b=EkectcQXOhpaZ5k/EM3Gi3E7z/KbHayHakfDlBSYEaUSDxKDOTTD0IClmMvFJOoymF
         w4ArOcRL/iXxc1VRsm2AEG5bjtQmuKjQMV7Ibzdgr3+AHnO7jldDSbBbyuJhNR5kqsTG
         fG2JX3Bl5bUlqNX3n4j5MMC+k5D55G29whJCd38Sd2tgS7tB1OFrmPvVf2/XIxj8LyhS
         WE4yoMJusP+jcusA52vJ/4O4qi7nbdmb1ttx6LNQxh6HHO/7tXZCYLgAQ6V701YxXAqV
         5nxvo6gp9UuynDuSXd1Xp7hS5epcab0NnJFt7Mcf6aqLo/TeAP7yWSJhy3hglA8cGf0s
         bmiA==
X-Gm-Message-State: AC+VfDyk9v5BwYSYPRwNQqsrchyL/dzfgThn3TIqLsTr9Gte5cWj0IRv
        kiXgKzP8qtHvVRX9b4EvBNCPoHOUrtSJf0Nr128=
X-Google-Smtp-Source: ACHHUZ429R5dVpOqWe0cVfpWG/0kSCoroolR1a8nyQU1biaJEVIrOT2mzmXEFLwW/GtirmmkddG1uovcBMBYvSa5LfU=
X-Received: by 2002:a17:90b:3715:b0:255:75e5:b456 with SMTP id
 mg21-20020a17090b371500b0025575e5b456mr3346109pjb.1.1685466041252; Tue, 30
 May 2023 10:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190828.358612414@linuxfoundation.org>
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 30 May 2023 10:00:30 -0700
Message-ID: <CAJq+SaBTqE+sYVGLoOZmv0U9DW=4P8riPwzi2Jwjd=7VsqHviQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
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

> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.114-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
