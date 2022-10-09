Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2755F8A53
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJIJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:16:35 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 098D26547;
        Sun,  9 Oct 2022 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Po3Gd
        8OWRlXIk1kE/BKrCYk99pzyKqg0DCJzmRulfFc=; b=pAcMjdSfugwjp22HOwFWe
        PKRJDXnbQ51+eCBje+XCwdtos1zp+gUWI3lXz4Wwet/Bt4YTcZnk726ImkjLhheN
        5ZAI0VQPM19SRuVLZnu77KhBez+wJaxjmXLoHcyP8MX1fcxQV10q+ooWXDkat8mX
        EBYmF3oKZj3KsBllyh0Rss=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgDXE9pBkUJj9IXCjw--.50958S2;
        Sun, 09 Oct 2022 17:15:46 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     giovanni.cabiddu@intel.com, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] crypto: qat - fix spelling typo in comment
Date:   Sun,  9 Oct 2022 17:15:19 +0800
Message-Id: <20221009091519.3152948-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDXE9pBkUJj9IXCjw--.50958S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5JF4rCFWrGrg_yoWktrg_CF
        48urZrWF1xGa1fArs09ayavr1Fv3s0yrW8uFn8W393C3sxJay8Kr93XF1DA347Cr4UJa1f
        uanrK3W2yw4UtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1U73JUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgKV+1Zce8IfVQABsq
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/crypto/qat/qat_common/adf_transport_access_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
index 3b6b0267bbec..d3667dbd9826 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
+++ b/drivers/crypto/qat/qat_common/adf_transport_access_macros.h
@@ -37,7 +37,7 @@
 #define ADF_SIZE_TO_RING_SIZE_IN_BYTES(SIZE) ((1 << (SIZE - 1)) << 7)
 #define ADF_RING_SIZE_IN_BYTES_TO_SIZE(SIZE) ((1 << (SIZE - 1)) >> 7)
 
-/* Minimum ring bufer size for memory allocation */
+/* Minimum ring buffer size for memory allocation */
 #define ADF_RING_SIZE_BYTES_MIN(SIZE) \
 	((SIZE < ADF_SIZE_TO_RING_SIZE_IN_BYTES(ADF_RING_SIZE_4K)) ? \
 		ADF_SIZE_TO_RING_SIZE_IN_BYTES(ADF_RING_SIZE_4K) : SIZE)
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

