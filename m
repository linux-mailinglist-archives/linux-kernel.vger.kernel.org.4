Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B475266643A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAKT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjAKT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:57:02 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2832BF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:57:01 -0800 (PST)
Received: from dslb-188-096-145-172.188.096.pools.vodafone-ip.de ([188.96.145.172] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFhDV-0005F2-3Z; Wed, 11 Jan 2023 20:56:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/20] staging: r8188eu: remove async write function prototypes
Date:   Wed, 11 Jan 2023 20:56:25 +0100
Message-Id: <20230111195640.306748-6-martin@kaiser.cx>
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

Remove some prototypes for async write functions which are not present in
the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_io.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f9394329b674..6ce099e91e20 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -227,22 +227,6 @@ void rtw_write_port_cancel(struct adapter *adapter);
 
 void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
 
-void async_write8(struct adapter *adapter, u32 addr, u8 val,
-		  void (*_async_io_callback)(struct adapter *padater,
-					     struct io_req *pio_req,
-					     u8 *cnxt), u8 *cnxt);
-void async_write16(struct adapter *adapter, u32 addr, u16 val,
-		   void (*_async_io_callback)(struct adapter *padater,
-					      struct io_req *pio_req,
-					      u8 *cnxt), u8 *cnxt);
-void async_write32(struct adapter *adapter, u32 addr, u32 val,
-		   void (*_async_io_callback)(struct adapter *padater,
-					      struct io_req *pio_req,
-					      u8 *cnxt), u8 *cnxt);
-
-void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-
 void dev_power_down(struct adapter *Adapter, u8 bpwrup);
 
 #endif	/* _RTL8711_IO_H_ */
-- 
2.30.2

