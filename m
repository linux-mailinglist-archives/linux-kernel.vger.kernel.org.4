Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8656C2049
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjCTSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCTSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:47:45 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628FD303E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:40:55 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id n17so8600608uaj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679337628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRXc2hz1Iyz4zZlb4PkpxwfxHP9/5AAbgn8o/1fstKc=;
        b=fCPa7dxOdX75YB4iebz6/YsqHObho72FNPm85eKCUXK0SWtPjKAVN3owSn7COZUTZJ
         mDhG7u3He3+ltZAkexETCJZdCDqys+1aRwVkPCLf3NYW13ZYgcu5qX+jWS2UpxU80c6n
         vkjdIjV/yG+dTkQvNeiJZaCB/VGJXJXujqrXGvk/NiGR90sOVqgi+75WjF008Tl6lkVQ
         RKiG5+kU0ll5XY5bUCEHGa+s55TTsf2iOH0IO1da3QYRs8JGquEBcNXe2En6RZ8r/qTx
         gdLRv04dqN1l7Hq0X7CYdZfq/aAaK5dr3hkiqvcK5IWuWuOTUO4mD0E4KAB4jYui08e2
         KZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRXc2hz1Iyz4zZlb4PkpxwfxHP9/5AAbgn8o/1fstKc=;
        b=DCAnjLhNC01s8/nemPOIrQAaozlEoW80RMHlbLHm7v/o6A8f2ZWteq16SPqeJqg9F1
         SbOzrSQkWvqO+ej2n4pWLRMxw+9k/KKNJMnp5VebnBUYi+vYcOF3FVM6cwOWMjDcfBhZ
         O5t5EW5/kDx/DQ3KArHB2OHQLQx5E341+sHb8dNmqLJtZgLqejRcju4Q+PRcCIGmzJ8s
         OptfRKFK2pZMab8vs1/WfpcMjNUwmUADmMOu6ZvAEopeMyzQHeKEfc/pqDkJu7byRkEB
         IvKaUcYFNQV0oZ9NyfOid3okJxPMLv6NuF0qWIUyHCIcaQyPB55OcLoFlCkHI+AJHDwy
         P2gg==
X-Gm-Message-State: AO0yUKV5H3XfFIr0wnISdNz4N+d+LP+mYMeJX9C19v6YiqnS4E2I+HSP
        WOsXzsSQycXqBGJKfFEL3L9HFy1c1c1yw39DU3tAdQ==
X-Google-Smtp-Source: AK7set8Y2G3DWP+1nUSxL7tzZouFSFwcwHrD9ont46UDJZYxB7UKIsVHOe3DTskCSaLQBHQxRrBiNRHPpMLNB9OUYgs=
X-Received: by 2002:ab0:1006:0:b0:68e:2dce:3162 with SMTP id
 f6-20020ab01006000000b0068e2dce3162mr5199367uab.2.1679337627835; Mon, 20 Mar
 2023 11:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230320145513.305686421@linuxfoundation.org>
In-Reply-To: <20230320145513.305686421@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Mar 2023 00:10:16 +0530
Message-ID: <CA+G9fYvNEThYX-c204_knup5G_1vA27j+HouS-n=HMUsdJpC_g@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/211] 6.2.8-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        llvm@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 at 20:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.8 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Mar 2023 14:54:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on PowerPC build failures.


> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/64: Set default CPU in Kconfig

We see PowerPC build failures with Clang 16 and nightly on the
following configurations:
* cell_defconfig
* ppc64e_defconfig
* tqm8xx_defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Error messages respectively:
-----8<-----
error: unknown target CPU 'cell'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603,
603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548,
970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5,
pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7,
power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32,
powerpc64, ppc64, powerpc64le, ppc64le, future
----->8-----

-----8<-----
error: unknown target CPU 'e500mc64'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603,
603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548,
970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5,
pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7,
power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32,
powerpc64, ppc64, powerpc64le, ppc64le, future
----->8-----

-----8<-----
error: unknown target CPU '860'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603,
603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548,
970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5,
pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7,
power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32,
powerpc64, ppc64, powerpc64le, ppc64le, future
----->8-----

The bisection pointed to this commit,
  45f7091aac35 ("powerpc/64: Set default CPU in Kconfig")


Follow up fix patch is here as per Christophe Leroy comments,
 powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG


--
Linaro LKFT
https://lkft.linaro.org
