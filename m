Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4A73725C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjFTRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFTRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:10:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2510D0;
        Tue, 20 Jun 2023 10:10:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-66869feb7d1so2093939b3a.3;
        Tue, 20 Jun 2023 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687281022; x=1689873022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=as+0n5OOb8N3j3zxYMsZi2GIrSF9WcrhdV/0bjInCqA=;
        b=kfe7rBblCd0NL0UHp4j69hOkwvnhY59MjpILKauLUDHmrfRK7fsIK9M6r9DbTh7Q2N
         zQQ3rwvVVZxbuQBHHOEJ6ETPiwHxK5QKpWn6kuqHpqMXeUUfjlKwDvTOIAc35NuQ0VzW
         Bo0F7rx7sSadd6Wdb/0kBQhHQzsO1/uB9P6CZdDjXV+yJA8PP8oizXIZ2jlF89BGU6Hl
         GLywxEY1GjMZf4CE1sS5fQtyCdW3WE+1/wz3ZgAyTb6ssW8Oa+edjSnFm/N6esCYPEQj
         /3HPpZYePZTqGO2fT0O7OGtrd/rHdxTUyScTSg/TG4gTa69i5wxvmT+bD+A1tY6ZP4ZB
         NMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281022; x=1689873022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=as+0n5OOb8N3j3zxYMsZi2GIrSF9WcrhdV/0bjInCqA=;
        b=CTgM4hVaJ5k4DyX4vgFcQSws2AfAmvJDzOouhJTsPF1OeIdu70lsjW8Rv/17DbShU2
         Z2OprfN7HvUDin3Mm6jmuSyIlusCczyjmU5ONxIifCJ0cGGmMAipGsQ/J8GcP1oPvsxM
         x7keqkUIW6xKvqjy6skm8xq0K4n56CNvmZgzd90maAyTyuS1wMBtHqgS4v4jlCGhY+c6
         Jl+73H1WHNPSsQfZZRMGw3XMbn2mHw38Z6sVzABStFrNwujcOruSq8MmoBPVQOnTYahf
         n6FVPc/u0EAQaA22uZYQdgfbCospLIgZbQG7Eti32HQvMY5QiJCSh5ytrrb8e3XcpfT9
         +Jlw==
X-Gm-Message-State: AC+VfDxtzqtVf0cgDC3tPM2cnDtCcQSNL9ndSfiqhTUPHcxv6O0RLwMB
        uO8YFrOiZPT450RLOh4qujBRkM76EcCNg3THac0=
X-Google-Smtp-Source: ACHHUZ4jUSlY4pY1lMKsSh+6IX+B+dl16SNTN1mye1RkfNwQn8Lys6N9EBhOO5h8T0g+a0MY+4wpWxk+mweUUFKt5e8=
X-Received: by 2002:a05:6a00:2d01:b0:668:8493:2545 with SMTP id
 fa1-20020a056a002d0100b0066884932545mr4646529pfb.24.1687281022552; Tue, 20
 Jun 2023 10:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102154.568541872@linuxfoundation.org>
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 20 Jun 2023 10:10:11 -0700
Message-ID: <CAJq+SaAFXBNp04yLxyuyRrFaYex2B93qU7KHzUGP6zZ3DQLWrg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
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

> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.35-rc1.gz
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
