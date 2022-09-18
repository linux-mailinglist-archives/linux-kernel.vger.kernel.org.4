Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873C25BBF3B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIRR5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIRR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 13:57:21 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0435167DB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:57:20 -0700 (PDT)
Received: from dslb-188-096-149-102.188.096.pools.vodafone-ip.de ([188.96.149.102] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oZyXa-0006VL-7c; Sun, 18 Sep 2022 19:57:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: r8188eu: remove two unused enum entries
Date:   Sun, 18 Sep 2022 19:57:00 +0200
Message-Id: <20220918175700.215170-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220918175700.215170-1-martin@kaiser.cx>
References: <20220918175700.215170-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both LED_BLINK_StartToBlink and LED_BLINK_RUNTOP in enum LED_STATE_871x
are not used in the r8188eu driver. Remove them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_led.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 7b1775b9fa64..8520f022a67f 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -27,12 +27,9 @@ enum LED_STATE_871x {
 	LED_BLINK_SCAN = 6, /*  LED is blinking during scanning period,
 			     * the # of times to blink is depend on time
 			     * for scanning. */
-	LED_BLINK_StartToBlink = 8,/*  Customzied for Sercomm Printer
-				    * Server case */
 	LED_BLINK_TXRX = 9,
 	LED_BLINK_WPS = 10,	/*  LED is blinkg during WPS communication */
 	LED_BLINK_WPS_STOP = 11,
-	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
 };
 
 struct led_priv {
-- 
2.30.2

