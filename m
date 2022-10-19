Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023676046B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiJSNS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiJSNSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:18:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745A1D52EF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:04:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id l22so25163997edj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3VL/mzhi5Wm2xdWGUHIAE4nO6Fe2O8bP7Z+pi4mNnY=;
        b=qLKOVrL36vYKIVJTbr+QmsymiwkoR0GnSstj+Db1nLKXqpZRqq95w0cOa6xrAwfFWy
         fetrIS3OK5N+eAV02l5JS7xZuQEiLu370QZ7tCHxYTlM92JEMueSMojPeYwG7MA7O+AQ
         swLdq/zj690ykUqj4E09trLyIhnDuo/o83EmHYYg+p3hzUTbl/eICv3AVLQwwwXJq48b
         xDzqa2HkMFKBXiy8CZC4XfOKwFY9aaIZlhIhfsVGX6ThS9Ltat8V/8mnqzrh/DNWKDSQ
         n2BKxJTmCQ3EpSnO+QlTQeOHlRhvOCM72M/BAYZPQreiiucvl8GvLEafViCbNBK28OUp
         GV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3VL/mzhi5Wm2xdWGUHIAE4nO6Fe2O8bP7Z+pi4mNnY=;
        b=UyC2ekZYD/2uunVNNyoE/rGYmomdYHyvScCzuIQcwyJ+Bd633JI3ToCq8sxuif5Ymr
         tqcMiJsNOng4xWB3JHVSzVvyG0DUkbuRH1klwkKWqEn94fq4goZbwhABLxvxhVFmmq1m
         TVSnmd1NsPL4IuYwIzeGyZEhNRj+IIQTjsREIuDnh36i/XirIk8bWXqQJ5Xod68rQHxV
         hWuRVYnncbKrR44XZJzExTSjZ/SiJbAk+Xa3hbE5NyigZ6E5DcNF5RhVw+lBnJw76Tmr
         pdev/WRnHIVO1//h7l0SLc2kq6a8uBEQtDeI8aeLmWTl16W37HN/TtEOhbtPsBu9XMZS
         4oEw==
X-Gm-Message-State: ACrzQf2Mm1NxkdwRKlnSwD7sif0FYx/L4DFPeAQZTy4zaIz5IMsZ9L31
        uY3WbelmVhSs3VvbpjqICxrbE2QaJ3wbGhCVf6FTEQ==
X-Google-Smtp-Source: AMsMyM4hCSd4KMgo27A24eMkRwBD6tvC/jw40UALp2dVxz0XOx3StHwqY07dyLHa/kPw1NNkhDsD2df6Cb1WLoz831o=
X-Received: by 2002:a05:6402:5419:b0:457:c955:a40f with SMTP id
 ev25-20020a056402541900b00457c955a40fmr7132566edb.391.1666184629159; Wed, 19
 Oct 2022 06:03:49 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 Oct 2022 18:33:37 +0530
Message-ID: <CA+G9fYsfNsZs1ktOn1StM2PVgc+o1QEjKvMJ1gxEqwtgw8Dzkg@mail.gmail.com>
Subject: drivers/pinctrl/freescale/pinctrl-imx1-core.c:209:2: error: implicit
 declaration of function 'seq_printf'; did you mean 'scnprintf'? [-Werror=implicit-function-declaration]
To:     NXP Linux Team <linux-imx@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please ignore if this has been reported already ]
Following build warnings / errors noticed on Linux next-20221018 and
20221019 tags while building for arm.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc' multi_v5_defconfig
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
drivers/pinctrl/freescale/pinctrl-imx1-core.c: In function 'imx1_pin_dbg_show':
drivers/pinctrl/freescale/pinctrl-imx1-core.c:209:2: error: implicit
declaration of function 'seq_printf'; did you mean 'scnprintf'?
[-Werror=implicit-function-declaration]
  209 |  seq_printf(s, "GPIO %d, function %d, direction %d, oconf %d,
iconfa %d, iconfb %d",
      |  ^~~~~~~~~~
      |  scnprintf
drivers/pinctrl/freescale/pinctrl-imx1-core.c: In function
'imx1_pinconf_group_dbg_show':
drivers/pinctrl/freescale/pinctrl-imx1-core.c:434:2: error: implicit
declaration of function 'seq_puts'
[-Werror=implicit-function-declaration]
  434 |  seq_puts(s, "\n");
      |  ^~~~~~~~
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: a72b55bc981b62f7186600d06d1824f1d0612b27
* git describe: next-20221019
* test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221019

## Test Regressions (compared to next-20221017)
* arm, build
  - clang-11-imx_v4_v5_defconfig
  - clang-11-multi_v5_defconfig
  - clang-11-mxs_defconfig
  - clang-12-imx_v4_v5_defconfig
  - clang-12-multi_v5_defconfig
  - clang-12-mxs_defconfig
  - clang-13-imx_v4_v5_defconfig
  - clang-13-multi_v5_defconfig
  - clang-13-mxs_defconfig
  - clang-14-imx_v4_v5_defconfig
  - clang-14-multi_v5_defconfig
  - clang-14-multi_v5_defconfig-65236a87
  - clang-14-mxs_defconfig
  - clang-nightly-imx_v4_v5_defconfig
  - clang-nightly-multi_v5_defconfig
  - clang-nightly-multi_v5_defconfig-65236a87
  - clang-nightly-mxs_defconfig
  - gcc-10-imx_v4_v5_defconfig
  - gcc-10-multi_v5_defconfig
  - gcc-10-mxs_defconfig
  - gcc-11-imx_v4_v5_defconfig
  - gcc-11-multi_v5_defconfig
  - gcc-11-multi_v5_defconfig-65236a87
  - gcc-11-mxs_defconfig
  - gcc-12-imx_v4_v5_defconfig
  - gcc-12-multi_v5_defconfig
  - gcc-12-multi_v5_defconfig-65236a87
  - gcc-12-mxs_defconfig
  - gcc-8-imx_v4_v5_defconfig
  - gcc-8-multi_v5_defconfig
  - gcc-8-mxs_defconfig
  - gcc-9-imx_v4_v5_defconfig
  - gcc-9-multi_v5_defconfig
  - gcc-9-mxs_defconfig

Build link
https://builds.tuxbuild.com/2GKpciP8HzSjXDbeqau9HpFlipH/


--
Linaro LKFT
https://lkft.linaro.org
