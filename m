Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E835F5091
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJEICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJEICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:02:15 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53232B91
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:02:13 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2957dWlm053427;
        Wed, 5 Oct 2022 15:39:32 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 Oct
 2022 16:01:10 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <clg@kaod.org>, <chin-ting_kuo@aspeedtech.com>,
        <broonie@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH] spi: aspeed: Fix typo in mode_bits field for AST2600 platform
Date:   Wed, 5 Oct 2022 16:01:04 +0800
Message-ID: <20221005080104.175769-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2957dWlm053427
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both quad SPI TX and RX modes can be supported on AST2600.
Correct typo in mode_bits field in both ast2600_fmc_data
ast2600_spi_data structs.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index a334e89add86..33cefcf18392 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -1163,7 +1163,7 @@ static const struct aspeed_spi_data ast2500_spi_data = {
 static const struct aspeed_spi_data ast2600_fmc_data = {
 	.max_cs	       = 3,
 	.hastype       = false,
-	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
@@ -1178,7 +1178,7 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
 static const struct aspeed_spi_data ast2600_spi_data = {
 	.max_cs	       = 2,
 	.hastype       = false,
-	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.mode_bits     = SPI_RX_QUAD | SPI_TX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
 	.timing	       = CE0_TIMING_COMPENSATION_REG,
-- 
2.25.1

