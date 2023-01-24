Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313267927E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjAXIED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjAXIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:04:01 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF186303FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:03:59 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id bx24so3528178uab.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PNYkARzuB34wGIN0FXri01x9300XgMbu5x0Pmjr/CQQ=;
        b=ZFwfrdYa0x3oVmK8wAwJwZEQ6bfeSt6sPkEebSJ3aeWDHK20C12F9Cg6SpvtYTCySv
         l7kHrsWTUbukj4TeJWaHdG0rL5c7KTRAJF0E5/8TBp52AGmX6Q23uw5ubXxp+60LRNzF
         2dVyfKC5LaZQX1YXu6F2xcoPSTJwezwQDRhvm5s52K++H33NdBk5HT9/jH6GR/wEYw89
         kajzzbrycfA+MJU6I/OI0FwyCD7fkW7F/RSezHyekk7Pf+K85PrY/VbSYXAMsbvtFfSb
         5CWlckPIb65HA6cJ0pkJ5YeMuDkf25Tga3pv85yHkhVVITU21OLUsNJ23LBP9v1Fx0UX
         URlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNYkARzuB34wGIN0FXri01x9300XgMbu5x0Pmjr/CQQ=;
        b=13WzQK83hXvcyZvMMG3t7Z6RSgxySiVLmvwXxwOgJmHmECOufU8urT4LI1p0juKprR
         gNF9aMNM6l9vJKXF7NiGPU7ypK2tMSox/KvCgRmXpxV2Hjz+K5FpXluxcbUQ4lJh61aV
         hU7OxuuxxQ+WT05Ho/sRb8kWrsm9pVlaF+6XTR7rhdJaGlkLc4GcNLBQH6vaXrgjTECm
         EFQiiVqi5cy+9yuDks3LNvxJN+G5o3vHK3JWhidVso3squQKW4nMLgqmsWO8pai7Z0ku
         SuurtgA5ohAvrYGcsvry5TwJEkJh1nLAkMWB7EjL9Sk4mareJ7dNzZsmVwGMA+3qXHbN
         hD4A==
X-Gm-Message-State: AO0yUKVCMRySKD+Uia2c5xqiwr8PHUPtBEPUuDDaJHaC8akveKRDhoUg
        CmaU55GOA/Tfiy4C3liuRK1F2QiYvioT3PTkV4OrihH5ci2/jKVq
X-Google-Smtp-Source: AK7set/1U9MWDTtXI1DL19jQzexGM++DfeMO3ZdAjqyOjq4nkqXVrUcLUJ08Sde4LDImUu1xly3yZhLSpNxWf3hucNc=
X-Received: by 2002:ab0:5611:0:b0:654:8b24:60a9 with SMTP id
 y17-20020ab05611000000b006548b2460a9mr50820uaa.59.1674547438462; Tue, 24 Jan
 2023 00:03:58 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 24 Jan 2023 13:33:47 +0530
Message-ID: <CA+G9fYs+4eAn52jW8vPd5dv2e4fj3rQGrDnp6YUrmsF_ThJiqA@mail.gmail.com>
Subject: next-20230124: x86: clang builds failed
To:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
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

Results from Linaro=E2=80=99s test farm.
Regressions on x86_64, and i386.

Regressions found on x86_64:

    - build/clang-15-lkftconfig-kcsan
    - build/clang-15-lkftconfig
    - build/clang-nightly-x86_64_defconfig
    - build/clang-15-x86_64_defconfig
    - build/clang-nightly-lkftconfig
    - build/clang-15-lkftconfig-compat
    - build/clang-lkftconfig

Regressions found on i386:

    - build/clang-15-defconfig
    - build/clang-15-lkftconfig
    - build/clang-nightly-defconfig
    - build/clang-nightly-lkftconfig
    - build/clang-lkftconfig


Build warnings and errors:
---------------------------
make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dx86_64 SRCARCH=3Dx8=
6
CROSS_COMPILE=3Dx86_64-linux-gnu- 'HOSTCC=3Dsccache clang' 'CC=3Dsccache
clang' LLVM=3D1 LLVM_IAS=3D1
io_uring/io_uring.c:1240:3: error: variable 'count' is uninitialized
when used here [-Werror,-Wuninitialized]
                count +=3D handle_tw_list(node, &ctx, &uring_locked, &fake)=
;
                ^~~~~
io_uring/io_uring.c:1230:20: note: initialize the variable 'count' to
silence this warning
        unsigned int count;
                          ^
                           =3D 0
1 error generated.
make[3]: *** [scripts/Makefile.build:252: io_uring/io_uring.o] Error 1

Build log links,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Kl1NaLatrfZ40PLJVY0=
iCMUhz2/

steps to reproduce:
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch x86_64 --toolchain clang-15
--kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-k=
ernel/linux/files/lkft.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/=
meta/recipes-kernel/linux/files/lkft-crypto.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/=
meta/recipes-kernel/linux/files/distro-overrides.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/=
meta/recipes-kernel/linux/files/systemd.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/=
meta/recipes-kernel/linux/files/virtio.config
--kconfig-add CONFIG_IGB=3Dy --kconfig-add
CONFIG_UNWINDER_FRAME_POINTER=3Dy LLVM=3D1 LLVM_IAS=3D1

--
Linaro LKFT
https://lkft.linaro.org
