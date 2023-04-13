Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2D6E1737
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 00:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDMWPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 18:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:15:01 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD8C65BC;
        Thu, 13 Apr 2023 15:15:00 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-183f4efa98aso25887116fac.2;
        Thu, 13 Apr 2023 15:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424099; x=1684016099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vA+ou4WJsRaw1OEoHe47epP2tndSue81sQo33gVKxA=;
        b=kGPSi5VpDRPy42eU26XOB1qPUropRGApy8wcz5NXYlTozZIVyv59pTPwpuBidBsgsj
         NAFJbcxc20dqqvDSqr4iN72pLg+BSG3TnMZIABf16Vb70Yw9SwjxefpklQvp4vu3Ufib
         pP/5bCkpz2cGhvwLQMdcWU496ZVpZq7v3TuDPzXQVlnhPsyeDWzSFoMtXQmuSnk8a52/
         saKq6pECJpuC1qAyEF2TLYxbq40/N491Z+K+RBlLrGtQyODUheadMfOJMU6itef6iY8n
         cQ+0SxWT0tcCaZMLYRvf+uTM0FKMD/KleOWXRUUq73rVYEU3I9vohLUCNxi3jXmFTrU8
         H6Gw==
X-Gm-Message-State: AAQBX9c0aD04oLSQkN/l/HCTtHuL+xSDML4ud6jYvjDq4GFd8J9Zj42P
        1eTgrnR4NXi/No4GhX1+rv5fw6+S8w==
X-Google-Smtp-Source: AKy350ZsrANUM75Zwz05EdX6p15MOKLlv4dq1npoVPDlpg1JN+f+v4ygyjaXqrk5mvCesiBUrdvgXg==
X-Received: by 2002:a05:6870:808d:b0:187:9235:27c8 with SMTP id q13-20020a056870808d00b00187923527c8mr2023432oab.37.1681424099710;
        Thu, 13 Apr 2023 15:14:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y7-20020a056870e3c700b001728669a604sm1188842oad.5.2023.04.13.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:14:59 -0700 (PDT)
Received: (nullmailer pid 1939789 invoked by uid 1000);
        Thu, 13 Apr 2023 22:14:58 -0000
Date:   Thu, 13 Apr 2023 17:14:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.2, take 3
Message-ID: <20230413221458.GA1938449-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple more DT fixes.

Rob


The following changes since commit 707344c8a188bb1d6704d3546229fc7a07c01a63:

  dt-bindings: interrupt-controller: arm,gic-v3: Fix typo in description of msi-controller property (2023-02-02 17:10:58 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.2-3

for you to fetch changes up to 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924:

  treewide: Fix probing of devices in DT overlays (2023-04-11 14:39:52 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.2, part 3:

- Fix interaction between fw_devlink and DT overlays causing
  devices to not be probed

- Fix the compatible string for loongson,cpu-interrupt-controller

----------------------------------------------------------------
Geert Uytterhoeven (1):
      treewide: Fix probing of devices in DT overlays

Liu Peibao (1):
      dt-bindings: interrupt-controller: loongarch: Fix mismatched compatible

 ...rrupt-controller.yaml => loongson,cpu-interrupt-controller.yaml} | 6 +++---
 drivers/bus/imx-weim.c                                              | 6 ++++++
 drivers/i2c/i2c-core-of.c                                           | 5 +++++
 drivers/of/dynamic.c                                                | 1 +
 drivers/of/platform.c                                               | 5 +++++
 drivers/spi/spi.c                                                   | 5 +++++
 6 files changed, 25 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{loongarch,cpu-interrupt-controller.yaml => loongson,cpu-interrupt-controller.yaml} (72%)
