Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE46D18E2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCaHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCaHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:46:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F71A973
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bx10so3806940ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680248773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6XgOZTowFcGahu4EGU1yeiRvS3r5TbCq21y2qrH2tY=;
        b=ShxO/adjRbHt3ZcSXKAHCOZfKZxIjIZpjHoLvdSa0NraKb1dT6g/nG0gzs+zmU3wHq
         BLaTic7PYrsGjtBIC69bKi+1R/TLwJNZ9MSqIjEG99GikJsOYyjQlfXVhUJsDLUjOBS5
         c161O2gPvAguXU6BPN8sNUSvEN3TkwApx1PX1AJyMq0u0FFHFmI3XEeeb847Pbpvj9uD
         gAfa+jdVjK377DQtIPl5xu1CALt/xcbJzxElaHIJY2lSakDtYbbtczIJPSJFVXC2lLdI
         v+mUQ9mwBlUf2l41OdHgEqXdui08YtLLZBTPUrIy/5JlJKZdnkYoR3SmX/adhVnnU7I9
         MTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6XgOZTowFcGahu4EGU1yeiRvS3r5TbCq21y2qrH2tY=;
        b=fkez14Sb4TQ54ut5gjfGJqsCrqV4EIPqc3qv6gZU/N73YZGJGu8qEARNct9iMV6Xnk
         bfyKiictZ7YeBUa7bN+MA8xgxbqHdnH89ExwajwxWjtOmSPtKuPWpS08jzOiIQuyq8KE
         HIp9IvWavCORcG0/WtD2wbROR7XwhQA9hR+TY1+WPgm8l480ZvEVXJp2E6Jt+nJ/uavG
         kKRVVu7qYhBUN0BfvntmhmCfIiUK9EAtcK6xLJrV8hYBbYspuslLSeH13LtZhZUObLCi
         yKMOZ2GQBe+xgEEfgjg2jM9HMURD8XL3LBUB6fzOHMo6AJCjFZlZyrvqIc9y0FyRPl81
         mH/g==
X-Gm-Message-State: AAQBX9c9f73dMY9KgrIne92b+ORvNNa8zU4nZTezUZOkrqggkk57RmdM
        R/CkY9MZvWCk2SHT2vRjalB+gA==
X-Google-Smtp-Source: AKy350bx5mHxBC2VUVKvuqYfJeg6LkdraEWnX/2Xo3NZExar9axfEwGSn+2TaDOSIq9yzESDyYgWOA==
X-Received: by 2002:a2e:8091:0:b0:298:9ea9:fd9e with SMTP id i17-20020a2e8091000000b002989ea9fd9emr8199264ljg.24.1680248772753;
        Fri, 31 Mar 2023 00:46:12 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e8794000000b0029573844d03sm241201lji.109.2023.03.31.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:46:12 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 00/10]  mtd: spi-nor: Address mode discovery (BFPT method & current address mode)
Date:   Fri, 31 Mar 2023 07:45:56 +0000
Message-Id: <20230331074606.3559258-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version of the following patch sets:
https://lore.kernel.org/linux-mtd/20220411125346.118274-1-tudor.ambarus@microchip.com/
https://lore.kernel.org/linux-mtd/20230315034004.5535-1-Takahiro.Kuwano@infineon.com/

Changes in v5:
- squash 6/11 and 7/11 to have a single point of failure in case
  regressions are determnined by bisecting. Update commit message.
- get rif of the now empty winbond_nor_default_init()
- s/sfdp_bits_set/SFDP_MASK_CHECK
- set micron-st's static spi_nor_set_4byte_addr_mode_wren_en4b_ex4 only
  when the 4byte addr mode method is not determined at BFPT parsing time
- reverse xmas tree for local variables in
  cypress_nor_set_addr_mode_nbytes.

Changes in v4:
- consider the BFPT retrieved address mode as an enumeration,
  manufacturers could support different methods at the same time
- split renaming of set_4byte_addr_mode methods in several patches for
  better clarity
- have initializations in a single line, even if bypasses the 80 chars
  limit, as they are < 100 chars anyway
- new patches that introduce spi_nor_set_4byte_addr_mode() and handle
  spi_nor_restore()
- clean Takahiro's patch

Takahiro Kuwano (1):
  mtd: spi-nor: spansion: Determine current address mode

Tudor Ambarus (9):
  mtd: spi-nor: core: Move generic method to core -
    micron_st_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    micron_st_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    spansion_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    spi_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
  mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data
  mtd: spi-nor: Stop exporting spi_nor_restore()
  mtd: spi-nor: core: Update flash's current address mode when changing
    address mode
  mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()

 Documentation/driver-api/mtd/spi-nor.rst |   3 -
 drivers/mtd/spi-nor/core.c               |  85 +++++++++++++--
 drivers/mtd/spi-nor/core.h               |   4 +
 drivers/mtd/spi-nor/macronix.c           |   8 +-
 drivers/mtd/spi-nor/micron-st.c          |  32 ++----
 drivers/mtd/spi-nor/sfdp.c               |  11 ++
 drivers/mtd/spi-nor/sfdp.h               |  27 +++++
 drivers/mtd/spi-nor/spansion.c           | 131 ++++++++++++++++++++++-
 drivers/mtd/spi-nor/winbond.c            |  24 +++--
 include/linux/mtd/spi-nor.h              |   6 --
 10 files changed, 272 insertions(+), 59 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

