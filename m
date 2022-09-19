Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A55BC9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiISKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:43:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5433E32
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:25:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so3059852wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=i8qtV1ORsa+HHhmlmkZQpKs+M06Hxfc+YDUSBHs+KQM=;
        b=BHxpezMJV9I0Vrn7MPNMzqigHCUPwbZ39msFNMcvODM9382mD4va5jMzdzyw3DTxfW
         EGgCmu9TZolJhYwHrK7uroVPcwjG9Ufy8hJ2clV4aZ32qm1RRJWG/2zFQAL8Ikew6SNJ
         iVLSn2TnHszk7aOLhVN80vsGKi6KVjb095upN+PYgaqtHpKdupzeQ//7nQpwGL19MyKI
         rVBLWTGFCMdqikEfmiTbdYcd7MbCNtRXv6VNVRwLAl4LFyN1rwAVHH5jYjcnq6NHWPVf
         VkjXKgvt8/2Z4Q3fi+OK7fp4fbsHujU2BhZbR+V5Hdkz8qGfTIStOBf+9psy85h70yNQ
         svjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=i8qtV1ORsa+HHhmlmkZQpKs+M06Hxfc+YDUSBHs+KQM=;
        b=WKrnWxJwDaOciJAi2Ns18nLJyhiJwffcx3nFrtkod6wADOIzmSjB0e3dVBIb+xC7IZ
         v7KY6ttfbyDN7OW0Yg7PsGkx9YxwOyn5rzJ4Lob8LaQMVyeR1Sef6IykR+aYAHSo5ZSn
         7jOO7BexaqCaIXW+ql9KWXH3StW5ajsBzI3yRtpwvg0smuAYmbgohGM9nlrR7cmlY/g4
         QM5iFvaISqh8awN4Dmp9k3nDlARqLyc518sOxmKhDjVMj2+LbLxb/4jD8pr2PHev5Uwk
         aTZ2MRxagLg/3TIiGxbXNGyNCZ5RNDJJrppw8pszqsY6GxsqWm3cY44eDecOyZMMqHp7
         u+bw==
X-Gm-Message-State: ACrzQf3h+Fnm26lzVCAhNKdCsalv4xyC8j1hAe6m4twBXJh2NyUFRcPi
        QXBCwBiJdIdiN1AgZpcCAoX7qA==
X-Google-Smtp-Source: AMsMyM563dXLnPjqspSBvSJ7Y7IQXbM52WpnK9RK2H3xJlFfsqc5fj7ojkYgZ/JHTb3Mu/bcQaa3Fw==
X-Received: by 2002:a05:600c:3591:b0:3b4:bf48:9f10 with SMTP id p17-20020a05600c359100b003b4bf489f10mr10204952wmq.76.1663583055840;
        Mon, 19 Sep 2022 03:24:15 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b11-20020adfd1cb000000b00225239d9265sm7939153wrd.74.2022.09.19.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:24:15 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.1
Date:   Mon, 19 Sep 2022 13:22:44 +0300
Message-Id: <20220919102244.3537437-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.1

for you to fetch changes up to 67e16ac1fec475e64dcb8238f471c6fd154ef806:

  clk: imx93: add SAI IPG clk (2022-09-19 13:06:45 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.1

- Change order between 'sim_enet_root_clk' and 'enet_qos_root_clk'
  clocks for i.MX8MP
- Drop unnecessary newline in i.MX8MM dt-bindings
- Add more MU1 and SAI clocks dt-bindings Ids
- Introduce slice busy bit check for i.MX93 composite clock
- Introduce white list bit check for i.MX93 composite clock
- Add new i.MX93 clock gate
- Add MU1 and MU2 clocks to i.MX93 clock provider
- Add SAI IPG clocks to i.MX93 clock provider

----------------------------------------------------------------
Marcel Ziswiler (1):
      dt-bindings: clock: imx8mm: don't use multiple blank lines

Peng Fan (8):
      clk: imx8mp: tune the order of enet_qos_root_clk
      dt-bindings: clock: imx93-clock: add more MU/SAI clocks
      clk: imx: clk-composite-93: check slice busy
      clk: imx: clk-composite-93: check white_list
      clk: imx: add i.MX93 clk gate
      clk: imx93: switch to use new clk gate API
      clk: imx93: add MU1/2 clock
      clk: imx93: add SAI IPG clk

 drivers/clk/imx/Makefile                 |   1 +
 drivers/clk/imx/clk-composite-93.c       | 171 +++++++++++++++++++++++++-
 drivers/clk/imx/clk-gate-93.c            | 199 +++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8mp.c             |   2 +-
 drivers/clk/imx/clk-imx93.c              |  30 +++--
 drivers/clk/imx/clk.h                    |   9 +-
 include/dt-bindings/clock/imx8mm-clock.h |   1 -
 include/dt-bindings/clock/imx93-clock.h  |   9 +-
 8 files changed, 402 insertions(+), 20 deletions(-)
 create mode 100644 drivers/clk/imx/clk-gate-93.c
