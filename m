Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C86C2053
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCTSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCTStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:49:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0F38475
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:42:55 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id f23so2196850vsv.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679337772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6qDlxgrvXVQRNB9kUbn6eufRRtTHPLdDgSZt+65vJI=;
        b=f4tYwGPHEiPX9T9NSQEefkwCMwavF0Hfvbj8MPt8OzL6EDMfSsCfBfOjHcWUPINIYO
         9ZL/1zFGenH3AzWv9GV0KXiADSzo+VifNzGX+xdaveJasZVWPs86w8AHE3037eSicsTt
         W43IW3n/QcpZBLnGR3WvNGApR8libNVl60RcIJrrrziM44R40p2A9CINpYv2KRzKMDoJ
         OkCQRcPkeAYra3fLCg2RE27/RiocXxzaspEN4Ngo+hL/I7Vxzk0GJDyy86SyNuimXbYj
         ++tKvusG3Ooqy+780AhinPAkinpjJ8vsgoBuqnLayzMZ7eLNDKSNOj4oabisOMENf/lU
         p2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6qDlxgrvXVQRNB9kUbn6eufRRtTHPLdDgSZt+65vJI=;
        b=N/+Dz1WFA1D19YKeUyHJeDENFI5jW/vNMZw7lGuqSNWEcpEvjSEEhm25zNE9gbqwLd
         ZmU31kYdVzWBtvgEh6leadGkyJx9yKULPpHuXzBjE9rX6MtcZ06QfvCs3LaGBKporxo4
         YnxXamPy327/bgxbhFkmG1qT36lCvzFOVlhwUssy3fgMVqPq8c97djdz+HwInXuGgipe
         RNNQ3QsjK1XdPTq8THa+K7iZtUf9BL1F10YolxDvu2XaeNQEXFHSLwcBlcB5Xl6KuzCm
         Y6RF9cjBmYEyeQHZHCIyY4hB3bPJj8oqF5iOgrY663Ic4trbuxHb8z+CXtrZhaJeUu6U
         BZfA==
X-Gm-Message-State: AAQBX9fUfOKxzy38MXE48W39bXlKyrGCFGTj3ecF/qm7zRp07Aef/098
        WnR8Zv9fhNtjyoVN/GndQlpN7JzNpRsq9WbU9v5S9Q==
X-Google-Smtp-Source: AK7set/vVlTyUh2BRkhjfN5Eql28JK/M5ok9ZONQir0aJp4DhxnNQlA6ExlGsyH5oMhXl2OBLvkb746J5x0qgMXmI+w=
X-Received: by 2002:a67:c01c:0:b0:402:9b84:1be4 with SMTP id
 v28-20020a67c01c000000b004029b841be4mr4451vsi.6.1679337771950; Mon, 20 Mar
 2023 11:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230320145507.420176832@linuxfoundation.org>
In-Reply-To: <20230320145507.420176832@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Mar 2023 00:12:40 +0530
Message-ID: <CA+G9fYtCtfSqrje=1wkw1ODpnJorDMFkB1bSVexpyc4gi3X0ZQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/198] 6.1.21-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 at 20:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.21 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Mar 2023 14:54:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on PowerPC build failures.

> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/64: Set default CPU in Kconfig
>

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
