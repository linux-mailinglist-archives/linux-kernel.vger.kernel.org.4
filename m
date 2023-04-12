Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FEE6DEBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLGVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:21:26 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29906AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:21:24 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id e20so9476920vsj.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681280483; x=1683872483;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJtC3FxClBPF9KjFwCjvXT4lKY0caN5jqIDZIqAIYeQ=;
        b=HWsv5qF4EZh2q9Ub5agE8aOHO19UMcdyYlsxUFZYaE0VvqQ1VP62eOaGoSi4R6f+UG
         s25S6HnnkKPQQ8nus5pRlqKJv156P6La7MMiH7/TYbCmaBpVVQQQZvUMzZAVeeaEe0hI
         rC3v3K9S0WOVPHc08gRfG1hmQvc9v3S+NGompZiZaCwnfuc6jplY4jXX7CiIvFSLJrmk
         0YjDM6PEUtyGVHXFMWFRefRiLJlinxYGXbubMiMzPMui+ZngN+A6J/IHOwU3mwz5QQOE
         v7ziyNnz/MGZrbFZB3ddiLrN7h4OqH92GuMVVhybndo+4RWdWoTpI4VGv+JISijkCxbF
         tdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681280483; x=1683872483;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJtC3FxClBPF9KjFwCjvXT4lKY0caN5jqIDZIqAIYeQ=;
        b=miDWhZuuWfbYXd9zWvcbHW8uiB1iiQM44xK6Qpo6iuQ8Im2NJf5vMyhpCe163iiKms
         uLiNXPM6Eldktcw30hJf2E19QcITqwAQrM69U5HCjnYhL+CF5nkrmgnT0xIlhn4WWdwq
         b65jD2pDvwuX+Y2PKa7yNO0gikHarn/km7+QDamsH8/TFjPALRTJzici8BdBtq8dZ5+z
         0oQdj1I/7xB/OZJa0vewTR+gqpoZSZSJD1sInKUAjcqVIAHniR6mxY734ayodxitGGt8
         SEjKQjBH08KmWgK24saj0JqCibLBkfQEH+z/ZFuKNPO6KuzHSiqwoNQcjkefRD+/+JjS
         LIGA==
X-Gm-Message-State: AAQBX9cJ0hlMFNJlfGmgOvGb+7/dDt4Y0JqnJv0aRrj10QJeqTeR+YY7
        u0Lf3mQfO+2N+9MqlP9+gmBGAe3fPGzuB3wC9+Non3R3R7AF1weymaw=
X-Google-Smtp-Source: AKy350a0vqqap07Vvf2s+L+rkB3Oghui8XnIa1r+4K+6Oa05z431j/fJMkzVKOOIU4n2ReUNHZzwlDr1cuLO86EKDxc=
X-Received: by 2002:a67:d20f:0:b0:426:392a:92bc with SMTP id
 y15-20020a67d20f000000b00426392a92bcmr3551765vsi.1.1681280482741; Tue, 11 Apr
 2023 23:21:22 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 Apr 2023 11:51:11 +0530
Message-ID: <CA+G9fYsWEYWjPYLOiSuKfsqLzzbvq8p=mATJLahobEhTWOJ5+A@mail.gmail.com>
Subject: next: arm: #pragma message "The platform is deprecated and scheduled
 for removal
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
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

Following arm build regressions noticed on Linux next-20230412.
We need to investigate the list of platforms that are getting deprecated
 and we will stop building platforms.

Regressions found on arm:

- build/clang-nightly-s3c6400_defconfig
- build/gcc-12-s3c6400_defconfig
- build/gcc-8-s3c6400_defconfig

arch/arm/mach-s3c/s3c64xx.c:423:9: note: '#pragma message: The
platform is deprecated and scheduled for removal. Please reach to the
maintainers of the platform and linux-samsung-soc@vger.kernel.org if
you still use it.Without such feedback, the platform will be removed
after 2024.'
  423 | #pragma message "The platform is deprecated and scheduled for
removal. " \
      |         ^~~~~~~
arm-linux-gnueabihf-ld: arch/arm/vfp/entry.o: in function `do_vfp':
arch/arm/vfp/entry.S:27: undefined reference to `vfp_entry'
make[2]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1

--
Linaro LKFT
https://lkft.linaro.org
