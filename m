Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939AE609167
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJWGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 02:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 02:04:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91509190
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666505060; x=1698041060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=urzVgSnTrOa0Lulj3LDdQfuLpk5Eu8nvU+tXswVTwt0=;
  b=L3Jhby/wC9DeII4OaEFI97SnjTGdJPbIgKm122PzgEZ3jFJaQ76aJJRb
   n6eLuYcd9L5Rhqd6feXvMJViwfVli6uGreMu6KtcZYyqIGlaky8XNrRIf
   4EE9cE+7vzS7WwUZMAzvGksITonvNE0b9YKwuI2zN/9KzPfWPi3aTE/wQ
   znd7Efs/mTGQWrf9TZp8B+kcecOM6wMyXbt/OehlQBaJ9vJSmUz30erbA
   8MzZ+UrzFet6mK4JLi+3eDSuWf+GhZ7HB+cFPFZzVyAakYK3EKpDyU3Nl
   Gp8iS5PC/LXoD4i+ZYZtNk6aABAvt/guzNQ4Q+oG4EbAcqzC2b0z8rlyP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="286952609"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="286952609"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 23:04:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="960072350"
X-IronPort-AV: E=Sophos;i="5.95,206,1661842800"; 
   d="scan'208";a="960072350"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 23:04:17 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] mtd: spi-nor: macronix: Add support for mx77l51250f
Date:   Sun, 23 Oct 2022 09:04:07 +0300
Message-Id: <20221023060407.1139129-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mx77l51250f spi-nor chips.

Datasheet: https://www.macronix.com/Lists/Datasheet/Attachments/8760/MX77L12850F,%203V,%20128Mb,%20v1.2.pdf

Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..ec7abb64e2bc 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -100,6 +100,9 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx77l51250f", INFO(0xc2751a, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.37.3

