Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22A468D11C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBGH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:57:20 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51228D30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:57:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so40918987ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjsB+AGSljRnQpA+58k97XCvwuzQDyJ3UN6KNCrj/C4=;
        b=pN1+ghys/kOt1G6oDLNcsqOKPC0GBRpCTvNgXY4pyab/kLCRMENic/vyj0vzi6c4/8
         EoK+/lRrHx8BJz0JTLDrb9Dz+QA3DoX++R1OGxa8vGW7ACwFZa32OhCovDBYjfzoazTe
         NXsZHaS5Ax+Q1VrttS0Zth3l3wfCRshuKzh8I6SOVmJvPR7qCWXfuN7DwSJQ6zdJL76W
         kINDEA6JlaqlX8mYnrWqgkwZGlv+GY8XnvALqebRPKdzzDWeQaFm4WLOO5W0DoW01fop
         PSaXOfVrbeXomDPbvO52xD6979y7rAagSmhzJQWmFpk8/Drjov4kOqJ+YAAtCpizkXUr
         voIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjsB+AGSljRnQpA+58k97XCvwuzQDyJ3UN6KNCrj/C4=;
        b=kJdIX9hFNBQWNTLGc+b39Ftnb+l0mnNK0x9UoyzUST+sKs/gfjcCPyEPAtIMSJsBpt
         hjUYAVxx7ffYo7okx/pKMaorwiIyBo5zpUPB1/knN7WB+DouV0gCyAx4xn7czZKxfjqV
         FyRZMS4+duGHNAbjnjJgUfkrrXqytcp+a4q9LF9LnHKx9yql7kW5JGUgVFhzSdqroXyV
         4vH5yyy/dr0XL48gkC0tNjIyuVpRBfpC/1/saD8tRa+jz3qay0RsGDxO68nu1L2XXlFc
         G2NGCanL7wU/nlmxr/mUixMuhw33dvptyUwTQELLEE0N8VOn0UTjYIz7Rv049t3ClbGT
         F59Q==
X-Gm-Message-State: AO0yUKWvv4HLDIkhqeLMmlHKt6lKYlZ1XvXMeQOCJGJr6kp7qxtGNG4n
        j2933ZeC71OywhZHdfCKcqaygCjaZ8cj7UHfewB0H8Ax9yJQ6Qyl
X-Google-Smtp-Source: AK7set9V3pgczMpgtevwU7e3NotwVmoDa6/EjWoWewDNkfPAzcq1B9PF5l3vDjS6m4TKEpRPyMZk5erMRliHmTK98EQ=
X-Received: by 2002:a17:906:38c2:b0:88c:f92e:a13e with SMTP id
 r2-20020a17090638c200b0088cf92ea13emr593049ejd.172.1675756637037; Mon, 06 Feb
 2023 23:57:17 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Feb 2023 13:27:05 +0530
Message-ID: <CA+G9fYuSWodh1teau4jGG_P15yT-ev1+bS7HAAmMu5D5J-d2vw@mail.gmail.com>
Subject: x86/include/asm/arch_hweight.h:49:15: error: invalid input size for
 constraint 'D'
To:     llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     borislav.petkov@amd.com, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Build regressions warnings / errors noticed on Linux next-20230207.

Regressions found on x86_64:

    - build/clang-15-lkftconfig-compat
    - build/clang-nightly-lkftconfig
    - build/clang-15-lkftconfig
    - build/clang-15-lkftconfig-kcsan
    - build/clang-lkftconfig

In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
In file included from include/linux/kernel.h:22:
In file included from include/linux/bitops.h:68:
In file included from arch/x86/include/asm/bitops.h:420:
arch/x86/include/asm/arch_hweight.h:49:15: error: invalid input size
for constraint 'D'
                         : REG_IN (w));
                                   ^
In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
In file included from arch/x86/entry/vdso/vdso32/../vgetcpu.c:8:
In file included from include/linux/kernel.h:25:
In file included from include/linux/math.h:6:
arch/x86/include/asm/div64.h:85:34: error: invalid output size for
constraint '=a'
        asm ("mulq %2; divq %3" : "=a" (q)
                                        ^
2 errors generated.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following config diff found.
 + CONFIG_COMPAT_WARN_32BIT_FILESYSTEM_ACCESS=y

Build details link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230207/testrun/14611359/suite/build/test/clang-lkftconfig/details/

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
tuxmake \
 --runtime podman \
 --target-arch x86_64 \
 --toolchain clang-15 \
 --kconfig defconfig \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config
\
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft-crypto.config
\
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/distro-overrides.config
\
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
\
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/virtio.config
\
 --kconfig-add CONFIG_IGB=y \
 --kconfig-add CONFIG_UNWINDER_FRAME_POINTER=y LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org
