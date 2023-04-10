Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106B46DC451
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDJIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDJIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:34:08 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7A3AA7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:34:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id y13so3992439vss.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681115645;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2y6ZF+9oOUd5xpzsnYpA/WWQqIIRWLv0YQ7yeTEnMFI=;
        b=LdEWgyWN5oc0YneShy1GFV80BlXsRdVOLVGntL5QZXzKMJw00sGV6ud9nsoaXXALAh
         cTmQqVYMpMbj4O5enPJ+sdLzx04GlcbnFQ7A4Y8ZdjE/zMCVXR/wx3VNYPdOA3I1a9u6
         gXJ+OS3XX7+U7bsGiyv18KMphV1RkqDfpLstm0he3r3C52LEX+D8AZ6vd+TZg2Q4XtY1
         89+zZuDkuCCof2vKmYOkcWlaffVjkZhwZYf30NkAQYz8bStQKxi+HIhY/QgSww+k3w2q
         4mrYA+nAeaNKkDeRQhzLbfhYioXJL3DOQXj1GVLFIe2fNUCwffmqk/lndEBUH2qxcdrX
         Uakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681115645;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2y6ZF+9oOUd5xpzsnYpA/WWQqIIRWLv0YQ7yeTEnMFI=;
        b=RrN7Kd0BKStvp9TzAXtSabuKfPACKKNPCnZIHQFTYKyxRPzZOIpDZ0MRdj12T8itds
         trkwcXIbbK0JK+nT/gFKs7LU1uwH7rEgk3xFXw5tUjXeBL+Kx7AbxyBvS/vFSSU0wSqn
         CiHUipzKQVgg93MOvMBuEmyEV4AbusL94XYMwM6/TTqcZWZ8kRhebrX26Dg1Ww31R4KO
         JY6h2RxDkYSFlx7z/LDLfXslWuBUo72Uk3cakAzSJw7Q20JTYiOivDoKoPCekDntWYCb
         9QAdxlwfsZzPwXH2UTRywXApeMch58ubCpt4rBHxTedWzIqYLbL3Z8yZDhIgxKFMsenB
         WLzQ==
X-Gm-Message-State: AAQBX9cMV6mQWMwMSbF9hiRXvL+m2NEH/mMtAXQV1YyZEkqPHfPwwJuN
        +agGvioqW0U7CeCopLoYg0vqBwprxFfQlRYVjDCsWQ==
X-Google-Smtp-Source: AKy350bncSFZcosjHjqQnOjeQEFT8SwcKqwSa3FsXW6R4FbtxDmAmfupWPWLtksuGhZxRt1waKe0plT2W9g0MedZecc=
X-Received: by 2002:a67:c38a:0:b0:425:e623:360a with SMTP id
 s10-20020a67c38a000000b00425e623360amr5739468vsj.1.1681115644735; Mon, 10 Apr
 2023 01:34:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Apr 2023 14:03:53 +0530
Message-ID: <CA+G9fYs9jB7V2QFBKy3WbMkGKqWSrE7iUq_t2QqCDLetws-bjg@mail.gmail.com>
Subject: next: MIPS: clang-16: tinyconfig: error: unknown target CPU 'r4600'
To:     llvm@lists.linux.dev, linux-mips@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS clang-16 tinyconfig build failed on Linux next-20230410.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang' LLVM=1 LLVM_IAS=1

error: unknown target CPU 'r4600'
note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5,
mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2,
mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
error: unknown target CPU 'r4600'
note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5,
mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2,
mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
error: unknown target CPU 'r4600'
note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5,
mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2,
mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
error: unknown target CPU 'r4600'
note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5,
mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2,
mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
make[2]: *** [/builds/linux/scripts/Makefile.build:114:
scripts/mod/devicetable-offsets.s] Error 1
make[2]: *** [/builds/linux/scripts/Makefile.build:252:
scripts/mod/empty.o] Error 1


Build history:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16119585/suite/build/test/clang-16-tinyconfig/history/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230406/testrun/16119585/suite/build/tests/


--
Linaro LKFT
https://lkft.linaro.org
