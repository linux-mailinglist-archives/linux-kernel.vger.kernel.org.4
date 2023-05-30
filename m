Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58437162A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjE3Nw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjE3Nw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:52:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C48C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:52:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b01d912924so35321265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685454745; x=1688046745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIQCOgBOMHXALjgqieEEifK+z8JLOURT7ke2XH+ZqQ=;
        b=g0SDWp9B4DZcM2zDBU+B8vGC6UW9J4pY9ibR1ExH00e/fECd1sDgW8XNhRm5fgSwpM
         IxpXziEE8B/17sC6bJY8L07SXbRaEibjmlQ9aBZAjevvxdOjGt6RNz1uM9f3dnvpSDHZ
         cFAxFxmM9VsYxMVMwP+1Z7xxpl8AdvMTa6zk+UK1pyiTjMvxXMebBSYjs5/eJc0BxHxJ
         hNtI/ml1jXlCGxq7aX3s3C7ofUI3tmLyQ7mIay+YcA9gw8/W4gtlPSPwyYex3eJouO+x
         JQKBLz5qsbXQl5bweDBmi2DZUt/n+poj3OY+CL207O4PlygQ8MIcfarcn6d11tSQ2qbt
         JBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685454745; x=1688046745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZIQCOgBOMHXALjgqieEEifK+z8JLOURT7ke2XH+ZqQ=;
        b=UqrUMGwgp4UCGDylrCpBEo3qKvrwSCaKzyPxevq3SuKlQz3pR4nkeemT8jDFLapU3q
         cMtNJxFnQXUJfjurF9QYiQhpI5jfHDlu/0pZ5F9QFgpahUsbpRvLBCGQKzEwhRPZHzmR
         gv6PfXNajve8DzuUilE0WR6Uoyvcqd95DlDd8Qui+2HtUPmRMzJ/N8i487j6JZNn8rBz
         sDClcMeUTsSMiofu5/tnS0zWjhRWyLmKUkzfi3PtwlW4T+fbn9ZkJ91Aiq5EP+YZRFXZ
         RM9x9aeEF3+hR0yzI47oM//UONw0DjVefHYh6GXUDNb0i+fWpNlz9zMksAOq7kl0os3n
         VL9g==
X-Gm-Message-State: AC+VfDxRX+quHSNSyEOfLzMffD/+KkkJnwW6rDLapsKNY7iQXNnCicWC
        wUvAoi+YjhvNeP9tolFAaCY=
X-Google-Smtp-Source: ACHHUZ5yPQK/rwAqbQJJTqIy7YWcl6WdJjYVEsunpe2v1CBi5yYWjYGbfi4xfzLjUPET3PErqG6IKw==
X-Received: by 2002:a17:902:a508:b0:1b0:31a8:2f74 with SMTP id s8-20020a170902a50800b001b031a82f74mr1898293plq.68.1685454745464;
        Tue, 30 May 2023 06:52:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3801:8cf:2f92:e53c:5c4])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b00198d7b52eefsm1461385plh.257.2023.05.30.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 06:52:25 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v5] Staging: rts5208: rtsx: Removed new line in else and else if
Date:   Tue, 30 May 2023 19:21:20 +0530
Message-Id: <20230530135120.37637-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Removed new line in else and else if,
this warning was given by checkpatch.pl

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in V5
	- Moved else and else if to the same line
	- Moved comment on else and else if statement to inside of it
---
---
 drivers/staging/rts5208/rtsx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..3f06db93e176 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -382,27 +382,21 @@ static int rtsx_control_thread(void *__dev)
 		if (chip->srb->sc_data_direction == DMA_BIDIRECTIONAL) {
 			dev_err(&dev->pci->dev, "UNKNOWN data direction\n");
 			chip->srb->result = DID_ERROR << 16;
-		}
-
-		/* reject if target != 0 or if LUN is higher than
-		 * the maximum known LUN
-		 */
-		else if (chip->srb->device->id) {
+		} else if (chip->srb->device->id) {
+			/* reject if target != 0 or if LUN is higher than
+			 * the maximum known LUN
+			 */
 			dev_err(&dev->pci->dev, "Bad target number (%d:%d)\n",
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		else if (chip->srb->device->lun > chip->max_lun) {
+		} else if (chip->srb->device->lun > chip->max_lun) {
 			dev_err(&dev->pci->dev, "Bad LUN (%d:%d)\n",
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else {
+			/* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

