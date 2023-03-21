Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D96C38AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCURz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCURzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:55:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D9515D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:55:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so16873610plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled; t=1679421322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2f7rgn2h3aX/OgonL+LZ4pVeZntbx1pC+H3yOOxuPo=;
        b=POoPbVQzBxPUZ9UVHQFclfZPqdYhET4djBJsztO6uaI2Xh59alX2Y6nwES4W+JkJB4
         7nQ48aAarEIbKFczycMLb/dMh+p1c2KwRNUMNhTcCQ8hMO8gXPv6iPaRq7f8+31+ZPdV
         iGpsXdJ8M7bwAqddpnJNHPtPfG9cLUqrcxk6r3RyD2DWV58X5HpA0nBurpDxSGR51HQ8
         UuO/OarnuvLM+MglRW9T0uQznVVXi0Uyb7olJa69yKDPsWYO5JTHKC7XIFeE5kvkw4BO
         1iB2NgswFTkUC5TQUw1/HGNW4D0BAc6LcyFeeb5gTiGZJ4pfNpxNqdeDsO+jSY24m52q
         jamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2f7rgn2h3aX/OgonL+LZ4pVeZntbx1pC+H3yOOxuPo=;
        b=SeOf5Vi8lArh/NDSYanYG8eA/Ns97lGtVS+Ns6G/CY7gerH3grxNsSQ9tB9I/NzNJG
         exiqMt8t9dji3PX53+1z56OBaJLQfyTYurPm6l6AhMOWm9B8h/l2hXvhgF4iEFs8L8YZ
         wdb1NPdFuFgP8q+OLhvg5KU/H+vz99UMPCOrTaBwsPBa1iwFnOWUjNolkYFmg10ac65d
         vRDytAVbnzChez7W14ED5dsTy1m4ANnndsIKlB0f2A4gsTZFar5wa0Sju2SiTpRfDuWz
         eAM8dk9ogAj1eLKAPrKUEQ5jt6leSEHN6tepQ6Vbu5bhA2+8itXo5lCG3tuDcYiOc7Ud
         gFgw==
X-Gm-Message-State: AO0yUKXTjHmvJoPVPJbkzjXL7aaod8iMGYJPfbTkJ7syop5Z+JJ4LXR4
        RFgtx0Zq8Mva2w8Z8EzmVK8XSbrJ4KNwVs69ScuhQ7bezzWIrJmg/dLG+HtD4M0sjsfNz34za+I
        Gk/jYnMjDnK4CSaPuESWfAw/PTHtVwALFdDg=
X-Google-Smtp-Source: AK7set/L+0d/V5U9z7rXu+z18lp6xAoVqf1aZZt5Bgnm0x6j85D095LBMwxBvdARwmaE0pXegdHoYmXQkVGkYgWkLoI=
X-Received: by 2002:a17:902:e892:b0:1a0:7630:8ef9 with SMTP id
 w18-20020a170902e89200b001a076308ef9mr1383862plg.12.1679421320553; Tue, 21
 Mar 2023 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230321080705.245176209@linuxfoundation.org>
In-Reply-To: <20230321080705.245176209@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 21 Mar 2023 13:55:09 -0400
Message-ID: <CA+pv=HOMuAfbHwkp4BYMeoJk4sL=bSoF=rGcYeXnLHZm2HsbzA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/198] 6.1.21-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SWM-Antispam: Scanned by pmxgwmtau.interior-mail.sladewatkinsmedia.com
X-SWM-TLS-Policy-Status: enforced
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:39=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.21 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Mar 2023 08:06:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.21-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.

Compiles and boots on my x86_64 test systems. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
