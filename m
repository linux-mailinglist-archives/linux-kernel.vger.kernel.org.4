Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3172CE9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjFLSks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjFLSkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:40:45 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB546E6F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:40:42 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43b3e2cce3eso132582137.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686595242; x=1689187242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kPF8uPb56GviGY9KiREimI3Llex5+RzsOybBEO8RgOE=;
        b=bSub8knI2My+mzdaIppR7khjRkqEOAJYxAgrpaHsB74yBrmaVGcnccW2fkxC4RD4Er
         Dj36HtgZm64aau1F0geqCqra5BKcQhORteB3ZvxW7jGgx9alss4uXQlntCEmhf0+qUBP
         SMaknbSSY9pftOMeU3KeaORgEvCbHS2kVgp5UnYdRQoz/IZowDK88X9xNypKonMdKix0
         +fifpmPPyY2IT9deMsOL7TohKu/WS+pDiOf0xNRBYb3SFiJ0KMRv2wPud7uFV5CVg/9F
         xnyR9o/n6O3XXziSeQDA8q522aR7h1Ea5bKDFX/e+SRceRhvlRHctdALXvVMGW7pQolc
         tX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595242; x=1689187242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPF8uPb56GviGY9KiREimI3Llex5+RzsOybBEO8RgOE=;
        b=BSt3Slr/hLekIVOCmVnawREmw6BaLNZNPsrJqZcYvJ0ZvQi+FEvic1/6Kml9q63T+6
         foQXCq11wBmOBJyNXkhwpDIaSau/3c1UfCp5x9Hv0lnNwXO4Dr1LLHvEM890JwN2ncjm
         QFWUzC5V6donfp8i10Oc8JY6geH7UpFlJizmlyTKx1r3U2LWwomNTAq1pkR3uT/Uz7Wf
         qxRWZdF7ZemcjaLanu8qf84ndtpqKrtvaPtKINhTmaKKanFkKuatUC+ZdC0fQWuOmhFI
         Yn7mxU8FGkIxZwsrS5n0PEUXD2LwSgZNY1sHlNvSWSgd33pCYK9NH1P6XhvTQlI0gQ9U
         PAZg==
X-Gm-Message-State: AC+VfDxU6gBdOiD8jT9ZnPd8uVJ01FCTox5JCqAo6GxMGfZDHYhzdVxZ
        sS9e7TvTOZrznn4RABJ25RrvQAJjP9l8iRI8Os9VWPsZM98TEWaZ3+koGQ==
X-Google-Smtp-Source: ACHHUZ6+WeYQrAwQgl9qOclJRU4IgMRZR5i2j3aydWORpX0W6M+7rLZHhZ1sf5W41WNq+KeYignkj7N34hIkFAod87o=
X-Received: by 2002:a05:6102:5106:b0:43b:1dd8:76b4 with SMTP id
 bm6-20020a056102510600b0043b1dd876b4mr5677539vsb.11.1686595241684; Mon, 12
 Jun 2023 11:40:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 00:10:30 +0530
Message-ID: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
Subject: =?UTF-8?Q?clang=3A_Powerpc=3A_clang=2Dnightly=2Dmaple=5Fdefconfig_=E2=80=94_FA?=
        =?UTF-8?Q?IL?=
To:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please ignore if it is already reported]

Following two builds failed on stable-rc 6.1.34-rc1.

  - Powerpc: clang-nightly-maple_defconfig =E2=80=94 FAIL
  - Powerpc: clang-nightly-cell_defconfig =E2=80=94 FAIL

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dpowerpc
CROSS_COMPILE=3Dpowerpc64le-linux-gnu- HOSTCC=3Dclang CC=3Dclang LLVM=3D1
LLVM_IAS=3D0 LD=3Dpowerpc64le-linux-gnu-ld

arch/powerpc/lib/copypage_power7.S: Assembler messages:
arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b01000=
'
arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010=
'
arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b01000=
'
arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010=
'
arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b01010=
'
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)
make[4]: *** [scripts/Makefile.build:382:
arch/powerpc/lib/copypage_power7.o] Error 1
make[4]: Target 'arch/powerpc/lib/' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: arch/powerpc/lib] Error 2
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:2959: Error: junk at end of line: `0b0=
1010'
arch/powerpc/kernel/exceptions-64s.S:2979: Error: junk at end of line: `0b0=
1010'
arch/powerpc/kernel/exceptions-64s.S:2994: Error: junk at end of line: `0b0=
1010'
arch/powerpc/kernel/exceptions-64s.S:3012: Error: junk at end of line: `0b0=
1010'
arch/powerpc/kernel/exceptions-64s.S:3032: Error: junk at end of line: `0b0=
1010'
arch/powerpc/kernel/exceptions-64s.S:3079: Error: junk at end of line: `0b0=
1010'
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)
make[4]: *** [scripts/Makefile.build:382: arch/powerpc/kernel/head_64.o] Er=
ror 1
arch/powerpc/kernel/entry_64.S: Assembler messages:
arch/powerpc/kernel/entry_64.S:172: Error: junk at end of line: `0b01010'
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)
make[4]: *** [scripts/Makefile.build:382:
arch/powerpc/kernel/entry_64.o] Error 1
make[4]: Target 'arch/powerpc/kernel/' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
make[3]: Target 'arch/powerpc/' not remade because of errors.
make[2]: *** [scripts/Makefile.build:500: arch/powerpc] Error 2
make[2]: Target './' not remade because of errors.
make[1]: *** [Makefile:2012: .] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:238: __sub-make] Error 2
make: Target '__all' not remade because of errors.



Links,
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1=
.33-133-g08f336c8c68d/testrun/17475368/suite/build/test/clang-nightly-cell_=
defconfig/history/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1=
.33-133-g08f336c8c68d/testrun/17475373/suite/build/test/clang-nightly-maple=
_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org
