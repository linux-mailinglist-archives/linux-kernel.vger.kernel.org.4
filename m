Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1CF5B516C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIKWDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIKWDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:03:52 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7917240B0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:51 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-127ba06d03fso18824566fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QciXyEtl0SG2sFGkjdrqOCkJJthnC/gW3bZjn86sQs4=;
        b=nedOYSluEe/44mthiiwXwA1U+s+w585VU+/rvGTWb2MVLxhVMCOtmFyFNWm5Tx4nrs
         Y/VKNMFavwPbWQ/bofYNMUUJPmD3kZOTVO+aYqiQKDGGnLt0DiW/E6TXIIQAfb1hfnC8
         Unml1Eyq/Z0zoF94XBmzFCALmSunHjPbqpVcgCEnWIDLogM+TohnaUANarxzJh/HQ3C8
         c3OVSevJPkUdg3+l7n4xSg6hddlARLnc4NjToD2DgM8ilRTeFDmTVoXS/Qkgq5iPq4S1
         ne7YFDXwa2QQW1WmawvHd059Au6Qxg9S7kwvrMK7AfmK7MLWZ1ZOx/Xa7bgGzMDyoUKB
         jqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QciXyEtl0SG2sFGkjdrqOCkJJthnC/gW3bZjn86sQs4=;
        b=EQ5w2imVi8TVnhDWn0kno6MXchQh7HcTjiWFi4sE7OKMnyCsRLxbNeRz5KKgx5anLz
         YMRT6l3lmw8GdgrM9esLf2LPgZxXN0T84vpeZDLGYyFE1DCBCtK9QaO9ccgNDJa4BN25
         NWkzC1A/4NSx43ZAoVL5K8MY2i223tAY6BDwtZFrPZvvNlY3kjiFQSJMEDuLPrsyOTag
         NaSyElsCsR1TXawUIGD8Aje6RGEFG0yUDrqkNMjUXio5RCm5WAAKky64zJQHBAgEwKWU
         5wSW+6NOUZUxDb3VAn6V3awXSJ3A8KldwQjC73A31aBngOHht243vOH/5UEVkjh2ZPZZ
         bMFg==
X-Gm-Message-State: ACgBeo2OZJ+F+8LPCUAQBhu+dAPGevIusG4yNiGqvIotj/tylqvFj1uD
        sUlLYk3MQvFmdNIfDr94JtNGosPoPgsEWg==
X-Google-Smtp-Source: AA6agR7M8OWqYsVeZuV7IzoTsnUUDdXizBgkugpQqrzObWrhOry54eJ7h10jSDTh27LUPjKoUGD+6Q==
X-Received: by 2002:a05:6808:201e:b0:34f:7d7a:3017 with SMTP id q30-20020a056808201e00b0034f7d7a3017mr2927903oiw.219.1662933831071;
        Sun, 11 Sep 2022 15:03:51 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r19-20020a056870439300b00127d2005ea1sm4664249oah.18.2022.09.11.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:03:50 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/3] Introduce the ACCES IDIO-16 GPIO library module
Date:   Sun, 11 Sep 2022 16:34:37 -0400
Message-Id: <cover.1662927941.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a similar vein as the Intel 8255 interface library module [0], the
ACCES IDIO-16 GPIO library module is introduced to consolidate much of
the shared code between the existing 104-IDIO-16 and PCI-IDIO-16 GPIO
drivers.

The idio-16 module exposes consumer library functions to facilitate
communication with devices within the ACCES IDIO-16 family such as the
104-IDIO-16 and the PCI-IDIO-16.

A CONFIG_GPIO_IDIO_16 Kconfig option is introduced by this patch.
Modules wanting access to these idio-16 library functions should select
this Kconfig option and import the IDIO_16 symbol namespace.

[0] https://lore.kernel.org/all/d1a24895f2ea67f689c24c34a20ddb43cd7246af.1658324498.git.william.gray@linaro.org/

William Breathitt Gray (3):
  gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module
  gpio: 104-idio-16: Utilize the idio-16 GPIO library
  gpio: pci-idio-16: Utilize the idio-16 GPIO library

 MAINTAINERS                     |   6 ++
 drivers/gpio/Kconfig            |  11 +++
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-104-idio-16.c |  91 +++++-------------
 drivers/gpio/gpio-idio-16.c     | 159 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h     |  70 ++++++++++++++
 drivers/gpio/gpio-pci-idio-16.c | 119 +++---------------------
 7 files changed, 281 insertions(+), 176 deletions(-)
 create mode 100644 drivers/gpio/gpio-idio-16.c
 create mode 100644 drivers/gpio/gpio-idio-16.h


base-commit: 3af20d2723be5f70e1ce818504a4c093a81b21f5
-- 
2.37.2

