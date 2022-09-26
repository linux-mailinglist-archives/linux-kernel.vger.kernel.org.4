Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78335EA94F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiIZO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiIZO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0657232
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:27:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so14008269ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=u6JTozXkaxXd5dDyL6DdTZJyXx50+ggpWDL0I2wBcQU=;
        b=SsQaJIKhxrx7j/q13DR0D47KqLq3az7r7OjFmvoOBxgW4wAo+yfwgdAWxnwmIqq3xH
         NFdY8eZW3Y95qE+W1FCcsk8LqH4kRVzFclajptKCfPmhrmbWN4aShgLRSnqaefsZLbvu
         yH8CMYZT6ggl5CV/d4uyoOVJGbvBMrL5ltNLvNwyFbdMxwma+vD+uOlDzhQS7gMTApyJ
         pNWalA07zHjVmB6A7B/sj0k8M4DNc9MZwYrhGFurk7HkJ4SiO9C/sjNofByO22rpMfHm
         6qV5NYrwWpQbkcXFbOfeIKqXSPeKHu1xNN3xrdamlZBstRnI8v1EG2w6P/CkKxKidoO2
         2WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=u6JTozXkaxXd5dDyL6DdTZJyXx50+ggpWDL0I2wBcQU=;
        b=UHgqLX4Yk/+w1LOng71z0XF3A6/TdZwCi1+tqviihV3WgJzzlk3pPuotBg0g3l4VAw
         lPUKyd6a+Iqi39+0JIOm01twn9xFpwe24d50pNWEZwvAJMmbtyND8g/GNM50OpIqwiCd
         54KPo0zwoSW/QirAlLyrD6pR+lgYyK9yAIwOaLasJfijvXhAq4YamIvpcoUFlqVVX/ub
         zdsl2C28nD4igPkk6phxHxA8jxw8uXP9GuLGdg90HXc9p3GRvn9c8QxJ7LSxAPOZ99Gx
         rBtFgMotXmIIPfDlBOUFZ6mqfYJL+0lYN+IJfaZKbXS8UKAuYKhqvtpu9rQccbTJPb8a
         KuQg==
X-Gm-Message-State: ACrzQf1hXjIWCmQDiRHXjNd1kVxZUeKsTO7+95byVrjbAfB3e4Ek9KqQ
        tSlnhG3lM5C/pm21PXAB9m79zZgm1lsErEMHnPeJwLm8xnphnw==
X-Google-Smtp-Source: AMsMyM4xbs6QkPMZUssp96ywiRoPnHbhhDadj6GaYovJ1TEbuwTk7ysNh+k94OuaEnPAp92gPeMRgsrCipNQb+tXFcg=
X-Received: by 2002:a17:906:fd85:b0:77b:b538:6472 with SMTP id
 xa5-20020a170906fd8500b0077bb5386472mr17913125ejb.48.1664198831674; Mon, 26
 Sep 2022 06:27:11 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 26 Sep 2022 18:57:00 +0530
Message-ID: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
Subject: arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
 .save or .vsave directives
To:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings / errors noticed on arm with clang-13 / 14
on Linux next-20220923.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on arm:

   - build-clang-13-bcm2835_defconfig
   - build-clang-nightly-imx_v6_v7_defconfig
   - build-clang-nightly-orion5x_defconfig
   - build-clang-13-keystone_defconfig
   - build-clang-13-omap2plus_defconfig
   - build-clang-14-imx_v6_v7_defconfig
   - build-clang-nightly-omap2plus_defconfig
   - build-clang-nightly-multi_v5_defconfig
   - build-clang-nightly-bcm2835_defconfig
   - build-clang-13-imx_v6_v7_defconfig
   - build-clang-13-imx_v4_v5_defconfig
   - build-clang-14-imx_v4_v5_defconfig
   - build-clang-13-orion5x_defconfig
   - build-clang-14-multi_v5_defconfig-65236a87
   - build-clang-14-lkftconfig
   - build-clang-nightly-imx_v4_v5_defconfig
   - build-clang-13-multi_v5_defconfig
   - build-clang-13-lkftconfig
   - build-clang-nightly-keystone_defconfig
   - build-clang-14-multi_v5_defconfig
   - build-clang-14-orion5x_defconfig
   - build-clang-14-omap2plus_defconfig
   - build-clang-nightly-multi_v5_defconfig-65236a87
   - build-clang-14-bcm2835_defconfig
   - build-clang-14-keystone_defconfig
   - build-clang-nightly-lkftconfig

arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
.save or .vsave directives
                "stmdb  sp, {sp, lr, pc}        \n\t"
                                                  ^
<inline asm>:3:2: note: instantiated into assembly here
        .save   {sp, lr, pc}
        ^
/builds/linux/arch/arm/probes/kprobes/core.c:412:29: error: .fnstart
must precede .pad directive
                "stmdb  sp!, {r0 - r11}         \n\t"
                                                  ^
<inline asm>:6:2: note: instantiated into assembly here
        .pad    #52
        ^
2 errors generated.
make[5]: *** [/builds/linux/scripts/Makefile.build:250:
arch/arm/probes/kprobes/core.o] Error 1

build log:
https://builds.tuxbuild.com/2FAyD1qcTlzjIYE7mjrugjCsxu1/

--
Linaro LKFT
https://lkft.linaro.org
