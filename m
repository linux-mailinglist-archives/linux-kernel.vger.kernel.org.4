Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804ED723C20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbjFFIrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjFFIrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:47:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937BF4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:47:34 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-437e6ffa660so1409329137.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686041253; x=1688633253;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vPzItteNtao+YX2FbM8/rysut6Tk9dQVilNxpZkVgzA=;
        b=HqUxxfmVhiaWGaexE8Xb1vP01EV/Lr1DGPmtIdT/oBaFSMrbzSA7bF/zS/DxG9BuiG
         8QbFSBEf3oCN5lKHUG1csB+Sr36Gx33Lv3Diww2h1/D7x4wzV8PDILnJ8Njv5q5SgUtE
         QmthRiRoUkOMd3QuGZhioNaoVZ3gQmPvYvCzHYe5h5sUt0NcWWAAJf3P8SSgpkQXJXZG
         Qcq3eTnyjNV5SqzR3DhRcmVBkFyXsuZv2dWaol7/L1ztTI69xU1+8ZMtSj6vYVXEv9C/
         xYSaaOh/Ck1gGxQJpSvz4DlDUgiG76Fe9oWhgIF7K8Pq+wZAEme6yh9ZUL32OgDPSQc+
         oeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041253; x=1688633253;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPzItteNtao+YX2FbM8/rysut6Tk9dQVilNxpZkVgzA=;
        b=at+yeSRr4MaVuhnLlh4F4awXYvauMbKr6QelqND5nhPSjF7VAaEyVTJ/Se9ODZlLta
         rQdtUknE2q/pHbRhgSiClUNdtFx8N+FiCZ0WqcLaZFWBSNwsUNRGw+YnDXi6yUzt6/nA
         ZoI7IbVdK6R3sHlgyut0lhc1GthFFCU92Uvubj708qEy5GhmrL6YOFhdAjW7uZHdN7Op
         jjyhU/9gqzDeIZ1QGq4tbwuPt7k/cxbpyLJvPAxqMrNatvgKpsr4yuxSY26X2is1x7Uy
         AZdyDpaL2Ai78cn4t7iG9Zcjm73bmCmefuHkM1xPdt53DvUCDl+PA6GecI7VgJy2gAKG
         rWmw==
X-Gm-Message-State: AC+VfDzw8Xo2IUoPJAojWGGGAjNY+cuHGciaZsacWHqo7cFieFgKy4tZ
        ec1H5K6/Di7oIhiXeaF0RRqdnnZ8IsiWkejllVt6t5L2N+pkK3KfzGk=
X-Google-Smtp-Source: ACHHUZ6M0VbEpBR3xvgxWdprNCWe6vkpORlSkghO/R13HK9fvMgepkWPezLh27ZmsCxT/zpLB1TsiWPrzkHhpbGn7WI=
X-Received: by 2002:a67:ec86:0:b0:426:20a8:a5b0 with SMTP id
 h6-20020a67ec86000000b0042620a8a5b0mr778337vsp.13.1686041253410; Tue, 06 Jun
 2023 01:47:33 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jun 2023 14:17:22 +0530
Message-ID: <CA+G9fYv0a-XxXfG6bNuPZGT=fzjtEfRGEYwk3n6M1WhEHUPo9g@mail.gmail.com>
Subject: arm: shmobile_defconfig: ld.lld: error: undefined symbol: lynx_pcs_destroy
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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

Following build regressions found while building arm shmobile_defconfig on
Linux next-20230606.

Regressions found on arm:

 - build/clang-16-shmobile_defconfig
 - build/gcc-8-shmobile_defconfig
 - build/gcc-12-shmobile_defconfig
 - build/clang-nightly-shmobile_defconfig


ld.lld: error: undefined symbol: lynx_pcs_destroy
>>> referenced by stmmac_mdio.c
>>>               drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o:(stmmac_mdio_unregister) in archive vmlinux.a
make[2]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

links,
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17347517/suite/build/test/gcc-12-shmobile_defconfig/history/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17347562/suite/build/test/clang-16-shmobile_defconfig/log

--
Linaro LKFT
https://lkft.linaro.org
