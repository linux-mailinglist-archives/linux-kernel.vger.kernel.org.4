Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710975EE94C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiI1WV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiI1WVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:21:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF60F185B;
        Wed, 28 Sep 2022 15:21:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso2154579wmq.4;
        Wed, 28 Sep 2022 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Wi426/C5OCiR5xNNz3hvTRVexYsTtTPGdXxj34f8Kp8=;
        b=JiEggR/MF06JHR5dYMCJei+y1uf0Yd+FZSPdr2e+9UtML22r1XBe8igzZYuvp//D56
         Bl5C3LVTW485F7h9pHFIugWD+8merXwEAu8+Vkl1DdEcME7JfuB9guoYx+o6/39NIgRl
         BUHCnAjV3/ytFTZ6DqK8rW8yJo0z3RJBhr/wBLRTWUxAkR4tcfYqTZlVwn+x35ByIVdF
         17MhGjQpDhbN74tmI8UyRs4W2IckugZw3J25sIgUhk3e6+e6FIWRX0XxLGe7mA3Rgw8/
         EUDryQoTIuVIX3l96Q0um2zn4RsPk91A5FdZM5ICUxvdv2+N4Vlk/7u/kmF/kUXjqPg6
         z5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Wi426/C5OCiR5xNNz3hvTRVexYsTtTPGdXxj34f8Kp8=;
        b=nGGU8x5bA6FH4KgxRzAZwzvrIG+db5rEOeWKdwKb4XkCj3oyF+A+OSGfi9I5TPkoFJ
         1kjBkUxk9OZ7vNTqp8ohZrBoyTGqvCzutZT379rs9sasOe1QrCLF9P83xYBhmbDghNFx
         S87R6F4tTyD4W6BwrgfG944es/J+F5zJDtmuNrd7MFA7Ak6TpDzveTy7kpOV1JsnCDA/
         OLltr/HkYBD1qH1rLu6vrwx50aesqqfmPltPcPnIMncPuw0aOpJZowhxcViIrXMbhB8o
         2ymuhOojq0ETu5Pas8Qqa7Mehm4MSMHcCxJW9+05KE2Ksh7qUSqXx07Eu54bKntitUxv
         6BOw==
X-Gm-Message-State: ACrzQf268FQgu9w3Mn7/K2QeKTRsW5G2FKIQBDicH+j5IYeW+Gthkxzr
        ugTgb7iCUdyo9ztFNJftVlk=
X-Google-Smtp-Source: AMsMyM7sjJNt8F/25DP65Qd9rESmJhYbPfew3piOcnzoKjMMnGPyN4Ylz7RtgSB7vCCj0qGJ69gByg==
X-Received: by 2002:a7b:ca53:0:b0:3b4:90c4:e07 with SMTP id m19-20020a7bca53000000b003b490c40e07mr127772wml.150.1664403677213;
        Wed, 28 Sep 2022 15:21:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c228200b003a6a3595edasm2753094wmf.27.2022.09.28.15.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:21:16 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Fix spelling mistake "unsolicted" -> "unsolicited"
Date:   Wed, 28 Sep 2022 23:21:16 +0100
Message-Id: <20220928222116.68294-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There are spelling mistakes in a log message and two comments. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 4 ++--
 drivers/scsi/lpfc/lpfc_ct.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index ac0c7ccf2eae..852b025e2fec 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2582,7 +2582,7 @@ static int lpfcdiag_loop_self_unreg(struct lpfc_hba *phba, uint16_t rpi)
  *
  * This function obtains the transmit and receive ids required to send
  * an unsolicited ct command with a payload. A special lpfc FsType and CmdRsp
- * flags are used to the unsolicted response handler is able to process
+ * flags are used to the unsolicited response handler is able to process
  * the ct command sent on the same port.
  **/
 static int lpfcdiag_loop_get_xri(struct lpfc_hba *phba, uint16_t rpi,
@@ -2874,7 +2874,7 @@ diag_cmd_data_alloc(struct lpfc_hba *phba,
  * @len: Number of data bytes
  *
  * This function allocates and posts a data buffer of sufficient size to receive
- * an unsolicted CT command.
+ * an unsolicited CT command.
  **/
 static int lpfcdiag_sli3_loop_post_rxbufs(struct lpfc_hba *phba, uint16_t rxxri,
 					  size_t len)
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 75fd2bfc212b..e941a99aa965 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -90,7 +90,7 @@ lpfc_ct_ignore_hbq_buffer(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq,
 				get_job_ulpstatus(phba, piocbq));
 	}
 	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
-			"0145 Ignoring unsolicted CT HBQ Size:%d "
+			"0145 Ignoring unsolicited CT HBQ Size:%d "
 			"status = x%x\n",
 			size, get_job_ulpstatus(phba, piocbq));
 }
-- 
2.37.1

