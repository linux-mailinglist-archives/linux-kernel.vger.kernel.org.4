Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081DA614A11
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKAL5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKAL5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:57:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3981C6387;
        Tue,  1 Nov 2022 04:57:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so19739265wrb.13;
        Tue, 01 Nov 2022 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avD7AsLYAabT4MRxA4af15kY8M1x7LqMRU8EJksJQzU=;
        b=HcwjTt+AZwgxEXuLfGdDhzw5siB0usEMihQMMtm6COsuce+D71orrJ32ulXf+P5z6U
         R5qPE/9LMHFAKTrGdjPQ8i0BquIGWgtCdmj1hJqmo4AaxbmNw6rtOrgFcIbuATL9zcPc
         1VsOhsmnf4qBPor5ZtXS+SHZl/MZu5yjUJW8fUTA+4hZccSXcrtw8bMtXXLX6GGyK0Ld
         nicXnR3INwSAyO/6Av4Tx1ERwua/HY0rclGcCSvegQa3x2BGidbZPtYP5OBhsLk3ztbT
         s0NQBKslkRdz+mqbswM8CxFbpz3GV/RRdTjir2T1KH22PyqTKSbDO7ElT2xLsJzocd1c
         slKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avD7AsLYAabT4MRxA4af15kY8M1x7LqMRU8EJksJQzU=;
        b=LxKbbqLvYQCIk4CjYm//SpWHaiGPEydr/KEIV4zYCLVBC8iEJ0Mffx1IfTbHpwlRz2
         KDUMkCfCYUsmyAAO82ZarRWyNU9MMiXHuyWu1KOW8jYEm3Uyy+QFuqS23twl5DgH0FXZ
         u9EiF9DQpb8+TpCCA606bz75Z9Ruu8j8hjvicr4KuVCpHwTQoQBPI8VlhCltFGsRpCEq
         wxr0UoP0+zjj01NCNo+keFVZAx0SCCnfTMN6Y2gENzJdtpev39H/8QOERl1sWS12Ngy1
         QB1eBMBBCq5p7WnfnIWTyD91tqMCqvcAF7RBiQBMVPcZIlzHSHQtSJhdA5TNvY1Vyjo6
         C79A==
X-Gm-Message-State: ACrzQf3AKz1CwcAVVETX09Q/LkVcCUkEYY1Q67qng6DDiNW/leR91Cii
        zyXpmelaZdkBt0LO5V4ItfU=
X-Google-Smtp-Source: AMsMyM7jxN4kNnHN2zLJV7RTLDufU+rENl6wf+klBTWoUB9yddvnX48XNBIEc5DGZIHDP37SuFuSKg==
X-Received: by 2002:a05:6000:381:b0:232:2e1:48e9 with SMTP id u1-20020a056000038100b0023202e148e9mr11123028wrf.166.1667303818657;
        Tue, 01 Nov 2022 04:56:58 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d4443000000b0023659925b2asm9863117wrr.51.2022.11.01.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 04:56:58 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: remove redundant pointer lp
Date:   Tue,  1 Nov 2022 11:56:57 +0000
Message-Id: <20221101115657.48267-1-colin.i.king@gmail.com>
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

Pointer lp is being initialized and incremented but the result
is never read. The pointer is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2b03210264bb..3f13fcf75fce 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9173,14 +9173,11 @@ lpfc_els_rcv_farpr(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		   struct lpfc_nodelist  *ndlp)
 {
 	struct lpfc_dmabuf *pcmd;
-	uint32_t *lp;
 	uint32_t did;
 
 	did = get_job_els_rsp64_did(vport->phba, cmdiocb);
 	pcmd = cmdiocb->cmd_dmabuf;
-	lp = (uint32_t *)pcmd->virt;
 
-	lp++;
 	/* FARP-RSP received from DID <did> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0600 FARP-RSP received from DID x%x\n", did);
-- 
2.37.3

