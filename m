Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5336865C41C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbjACQjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjACQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:38:57 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED52273B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:38:55 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:f1ca:ff0d:9dea:806e])
        by michel.telenet-ops.be with bizsmtp
        id 4Ges2900F2YHDVW06Geskc; Tue, 03 Jan 2023 17:38:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkJQ-00201A-Fo; Tue, 03 Jan 2023 17:38:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkJQ-001T6P-0v; Tue, 03 Jan 2023 17:38:52 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mmc: sdio: Spelling s/compement/complement/
Date:   Tue,  3 Jan 2023 17:38:51 +0100
Message-Id: <a650c8b930a30f5902f4fcfe23877314d098abde.1672763862.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "complement".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/core/sdio_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 79dbf90216b599c7..b774bf51981d05a4 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -766,7 +766,7 @@ EXPORT_SYMBOL_GPL(sdio_retune_crc_disable);
  *	sdio_retune_crc_enable - re-enable retuning on CRC errors
  *	@func: SDIO function attached to host
  *
- *	This is the compement to sdio_retune_crc_disable().
+ *	This is the complement to sdio_retune_crc_disable().
  */
 void sdio_retune_crc_enable(struct sdio_func *func)
 {
-- 
2.25.1

