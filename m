Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD616E8B84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjDTHiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjDTHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:38:12 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5398A3C0F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:38:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9C21518014A344;
        Thu, 20 Apr 2023 15:37:53 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
To:     kabel@kernel.org
Cc:     linux-kernel@vger.kernel.org, yunchuan <yunchuan@nfschina.com>
Subject: [PATCH] firmware:Remove unnecessary (void*) conversions
Date:   Thu, 20 Apr 2023 15:37:51 +0800
Message-Id: <20230420073751.1031944-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: yunchuan <yunchuan@nfschina.com>
---
 drivers/firmware/turris-mox-rwtm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 6ea5789a89e2..af2fa620e6bc 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -283,7 +283,7 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 
 static int mox_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-	struct mox_rwtm *rwtm = (struct mox_rwtm *) rng->priv;
+	struct mox_rwtm *rwtm = rng->priv;
 	struct armada_37xx_rwtm_tx_msg msg;
 	int ret;
 
-- 
2.30.2

