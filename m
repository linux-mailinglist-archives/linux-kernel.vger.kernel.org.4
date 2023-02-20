Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE84469C521
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 07:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBTGJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 01:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTGJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 01:09:26 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE68BDEC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 22:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ol8nT
        fxhw6amMHUtNacV5YZNaWKDmAC4vNOdm3Z7UZ4=; b=c0Q0MBbz1HbboLmOuOxsz
        Kz3bbEpsasBhZjgZhCCsUOV7OUSaKGLD1PusFRf00sGrLRekeV5DqRcQsEoNawQ6
        n0bEe4Ew50BYTwRd2McanEOeqv37oHugXH+5Nuvo+k/TpeyUEmSZ/v+2qH8Q99I9
        JOVolO0tCafgP7PiKricwY=
Received: from localhost (unknown [122.206.190.60])
        by smtp16 (Coremail) with SMTP id MNxpCgCngTClDvNj2Lr3Eg--.9016S2;
        Mon, 20 Feb 2023 14:09:41 +0800 (CST)
From:   Shibo Li <zzutcyha@163.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Shibo Li <zzutcyha@163.com>
Subject: [PATCH] staging: rtl8712: Fix Sparse warning in rtl871x_xmit.c
Date:   Mon, 20 Feb 2023 06:08:23 +0000
Message-Id: <20230220060823.11472-1-zzutcyha@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: MNxpCgCngTClDvNj2Lr3Eg--.9016S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw48XF4UGr13WFyftryUtrb_yoWftFb_Cr
        yaq3s7Jr4qkr93A3Z7AFs7Ja4S93WkWa4vka1Dt34fAFZFyr95Ar92q3W5GFy29rW7KryD
        Cr4vqr1rtrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_oq2JUUUUU==
X-Originating-IP: [122.206.190.60]
X-CM-SenderInfo: x22x3ux1kdqiywtou0bp/1tbiZQEcbF8ZW-e6bAAAso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning in rtl871x_xmit.c:

WARNING: Possible repeated word: 'very'
+ * Must be very very cautious...

Signed-off-by: Shibo Li <zzutcyha@163.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..30a0276b8b58 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
  * If we turn on USE_RXTHREAD, then, no need for critical section.
  * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
  *
- * Must be very very cautious...
+ * Must be very cautious...
  *
  */
 struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
-- 
2.39.2

