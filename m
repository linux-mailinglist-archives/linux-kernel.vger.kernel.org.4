Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803726B8D57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCNIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCNIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:32:02 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A735BDB3;
        Tue, 14 Mar 2023 01:31:58 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PbRb06HTlz8R040;
        Tue, 14 Mar 2023 16:31:56 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32E8VmVB046544;
        Tue, 14 Mar 2023 16:31:49 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 14 Mar 2023 16:31:51 +0800 (CST)
Date:   Tue, 14 Mar 2023 16:31:51 +0800 (CST)
X-Zmail-TransId: 2af9641030f7ffffffff9c4-ca210
X-Mailer: Zmail v1.0
Message-ID: <202303141631511535639@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <herbert@gondor.apana.org.au>
Cc:     <davem@davemloft.net>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <linux-crypto@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBjcnlwdG86IHAxMC1hZXMtZ2NtIC0gcmVtb3ZlIGR1cGxpY2F0ZSBpbmNsdWRlIGhlYWRlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32E8VmVB046544
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641030FC.000 by FangMail milter!
X-FangMail-Envelope: 1678782716/4PbRb06HTlz8R040/641030FC.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641030FC.000/4PbRb06HTlz8R040
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

crypto/algapi.h is included more than once.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
index c95f5b7cc456..1533c8cdd26f 100644
--- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
+++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
@@ -8,7 +8,6 @@
 #include <asm/unaligned.h>
 #include <asm/simd.h>
 #include <asm/switch_to.h>
-#include <crypto/algapi.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/b128ops.h>
-- 
2.25.1
