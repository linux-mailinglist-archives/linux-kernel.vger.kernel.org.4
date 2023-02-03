Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6EF689685
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjBCK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjBCKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:25:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A12E0D9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:25:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so4187507wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2li3zPs66adcFuU3w6fWPa4bvxMwh4iyFZN+IJWd18=;
        b=cY8AAXxl/W0AIWwK+p3i0BhBUBx8hsUKfzyAvqrbRA1R+3I3m/XoisUiBjLlA8e0TN
         PZ3FMeet5CcAl0LN9XE7ZukqM1FGtl5bddIM43tefWAOaZ3+h7EzTXM3vbd318SaWoBD
         8jrpPyYacRzKrc+Ly8tLhzDsmN7Cy37objq5fT/HNz+oKmxUFa/NSAebg143Hb7JSdVN
         fPYTynvCgaGYbf3PRYUp8QVExUSosSaYZ1Da999Q02wdDXTEtCyCA9UZmVGT/etT5kR5
         nNqtwShPuw6zvRNBQowf1SR595vQNcR3860SIrFiE3wVbjOsSk2uATJKkbatTO4M3qt7
         baGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2li3zPs66adcFuU3w6fWPa4bvxMwh4iyFZN+IJWd18=;
        b=b7feufHdi3Twzu/EFjE5R8bZkxnr4Nb8L6pXeZZ9Lj4xUPMGMNUXAW9Nr0ciKK2wnF
         dcB7Ec2sEfH7ZBuHvRuLigGwiBHwtITXJYXIBrVOa+vRyF38tAUql9oA6uHf4XSvzhsC
         R4Ju1bQCWhPCWN11lWs6ZHL9yyBBh6k9mzlvkI4lK6ielDvzWiWOZCCrHMkre+KWJTR1
         TwirJ8mAa9/I9DsyWduJVBe+JUYDviimN0mG+XxZEq67CzPmzLcEN2POlE7zO3MeZ6A0
         vJgFCht+D9MyQPZ2i8v9zZ/NbyvlrpeXKN/HvyBJ+t7YnnteaurY6YxBjo5wZKQbfwbo
         COGw==
X-Gm-Message-State: AO0yUKXcbWO2X37UGNiKRMNjQAtYnqFL91k6rlr9EgMQyHBMukmABgF/
        1HwEg4srhFfRz5QS6ad30OkNxQ==
X-Google-Smtp-Source: AK7set8V1+xbY96zxhy8Zm0i5a2C/0NC27SxQwSLHyoXk+LdA6cNE1jUsXwgoQlCVht10bDofuW1aQ==
X-Received: by 2002:a5d:4d85:0:b0:2be:3ccd:7f37 with SMTP id b5-20020a5d4d85000000b002be3ccd7f37mr8321268wru.52.1675419940784;
        Fri, 03 Feb 2023 02:25:40 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d6048000000b002bfb02153d1sm1636938wrt.45.2023.02.03.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:25:40 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.3
Date:   Fri,  3 Feb 2023 12:25:29 +0200
Message-Id: <20230203102529.2662598-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.3

for you to fetch changes up to 4e197ee880c24ecb63f7fe17449b3653bc64b03c:

  clk: imx6ul: add ethernet refclock mux support (2023-01-31 14:45:17 +0200)

----------------------------------------------------------------
i.MX clocks changes for 6.3

- Free the imx_uart_clocks even if imx_register_uart_clocks returns early.
- Get the stdout clocks count from device tree.
- Drop the clock count argument from imx_register_uart_clocks.
- Keep the uart clocks on i.MX93 for when earlycon is used.
- Fix SPDX comment in i.MX6SLL clocks bindings header.
- Drop some unnecessary spaces from i.MX8ULP clocks bindings header.
- Add a new clk-gpr-mux clock type and use it on i.MX6Q to add ENET ref
  clocks.
- Add the imx_obtain_fixed_of_clock for allowing to add a clock that is
  not configured via devicetree.
- Fix the ENET1 gate configuration for i.MX6UL according to the
  reference manual.
- Add ENET refclock mux support for i.MX6UL.

----------------------------------------------------------------
Marcel Ziswiler (2):
      clk: imx6sll: add proper spdx license identifier
      dt-bindings: imx8ulp: clock: no spaces before tabs

Oleksij Rempel (5):
      clk: imx: add clk-gpr-mux driver
      clk: imx6q: add ethernet refclock mux support
      clk: imx: add imx_obtain_fixed_of_clock()
      clk: imx6ul: fix enet1 gate configuration
      clk: imx6ul: add ethernet refclock mux support

Peng Fan (4):
      clk: imx: avoid memory leak
      clk: imx: get stdout clk count from device tree
      clk: imx: remove clk_count of imx_register_uart_clocks
      clk: imx: imx93: invoke imx_register_uart_clocks

 drivers/clk/imx/Makefile                    |   1 +
 drivers/clk/imx/clk-gpr-mux.c               | 119 ++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx25.c                 |   2 +-
 drivers/clk/imx/clk-imx27.c                 |   2 +-
 drivers/clk/imx/clk-imx35.c                 |   2 +-
 drivers/clk/imx/clk-imx5.c                  |   6 +-
 drivers/clk/imx/clk-imx6q.c                 |  15 +++-
 drivers/clk/imx/clk-imx6sl.c                |   2 +-
 drivers/clk/imx/clk-imx6sll.c               |   2 +-
 drivers/clk/imx/clk-imx6sx.c                |   2 +-
 drivers/clk/imx/clk-imx6ul.c                |  33 +++++++-
 drivers/clk/imx/clk-imx7d.c                 |   2 +-
 drivers/clk/imx/clk-imx7ulp.c               |   4 +-
 drivers/clk/imx/clk-imx8mm.c                |   2 +-
 drivers/clk/imx/clk-imx8mn.c                |   2 +-
 drivers/clk/imx/clk-imx8mp.c                |   2 +-
 drivers/clk/imx/clk-imx8mq.c                |   2 +-
 drivers/clk/imx/clk-imx8ulp.c               |   2 +-
 drivers/clk/imx/clk-imx93.c                 |   2 +
 drivers/clk/imx/clk.c                       |  31 ++++++--
 drivers/clk/imx/clk.h                       |  12 ++-
 include/dt-bindings/clock/imx6qdl-clock.h   |   4 +-
 include/dt-bindings/clock/imx6sll-clock.h   |   2 +-
 include/dt-bindings/clock/imx6ul-clock.h    |   7 +-
 include/dt-bindings/clock/imx8ulp-clock.h   |   4 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |   6 +-
 26 files changed, 235 insertions(+), 35 deletions(-)
 create mode 100644 drivers/clk/imx/clk-gpr-mux.c
