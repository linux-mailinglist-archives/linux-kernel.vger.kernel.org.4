Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AF614AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKAMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:32:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A606E18B12;
        Tue,  1 Nov 2022 05:32:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so19936712wrh.1;
        Tue, 01 Nov 2022 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvV/hDRNG87XgGLwtJe2i5KT4izzaOEXiuV4DZ8rKKU=;
        b=TkHrHAcpF50Vgp/IC/j0Oqp0hXP/7THF03asCvqoTkHgHGPUo441bISpk7fcKnnGUd
         zYkLrzmSFDjwuwEOUClSxeFpNzaOrzF7FNL6PFQdDKM+I+vTvFw8A4mLON0xrJtKfYmM
         Jw6mAst3Fb/N7gjYhb4jLx53Esg247MgnGaiAN2iFM15ZgNojVuMl7wHE4QAFTpZihTn
         bVygCZ5MsLwlrm2q0Fs0kbKXpV5E0s1xeCT2L3c1v+b3gSJOQFLex1X/X2OK1yjBSeTb
         qlTvq4T9TCdnrnoZdXKiCkOC5tSsnQ3abUIR53w4lLRKcoFbmCWU5gj6Ekdqh4F+7dDy
         s4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvV/hDRNG87XgGLwtJe2i5KT4izzaOEXiuV4DZ8rKKU=;
        b=2JB+HUQF6uTuYrWDUvE1rsumTksixLa78EAj1CMS7HM4eMgh6FhzzfGdy8+A0oXS+Q
         K1pEKebKOiCSYncgtN2f2inS7buNIlC/j6YouzUX3FhEH2ARXAuRznd1ImoO5ms2FSAX
         zS7ORbzY18dPJXBttDirqFKZ4/npoQ6Cgm84lxXc9rUj6o6VYdZzJ66V04OMT0IYSz2y
         ThxHmPF+0PFwXHDwBiEok+QnOcF92Htk4VYDZIbXO7K0Lrpg/4/VA/78eFT6begeVoXp
         tTBF7CYdxiJ1e4WNTYzMC1lbnWNDRibetdcGmW7WSVhhmfFNce8SSuQf7rvK1rRaG0Ck
         83Iw==
X-Gm-Message-State: ACrzQf2Kcfmylry9T/Cwg9CXZOyWb4hPJ8vOod+TGdJQ5uK3/HLG5xUB
        NxE4iAa17KZWibeVSkdYW9U=
X-Google-Smtp-Source: AMsMyM6tcnwP1VN45XylSWH7XmMzOZr5umE8Rl9wKNMe5SgJ8mKS1I75LJI2dcceafxwntpH8Bccvg==
X-Received: by 2002:adf:dd12:0:b0:236:6ef7:dacf with SMTP id a18-20020adfdd12000000b002366ef7dacfmr11264047wrm.204.1667305957152;
        Tue, 01 Nov 2022 05:32:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0022b315b4649sm9894518wru.26.2022.11.01.05.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:32:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: Remove unused variable n
Date:   Tue,  1 Nov 2022 12:32:35 +0000
Message-Id: <20221101123235.52152-1-colin.i.king@gmail.com>
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

Variable n is just being incremented and it's never used anywhere else. The
variable and the increment are redundant so remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/csiostor/csio_wr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index fe0355c964bc..a516df019c22 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -1051,7 +1051,6 @@ csio_wr_process_fl(struct csio_hw *hw, struct csio_q *q,
 	struct csio_fl_dma_buf flb;
 	struct csio_dma_buf *buf, *fbuf;
 	uint32_t bufsz, len, lastlen = 0;
-	int n;
 	struct csio_q *flq = hw->wrm.q_arr[q->un.iq.flq_idx];
 
 	CSIO_DB_ASSERT(flq != NULL);
@@ -1071,7 +1070,7 @@ csio_wr_process_fl(struct csio_hw *hw, struct csio_q *q,
 	flb.totlen = len;
 
 	/* Consume all freelist buffers used for len bytes */
-	for (n = 0, fbuf = flb.flbufs; ; n++, fbuf++) {
+	for (fbuf = flb.flbufs; ; fbuf++) {
 		buf = &flq->un.fl.bufs[flq->cidx];
 		bufsz = csio_wr_fl_bufsz(sge, buf);
 
-- 
2.37.3

