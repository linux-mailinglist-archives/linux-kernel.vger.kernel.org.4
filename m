Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE12F716A63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjE3RCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjE3RCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:02:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779E0135;
        Tue, 30 May 2023 10:02:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256a41d3e81so1446166a91.1;
        Tue, 30 May 2023 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685466149; x=1688058149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8y7yMNzZ1Qqhpw6rilc+hpdM25AgZyUqwGPTyZvG30=;
        b=JVzcVggwmyRveToNOSRrzjG4a7ygx+T88EwX6Jiqkm6w+4l3PEXGCSlVKcgEHLB8kG
         ZxlGgChiCIQLHOiVqWQ0SQmwA3Jm57JvGACwNps1r7tmZ8t3iNuhHC8NK1BLTTqWLdYq
         KQj2UaqLp3bY3B5H0VdMQWRMX88fLheJh5jpLSF4BnGXfgPIC4/ZwAfQGJ02J0AiJD2C
         4+XsjvN+XO0iQnlGPmZrmv3tTdMjzkN4/1b1YrU4WtfN0xnb39T2bYhJYP0/T6+bOrNN
         VKAPqbEJKX5KePCzaQJsxdfU9wXQ9mWSYzC0LUMVSvN2QreNLxMyWuoet8iCBzXHF70g
         CJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685466149; x=1688058149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8y7yMNzZ1Qqhpw6rilc+hpdM25AgZyUqwGPTyZvG30=;
        b=Ve4TqVAYqgY0mkYVcaliqs05Nzwesw4tk5cAKnEDW811exrf7CPq0OX7FY9srA+Vud
         a2nFLslXMKJXaCTEkno7tChR/SG70fCUCgVAK+4HUWzDwW3Ow47Rz9CbGwTCxZHIaCGb
         kpYdKiaZLu2LFKzqlNf6CACWXbNledYFlub9LpyXj7cdApT6HqvGzd9lU5MQKbb3Uxbh
         BznbGRgvSfHHuk52hQPP1XVyews4GHj0ffecr3Ldcoqqiz1P24zOhi0t2qW7xp93khLA
         LJNSkXlwrclt1rUX1ih3asHFzovMkWO11vsPRW0eQOs+VIvSN33GxVPwkbgJC8bpm8Ex
         Cngg==
X-Gm-Message-State: AC+VfDyTfRlzw/oJF5agYBr+4wcp/ZYglkm190Mi+DaRfSSy3g26ivVV
        TkWSd+x1HXI2L48Zmz4MMSSMMPrCMzvWjASIAD8=
X-Google-Smtp-Source: ACHHUZ7h6bz8p9RbMa12RIVDXgKFTfWqgt7XTokWmigWLZSciY6OzVC41VUTCh37/71OMtc3oZUIKTC2sEYLvnncv7g=
X-Received: by 2002:a17:90a:cc9:b0:256:6f35:fd60 with SMTP id
 9-20020a17090a0cc900b002566f35fd60mr2934376pjt.17.1685466148757; Tue, 30 May
 2023 10:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190835.386670951@linuxfoundation.org>
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 30 May 2023 10:02:17 -0700
Message-ID: <CAJq+SaCyTfTuD5Qte7cA4HhSqUzUOwDXWnNp10zTBLM9Gh5UQg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
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

> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.31-rc1.gz
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
