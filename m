Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340D972FDF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjFNMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjFNML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:11:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DD22106
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso3855354f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744672; x=1689336672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge+PAUGZKltRvYWfI3TIkZLbX5qEJ8c1zqJq4aE+VKY=;
        b=i+7KLBzGa6EDe9X035n2t3xZfw18EGKMD5/vy/nOuPzKxCgoKzQjSkfRDOO5yzgEUd
         wAUHH6aF3JN6vK7piNdhDrHBqLYh63UNIA8hZMTeSWWRhhT2SuR/kI5ux+1IHzY5Pmjg
         RLt34xNTLynai3g8ISGh6JxzrQ/COf4Y2x5hJILi4VD/LTniJfLSelbBJ+q81UsOEW8/
         jKJIjSZvGXdY21fLm4rrz6iMkpZSsrEACCfBrOH1P7j/Q/PRXrr6yrYz/00GitgT2hXB
         Ls304hHCcFCCVYynywTIWKJU24PU75ToZGF0jxknJw2UogjqRRF8yT2CG27SXu0VDZSX
         /QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744672; x=1689336672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge+PAUGZKltRvYWfI3TIkZLbX5qEJ8c1zqJq4aE+VKY=;
        b=GxQfWzaxf8/qvvF0rjk8kdRzJJ3xbXXzd2iJvxmxUZvppHC4qz6HpEwdYLt2oxgHGC
         CWD2xx3nKmdsDPsmPWcpsWwCMuvi4z/+0DOLsVzLt/Pe4RgGk7a5Mao8QdTGvDwipAOU
         IZB5hcREg0w2U5JoxRULtfGC8RX+gX+P/DPeCX1JssIuBia8pdV+bjYQOSZiy2eTPfA+
         kGjk9tBgpQm2mJ199k1XXF77REnF2CKZonoAcIXYCEaHfSpEfZYguRMmBKUHRyGs7uvs
         HRsjoq49wibrF9/Orj9pOZeR71LDgTcgSsutlMXn/X/rxajJOngVX9r3fvS+4Cm0RJgK
         p4/g==
X-Gm-Message-State: AC+VfDyvAAvycBnuF678+dz+i+iwy8lyPXNvX7gE+cXUCVWM0URRhm7U
        A8ka85f7fQ2CtNfxLZyBv2ypUQ==
X-Google-Smtp-Source: ACHHUZ7e3VqGRTMl+9qL5siJ7YTEPgn1IwbO0xBI2LWD4uIG+jKrIrRyMTOdSzx4Hju9i2pepRULYQ==
X-Received: by 2002:adf:e9cb:0:b0:309:5188:5928 with SMTP id l11-20020adfe9cb000000b0030951885928mr10337077wrn.35.1686744672185;
        Wed, 14 Jun 2023 05:11:12 -0700 (PDT)
Received: from hackbox.lan ([188.24.163.226])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0030e5ccaec84sm18244057wrz.32.2023.06.14.05.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:11:11 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.5
Date:   Wed, 14 Jun 2023 15:10:59 +0300
Message-Id: <20230614121059.42888-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.5

for you to fetch changes up to 878b02d5f3b56cb090dbe2c70c89273be144087f:

  clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe() (2023-06-12 12:20:02 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.5

- Remove CLK_SET_RATE_PARENT flag from LDB clocks on i.MX6SX
- Keep UART clocks enabled during kernel boot if earlycon is set
- Drop the imx_unregister_clocks as there are no users for it
- Switch to _safe iterator on imx_clk_scu_unregister to avoid use after free
- Add determine_rate op to the imx8m composite clock
- Use device managed API for iomap and kzalloc for i.MXRT1050,
  i.MX8MN, i.MX8MP and i.MX93 clock controller drivers
- Add missing interrupt DT property for the i.MX8M clock controller

----------------------------------------------------------------
Adam Ford (1):
      clk: imx: composite-8m: Add imx8m_divider_determine_rate

Alexander Stein (2):
      clk: imx6ul: retain early UART clocks during kernel init
      dt-bindings: clock: imx8m: Add missing interrupt property

Dan Carpenter (1):
      clk: imx: scu: use _safe list iterator to avoid a use after free

Fabio Estevam (1):
      clk: imx: imx6sx: Remove CLK_SET_RATE_PARENT from the LDB clocks

Hao Luo (1):
      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Kai Ma (1):
      clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe

Peng Fan (1):
      clk: imx: drop imx_unregister_clocks

Yuxing Liu (1):
      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zhanhao Hu (1):
      clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

 .../devicetree/bindings/clock/imx8m-clock.yaml     |  3 +++
 drivers/clk/imx/clk-composite-8m.c                 | 31 ++++++++++++++++++++++
 drivers/clk/imx/clk-imx6sx.c                       |  8 +++---
 drivers/clk/imx/clk-imx6ul.c                       |  2 ++
 drivers/clk/imx/clk-imx8mn.c                       |  8 +++---
 drivers/clk/imx/clk-imx8mp.c                       | 24 +++++++++--------
 drivers/clk/imx/clk-imx93.c                        | 15 ++++++-----
 drivers/clk/imx/clk-imxrt1050.c                    | 22 ++++++++++-----
 drivers/clk/imx/clk-scu.c                          |  4 +--
 drivers/clk/imx/clk.c                              |  8 ------
 drivers/clk/imx/clk.h                              |  1 -
 11 files changed, 82 insertions(+), 44 deletions(-)
