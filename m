Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43F6E9164
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjDTLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbjDTLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:00:53 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC0A5E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:58:30 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id p12so1805546uak.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988287; x=1684580287;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OlkpqVPsMGBCHCwPiGXeltlqZgDhFYvIj0YwaJwjXcY=;
        b=SV6NOe5HXGojj8j858toAmnSCAUSPE+WaKKDGb4VN2CvbQQri0Qft/DJ2/u6BcgzIJ
         FP9KTi9YL+RDIsLWGjjdaTD+mwNxmS81RD6Kv75eL8QiZqvJ5D/5HnBNXxAXTWpzmD5c
         ByPMIyHMuAyJ2PH12t3+7r60A68vWdORNBRVkrNLSL1KjQ+L2dlt8PJyFucLhPNQ8EWe
         tL49nbKGktraXetVBfH1pqPCuS3fH/RauI+qN7JXAzO9XPUTml6aFgFtHD3g0hwqhatJ
         dvV4v0hO76lzr9KdIbk6DYwHAn2C52Ms8rtGrYA0V4HoCzc5ZL4rLxX9rgRVERyISyUq
         /CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988287; x=1684580287;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlkpqVPsMGBCHCwPiGXeltlqZgDhFYvIj0YwaJwjXcY=;
        b=OOaAZmpTCbEdC/6NMROTeth4fky5vVxkmmNGt33ktAYJe17ZgTHODG1NCKfMjHjcG7
         vxDcDd0VSpouJr9nastfZk/Myga+HvSP7zQlR3F2wqQgUmGD68ZMzzIqluZttV5WYsvD
         XJ5TqXALjynRWnO+4twOmjT+PCJITgKvTd4bM5mFW8z1XaWArj0uQ9zSdDSAeFfLHJMc
         LhwSXrxPBpq7Gi2PxVfH8IgeO0qC5+oL57sXuM81ZVnB4On7Y210d14TG8cKLRXI5yFt
         RBzQ//xG/csvurZ7VLS+3vzQWKRxPa2vrLW/Wy9gulUKHS0VfUFyMq09GnYmPI4DBFsv
         nwAg==
X-Gm-Message-State: AAQBX9cvJaYkG3diWUdIj6zNidX8Ijyyhjhhe/CZU6QekBBVDo6fDU3T
        lSFo+yrjbeG1FyRGEzBLDQqD8svTifbo7VUlDk1P/Q==
X-Google-Smtp-Source: AKy350b7fx0YW1+BNZLLBmYhRSGLKi7LfzgDknAEsvAl3PAP80GeDmOlnQyMN2RGFNnwI0N5D1wvi1oRdNQ/BUlwORQ=
X-Received: by 2002:a1f:4114:0:b0:443:e263:2dff with SMTP id
 o20-20020a1f4114000000b00443e2632dffmr377711vka.7.1681988287392; Thu, 20 Apr
 2023 03:58:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 20 Apr 2023 16:27:56 +0530
Message-ID: <CA+G9fYsdMioe4+DEgeh38aTeaY3YaN_s_c0GFjPHhuPWfxyetA@mail.gmail.com>
Subject: next: powerpc: gpio_mdio.c:(.text+0x13c): undefined reference to `__of_mdiobus_register'
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        ajd@linux.ibm.com, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build failures noticed on Linux next-20230419 for powerpc.

Regressions found on powerpc:
 - build/gcc-8-defconfig
 - build/clang-16-defconfig
 - build/gcc-12-defconfig
 - build/clang-nightly-defconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
powerpc64le-linux-gnu-ld: arch/powerpc/platforms/pasemi/gpio_mdio.o:
in function `gpio_mdio_probe':
gpio_mdio.c:(.text+0x13c): undefined reference to `__of_mdiobus_register'
powerpc64le-linux-gnu-ld: drivers/net/phy/phy_device.o: in function `phy_probe':
phy_device.c:(.text+0x56ac): undefined reference to
`devm_led_classdev_register_ext'
powerpc64le-linux-gnu-ld: drivers/net/ethernet/pasemi/pasemi_mac.o: in
function `pasemi_mac_open':
pasemi_mac.c:(.text+0x19ac): undefined reference to `of_phy_connect'
make[2]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1

Build details:
---------
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230419/testrun/16369015/suite/build/test/gcc-12-defconfig/details/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230419/testrun/16369015/suite/build/test/gcc-12-defconfig/log


Steps to reproduce:
------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org
