Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345E72385B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjFFHG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjFFHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:06:56 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39EC5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:06:55 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-461da1198afso880177e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686035214; x=1688627214;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C1ozZq870KAb+6oNoYDYw8jrsSo5Jl0b6K0qLqBb3b0=;
        b=rbXA8IfhANxbtLxUs+ybhYlcSzwfA5IggOmY5ZjCC4g7EmN6wmxl3e/k55M7e3XQK0
         iEIzXDN3lRYbkqhfAn77UF7lWK1OAsHxoA1UAU0JNjm2zUCBzBHd3RKK0i2P9NHVRhHL
         75BiueWX0Z5l3f4njQyUrBcEopYMF7Hgi/TmqZwQx7gFjaHoerpKfMOFiVoSakehqUwk
         aOoaTE4G/Eca+zkIwg7kduFjJeiJuNyCOTHiub3PDofWVjm0F1n1EOYgpuGKD1RnVzxw
         WkCI0S2XDfBZWwsF+csMt394c9QyHoULlMZMXZju6Hqj0UxvWUSRmaQqsP7bny5tbu0V
         0BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686035214; x=1688627214;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1ozZq870KAb+6oNoYDYw8jrsSo5Jl0b6K0qLqBb3b0=;
        b=JsTID+abPWbQUdsxkvyNhiUUhreQs+vre6Ro6FHYWFM8Lg9/EDB73t04QC0ehi33ex
         28Rd/ulwYHWXxVc0QocEtAAGViSkKE1d9pxo/3FxRu3ypETZo/2gnrVYm8KZGT/o2nrG
         ZNlNMmhhN0kHtOgg/1rMFHGtZOVHnRQ0kzu3p4LKq1qksvo0KaSQoW5MnH7JyW0v/1ac
         QrLZo1zgvy2xWQ3C0QYQpbTUnDWbrItGkxEH2bS8+X5rXAcI/Z0wfrG4FBqMITIae6I9
         osVaTs6aHFolMP+roUmJzUW+GwZy+/SfAE4i6k4HXVtXLdlNVqOg1wlZqRQCKra+Bx7D
         CmRg==
X-Gm-Message-State: AC+VfDyqITkSo2S/lvEsJVrUE7uSmCRg+Mpb9nYM/bri4lzHLSCviIpr
        1/qIA2tiuhuaTYp8vPTf9yWwMq3dINL5x9ZD/h64LAkEfanVYhD2TjM=
X-Google-Smtp-Source: ACHHUZ7aPrm570/8BxX3lP0KZqPqmfsW0iBwZYyldLzeJu7wmf09RiDglmhWrihns8goe/c96xxZ+7kNyHoA5xshzb0=
X-Received: by 2002:a1f:62c4:0:b0:43f:b997:beea with SMTP id
 w187-20020a1f62c4000000b0043fb997beeamr382368vkb.13.1686035213755; Tue, 06
 Jun 2023 00:06:53 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jun 2023 12:36:42 +0530
Message-ID: <CA+G9fYtD4+d3SJeCauPhQz_3cR=Z6dhOpBsW85mFbKf0jsvn1w@mail.gmail.com>
Subject: drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:
 stmmac_mdio.c:(.text+0xe74): undefined reference to `lynx_pcs_destroy'
To:     open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

Following build failed on Linux next arc,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on arc:

 - build/gcc-9-vdk_hs38_smp_defconfig
 - build/gcc-9-axs103_defconfig

arc-elf32-ld: drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o: in
function `stmmac_mdio_unregister':
stmmac_mdio.c:(.text+0xe74): undefined reference to `lynx_pcs_destroy'
arc-elf32-ld: stmmac_mdio.c:(.text+0xe74): undefined reference to
`lynx_pcs_destroy'
make[2]: *** [/builds/linux/scripts/Makefile.vmlinux:35: vmlinux] Error 1


Build log:
========
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346877/suite/build/test/gcc-9-axs103_defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346877/suite/build/test/gcc-9-axs103_defconfig/log


--
Linaro LKFT
https://lkft.linaro.org
