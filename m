Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B768E114
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjBGTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjBGTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:23:41 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA543B0C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:23:41 -0800 (PST)
Received: from dslb-178-004-202-208.178.004.pools.vodafone-ip.de ([178.4.202.208] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pPTZ0-0002XK-Vz; Tue, 07 Feb 2023 20:23:35 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/7] staging: r8188eu: xmit_buf's ff_hwaddr is not used
Date:   Tue,  7 Feb 2023 20:23:16 +0100
Message-Id: <20230207192319.294203-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230207192319.294203-1-martin@kaiser.cx>
References: <20230207192319.294203-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ff_hwaddr in struct xmit_buf is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 0c999ae6a1f1..9a001fbf45a0 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -193,7 +193,6 @@ struct xmit_buf {
 	u32 alloc_sz;
 	u32  len;
 	struct submit_ctx *sctx;
-	u32	ff_hwaddr;
 	struct urb *pxmit_urb;
 	int last[8];
 };
-- 
2.30.2

