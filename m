Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9868E115
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBGTXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBGTXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:23:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66803A599
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:23:38 -0800 (PST)
Received: from dslb-178-004-202-208.178.004.pools.vodafone-ip.de ([178.4.202.208] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pPTYy-0002XK-Pd; Tue, 07 Feb 2023 20:23:32 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/7] staging: r8188eu: remove unused frametag defines
Date:   Tue,  7 Feb 2023 20:23:15 +0100
Message-Id: <20230207192319.294203-4-martin@kaiser.cx>
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

Remove some frametag defines which are not used in the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_xmit.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b332c2a86dbb..0c999ae6a1f1 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -152,14 +152,7 @@ struct pkt_attrib {
 
 #define NULL_FRAMETAG		(0x0)
 #define DATA_FRAMETAG		0x01
-#define L2_FRAMETAG		0x02
 #define MGNT_FRAMETAG		0x03
-#define AMSDU_FRAMETAG	0x04
-
-#define EII_FRAMETAG		0x05
-#define IEEE8023_FRAMETAG  0x06
-
-#define MP_FRAMETAG		0x07
 
 #define TXAGG_FRAMETAG	0x08
 
-- 
2.30.2

