Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA00F62EDC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiKRGkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiKRGkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E29BA1B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso3360049wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWGCsOWTltJ1s1TmyB5iq5IA0ySKVXAwV7/ThLFlqPs=;
        b=pC88QgXBumO1/V0lO/txig9KlBbZtpSqoe0HtMylZBH3OxwEKdFA7SsObIXCVOdNsA
         xsDoAXxODeqjmlVObMeHyuQkxUoxbYLx1TeNPxOyXxgIFJ7Sw4V63g7qhZT2N2LXvOcZ
         bfVtIjzeyPOC0q2IF8ZskfRXSJIIGt9OGBaMREQwZgumhoTznSb7T2xzCgDv/K8AoqYa
         KR0jc9yVR58qjDOX6+KVwlIekONVLr0jcusUrxDnx8zNyqK63KGhTC/x5xK5njkcDvJY
         eRG1nHSlpffHANRa4fQZETtQuHt3cUmQf2n7Wy7IwAQSMySGQRnPv6Wo3hfAgs5+NnB+
         3Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWGCsOWTltJ1s1TmyB5iq5IA0ySKVXAwV7/ThLFlqPs=;
        b=f45Q0wdFEkrEOET+TpllG0ojQpvRkJBYuliwBgkP8PJnHeX6CKKtxjAIrKsL7CELNn
         KsVLm1rafTP38R1SVQ5AMSTnDDi72LluLt1teHHTn8TeVG5kEjxGNjFsybpY846Tq4Cv
         uh11QksEiTgPDal/OBVs4mBik6cUV5g+gbg4Hu1reHCbH+ac0iB7b0f5n4r68FYgBAWR
         H2jMEsW4a6wufBtvhYf8d6y83iVIHrzjKfY4Z87uDjHeZ5+3AMIfY1qm5aDSUX5nbRrE
         uQKEKLdxtb/zGGormry7LXxNn9KP6sv5YcAH9nKyHXJQeLQPimONY+3+H8H6M/gR2u68
         DpDg==
X-Gm-Message-State: ANoB5pkEOjiWAoNSB2Iw2+tDe2oBKzGl4iI5MRBCupaNjKN00OdCK8Am
        yf1FN4D61yYVFfcoZ7pgb3k42w==
X-Google-Smtp-Source: AA0mqf5MvrMwYIfTpAwseYx16haMFQz6Z5zjhktwhrzPWkWu/lhefUN4dmltCCWxbQeWWOn/RpqeAQ==
X-Received: by 2002:a1c:e917:0:b0:3cf:681a:43e1 with SMTP id q23-20020a1ce917000000b003cf681a43e1mr3656481wmc.126.1668753592179;
        Thu, 17 Nov 2022 22:39:52 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:51 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/13] nvmem: patches (set 1) for 6.2
Date:   Fri, 18 Nov 2022 06:39:19 +0000
Message-Id: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 6.2 which includes

- Adding bindings for new ONIE and sl28 vpd nvmem layouts
- few enhacements to stm32 provider.
- add Broadcom format support int u-boot-env provider.
- 2 typo fixes

Can you please queue them up for 6.2.

thanks for you help,
srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Colin Ian King (1):
  nvmem: Kconfig: Fix spelling mistake "controlls" -> "controls"

Jiangshan Yi (1):
  nvmem: stm32: fix spelling typo in comment

Michael Walle (1):
  dt-bindings: nvmem: add YAML schema for the sl28 vpd layout

Miquel Raynal (5):
  dt-bindings: nvmem: Fix example
  dt-bindings: nvmem: Introduce the nvmem-layout container
  dt-bindings: eeprom: Inherit from nvmem.yaml
  dt-bindings: vendor-prefixes: Add ONIE
  dt-bindings: nvmem: add YAML schema for the ONIE tlv layout

Patrick Delaunay (4):
  nvmem: stm32: move STM32MP15_BSEC_NUM_LOWER in config
  nvmem: stm32: add warning when upper OTPs are updated
  nvmem: stm32: add nvmem type attribute
  dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem

Rafał Miłecki (1):
  nvmem: u-boot-env: add Broadcom format support

 .../devicetree/bindings/eeprom/at24.yaml      |   5 +-
 .../devicetree/bindings/eeprom/at25.yaml      |   1 +
 .../bindings/eeprom/microchip,93lc46b.yaml    |   1 +
 .../nvmem/layouts/kontron,sl28-vpd.yaml       |  64 ++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  34 ++++
 .../nvmem/layouts/onie,tlv-layout.yaml        | 147 ++++++++++++++++++
 .../devicetree/bindings/nvmem/nvmem.yaml      |   8 +
 .../bindings/nvmem/st,stm32-romem.yaml        |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/nvmem/Kconfig                         |   2 +-
 drivers/nvmem/stm32-romem.c                   |  27 +++-
 drivers/nvmem/u-boot-env.c                    |  14 ++
 12 files changed, 298 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml

-- 
2.25.1

