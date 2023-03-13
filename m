Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B96B74E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCMK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCMK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:47 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617CE38D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by michel.telenet-ops.be with bizsmtp
        id Xmyg2900401Vtj806mygte; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3I3-Ft;
        Mon, 13 Mar 2023 11:58:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWl-Tj;
        Mon, 13 Mar 2023 11:58:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/6] spi: Constify spi_get_ctldata()'s spi parameter
Date:   Mon, 13 Mar 2023 11:58:35 +0100
Message-Id: <8960e07adaad8d92d2c3aa045af9ee3c5d2130a8.1678704562.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "spi" parameter of spi_get_ctldata() can be const.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index bdb35a91b4bf0141..6097d2f5126624eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -244,7 +244,7 @@ static inline void spi_dev_put(struct spi_device *spi)
 }
 
 /* ctldata is for the bus_controller driver's runtime state */
-static inline void *spi_get_ctldata(struct spi_device *spi)
+static inline void *spi_get_ctldata(const struct spi_device *spi)
 {
 	return spi->controller_state;
 }
-- 
2.34.1

