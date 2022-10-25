Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01260C28D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJYETl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJYETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:19:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A812D14
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:19:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y69so15480398ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jE7EEHygapTbBlOi1/r0KUl4gfCfTSeyBtwcchujuS4=;
        b=L5t9dACOeajWFPBBNkkOq1cpmHLOnknd3X3s7A9Oh7Q0sQCf4ta6gP6tyxXXCTH6kt
         kbPUUyHylnIoaAYJO/iY6VUhmU+ox/jHZOc6FlryTgfeDhJKM5I8o5qrs/KFsvMaqPR9
         gZSQfgZt3z2e+JLfuVb/SszSXhn7mG8jXEXth/qreoIeOt6TDiR1kT3Wn7PRrqLUuEY2
         9Em03DJ6KeajIbbxtmvFYl/C+uE7B8WepXUU2St78k2rq9gcEOWuKsZUYl+maBn7nRjz
         szLgu8eMG+jElCsW0W4iAzWpPrQS4r+JZJEgUp9RUKm5BzUKcZWQiMS6t1z85K0k7lZT
         KxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jE7EEHygapTbBlOi1/r0KUl4gfCfTSeyBtwcchujuS4=;
        b=tkk6QMq2K3G2Xp7ku2PKCCZbuNRY+TB15NgLwo4doQAgg750imnUhwZiq6SCHtuYXl
         aqMl2g9X4D4OqMkua3o26yZV9gZ/WksbbNvdakij3c1oJk4aLvndoIUtGg0msamO04hQ
         5Q0cnMo4/KdPxP6+ob/yF1PSsLL1mQ2SIhPIne7hGJLVID2+H36yMcPVfpbjbp1msUsk
         zwFq8r7fZwyasFOGSD0W9X/Tx6xloZjvKkHcYdF5dBdTvfSqx8p00EDwmYuoIiuot51O
         /lWHolrKRH9sNmEaaN1cqx02bfJMvdDdvPKrkzfrqq3/zAgffHa7j8IoLgNxaTFgqQuq
         V3SA==
X-Gm-Message-State: ACrzQf2E6kRHn+gcF05pxwmP2MT5nuJmAbUHQRT7DhT9iMK+WX7vTa0o
        1JI/LKTh+kVCSBaKsL8eREOZiOXTx/UZwOvYjyWnvOtw0VYsJQ==
X-Google-Smtp-Source: AMsMyM6vHccmjOGY9MBuk8BkT14fEDoHR/RHC3R/yIc8fKdeJMl3VSEyXK+Qd9kMNXyQ/z6B2juZ/IeVYQZZs0V96yI=
X-Received: by 2002:a05:6402:3c5:b0:45b:55d8:21ff with SMTP id
 t5-20020a05640203c500b0045b55d821ffmr34082611edw.253.1666671575538; Mon, 24
 Oct 2022 21:19:35 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Oct 2022 09:49:24 +0530
Message-ID: <CA+G9fYvGe+fHXw8RMeZuXB-rGVDjs81m9_RwDq73R+pnVpYjEw@mail.gmail.com>
Subject: Clang Build warning detected - include/linux/memremap.h:258:9: error:
 expression which evaluates to zero treated as a null pointer constant of type
 'struct folio *' [-Werror,-Wnon-literal-null-conversion]
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warning / errors noticed while building x86_64 with clang
on Linux next-20221025 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 76cf65d1377f733af1e2a55233e3353ffa577f54
* git describe: next-20221024
* test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221024

## Test Regressions (compared to next-20221021)
* i386, build
  - clang-12-lkftconfig
  - clang-13-lkftconfig
  - clang-14-lkftconfig
  - clang-nightly-lkftconfig

* x86_64, build
  - clang-12-lkftconfig
  - clang-13-lkftconfig
  - clang-14-lkftconfig
  - clang-nightly-lkftconfig


make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang CC=clang
In file included from arch/x86/kernel/asm-offsets.c:13:
In file included from include/linux/suspend.h:5:
In file included from include/linux/swap.h:9:
In file included from include/linux/memcontrol.h:20:
In file included from include/linux/mm.h:31:
include/linux/memremap.h:258:9: error: expression which evaluates to
zero treated as a null pointer constant of type 'struct folio *'
[-Werror,-Wnon-literal-null-conversion]
        return false;
               ^~~~~
1 error generated.
make[2]: *** [scripts/Makefile.build:118: arch/x86/kernel/asm-offsets.s] Error 1


--
Linaro LKFT
https://lkft.linaro.org
