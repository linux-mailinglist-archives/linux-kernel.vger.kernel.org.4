Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FA73F683
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjF0IKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjF0IK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:10:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82971FCF;
        Tue, 27 Jun 2023 01:10:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668711086f4so2752565b3a.1;
        Tue, 27 Jun 2023 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687853425; x=1690445425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xma4Gb4pEkAaFNibqGslSuwc+Q9f0EZKxO+NL/xlyfI=;
        b=fiBi966y5+YTn7gXaGwP283Y2BULbbybfwWimaRKkiaLfziKHTr1Nn0u1Y4UaJ/uSI
         4IhX+y6uQgiQ18lasWqI4l0uK3jdswVclrdS1f8VT6CKG+aKKUgEduqi2upawQ6oMuJE
         lm0DbIknBPi8M4R2E/bBlE1gxXv4dRLEGf+VdtQGNa4DsV8cPbS/0MB5VUZ3QXKiRQ8Q
         hVUr3UhZa2tyxKz/59QEJVK1N4C+oNENC9UIUARU0oQRGrz4C8Wnq2RONrppJ9vCcS8O
         wUCeH7i4v9Ecgh5zu+zElctWm9yHWqD3Pbx7uUcbCYnsAHWCm+my7dj3Ecvba/L4CG54
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853425; x=1690445425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xma4Gb4pEkAaFNibqGslSuwc+Q9f0EZKxO+NL/xlyfI=;
        b=OC4I4H0WnUEStVDLeR5HBjmMYTudFr8PGFezBi6Fr+OxQ0Ipj9NrC8ho9pclJDctOV
         RK587EtlrHF9znGL5MDf/ZuwoUwyz5lmhzyJCwFVLhDytdZzYuv6GcNMZh+28Ch0qF0T
         6pz88Xoj5leJcr7obmo9hyRNt2Wx7fPwy+igjtA8bcIIgd9k4KfPzW+G+P+IY4Ljwpzu
         nKkbyLU9uqfCSHOtxRyb0WDHCyOAjOEWI0x1F9RXZ1p1+hK5CjPakwfe08dyFHxECwFN
         zUzWwUd5XBiebwLjv0M1gpEu95BbxVsFowUfeOPVjG1+vT58DDOMA0rHe8EcYiAa640i
         ayLg==
X-Gm-Message-State: AC+VfDxXFmf8ES1gGKAKVYh4Ytt7JG5Dp2ivQuZRwaovTroo3ugSDtDe
        CKtFOZ5ggCslSM6FXCOEFRM=
X-Google-Smtp-Source: ACHHUZ6CTNgcyl0NsEzGvyssYofApXbtOrbfoHv2bAAqnrKqKJBxnRusB1xfPUGPR21Y52lkC3EaWQ==
X-Received: by 2002:a05:6a00:228a:b0:666:eaaf:a2af with SMTP id f10-20020a056a00228a00b00666eaafa2afmr40933721pfe.14.1687853425063;
        Tue, 27 Jun 2023 01:10:25 -0700 (PDT)
Received: from hackyzh-VMware-Virtual-Platform.localdomain ([117.163.240.206])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b00672401787c6sm3670351pfh.109.2023.06.27.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:10:24 -0700 (PDT)
From:   yqsun1997@gmail.com
To:     tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 499671216@qq.com,
        yqsun1997 <yqsun1997@gmail.com>
Subject: [PATCH] OOB read and write in mtk multiple places
Date:   Tue, 27 Jun 2023 16:10:02 +0800
Message-Id: <20230627081002.1768990-1-yqsun1997@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yqsun1997 <yqsun1997@gmail.com>

The num_planes max index is 8,
but bytesperline and bytesperline in struct mtk_q_data,
The max index is MTK_VCODEC_MAX_PLANES == 3,
so will cause OOB read and write in multiple places.like vidioc_venc_g_fmt
same as commit 8fbcf730

Signed-off-by: yqsun1997 <yqsun1997@gmail.com>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 9acab54fd..c2c157675 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -22,7 +22,7 @@
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
 
-#define MTK_VCODEC_MAX_PLANES	3
+#define MTK_VCODEC_MAX_PLANES	8
 #define MTK_V4L2_BENCHMARK	0
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
-- 
2.39.2

