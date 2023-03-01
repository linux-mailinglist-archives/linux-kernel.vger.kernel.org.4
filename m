Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE66A756E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCAUfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCAUfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:35:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1512BF17;
        Wed,  1 Mar 2023 12:35:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD31F614B7;
        Wed,  1 Mar 2023 20:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD9FC433D2;
        Wed,  1 Mar 2023 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677702912;
        bh=YsjQYCEe5cMpHM266XEFx09o2XbLKShi+/MC4dJJ6U4=;
        h=From:To:Cc:Subject:Date:From;
        b=QpT2X/ZdQmKGb/9P6xYJ1ePVzpRs4jO1txfRdj2/0P8G0fbKYTKXHj5yVtCIPTfC7
         ecGOj1BKFnH72crPgW3l8IoCCvRhTZIHgxCtNA6xnXqOJHmy/7G3nzAMv8XO1L32qn
         YefZkZC1iAGgx+MpceoC80CyVYfAPkaRmbJx4JwDiSco3pmGhpQ7SSfLvE/K5uzJd+
         gSuZ9MpJpzm27+sawhMGim9ZKko5npkEOl3vs7cQ1DuIiZ/avHSKoQpKPyIX0A4+Zh
         XlP8uvXjFOCbJzgZaFosTlyItPKMRyzMijAr/ROPmvhFCG6WdJLqyncTy0P4T+ELar
         46bOUltPm39tA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.3
Date:   Wed, 01 Mar 2023 20:34:59 +0000
Message-Id: <20230301203511.BDD9FC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7234d746a8339066313518bfa024fa03f363a55e:

  spi: dt-bindings: qcom,spi-qcom-qspi: document OPP and power-domains (2023-02-17 19:18:54 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.3

for you to fetch changes up to 2449d436681d40bc63ec2c766fd51b632270d8a7:

  spi: tegra210-quad: Fix iterator outside loop (2023-02-28 13:59:58 +0000)

----------------------------------------------------------------
spi: Fixes for v6.3

A small set of fixes for SPI drivers, Krishna has been doing a bunch of
work on Tegra210 QuadSPI and found a bunch of issues there and there's
a couple of small fixes for other drivers too.

----------------------------------------------------------------
Dhruva Gole (1):
      spi: spi-sn-f-ospi: fix duplicate flag while assigning to mode_bits

Hongbin Ji (1):
      spi: cadence-quadspi: Fix cancel the indirect read mask

Krishna Yarlagadda (3):
      spi: tegra210-quad: set half duplex flag
      spi: tegra210-quad: Fix validate combined sequence
      spi: tegra210-quad: Fix iterator outside loop

 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi-sn-f-ospi.c       |  2 +-
 drivers/spi/spi-tegra210-quad.c   | 15 ++++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)
