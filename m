Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C206734CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjFSHrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:47:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F2B98
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:47:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.124])
        by gateway (Coremail) with SMTP id _____8AxHusHCJBkhsgGAA--.14066S3;
        Mon, 19 Jun 2023 15:47:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.124])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXMoECJBkZf8fAA--.15854S4;
        Mon, 19 Jun 2023 15:47:16 +0800 (CST)
From:   YingKun Meng <mengyingkun@loongson.cn>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     harshit.m.mogalapalli@oracle.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        YingKun Meng <mengyingkun@loongson.cn>
Subject: [PATCH v1] ASoC: loongson: change the type of variable irq to int
Date:   Mon, 19 Jun 2023 15:46:49 +0800
Message-Id: <20230619074649.3608726-1-mengyingkun@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXMoECJBkZf8fAA--.15854S4
X-CM-SenderInfo: 5phqw55lqjy33q6o00pqjv00gofq/1tbiAQAHDGSO9AIDRgAEsX
X-Coremail-Antispam: 1Uk129KBj9xXoWrury5KryDXw1kCrWfKFW7trc_yoWDCrX_Ga
        42qan5uryUJFy7Wa4UWrW8AryaqFyfA3W5CF17tFn7W3W7tr1Sk34kCr15uFy3XrW0vFZx
        Zr48Wr4xZw1FyosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use variable 'irq' to store the return value of fwnode_get_irq_byname().
A negative value indicates that the operation failed. If the type of 'irq'
is unsigned int, we never know if the operation failed.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/loongarch/325dd825-6fa5-0ebc-4b7e-7acf2d2840e4@loongson.cn/
Signed-off-by: YingKun Meng <mengyingkun@loongson.cn>
---
 sound/soc/loongson/loongson_i2s.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/loongson/loongson_i2s.h b/sound/soc/loongson/loongson_i2s.h
index 52788f6a94ad..89492eebf834 100644
--- a/sound/soc/loongson/loongson_i2s.h
+++ b/sound/soc/loongson/loongson_i2s.h
@@ -45,7 +45,7 @@
 struct loongson_dma_data {
 	dma_addr_t dev_addr;		/* device physical address for DMA */
 	void __iomem *order_addr;	/* DMA order register */
-	u32 irq;			/* DMA irq */
+	int irq;			/* DMA irq */
 };
 
 struct loongson_i2s {
-- 
2.33.0

