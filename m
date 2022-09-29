Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6A5EF935
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiI2Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiI2PfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:35:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C970C1C5C8E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:34:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m3so2463604eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=rS9nGs1jSxsJFkW7ucjGXH88knXHJkp6lBLG2+yEkog=;
        b=bkKh4ThppJrC9AyYyd9oQi9LDDip/+RdN5D6r9QTRFauGlbNgAMScvDtMeEcvSs/zL
         OJS9Y6NRg8mipRU1e0iL5ZYVKU/zQ8WQSUl7pA8P+dWKwYNmfoFckFluOBRwnU/cNqfC
         b5UD685e4uMnmHmFx6cOv30nYE95v8d0JSSPROY9g1sTboyeICnjS8tlwFyA9zVyPy+l
         h7fkK4wjYtunlKseXcATDejFL9wY3wpR+u5TpvrqgCyQ1EbMjosaJrxLQCLiww+/in0+
         EN7NTwgR/VasetBXHywM6LwPeII0ONvk5AF2N0Vh8Vbar59iM49agY4W0bUyqDIEAHjw
         +D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rS9nGs1jSxsJFkW7ucjGXH88knXHJkp6lBLG2+yEkog=;
        b=JsxibbLY7A0WTcea0vWXfzsO9VLQBqwPtbXkWh8CfG1140F9hHMlnLMX64KxGDwKZ0
         Ajppo4HWB35BE0obZiC9vmzKVfz4G1/EeHeFXFHsqAIvHM61AiYTVyJxIKvrTaJo11qC
         Uj4uyDfEeCL1tknf97baxY3w6IL8ozv2tuM4aIvIf9mRUYs41vnaVAGJGvpnhryDhuBr
         DjgxL27HllJ1FxN9CQXP8aYHhDG1QCO26u67JjQHxQvGgxtpoJQQ9m6Fktw+xKJILZ3+
         ATtfuuqsfP9ogg021IjM3BeefCz/sWXYtiuqkYkUS57v/LySkMv1VvqTUzEBvBPWXdHG
         yx8g==
X-Gm-Message-State: ACrzQf01PFJxg/zoz9MZS2g4CWG/3xgpfZuhPmGKJSUclyAUbpwDBWSk
        fk/eYljvSWJqW0tDVFa6repbXkb97uEAc8YZhGq9Ag==
X-Google-Smtp-Source: AMsMyM7kswi/PF9HwYcWUAM1s6Tq3ddrQbj6buyD2yWS/ohA/Zhu9ewFijgTGR9Q6ff/La0f2i95zGXbVTX+2GVU5TU=
X-Received: by 2002:aa7:c450:0:b0:458:23cd:3999 with SMTP id
 n16-20020aa7c450000000b0045823cd3999mr3779012edr.208.1664465645660; Thu, 29
 Sep 2022 08:34:05 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 29 Sep 2022 21:03:54 +0530
Message-ID: <CA+G9fYuw3Xn2wPc3_MXsJFNx7O4Zu91wFt+VsK4qwKMB7HdGow@mail.gmail.com>
Subject: selftest: arm64: missing install files
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running kselftest arm64 tests the following list of tests
were missing which means those test binaries not installed on to the rootfs.
Not a part of "make install" do we need to fix Makefiles ?
or am I missing something on the build machine ?

We are building on the one machine and testing on multiple arm64 target
devices. Please refer to build log [1] and test log [2].

# selftests: arm64: fp-stress
# Warning: file fp-stress is missing!

# selftests: arm64: sve-ptrace
# Warning: file sve-ptrace is missing!

# selftests: arm64: vec-syscfg
# Warning: file vec-syscfg is missing!

# selftests: arm64: za-ptrace
# Warning: file za-ptrace is missing!

# selftests: arm64: hwcap
# Warning: file hwcap is missing!

# selftests: arm64: ptrace
# Warning: file ptrace is missing!

# selftests: arm64: syscall-abi
# Warning: file syscall-abi is missing!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


[1] Build log: click on log.do_compile file link
https://storage.lkft.org/rootfs-kselftest/oe-kirkstone/20220927-202538/juno/

[2] Test log: click on full log file link
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220923/testrun/12052498/suite/kselftest-arm64/tests/

- Naresh
