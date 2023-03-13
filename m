Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B585B6B7EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCMRL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:11:23 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE77DD0F;
        Mon, 13 Mar 2023 10:10:48 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 1674A20765;
        Mon, 13 Mar 2023 18:09:54 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-gpio@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] gpio: fxl6408: add I2C GPIO expander driver
Date:   Mon, 13 Mar 2023 18:09:48 +0100
Message-Id: <20230313170950.256964-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for Fairchild (now ON Semiconductor) fxl6408 8-bit I2C-controlled
GPIO expander, see data-sheet [0].

[0] https://www.onsemi.com/download/data-sheet/pdf/fxl6408-d.pdf

v3:
 * dt schema
  * add Reviewed-by: Krzysztof Kozlowski krzysztof.kozlowski@linaro.org
 * driver
  * add include files: kernel.h and err.h
  * refactor of fxl6408_identify and used dev_err_probe instead of dev_err

v2:
 * improved commit messages and titles
 * dt schema:
  * remove "driver" word from yaml
  * simplify gpio-hog property definition
  * rename fcs,fxl6408-gpio.yaml to fcs,fxl6408.yaml
  * add missing SoB
 * driver:
  * remove includes: <linux/gpio.h> and <linux/of_platform.h>
  * add missing and required select REGMAP_I2C in KConfig
  * use dev_err_probe()
  * add "Datasheet:" tag in commit message
  * improve KConfig help section
  * fix newlines, multi-line comments and trailing commas
 

Emanuele Ghidoli (2):
  dt-bindings: gpio: add fcs,fxl6408
  gpio: fxl6408: add I2C GPIO expander driver

 .../devicetree/bindings/gpio/fcs,fxl6408.yaml |  58 +++++++
 drivers/gpio/Kconfig                          |  10 ++
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-fxl6408.c                   | 158 ++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408.yaml
 create mode 100644 drivers/gpio/gpio-fxl6408.c

-- 
2.25.1

