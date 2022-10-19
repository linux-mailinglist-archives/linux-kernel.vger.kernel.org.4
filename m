Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A1603873
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSDIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJSDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:08:45 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3449FE8A9C;
        Tue, 18 Oct 2022 20:08:39 -0700 (PDT)
X-QQ-mid: bizesmtp73t1666148898txwlkp7l
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 11:08:17 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: 7jw2iSiCazosd9fh5pCymvb/pMGe5xvT3aHl6VpPEThr/Rz6ye33ctZlSuRHp
        GeRaq5J+qgY58zlZpSh5CTU5cXW5RqWNmKrMM18yWc01NRKtrV2oxG8iA4LcMIeqeXGhYTG
        xDuTjhx7QqwVNvSY46RrtFGtxVnadsbE6qaNhuaRbIFSRBKJ4kj/ZVrW+8pgEje75m+S1P6
        /HfHGvzjucNyXs6cGju+BN1l1zIJKTmVa8W24+wmtFDtxoyV43Cj7Xsx52dhYfieGNy5FZj
        EHJDQYD6b0ca2Opg7DgSDyOdahyX+nJUBJmwJadZ5U7YSwCvwRygl9O22jwCDs7kyRIoyae
        DjI2cwtViAzgQlf0l20nTMUsAatBEY+vIwJkdO7pPxhc4kMr1pYCfP9aqAulvjc8KXLyGQ9
X-QQ-GoodBg: 1
From:   Zhang Xincheng <zhangxincheng@uniontech.com>
To:     sudipm.mukherjee@gmail.com
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Zhang Xincheng <zhangxincheng@uniontech.com>
Subject: [PATCH] parport_pc: Remove WCH CH382 PCI-E single parallel port card.
Date:   Wed, 19 Oct 2022 11:07:59 +0800
Message-Id: <20221019030759.29506-1-zhangxincheng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCH CH382L PCI-E adapter with 1 parallel port has been included
inside parport_serial.

Signed-off-by: Zhang Xincheng <zhangxincheng@uniontech.com>
---
 drivers/parport/parport_pc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 7c45927e2131..cf0cefe38e90 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2613,7 +2613,6 @@ enum parport_pc_pci_cards {
 	netmos_9901,
 	netmos_9865,
 	quatech_sppxp100,
-	wch_ch382l,
 };
 
 
@@ -2677,7 +2676,6 @@ static struct parport_pc_pci {
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
-	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2769,8 +2767,6 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
-	/* WCH CH382L PCI-E single parallel port card */
-	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.20.1

