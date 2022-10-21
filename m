Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085A86072B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJUInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:43:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593B2475E0;
        Fri, 21 Oct 2022 01:43:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a10so3241713wrm.12;
        Fri, 21 Oct 2022 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHHbS7emJ7bcil9wJ91wf+rz9g+zVjFgrZmtc6DrjKw=;
        b=VscjzTazJMHY7zL8gBmLasXCkhTdM0IN81yZKrdBIYJ1eC/0EXRVHW158yi8QMtotS
         CYcR2WL7PgaU6CkODUHcKiCdehPy/uOY2JPcY5RKkKNU2O47ecMdeYq5r5MViAjdb27a
         DdSrqQI55IWNabInVZcFQbcFVs6VsH2Bt9+xJe2bHEsfGnD/ejmIiG/d8GjSJG5gmAjE
         t2YRtEO8pP4d+W1l6IY+zxvwfnVM8ekC+oVpLuoLVHSAte4c/ld4b45DfbUya2NwKRe/
         DkaS1Va5R/e/sBZU424noYrgc0rhifbR/rH+neOLHXRXxZlA05QGkDIXR6GjlHvy8dbQ
         yuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHHbS7emJ7bcil9wJ91wf+rz9g+zVjFgrZmtc6DrjKw=;
        b=M82q4ng+kcRKHtxWbSv6CItYH/7RR/pUnfiXtgVnlWB2bpI35JOAcQY3/g7QZtzMml
         /66UKtWE4A21TR8AVwlhMFxPdrBocIPtIaJFsANe/r5wk5h7wEKnh3+7XlCwZa1QNFGt
         3YtOc4Kr2+O/VPMgZA55wBndspMRgwjV6zbWZ8TAO1z0XNU0FpAy+7gwsmvZ6a+hOde9
         elysxJfSAwsh9IkgzZyIXG9tMSmXqpjUlHpqdMAwE0AQvBgdJVpr0pN1OZHPoSs17P3Y
         xa4K60daXILlcAxbOn5pfrI2ArOun+FMnSBVbpF43D29W3wYpA76QxPuntx3I+aGrD5l
         m9og==
X-Gm-Message-State: ACrzQf3VezAiV7tdYRT8Japyk9xQQZRrbc1Hc7WZMPy4K3hJWJCoV/Hp
        OIzJiJ+TM06+8Y6NWotdiWE=
X-Google-Smtp-Source: AMsMyM6H1HA8tPJha9xPy1aZuHlCJCpgbM46trP62B3ngcPsvMcfEkI8L8YnqMjjeT/fpSrx0wyFOA==
X-Received: by 2002:a05:6000:611:b0:22e:c347:2943 with SMTP id bn17-20020a056000061100b0022ec3472943mr11308905wrb.603.1666341788607;
        Fri, 21 Oct 2022 01:43:08 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003b3365b38f9sm2137812wmg.10.2022.10.21.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:43:08 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: s5p-mfc: Fix spelling mistake "mmaping" -> "mmapping"
Date:   Fri, 21 Oct 2022 09:43:07 +0100
Message-Id: <20221021084307.65696-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of spelling mistakes in mfc_debug messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fca5c6405eec..8c33d09a76aa 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1047,10 +1047,10 @@ static int s5p_mfc_mmap(struct file *file, struct vm_area_struct *vma)
 	int ret;
 
 	if (offset < DST_QUEUE_OFF_BASE) {
-		mfc_debug(2, "mmaping source\n");
+		mfc_debug(2, "mmapping source\n");
 		ret = vb2_mmap(&ctx->vq_src, vma);
 	} else {		/* capture */
-		mfc_debug(2, "mmaping destination\n");
+		mfc_debug(2, "mmapping destination\n");
 		vma->vm_pgoff -= (DST_QUEUE_OFF_BASE >> PAGE_SHIFT);
 		ret = vb2_mmap(&ctx->vq_dst, vma);
 	}
-- 
2.37.3

