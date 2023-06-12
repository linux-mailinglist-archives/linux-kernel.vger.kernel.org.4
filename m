Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4972D30F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjFLVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbjFLVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:15:03 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C594C4C0D;
        Mon, 12 Jun 2023 14:09:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3b56dcf1bso20241335ad.2;
        Mon, 12 Jun 2023 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686604113; x=1689196113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PgflJ5HauZ4+h2KSgczCGeZma4l/SQyA77jKXJkcojw=;
        b=OqbJgCcwUK2y+JS690twBeqU7wnjZEkGEyBBQpyjRuTpWve63YvvJFZxOQxaImcyzk
         bvd9BvpY5kEIF+l4O3T7tVLy2vvftotbtSqhmKGm/2oE8+uo3i4uimq9+cYs/bLg+W8k
         cXfmdO+8pZrZPUtDew9ZCFVlfctj47LhPFXiStMTuia4bIFLgWV7hpzFtJgGMYWmH7BB
         XvQG5VBfmxfb5+bpVS9Z+7e3T9Ux1TxmKI5wmksfk5nGmPa7YHMMYhqhdUCFmZ/0gqe7
         QWcNXR9STF7lIGgAzhmuRSf1ydHV5WXJoaGaY+eevuDmZWG47zsYQ6v0bdxZvOmv9bxQ
         iXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686604113; x=1689196113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgflJ5HauZ4+h2KSgczCGeZma4l/SQyA77jKXJkcojw=;
        b=kJUijEgHyIF4KlHZcMTafc+JDKYc8tnBWruzi/rqU0dXV8eTR1svRMJwObZKhcFe6e
         GitBi0xN3ZtJ1XArKf2b0Xk8Eu6bRm8JwA/vzp2wZ+Ht4dHKmfAPv3l0+14MGi1Sc/ET
         9BhvnGHq2uCpel7aV84cYMoFoZiD7lqavuE1UgXIQicFcOT6vO7x4GMS2d+ktpqDvcqU
         3zsPZcS7aD3rgAH8S/6VrGOkcDTV5rudceJEbyAmGKaijDuU8mULRhp9AtrLAAmyk9yv
         qGe6ISLeq324B/xN0/z9cF5misrw4POTBIvupETwIFKXYBoRIaLwpsirmvdWrliNIBq0
         rBrQ==
X-Gm-Message-State: AC+VfDztLWPTRrvxJCoDpKOcs1q+zuAql2ADziy12Lrv1exwkWIiSiyk
        HWbug+UgtvApR3BHGTGCoZpVkcOK+P373xUG4liFtuXZsVU=
X-Google-Smtp-Source: ACHHUZ5D8B2tB4XZQaX7PnLlkIGl7fgsEwEyJER/K4Dpmu9w++B5VMhiO3d0v8uoPAtcGofZyZqzESr0QPwUfnACVps=
X-Received: by 2002:a17:903:32c7:b0:1b0:4c32:5d6d with SMTP id
 i7-20020a17090332c700b001b04c325d6dmr10231740plr.31.1686604112978; Mon, 12
 Jun 2023 14:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230612101715.129581706@linuxfoundation.org>
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 12 Jun 2023 14:08:22 -0700
Message-ID: <CAJq+SaA3BzspzE=fjLYxrJ55nyKRxkjV_1dwUtN5-f8_P3kubw@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
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

> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
