Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5777382D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFUL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjFUL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:28:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A8EE72
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:28:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so73933601fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687346927; x=1689938927;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4R8fi9cYEPann0vyPeei/XBYWeLBvD08A7Gh7y01sdE=;
        b=bq0jNGfoVdWVdBkIePcR2DdDezrb/Bt7PnT50R2UdEYleSd/Pu6NAPVe3l6PgAbyyK
         UNgMgLLfO1wP9pDDQzrwEdhNICLnywylMesfKaj+JbRgVC92XA+QAHvSgU3/6Vk8iSue
         In/YWUXS1H1bY3x0udkE7NKU4kNR8WLeNT65QGpilzHZM59EuElzS9rQBkJzaZyPlkbU
         8vEJ9S1x7dfiLwR7wBccDimJXa8wjR0wdZS1v82PChE1JP7cbWGOURiXagumljnBy/Le
         vPDVTivGancHY/Nfosv8M6hv5AsKBFi3i/ZeCylVi6g8Rz7BNQhnFfDkZpGKYPM8SDuS
         SgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346927; x=1689938927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4R8fi9cYEPann0vyPeei/XBYWeLBvD08A7Gh7y01sdE=;
        b=RGuUOqQl/b58RVUaa1OID6k05Vyz1HbD7p1TmwX2HCn7b4PVi7XDlhE6cEMw5hlOR6
         lS13q/rbHMOWqlPb4ouakvNfmzn2rDatCIQXwG1F+smPXGE4GyoyKP9iEv8nbdjs0+n5
         6wAqSfDJsLZvjy4eFPuLwO+Qq0k5LnwWi4P1nKZjpujXHnO6uDLapc/1KvAJ6+dTigNV
         P8sFaCRzQzxOxh0MmFBpfHFv6NihoOwBS/kzk3smx86wBCmwQPsGHR5APXHgp3aJfjTI
         vVVPjsuvc07xQIbV6a3gdGy1aMJ9ck4ZW3Q811GVNNJnHFrmYgbNwlLMtYC49gdBjjpt
         GJ2A==
X-Gm-Message-State: AC+VfDy6ahUi1W6YGNBFXjpvbRYrx00ayEdY2eHVrGoymxsI5xNZYC07
        UWnbG7OT3kIr6A0hkNEXX/gTgAi9Ot73+R50GagDVCOiW88/QSHFcF9ikw==
X-Google-Smtp-Source: ACHHUZ5HtzMh7LUuRksb6o3JVrqkR/L5C9aO96+ELySDfrXwynxSqfswwDvIB6mKQsvwyuS6UvwKeVb6Md2wgbHq2fQ=
X-Received: by 2002:a2e:7003:0:b0:2b4:70b1:af01 with SMTP id
 l3-20020a2e7003000000b002b470b1af01mr6906098ljc.20.1687346926934; Wed, 21 Jun
 2023 04:28:46 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jun 2023 16:58:34 +0530
Message-ID: <CA+G9fYtoB7nxiNp23PyHwZpODwA0OPFfbUaK_PWiV9DO34VKjA@mail.gmail.com>
Subject: next: drivers/irqchip/irq-mxs.c:12:10: fatal error:
 linux/irqchip/mxs.h: No such file or directory
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regressions noticed on Linux next-20230620 and next-20230621.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on arm:

 - build/gcc-12-mxs_defconfig
 - build/clang-nightly-mxs_defconfig
 - build/gcc-8-mxs_defconfig
 - build/clang-16-mxs_defconfig

Build log:
--------
drivers/irqchip/irq-mxs.c:12:10: fatal error: linux/irqchip/mxs.h: No
such file or directory
   12 | #include <linux/irqchip/mxs.h>
      |          ^~~~~~~~~~~~~~~~~~~~~
compilation terminated.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17700541/suite/build/test/gcc-12-mxs_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230621/testrun/17700541/suite/build/test/gcc-12-mxs_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org
