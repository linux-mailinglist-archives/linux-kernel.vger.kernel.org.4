Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65274D30C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjGJKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjGJKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:11:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9252724
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:09:39 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxV_Hh2KtkwBcDAA--.9201S3;
        Mon, 10 Jul 2023 18:09:37 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c7g2KtknCInAA--.45834S2;
        Mon, 10 Jul 2023 18:09:36 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Li Yi <liyi@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/loongson: Fix two warnings because of passing wrong type
Date:   Mon, 10 Jul 2023 18:09:31 +0800
Message-Id: <20230710100931.255234-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c7g2KtknCInAA--.45834S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4fur45Gw15KFWUXFykXrc_yoW8Ar1kpF
        47Ca48trZ8Jr12yr4kG3WUZ34Fv3ZaqFZa9FZ7C3Z09w1DAF1UZF1kuFW5Kry7Zay2vrWa
        yr93G3yag3WqqwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8uuWJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When accessing I/O memory, we should pass '__iomem *' type instead of
'void *' simply, otherwise sparse tests will complain. After applied
this patch, the following two sparse warnings got fixed.

1) drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35:
   sparse:     expected void volatile [noderef] __iomem *
   sparse:     got void *kptr

2) drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51:
   sparse:     expected void const volatile [noderef] __iomem *
   sparse:     got void *kptr

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307100243.v3hv6aes-lkp@intel.com/
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/loongson/lsdc_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_benchmark.c b/drivers/gpu/drm/loongson/lsdc_benchmark.c
index b088646a2ff9..36e352820bdb 100644
--- a/drivers/gpu/drm/loongson/lsdc_benchmark.c
+++ b/drivers/gpu/drm/loongson/lsdc_benchmark.c
@@ -24,7 +24,7 @@ static void lsdc_copy_gtt_to_vram_cpu(struct lsdc_bo *src_bo,
 	lsdc_bo_kmap(dst_bo);
 
 	while (n--)
-		memcpy_toio(dst_bo->kptr, src_bo->kptr, size);
+		memcpy_toio((void __iomem *)dst_bo->kptr, src_bo->kptr, size);
 
 	lsdc_bo_kunmap(src_bo);
 	lsdc_bo_kunmap(dst_bo);
@@ -39,7 +39,7 @@ static void lsdc_copy_vram_to_gtt_cpu(struct lsdc_bo *src_bo,
 	lsdc_bo_kmap(dst_bo);
 
 	while (n--)
-		memcpy_fromio(dst_bo->kptr, src_bo->kptr, size);
+		memcpy_fromio(dst_bo->kptr, (void __iomem *)src_bo->kptr, size);
 
 	lsdc_bo_kunmap(src_bo);
 	lsdc_bo_kunmap(dst_bo);
-- 
2.34.1

