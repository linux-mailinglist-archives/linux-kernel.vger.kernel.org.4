Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0200D69CF78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjBTOdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjBTOds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:33:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043E5B9B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:33:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C20AB80B19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694A6C433D2;
        Mon, 20 Feb 2023 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676903623;
        bh=imPDLE6Sr6EMKvoaJ2BHvC5KgE5elioPiF60urPgCZA=;
        h=From:To:Cc:Subject:Date:From;
        b=jmt/1P77rPEojc1DJ4t2/D0KcOe3GfJhw22V+UrN4huuFfZQ5vysqWfme2vW+ieV/
         W978eQcjn5/+D5+3NJQA0t7lJSED0ZabkmDOblfEM+GwyoA1zB2ev3297R5ag+cdsG
         WwFMZLKfFoHw1bnbtJOHd6vKEv6gUa4CKVX5CqJDOGpqrzSKdjyNZDojCcVQ1+4ZjG
         +gh7LzId0FxmF4qJ25rK90iUnP2qRuTmcXkCMU60vT5pDudHBvosZSXI69dSq9Mrsx
         Cldg4AF1rK7cU8i8iM4rhrKNS5rXVqDeWK/FccbwvsEN5QtIOGHwYYv5jNbTnc9bnI
         Yjac8EGXB31QA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.3
Date:   Mon, 20 Feb 2023 14:33:34 +0000
Message-Id: <20230220143343.694A6C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.3

for you to fetch changes up to 40f4b05868101e047a8502ebb94f05312186421b:

  Merge remote-tracking branch 'regmap/for-6.3' into regmap-next (2023-02-17 02:14:50 +0000)

----------------------------------------------------------------
regmap: Updates for v6.3

A quiet release for regmap, we've seen several cleanups, an update for a
change in the MDIO APIs and one small fix.

----------------------------------------------------------------
Aidan MacDonald (2):
      regmap-irq: Remove unused type_invert flag
      regmap-irq: Remove unused mask_invert flag

Andrew Lunn (1):
      regmap: Rework regmap_mdio_c45_{read|write} for new C45 API.

Christophe JAILLET (1):
      regmap: Reorder fields in 'struct regmap_bus' to save some memory

Daniel Golle (1):
      regmap: apply reg_base and reg_downshift for single register ops

Mark Brown (1):
      Merge remote-tracking branch 'regmap/for-6.3' into regmap-next

 drivers/base/regmap/regmap-irq.c  | 25 ++----------------------
 drivers/base/regmap/regmap-mdio.c | 41 ++++++++++++++++++++++-----------------
 drivers/base/regmap/regmap.c      |  6 ++++++
 include/linux/regmap.h            | 19 +++++++++---------
 4 files changed, 41 insertions(+), 50 deletions(-)
