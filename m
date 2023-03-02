Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A86A81DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCBMEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBMEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:04:07 -0500
X-Greylist: delayed 276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 04:04:04 PST
Received: from 189.cn (ptr.189.cn [183.61.185.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90EE91F93B;
        Thu,  2 Mar 2023 04:04:04 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:46066.54360919
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 64F83100248;
        Thu,  2 Mar 2023 19:59:24 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-698c9d7bb7-jn5ln with ESMTP id 9652da7c70eb49d3b926ac93c6c405e9 for sumit.semwal@linaro.org;
        Thu, 02 Mar 2023 19:59:27 CST
X-Transaction-ID: 9652da7c70eb49d3b926ac93c6c405e9
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   suijingfeng <15330273260@189.cn>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf/dma-buf.c: add a blank line between the two adjoining functions
Date:   Thu,  2 Mar 2023 19:59:23 +0800
Message-Id: <20230302115923.327852-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: suijingfeng <15330273260@189.cn>
---
 drivers/dma-buf/dma-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 757c0fb77a6c..45d56aa4319c 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -777,10 +777,10 @@ static void mangle_sg_table(struct sg_table *sg_table)
 	for_each_sgtable_sg(sg_table, sg, i)
 		sg->page_link ^= ~0xffUL;
 #endif
-
 }
-static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
-				       enum dma_data_direction direction)
+
+static struct sg_table *__map_dma_buf(struct dma_buf_attachment *attach,
+				      enum dma_data_direction direction)
 {
 	struct sg_table *sg_table;
 	signed long ret;
-- 
2.25.1

