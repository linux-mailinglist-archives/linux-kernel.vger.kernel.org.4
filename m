Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41825659B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiL3SHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiL3SHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:07:14 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6361B60E2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 10:07:13 -0800 (PST)
Received: from dslb-188-097-208-179.188.097.pools.vodafone-ip.de ([188.97.208.179] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pBJmd-0004rR-It; Fri, 30 Dec 2022 19:07:07 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/20] staging: r8188eu: remove some unused CAM defines
Date:   Fri, 30 Dec 2022 19:06:28 +0100
Message-Id: <20221230180646.91008-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230180646.91008-1-martin@kaiser.cx>
References: <20221230180646.91008-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some CAM-related defines which are not used in the r8188eu driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../staging/r8188eu/include/rtl8188e_spec.h   | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 3fa3b3e5dd64..25b31417cd58 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -510,28 +510,7 @@ Default: 00b.
 /*        8192C BW_OPMODE bits		(Offset 0x203, 8bit) */
 #define	BW_OPMODE_20MHZ			BIT(2)
 
-/*        8192C CAM Config Setting (offset 0x250, 1 byte) */
-#define	CAM_VALID			BIT(15)
-#define	CAM_NOTVALID			0x0000
-#define	CAM_USEDK			BIT(5)
-
-#define	CAM_CONTENT_COUNT		8
-
-#define	CAM_NONE			0x0
-#define	CAM_WEP40			0x01
-#define	CAM_TKIP			0x02
-#define	CAM_AES				0x04
-#define	CAM_WEP104			0x05
-#define	CAM_SMS4			0x6
-
-#define	TOTAL_CAM_ENTRY			32
-#define	HALF_CAM_ENTRY			16
-
-#define	CAM_CONFIG_USEDK		true
-#define	CAM_CONFIG_NO_USEDK		false
-
 #define	CAM_WRITE			BIT(16)
-#define	CAM_READ			0x00000000
 #define	CAM_POLLINIG			BIT(31)
 
 #define	SCR_UseDK			0x01
-- 
2.30.2

