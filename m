Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4172F7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbjFNIiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjFNIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:38:08 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10ED19AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:38:07 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43f4167d2b5so362119137.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686731887; x=1689323887;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=499kRowY3ut9w2IKIu3JV66393KagO/V1ETX0vASsbc=;
        b=LxvRjJ7JwDFLylNnpGILWNurpnw1hh/O40sM1l/wdLvZ2JJSacZ7w0qHOYb2n8s15i
         /poP/ZQNHt8EU5R/hDkZQZMZQmasYtwXmjg0psamwdmfYjsYByxAnJ0trPXmkLP8jDhf
         qOjWOjJvQOgOTfA5tUxysjS+CHq8ntadZUEI27D/qD74buhiKx8KkoyxVGgQzw7C1wAW
         HpSDyWTcX0AtZ2DSpwKGudi/V4s8jzp5ujXrY8r7q/K2Gtc5ueZz3PEsnkjJVOx9GViT
         g4GEMFtzZAa0EmnQhiAJKaWg9kPYe2L7guswYCvGB5kuGHMw5qrWATDK6v3Ph0rVWb4o
         GUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686731887; x=1689323887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=499kRowY3ut9w2IKIu3JV66393KagO/V1ETX0vASsbc=;
        b=jvbMFm/vkM4Gib0io0GyDvFnBtj5HGUACdLhe31egXsub4Z3gYp4cWE3vbVNhDmznq
         gFpbiga2/pHk87zEt9uO3lk+uuKLI0ibOuGBYIPmXtSgGv78BpG0lHnzJ0XAQdr86Ua5
         2pZkNlMPRAXnRll8xyUHvMAksfqjcmXS4gTqhsb+kU1SsBRSrsIUDORWOvYpRjgoGhC/
         +96Rv/Ej5xZIpP0Js22NkmzJYyNBdcZxD7QGTOvtcDupwkHyHzqR++7fGohMk/RSnZjZ
         pMY1os1kTGIUW87LnA/yeFbLwG5B6N/w2ziiehmKAayF0PbfVXoNycz+FX9fkNdZZ+5I
         neNw==
X-Gm-Message-State: AC+VfDxsbAZHn/E12yV0hN/snQUwDOu6Eoq74gZMlZ5UeWUrCxI6WU8W
        PfbO3wxVuztdwMvwj2dgQ73hdCj9Fqn/tR22UmG5CQ==
X-Google-Smtp-Source: ACHHUZ4WDsuhUexTCWukKx0TSGAFzdA2OXi10yxdIqOYR0kanqWSlUu8lE8c33eJwusuthaOehwbksyMtjNZf4pQRf0=
X-Received: by 2002:a05:6102:301a:b0:43f:5036:677e with SMTP id
 s26-20020a056102301a00b0043f5036677emr190974vsa.6.1686731886786; Wed, 14 Jun
 2023 01:38:06 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 14 Jun 2023 14:07:55 +0530
Message-ID: <CA+G9fYu0GLCFUKsqod7cO8jku7Sp6b7gRqFo1sz7oxfpC78GGg@mail.gmail.com>
Subject: next: drivers/char/mem.c:164:25: error: implicit declaration of
 function 'unxlate_dev_mem_ptr';
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regressions noticed on Linux next-20230614 and next-20230613.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on sh:

 - build/gcc-8-microdev_defconfig
 - build/gcc-11-dreamcast_defconfig
 - build/gcc-11-microdev_defconfig
 - build/gcc-8-shx3_defconfig
 - build/gcc-8-dreamcast_defconfig
 - build/gcc-11-defconfig
 - build/gcc-11-allnoconfig
 - build/gcc-8-tinyconfig
 - build/gcc-11-tinyconfig
 - build/gcc-8-allnoconfig
 - build/gcc-8-defconfig
 - build/gcc-11-shx3_defconfig


build log:
======
drivers/char/mem.c: In function 'read_mem':
drivers/char/mem.c:164:25: error: implicit declaration of function
'unxlate_dev_mem_ptr'; did you mean 'xlate_dev_mem_ptr'?
[-Werror=implicit-function-declaration]
  164 |                         unxlate_dev_mem_ptr(p, ptr);
      |                         ^~~~~~~~~~~~~~~~~~~
      |                         xlate_dev_mem_ptr
cc1: some warnings being treated as errors

steps to reproduce:
=========
tuxmake --runtime podman --target-arch sh --toolchain gcc-11 --kconfig
shx3_defconfig


Links,
===
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/test/gcc-11-shx3_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/tests/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230614/testrun/17514799/suite/build/test/gcc-11-shx3_defconfig/history/



--
Linaro LKFT
https://lkft.linaro.org
