Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7621966642E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjAKT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjAKT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:57:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4BED93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:57:06 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDZ-0005F2-PV; Wed, 11 Jan 2023 20:57:01 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/20] staging: r8188eu: remove struct reg_protocol_wt
Date:   Wed, 11 Jan 2023 20:56:31 +0100
Message-Id: <20230111195640.306748-12-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111195640.306748-1-martin@kaiser.cx>
References: <20230111195640.306748-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct reg_protocol_wt. It's not used in the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_io.h | 42 ------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 858fd9cbb57a..ae290a18e593 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -102,48 +102,6 @@ struct	intf_hdl {
 	struct dvobj_priv *pintf_dev;
 };
 
-struct reg_protocol_wt {
-#ifdef __LITTLE_ENDIAN
-	/* DW1 */
-	u32	NumOfTrans:4;
-	u32	Reserved1:4;
-	u32	Reserved2:24;
-	/* DW2 */
-	u32	ByteCount:7;
-	u32	WriteEnable:1;		/* 0:read, 1:write */
-	u32	FixOrContinuous:1;	/* 0:continuous, 1: Fix */
-	u32	BurstMode:1;
-	u32	Byte1Access:1;
-	u32	Byte2Access:1;
-	u32	Byte4Access:1;
-	u32	Reserved3:3;
-	u32	Reserved4:16;
-	/* DW3 */
-	u32	BusAddress;
-	/* DW4 */
-	u32	Value;
-#else
-	/* DW1 */
-	u32 Reserved1 :4;
-	u32 NumOfTrans:4;
-	u32 Reserved2:24;
-	/* DW2 */
-	u32 WriteEnable:1;
-	u32 ByteCount:7;
-	u32 Reserved3:3;
-	u32 Byte4Access:1;
-	u32 Byte2Access:1;
-	u32 Byte1Access:1;
-	u32 BurstMode:1;
-	u32 FixOrContinuous:1;
-	u32 Reserved4:16;
-	/* DW3 */
-	u32	BusAddress;
-	/* DW4 */
-	u32	Value;
-#endif
-};
-
 uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
 void unregister_intf_hdl(struct intf_hdl *pintfhdl);
 
-- 
2.30.2

