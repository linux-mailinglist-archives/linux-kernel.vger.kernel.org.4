Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204FF5B7A26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiIMSwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiIMSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:51:53 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1513F9E;
        Tue, 13 Sep 2022 11:36:07 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-127f5411b9cso34546683fac.4;
        Tue, 13 Sep 2022 11:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NsKE+BEH4KxDRW88FUFgCoVeNl0M6BtUtpnnF6L+EYk=;
        b=PPbkPSfW1hDiiPqLH9kK9sIJFeDY2iRLQOvcTafJ07rKg+GeVXNNg894bhw9aPiri9
         +SbkLrhqov1V0euqs77hjslbg6r6eAkChJlBXU/QfrOsZZ87Wv66pakJwmpJ2JSWSbCq
         fCdjEaeWdh7T+Y+ZTfEkfjLE6G07x0AlDMAkYeSg0ytHQPDtAfXGW7x2oh6oSHIG8cbY
         BWre580BlRcmlaQ//JDqTbNu0B8+kinT61DYfi53jSSbyWQjDBwy10SB2nIlEP96MKNv
         3J18B+sxwj4HctgamnOmiffZFEvj5zkEi6CZTIV9qJ8lDfsCm0f6/jaTLERknBgGlBWl
         fFRg==
X-Gm-Message-State: ACgBeo0Od7HAX92dO07LbsqzUK9CPRw4XDzSSa3faSAkRm4sB67cu/om
        mDnedxc1BTgHD0CWTXncPA==
X-Google-Smtp-Source: AA6agR4F9hbDNpEPKWtVF5rfUO9KvOelSHz3eMtkGVqZO0hzZpUIJ/ltVqY558YMHeovwK4OZUGfiA==
X-Received: by 2002:a05:6870:608e:b0:12b:c0de:bc9d with SMTP id t14-20020a056870608e00b0012bc0debc9dmr378101oae.52.1663094167138;
        Tue, 13 Sep 2022 11:36:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b11-20020a056870d1cb00b001276cea2320sm7379784oac.58.2022.09.13.11.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 11:36:06 -0700 (PDT)
Received: (nullmailer pid 162606 invoked by uid 1000);
        Tue, 13 Sep 2022 18:36:05 -0000
Date:   Tue, 13 Sep 2022 13:36:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.0, take 2
Message-ID: <20220913183605.GA155025-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple more DT fixes.

Rob


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.0-2

for you to fetch changes up to de11663b75b0a8f1cfeb00d3b4acec9bd5a49cad:

  dt-bindings: pinctrl: qcom: drop non-working codeaurora.org emails (2022-09-13 10:18:23 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.0, take 2:

- Update some stale binding maintainer emails

- Fix property name error in apple,aic binding

- Add missing param to of_dma_configure_id() stub

- Fix an off-by-one error in unflatten_dt_nodes()

----------------------------------------------------------------
Janne Grunau (1):
      dt-bindings: apple,aic: Fix required item "apple,fiq-index" in affinity description

Krzysztof Kozlowski (3):
      dt-bindings: interconnect: fsl,imx8m-noc: drop Leonard Crestez
      dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org emails
      dt-bindings: pinctrl: qcom: drop non-working codeaurora.org emails

Neil Armstrong (1):
      MAINTAINERS: Update email of Neil Armstrong

Sergey Shtylyov (1):
      of: fdt: fix off-by-one error in unflatten_dt_nodes()

Thierry Reding (1):
      of/device: Fix up of_dma_configure_id() stub

 .mailmap                                             |  1 +
 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml      |  2 +-
 .../bindings/display/amlogic,meson-dw-hdmi.yaml      |  2 +-
 .../bindings/display/amlogic,meson-vpu.yaml          |  2 +-
 .../bindings/display/bridge/analogix,anx7814.yaml    |  2 +-
 .../bindings/display/bridge/ite,it66121.yaml         |  2 +-
 .../bindings/display/panel/sgd,gktw70sdae4se.yaml    |  2 +-
 .../devicetree/bindings/i2c/amlogic,meson6-i2c.yaml  |  2 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml         |  2 +-
 .../bindings/interrupt-controller/apple,aic.yaml     |  2 +-
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml     |  2 +-
 .../devicetree/bindings/media/amlogic,axg-ge2d.yaml  |  2 +-
 .../devicetree/bindings/media/amlogic,gx-vdec.yaml   |  2 +-
 .../bindings/media/amlogic,meson-gx-ao-cec.yaml      |  2 +-
 .../devicetree/bindings/mfd/khadas,mcu.yaml          |  2 +-
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml |  2 +-
 .../bindings/phy/amlogic,axg-mipi-dphy.yaml          |  2 +-
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml    |  2 +-
 .../phy/amlogic,meson-g12a-usb3-pcie-phy.yaml        |  2 +-
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml       |  1 -
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml        |  2 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml        |  2 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml        |  2 +-
 .../bindings/reset/amlogic,meson-reset.yaml          |  2 +-
 .../devicetree/bindings/rng/amlogic,meson-rng.yaml   |  2 +-
 .../bindings/serial/amlogic,meson-uart.yaml          |  2 +-
 .../bindings/soc/amlogic/amlogic,canvas.yaml         |  2 +-
 .../bindings/spi/amlogic,meson-gx-spicc.yaml         |  2 +-
 .../bindings/spi/amlogic,meson6-spifc.yaml           |  2 +-
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml    |  2 +-
 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml    |  2 +-
 MAINTAINERS                                          | 20 ++++++++++----------
 drivers/of/fdt.c                                     |  2 +-
 include/linux/of_device.h                            |  5 +++--
 34 files changed, 44 insertions(+), 43 deletions(-)
