Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43A701C07
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjENGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:52:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786E2105
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:52:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so13952788b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684047162; x=1686639162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyq46DYiYFeczNtd5py4N6kycWAKUkPxuVjsobEQu/8=;
        b=CERCoTYfkyyRChuQXQEGV7ZqIc6UqCzzpaPg367AFt4hA6jofj4+mGeG95BttbwTYg
         5F7Tdsxlxqj6ETKb5eQMi8S/FmCRLtKG5c3tCknUESHw7+UTtkb+NNMBs/eFeHCYkxVf
         ODVa6n4sp0Nw+4NhNsQplk1aGg0q37xRfLtmB1sBYReRbzSqlTDLRJ+DRaV5LIj0U1tX
         npRhfadLTeU9kFDY6RHr9z9dJF66fW6VZ9MxDVXNDz5fAMMePhRjFj5vR/L9NyBcRfx7
         83cYU1gqXV8IdsKDa9UJ6gKg1gU6ql7Y20TWrU85Ie5iDvlICyxidFVl3jOZhC4tXvsq
         Wq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684047162; x=1686639162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fyq46DYiYFeczNtd5py4N6kycWAKUkPxuVjsobEQu/8=;
        b=kV+cBRHJLIYjBQx4VM7HvVylcwgRCIHoEZ+SvWgh48x4Gm6jy1fi3KZFqhl1ctCiFL
         v6hsJMFmKd75AwuAvuKW1Ck8UQduFcfMEeHNzot0iYupW6MwI5WV/gdaAT4Ds1DQ2Ao/
         JHcdGG+fP/mjHYNBTB71wNKTbYsyVU53YNmWyqntmCn7IYlg/6GcmzGMNzYsp+tx5f3y
         3g4OR2I1Px1qeGC6dR6g2GhUCqNoluZ2/Fab7lgK5uFUpaoX8lxJYF1Rf8Z0GZDBNHi6
         XpHU54NrrCnibOIkrKKHhByMEFN3zwXsNOgeNH5TXTjEmxyNY/+vEp3rt9rfEr4ko6vx
         FTjw==
X-Gm-Message-State: AC+VfDy2KM4u1nB2S1LvZewJ/3mSNR4WKmzY04vSdRRTdu2jNUUwOZzi
        0ng8pPYicpHn+0nXC2pcVOA=
X-Google-Smtp-Source: ACHHUZ7QRGKi5O7EJ5OFWTWGUsrkoDk9VuXnjdXKkNCkx4qJGQu7zSG3S6jpSGS8keN/1GWl7wPsZA==
X-Received: by 2002:a05:6a00:1502:b0:647:157b:cb61 with SMTP id q2-20020a056a00150200b00647157bcb61mr23477519pfu.7.1684047162202;
        Sat, 13 May 2023 23:52:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:c449:77a9:2cbd:238f])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b005aa60d8545esm9569943pfo.61.2023.05.13.23.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 23:52:41 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: rts5208: rtsx: fixed unbalanced braces around else statement
Date:   Sun, 14 May 2023 12:19:36 +0530
Message-Id: <20230514064936.7895-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed unbalanced braces around else statement

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..0ab9355873f7 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
 				chip->srb->device->id,
 				(u8)chip->srb->device->lun);
 			chip->srb->result = DID_BAD_TARGET << 16;
-		}
-
-		/* we've got a command, let's do it! */
-		else {
+		} else {
+			//we've got a command, let's do it!
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

