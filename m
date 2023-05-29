Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA507147BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjE2KJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjE2KJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:09:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA44BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:09:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96fab30d1e1so656046466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1685354990; x=1687946990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Ulvr/gZUbv6oI079IaQPegeBjM6/iRJ/6/UwLkRIg=;
        b=u0JRN58+4SypFTy3LwYLGaRT+pC3gNXCQAb3K2We3OX03t3OiCaUE8O9PNCgyi0fsL
         xwZEshK9wGftnJjhwIHLDwjsDqCqqGeOI5SeA623HJDmw9d7swXSTcJoB5GjMxqzUgJP
         pQpsBikAKC9tCZvq5G3GXS2k2G3EBxuRiV+Ug087VMdXK9T9VxkZe5opjU1l8TpSUzFX
         /Wdr+lTTzVsSVIX121RkuNs9RPwDmvOF7Ys5Mi2fRn/8RYDcNhw3dht1JasjztUs23Nv
         AH0yn20+VmeVSQkcBNILqfZ4s9GdCecwBCn4RSsYNGBFZif8KIxkM77RQixwHTuOXM//
         2KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685354990; x=1687946990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Ulvr/gZUbv6oI079IaQPegeBjM6/iRJ/6/UwLkRIg=;
        b=DqVoY7/AAYyBwaJ7kp1TyLmD6o/pcfx5u3o4vzAjyLPB1eRWEwbL1WtxsgQqLDIJmx
         jxBtSrQBOF3vtPfHYkkgfBZaN4QTSJWiFBAHGrzu5Nw8mgIFAIefGIuW7Dd9B+suhaV6
         WPBqqs+EfE69vHhG7OZL3FQer2b8YpPrG1OuWcnaKIhagk/96ckPBedmIJ3yYCMJeEsH
         MW+uYr6Jyy8aNk3hhNQh3L5ubiMdIb3pe8NEBdq5zwl2K6vwbZflKSFm6LSOG1xx25IL
         QcJeTApgfoCBjXv2HUGBOVeO488rlUo5sobZlG9x/qqfBvEs9zOuPQ/biwfttpuk9Oe0
         KTDw==
X-Gm-Message-State: AC+VfDzZ53c39/AG+HVbhS/rlvPpWA9twe1BHZ0eZYgbjObZQFYxPQFs
        bHPfLm7z0Co0ytEvNfAc+MXuyFLaNutIuUa/WPJKDA==
X-Google-Smtp-Source: ACHHUZ7gGI3d+zboU9ha1LNYX0Fy1Nci+qG9oOeSWbJgf5FflG7F+amRsB5ehHf3hNCeJzKwO8dgEGm80cuCHlYuCwA=
X-Received: by 2002:a17:907:6e02:b0:973:87d3:80d4 with SMTP id
 sd2-20020a1709076e0200b0097387d380d4mr7807032ejc.18.1685354990400; Mon, 29
 May 2023 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230528190835.386670951@linuxfoundation.org>
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 29 May 2023 19:09:39 +0900
Message-ID: <CAKL4bV5DhZD-ekQV2PPyAErndyHUwMS0b5VNABxbtx1eW23Egg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, May 29, 2023 at 4:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.31-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.31-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
