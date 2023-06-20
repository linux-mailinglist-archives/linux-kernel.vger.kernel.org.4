Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEF8737254
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFTRIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:08:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB4F1727;
        Tue, 20 Jun 2023 10:08:50 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6687466137bso1515741b3a.0;
        Tue, 20 Jun 2023 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687280929; x=1689872929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wFGdUhJIBvjZjZSPOJLH/5SirsIlZFmwYpBcX309B40=;
        b=KOr/w2LE0N+lCMF3SiWPHFIGKhNRgDIwIgVr++EtSOr/zcJTtOm8HemTs8EfdZHmDF
         7DcNWayUhu78jIwTwgvOjefkpit9nyPWFPB/Yf47V5V7f1Djgw/7oMdm04fbkLqT7FuJ
         lxMVY6ByRaP9IQoLPySikUf/XW5l3575AS0UvFSVqsU0soHamSRx8OqyBaZOk/2HJq+K
         AsbdkdFW4xtC3oiHa2wEnllSnwfyD9h/vnJ7TjRAaFrlP2K3eRDIa4UhY8PybY8spXYx
         M5tihhJpvKlkAuoJqV4uCUkdvvvuXYRViHivbRL7UcaEAIvN/yFkFoeI61O7BScyw4Dv
         H/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280929; x=1689872929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFGdUhJIBvjZjZSPOJLH/5SirsIlZFmwYpBcX309B40=;
        b=VtjBEGdLSNTzTG+dpXexxp4AATByASUEeZi7KW0ooaK2UnBLNINn1DV0HwtIjuBtvz
         C/gTXkD2EORVAaUrH8ldN0XQzvIsn0ISsTJuc6+u5eWBBby2wcbLxVajDllXCd8gQYuy
         ZAQf05Zs0xivqfdsU3haYlVHhi7cYgr5vocxghrpiqG8njoFhjbzdKO1TwowVfU44xAX
         HPLxW7WLY5wjDVV8mFnXKNT26680h6FeaZjj5sQUhOLS85nxWhEE2xhtC7kdij76tFWC
         V7mEJSCniqBuv9uv5LSxYlhJechjZwVT3jtsMByk/fqWZAv3zQwXL4FBwqkk9r5YEFb5
         EFhQ==
X-Gm-Message-State: AC+VfDwFgK2z0J657WUdTj7HQppVMKSpbE0TcEAdL5+9W8SzU6hOvTa7
        U9GN8OZyhF/gYLAoHNgG22ZfaH4IescRJQAXqbs=
X-Google-Smtp-Source: ACHHUZ4/bWOvXG/fzvHtGlvOXO5Gtz33y3AeFhTF7rRywTl8W5azhHtx7zPZjjr/kbSPEcTz6LztSakmX4O5lUiqEho=
X-Received: by 2002:a05:6a00:3a24:b0:668:83b7:fd02 with SMTP id
 fj36-20020a056a003a2400b0066883b7fd02mr4524235pfb.31.1687280929614; Tue, 20
 Jun 2023 10:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102138.279161276@linuxfoundation.org>
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 20 Jun 2023 10:08:38 -0700
Message-ID: <CAJq+SaCOKpEFEt7G2fxtV4ahX=7Zb2P=4CGEVEmtqvhgbED6sw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
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

>
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
