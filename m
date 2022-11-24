Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9B637D15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKXPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:38:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C72E9C9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:38:00 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-381662c78a9so18638697b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+9+t5BCEz2/cOATY8b1f1ZAF/h7b08cMGTn/gwCEHcM=;
        b=uqy6I8rFSXZ7T+0oxJPrQrZb1rD5KZFZS0UsiTPqAst7mHOW4CYPTWaktZapM/5+nF
         WTBUVPLyrreyASEYTmcAe18mictzVkmPWGw9uGCNKJVPo7oMu/wI3btQ4DXNFub0DZ7B
         re3zNlPS++ZT/+EccQl5cqTRQCxHrYCgET4P1r87/AVOz/S/ebHKTIhD6AYf+I5vD/aT
         RuSzWeuMmTyz0qFwS5PBCqWp0PVM+2DEIg3XyE5fZ0O4mic7xK2nbglBF57jVa3h0NWm
         CnOLEjuc+D0UkMOyQjNUAHp2Q102jaImw/BWLD3cQ910Ok6oPNW41ZeNzTI267Rl83bx
         TWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9+t5BCEz2/cOATY8b1f1ZAF/h7b08cMGTn/gwCEHcM=;
        b=tS3IeLnyKMkQqc1M+xUx+HKi3AlPwHnnPrJTPLIDLB2/HU/DBOcIDyEBxnpI/Sqzxp
         11/qsNkOUEvR10BRwR/RjWTj6bf9SB65nfQzFmzDONbkXxpETzRr52KyWaUYtLDSbTGA
         VZ4vpy5E6iwCi10NYVuQLMhF9XKIxF5+cddTh03d3NHDTDob1HcUHW4lzou/3EBBb4L6
         EojLDnWsHooJ/2DXemu6Y53xkHp8alcXas5Qn8mAomc12m0r5UVPasfQxb1CRIcPlXR2
         JqeBUxjPaNqcrxIixZqfgjDg9nPf13XMFM0gMiWe1RJkteHprJHLG7005UZ3uUTKanRW
         qx1w==
X-Gm-Message-State: ANoB5pmWhImoc/bMQbDbE7ufMAZJS849j7xZaxkgMDfdPmEqTLLi9bHx
        +PY2pA73lufUYXpx89kMkypOpY7UQn28w9ZVJUC0vg==
X-Google-Smtp-Source: AA0mqf4e0pqZj2Su1ieUS51maEc7fAR4/V3WqT4wVlDMaB9yE7UkTBhoD4iH5GzzwqUaZvnrtE+BKyxQkNd54zC9AUM=
X-Received: by 2002:a0d:db8d:0:b0:3b5:ea43:e343 with SMTP id
 d135-20020a0ddb8d000000b003b5ea43e343mr2430329ywe.259.1669304279374; Thu, 24
 Nov 2022 07:37:59 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 24 Nov 2022 21:07:48 +0530
Message-ID: <CA+G9fYtMoRLC0-9hnpw6+fb_i-6jqLNQH83Q90JqyXO7aCJwNw@mail.gmail.com>
Subject: next: x86: clang: mm/khugepaged.c:1428:45: error: variable 'pmd' is
 uninitialized when used here
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, vishal.moola@gmail.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKFT CI system noticed clang-15 build failures on x86_64 and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
'HOSTCC=sccache clang' 'CC=sccache clang'
mm/khugepaged.c:1428:45: error: variable 'pmd' is uninitialized when
used here [-Werror,-Wuninitialized]
        page_table_check_pte_clear_range(mm, addr, pmd);
                                                   ^~~
mm/khugepaged.c:1415:2: note: variable 'pmd' is declared here
        pmd_t pmd;
        ^
1 error generated.
make[3]: *** [scripts/Makefile.build:252: mm/khugepaged.o] Error 1

steps to reproduce:
------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch x86_64 --toolchain clang-15
--kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft-crypto.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/distro-overrides.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/virtio.config
--kconfig-add CONFIG_IGB=y --kconfig-add
CONFIG_UNWINDER_FRAME_POINTER=y LLVM=1 LLVM_IAS=1


Build results compare:
https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20221124/testrun/13170041/suite/build/test/clang-lkftconfig/history/

Build log link,
https://builds.tuxbuild.com/2Hz2wymTKCJRrwkDTV5zeM4SkJ0/

--
Linaro LKFT
https://lkft.linaro.org
