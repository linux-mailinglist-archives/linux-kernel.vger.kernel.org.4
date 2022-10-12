Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2E5FCD19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJLVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJLVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:25:43 -0400
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 14:25:31 PDT
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68020B56E0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:25:30 -0700 (PDT)
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h5.fbrelay.privateemail.com (Postfix) with ESMTPS id 627CC6001B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:16:25 +0000 (UTC)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id A312B18000A3;
        Wed, 12 Oct 2022 17:16:22 -0400 (EDT)
Received: from fedora.. (93-55-228-234.ip265.fastwebnet.it [93.55.228.234])
        by mta-07.privateemail.com (Postfix) with ESMTPA id 15C1418000A1;
        Wed, 12 Oct 2022 17:16:16 -0400 (EDT)
From:   Rigel Di Scala <zedr@zedr.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        rigeld@gmail.com, Rigel Di Scala <zedr@zedr.com>
Subject: [PATCH] Staging: rtl8192e: fix a brace style issue
Date:   Wed, 12 Oct 2022 21:16:12 +0000
Message-Id: <20221012211612.75871-1-zedr@zedr.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue affecting a conditional if statement.

Signed-off-by: Rigel Di Scala <zedr@zedr.com>
---
 drivers/staging/rtl8192e/rtl819x_BAProc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 19d13b3fc..e932ad1a9 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -180,11 +180,10 @@ static void rtllib_send_ADDBAReq(struct rtllib_device *ieee, u8 *dst,
 
 	skb = rtllib_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ);
 
-	if (skb) {
+	if (skb)
 		softmac_mgmt_xmit(skb, ieee);
-	} else {
+	else
 		netdev_dbg(ieee->dev, "Failed to generate ADDBAReq packet.\n");
-	}
 }
 
 static void rtllib_send_ADDBARsp(struct rtllib_device *ieee, u8 *dst,
-- 
2.37.3

