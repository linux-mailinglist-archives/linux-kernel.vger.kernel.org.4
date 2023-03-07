Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702AC6AE86E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCGRPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCGRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:15:30 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCEA98870
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:10:44 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id l24so9323747uac.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678209044;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KIn8EmjVZXMIksB8zjEgoQdx6+avtzvKoc8M8o1P+qQ=;
        b=wl6GoQqIn1S+5No7OH23lHBPETR7TEG95EQbuMb2Rf/gIXiCTgOrbmeHDfcl27iPaY
         rnxnxzUrqIrx61/42bhsKOjPaAI0ohNmq8epJ0hiub1txCPDWHiE54hDkvN+OQsxl68c
         9541pPkkoglAdPT5s1DdNG8MCosHCLyu043x8DvQJTChx26uIOIqo9sFUf8LZDWXKjl7
         krH4OAp99eSlpiwwTUpxAFL5XBLk/5/ITWXLBxfB3kTTw+r0t06JsQaslRFErHXWtdMn
         7ArcyP3MYVu760ofcyElxCt8c68C49mO/+MSqJEFnfB5fEZ2LwG7WkSFEO2OklP68Zuz
         0nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209044;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIn8EmjVZXMIksB8zjEgoQdx6+avtzvKoc8M8o1P+qQ=;
        b=kabXY2osN6MskfCDWI/IXDVE9sQ/9x2rtRfPIfj5ZiNFlPr2VwEdvoCgF5lAt/r5FN
         3IBxYutsy0ok9l+rDQV7+/EZCfjlOzj+4XWetSdxdF6EnH4UjdDX55onZcdtcUzIzKMf
         F+CAa3gT1fIYJs8SpAEy6O7HSSFO3Bzc9yYA4BV5v5egZYCBO14FLu/8QRe+VEeksXG4
         pSyOhsy9wu95Gpo0YzAIlhTvLgDNSQUMZq6AVXMVMYGAxRoy1Tn64h7t/u+1u4Eh/4Pc
         lKsAriGl12nH8/QfSUglnZcFb8nBBAUq5pP0TmHOIrQpLcNKOSahes7Xrm3HBGhG+nf1
         zIAQ==
X-Gm-Message-State: AO0yUKWcET6uyCfuOywoUCeMLO8ss2o3NBcVee/vxGdwbG7QtrfQgflK
        XDEVodDITBJt3Doa21E6t3Ak5Uo0px80Os8Df5mhlQ==
X-Google-Smtp-Source: AK7set/bhoohIHPplRt9TfONDspPs9BodGz0B9Efo6Mi4NSUeSJ+E93AsRJu5dzoPYGCUEnigCcibmyw6uyumYKlfek=
X-Received: by 2002:ab0:5402:0:b0:688:d612:2024 with SMTP id
 n2-20020ab05402000000b00688d6122024mr10112429uaa.2.1678209042865; Tue, 07 Mar
 2023 09:10:42 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Mar 2023 22:40:31 +0530
Message-ID: <CA+G9fYvX8W6R6FtxZbCmdeKhSikmdD9Tten8U5qXX4cG3+-1VQ@mail.gmail.com>
Subject: next: arch/mips/ar7/gpio.c:19:33: error: field 'chip' has incomplete type
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build regression found while building mips ar7_defconfig
on Linux next-20230307 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Please find the build log and details below.

build log:
--------
arch/mips/ar7/gpio.c:19:33: error: field 'chip' has incomplete type
   19 |         struct gpio_chip        chip;
      |                                 ^~~~
arch/mips/ar7/gpio.c: In function 'ar7_gpio_get_value':
arch/mips/ar7/gpio.c:24:38: error: implicit declaration of function
'gpiochip_get_data' [-Werror=implicit-function-declaration]
   24 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c:24:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
arch/mips/ar7/gpio.c: In function 'titan_gpio_get_value':
arch/mips/ar7/gpio.c:32:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   32 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'ar7_gpio_set_value':
arch/mips/ar7/gpio.c:42:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   42 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'titan_gpio_set_value':
arch/mips/ar7/gpio.c:55:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   55 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'ar7_gpio_direction_input':
arch/mips/ar7/gpio.c:68:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   68 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'titan_gpio_direction_input':
arch/mips/ar7/gpio.c:78:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   78 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'ar7_gpio_direction_output':
arch/mips/ar7/gpio.c:93:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
   93 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'titan_gpio_direction_output':
arch/mips/ar7/gpio.c:105:38: error: initialization of 'struct
ar7_gpio_chip *' from 'int' makes pointer from integer without a cast
[-Werror=int-conversion]
  105 |         struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
      |                                      ^~~~~~~~~~~~~~~~~
arch/mips/ar7/gpio.c: In function 'ar7_gpio_init':
arch/mips/ar7/gpio.c:318:15: error: implicit declaration of function
'gpiochip_add_data' [-Werror=implicit-function-declaration]
  318 |         ret = gpiochip_add_data(&gpch->chip, gpch);
      |               ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Build details,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15301952/suite/build/test/gcc-12-ar7_defconfig/log
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15301952/suite/build/test/gcc-12-ar7_defconfig/history/


metadata:
  build_name: gcc-12-ar7_defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXLAJXuaMcoIJz6Tg4y1ecnvF/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2MfXLAJXuaMcoIJz6Tg4y1ecnvF/
  git_describe: next-20230307
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 709c6adf19dc558e44ab5c01659b09a16a2d3c82
  git_short_log: 709c6adf19dc ("Add linux-next specific files for 20230307")


Steps to reproduce:
---------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch mips --toolchain gcc-12
--kconfig ar7_defconfig


--
Linaro LKFT
https://lkft.linaro.org
