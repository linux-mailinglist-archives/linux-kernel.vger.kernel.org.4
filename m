Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25571624126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiKJLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiKJLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:14:49 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D16F34A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:14:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 7so1883248ybp.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2bzJsB3PbL2X/ibwn3ezEZIfiFkuOTKtlMfImy68cw=;
        b=SZpX7Q3VH7kdT2mdWoO/QbBXjTZrWo4vvC/LeRfeAISTPI9+3kKF6QzsnDSlTjhzsz
         y01yoLLOAGTWPvGFzhGfBuYQOHteTyMuWJzvJLZ8YcJp4563rQJuqMyr9NtiJ1/RXc+5
         6Zcv+KoRPnYi96FeLJOPtQ1wkq2uvuViyePYA2zNupq1V7SnJVDFLHs/ZXV0Nvqn0zTa
         JHmbllz/nTATi0fRb7vfjhpD8bpJbN1Rw6PeDUyc+LLZavrgYj5ul2VLSnBKkWDgPgS+
         BOLMSfKscmE8mG4ImjW3Leym5HYNAkY4LHVbevGDqRFC9E3u5mblGFNltT/zyubmcWRB
         cO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2bzJsB3PbL2X/ibwn3ezEZIfiFkuOTKtlMfImy68cw=;
        b=Bi+4B4btdQGj7WRk5Xp8BEp0mskmvoVcldvpcKkwpeGUI7NgICJ0RONLsHwuA5xDjJ
         b1Pdn4355CNzQsKzrd7aF7pODIKkNkoN6KK222hjt3A12K9rBRn0k2LMKEUdcZTpFWDp
         ZJjDOhCkkPKIJHCOyL5yGrsXvfSjlgwi8m3TWiXruPR/+z2/h4eqPRWV3keLiG+TXVV+
         eDtdu5B8GxbdQKXzw4VJHE7Cng+oGOSahtJix0vFaRoVjvAvFtwEy7gTdoPB8cNcFJm1
         6StFXTiAoDL3QtN+F5qCwK0vtqQTiZGbz33ktoarJw3/VUzVuSipk/7nYaakMGupBnC7
         DWDA==
X-Gm-Message-State: ANoB5pm1Vx/BmqEtBPjYoE8dg9Eo/oZ5tauiLj2PBpUXvc1n134xauH0
        m7/MiMn8AlTsd96B3KmMH2plj5WBmkK+pa5x6DMLkZs6Ut8mig==
X-Google-Smtp-Source: AA0mqf4HAlvllfiTAy8O9bwGOZY+LqHNa1fYXXmuHTN8m/MtWdK5qYiJCbTluraqvq+eDKvsSspGFDYmqQHDLvDcHGI=
X-Received: by 2002:a05:6902:b16:b0:6d6:9455:d6c5 with SMTP id
 ch22-20020a0569020b1600b006d69455d6c5mr20823348ybb.164.1668078860624; Thu, 10
 Nov 2022 03:14:20 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Nov 2022 16:44:09 +0530
Message-ID: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
Subject: x86: clang: acpi-cpufreq.c:970:24: error: variable 'ret' is
 uninitialized when used here [-Werror,-Wuninitialized]
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
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

[Please ignore email this if it is already reported]

Kernel build warning noticed on x86_64 with clang toolchain [1].
Build failures noticed from next-20221108 .. next-20221110.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang
CC=clang
drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is
uninitialized when used here [-Werror,-Wuninitialized]
        acpi_cpufreq_online = ret;
                              ^~~
drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable
'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

tuxmake --runtime podman --target-arch x86_64 --toolchain
clang-nightly --kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft-crypto.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/distro-overrides.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/virtio.config
--kconfig-add CONFIG_IGB=y --kconfig-add
CONFIG_UNWINDER_FRAME_POINTER=y LLVM=1 LLVM_IAS=1



Build log:
[1] https://builds.tuxbuild.com/2HLg3VgMgxRXBn31n6Ig7BFwSy9/


--
Linaro LKFT
https://lkft.linaro.org
