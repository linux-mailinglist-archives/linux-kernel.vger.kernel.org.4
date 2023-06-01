Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09377719692
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjFAJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjFAJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:14:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79FDE7;
        Thu,  1 Jun 2023 02:14:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d44b198baso552512b3a.0;
        Thu, 01 Jun 2023 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685610854; x=1688202854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMARNOfEe0u/4psMeYuFfqWOzY+kT8DC4HRTyQFo2qg=;
        b=Re8yyQliQIJ/8C6NcrbPduLlM0FkGtbkutpo6IUKlXingWN2B7Fa6jZdfrw6EuU82p
         fRc6Z3ya3ErU2eLzzdR5F6iAug0uCAospnp+9oBIJHiLEZ8ssrIkRfITynVunTRMD8/N
         IPBOXrkIBHLI5tj61EidKAKxwhZXfKm7AOxZfCBxqpvMTrWDY2nQjV9w/dSbcKP1l+VJ
         kPfJ527dKTLJjHrLrr5ZbKUbYO/Q/AZHtzLgOtL4o+a0UXJrzmFMIvuYzKdcMfvV77zI
         cjATR7jkwLnC2+/zedqQ/8WiV7KV23PkBILEogNPDs1cixTXEkFx5E6/oEUVCnMxtA70
         DDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685610854; x=1688202854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMARNOfEe0u/4psMeYuFfqWOzY+kT8DC4HRTyQFo2qg=;
        b=YrGP71L7LcWHhb7Prcj+AsdMNd/3H9Jbjl+8IgfuSHpNDY0Kaw6zglOx9rmnchDnHR
         HmdS29WpS8zb7OfaZ5esjm9HcgwN39qjVEBxOy9Ja0ERUUR5pXsPG9SCre8ZUyenWLX+
         xiJMAomSWGxw1n1hdmWevaXeSuSdZli4ONa4XVY/OoGCTnvyfOhrr15y36rqrKdH47E7
         /5QMdrssbHKnPTl3BlglejSagRltnlOloSOTynoxCCGnr+YUIrVBYWE0lis+nbulJ4++
         p1jZ/0XQ7xCQ3Hwc7Dkyx3geWueHeJgnG4/FXFHT8l7+WQx7ZjoYYNoxSqzX+FxEquWj
         oD7Q==
X-Gm-Message-State: AC+VfDyHCf0iV3ex6ves94qyV9ekuPkvYAH7YoI4W+ymi4RB+Pz05/6B
        IFRyJApovy4EyW+pO7BsYC8=
X-Google-Smtp-Source: ACHHUZ5lFjaYlFUmRfI4uAlFbV09sXZDvXloteNfQ2mU3aVzdjtswpIBVkMQFh78hq7+czuUyyRYNQ==
X-Received: by 2002:a05:6a20:54a3:b0:10d:951f:58bd with SMTP id i35-20020a056a2054a300b0010d951f58bdmr1408215pzk.19.1685610854276;
        Thu, 01 Jun 2023 02:14:14 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.242])
        by smtp.gmail.com with ESMTPSA id f11-20020aa782cb000000b0064aea45b040sm4558133pfn.168.2023.06.01.02.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:14:13 -0700 (PDT)
From:   Zhang Hui <masonzhang.xiaomi@gmail.com>
X-Google-Original-From: Zhang Hui <zhanghui31@xiaomi.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        zhanghui <zhanghui31@xiaomi.com>, Bean Huo <beanhuo@micron.com>,
        peng.zhou@mediatek.com, yudongbin@xiaomi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] scsi: ufs: core: Fix ufshcd_inc_sq_tail function bug
Date:   Thu,  1 Jun 2023 17:13:57 +0800
Message-Id: <20230601091357.1365-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhanghui <zhanghui31@xiaomi.com>

If q->max_entries is not multiple of 32, mask not every bit is 1.
So q->sq_tail_slot some bit will be cleared by use this way.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
 drivers/ufs/core/ufshcd-priv.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d53b93c21a0c..319fba31c1f5 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -366,10 +366,11 @@ static inline bool ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info, u8
 static inline void ufshcd_inc_sq_tail(struct ufs_hw_queue *q)
 	__must_hold(&q->sq_lock)
 {
-	u32 mask = q->max_entries - 1;
 	u32 val;
 
-	q->sq_tail_slot = (q->sq_tail_slot + 1) & mask;
+	q->sq_tail_slot++;
+	if (q->sq_tail_slot == q->max_entries)
+		q->sq_tail_slot = 0;
 	val = q->sq_tail_slot * sizeof(struct utp_transfer_req_desc);
 	writel(val, q->mcq_sq_tail);
 }
-- 
2.39.0

