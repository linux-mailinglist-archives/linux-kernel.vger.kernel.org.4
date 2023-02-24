Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8636A6A15B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjBXEDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBXEDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:03:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A981714D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:03:16 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id fd25so6360534pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=viIOhCYTnJ1HqrNbM7zDtkeN6+E0N7cvZ2uLR5Llo10=;
        b=qV++WWFj7HtM9LTeMQzCYC6F/jD7okWIcIvdh5dGunXPzSTNaHLO9OCLWul/tVsRJ/
         0nUEFRQPRkRGfYLAi2iczhcnmuToKhqAJ8YOefo5v1xprTQGruAjrEFJsjN18bCenXzI
         qX6xB6J8kIeQ/KrsP56KxYMFQ0JR4dvW/7hRVRb3wNi5qFeW59IVt3jubiTq7KF6pMvN
         eFkXNPMeuuutVImSnEzXZukRiDJ12uV0EOQcJHTQX2kPveEwg+FqEqo1mPNQb10MuwS8
         juWTOL9ka474BclXc7HgN5+KHwp5dQx49LPd1IrHzZuBjOCyzkxSaWlxi4MlF7RKLw3R
         2/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viIOhCYTnJ1HqrNbM7zDtkeN6+E0N7cvZ2uLR5Llo10=;
        b=zU4jhTK5g1ThWRMqKEYELSHFkoUVku0tK5rUy3y9SXMdLIKQsaWJAhZQHjh2QbZGyX
         qT4ThBiM4dcsnbGgXSwhLj+mY1vLp/B/UlUv4TP7rJ5EnI+O9icxM4sw3ts8gy2yc4wQ
         Dd9wyt6+qTZCyNsXk1BGobK09KvSXUveNZhCnh8IN4LNL9ZSZjqO/d7lYJsNiZw7KP9S
         AW0IhHe5narSMdAkdCxTy2Cb8ewFeiPojiYi6+b2/9HzX416tDri3okOkJseTg9OpyxG
         4kaIdkK3VIw+avte2/Vwcixiv0PPez1D5XliAjYVXxIMl53aVoSxhV87JhZ6aWbFgyw+
         5G1g==
X-Gm-Message-State: AO0yUKWRyV2+nhrm06GFWlUdUk1bPKFsCzxkaE7Lw3/H6l0G5KxC68EQ
        ZnRHfnjA/A4S67Jf5l3LHF/wya++dMjoxTnv/cpNyQ==
X-Google-Smtp-Source: AK7set/w8xcr4dCuaVnpbOhj+JEvdqJCPjC50BRKBFEBFqec1ih9wU0y8DYJ+RDKMrdBKl51cVC9UbOdly7oGibm7Ng=
X-Received: by 2002:a63:3756:0:b0:4fc:d6df:85a0 with SMTP id
 g22-20020a633756000000b004fcd6df85a0mr2289484pgn.1.1677211396278; Thu, 23 Feb
 2023 20:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20230223141542.672463796@linuxfoundation.org>
In-Reply-To: <20230223141542.672463796@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Thu, 23 Feb 2023 23:03:04 -0500
Message-ID: <CA+pv=HP-KdcdU4bh-CjAEOGkrmofAj=v6hCf0bva4bUhfAaT0Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.96-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.96 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Feb 2023 14:15:30 +0000.
> Anything received after that time might be too late.

After making some scripts executable[1], 5.15.96-rc2 compiled and
booted on my x86_64 test system. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

[1] https://lore.kernel.org/stable/b1552656-7af0-42cf-017e-df919b0d0585@linuxfoundation.org/

Thanks,
-- Slade
