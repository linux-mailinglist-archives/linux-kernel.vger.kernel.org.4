Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03BF6B233C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCILlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCILlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:41:09 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F0E061D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:41:07 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id f17so899012uax.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678362066;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=teKjzQksFpPGJFCU9fN82LdVpNRb9d5I1zD9wQeb0aw=;
        b=pdjUL/w/rLtYnlVJvvjRWsGrA9h2JihcJYK9Yw8UoPW5WOJZe75MXSU6rbbbaiplBa
         5129r6lTYABkrxyDFSGy8dTxUK48js8aDCtTPWlhRRiaekGriYxBWNIE8xS7UxElayQI
         /aPY8DvnPx/hd5JOcRW+IZa11vhj4T3DGhuRN6hPdKS8rJQXOyBoLsoKJaV/3Quw3H1X
         niEnvOzo1tcSckR/7dvFJm0ilAnzY6t5meYbYZtyryNmO2a4Ubk75YoBLhZ7MUJwKS9d
         73nFfSPUff5pP9cu+qPvAZirPGfkAscUHpf6c6az1XAD3uCPrFFg0Mj7F124r+4MhNWU
         0tDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678362066;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teKjzQksFpPGJFCU9fN82LdVpNRb9d5I1zD9wQeb0aw=;
        b=Z7hnKhzs4wW1qneKtClIThVfgtcDYeVhBltoBRk0acr1cjg0eucdBuDL+mBbIxFuvo
         QW7prPCPbOP2XhFzzTW+xfmVUhqUmLpFYoNtlaN8/MR0XMtnfIGU91Jtm+4up5GxBmRk
         GUfrEYTMd7qc4uH6rAY/Y96gYwnkQtjMguQL0fMjiGMQkcDc0/Ys9fei3hMexboMwAfz
         Go1WmakUikuZT0BvoyJG1fY2lyzZvnE1ewFfxpPUvs2bHRDwahoZTuozZ+/gnnRsNWVa
         IKgmTxjRKaWeBJizhYyuEB3hopk83DG0b+AUNnoP3QL+FKBoFawOfMaXFupF46Z2ZAKl
         rFUw==
X-Gm-Message-State: AO0yUKW7N4Z6A9NCoGXanQe+85XsXiCAhDECS5bf6RCYgcRZ7sO4LVUz
        VV76l0ePO6wt45JMGRwdbL2RBsug6/Qg/42Xg5yMnA==
X-Google-Smtp-Source: AK7set/TJMQosQtQJMA0HdpRI0HfxO5Euyv0welCfCiiHVg46yUefioyU54rQoQ9a6NZdh7y8umrO2iItsmGMSqf7rI=
X-Received: by 2002:a1f:9817:0:b0:400:ea69:7082 with SMTP id
 a23-20020a1f9817000000b00400ea697082mr13440817vke.0.1678362066381; Thu, 09
 Mar 2023 03:41:06 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 9 Mar 2023 17:10:55 +0530
Message-ID: <CA+G9fYs7suzGsEDK40G0pzxXyR1o2V4Pn-oy1owTsTWRVEVHog@mail.gmail.com>
Subject: sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of
 undefined type 'struct gpio_chip'
To:     Linux-sh list <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build error reported on sh shx3_defconfig on Linux next-20230309
and started from next-20230307.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
arch/sh/boards/mach-x3proto/setup.c: In function 'x3proto_devices_setup':
arch/sh/boards/mach-x3proto/setup.c:246:62: error: invalid use of
undefined type 'struct gpio_chip'
  246 |                 baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
      |                                                              ^
make[3]: *** [scripts/Makefile.build:252:
arch/sh/boards/mach-x3proto/setup.o] Error 1
make[3]: Target 'arch/sh/boards/mach-x3proto/' not remade because of errors.
make[2]: *** [scripts/Makefile.build:494: arch/sh/boards/mach-x3proto] Error 2


build links,
---------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230309/testrun/15403540/suite/build/test/gcc-11-shx3_defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230309/testrun/15403540/suite/build/test/gcc-11-shx3_defconfig/history/


metadata:
----------
  build_name: gcc-11-shx3_defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ml9hI6V0nIKrCQbtRVoxCOy7BY/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ml9hI6V0nIKrCQbtRVoxCOy7BY/
  git_describe: next-20230309
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 2c6433e9294b6d0f4d8f08c3c70a3eac434d3ec8
  git_short_log: 2c6433e9294b ("Add linux-next specific files for 20230309")


Steps to reproduce:
----------
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
tuxmake --runtime podman --target-arch sh --toolchain gcc-11 --kconfig
shx3_defconfig

--
Linaro LKFT
https://lkft.linaro.org
