Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F16084A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 07:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJVFim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 01:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVFik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 01:38:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958029C3C1;
        Fri, 21 Oct 2022 22:38:35 -0700 (PDT)
X-QQ-mid: bizesmtp85t1666417092txe04id2
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:38:10 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: tgzXWVxr7ygoZz6GntRSS1/NLqazdIA8AqBZ1SCZmiYhoAm2Fuk7n2ZTzjEie
        tGgLYTH1ps5ULv2IaVx/G/O1BQ2rHPk5GwX3r0XByQELwHMKyVr9X/yi1seAUm4nJBTAlSc
        T9cl+23040Avttm9H/shlmsjmkeQDvGwLdEcqUMs1sA5S1bYk9GdnCmojQYkQyBT6h8ZxVi
        XxQ8zq10vP+jfiClp2kJqM1P/3/EA0S4CoVAMO7BOY2fvwJ1a7ierMeDtE7VLk9rfgboFc2
        eIQSLUnQrSlhDhtlLQPf6t2hbdtOxb+pqGe8atLviBfIcehu+KQRrLKkMZXQoaCK7j+EpTV
        tHAaLEYQdGzWN86Uunc3Bo/vOmpnSd33/tjAy6nMjHFOFxAxr0=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] marvell/octeontx: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:38:02 +0800
Message-Id: <20221022053802.26941-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
index b8bdb9f134f3..be84dbd22961 100644
--- a/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
+++ b/drivers/crypto/marvell/octeontx/otx_cpt_hw_types.h
@@ -534,7 +534,7 @@ union otx_cptx_vqx_misc_ena_w1s {
  * Word0
  *  reserved_20_63:44 [63:20] Reserved.
  *  dbell_cnt:20 [19:0](R/W/H) Number of instruction queue 64-bit words to add
- *	to the CPT instruction doorbell count. Readback value is the the
+ *	to the CPT instruction doorbell count. Readback value is the
  *	current number of pending doorbell requests. If counter overflows
  *	CPT()_VQ()_MISC_INT[DBELL_DOVF] is set. To reset the count back to
  *	zero, write one to clear CPT()_VQ()_MISC_INT_ENA_W1C[DBELL_DOVF],
-- 
2.36.1

