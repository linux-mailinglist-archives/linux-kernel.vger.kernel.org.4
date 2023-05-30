Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC26B71539A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjE3CXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjE3CXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:23:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71E09D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:23:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so820888a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685413421; x=1688005421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7yxoBalJu1ZCTXrRuET/e/J8+mI0agu1V6HCaCfZ5Y=;
        b=JInACbaRG6zCY54oNSpmPgvZZumFjCPunkuf/OzCrnpLD69mSnpE4jRqYh1leO/FvZ
         j+0KrSwqplZ2flR8iwKpTRSeYdkMHKFqEOY8eF/xG+NqllhjxsecM7R/jxLGWLrQeTYy
         uQRjPMMDA5PyDPTlgHT+08D8KFINy9sEz7vOSojUnNlScDO8HD/lAmMgLA2vrlBgoZi4
         OuQ9oPUx47kDoIO7ZRoGDoTr4NFi862+JQSooIP7fppA57LipQ5PdV/jLs4ydSs9MK8C
         ywpuTKcqaK2Ucw8g0nC7aEEKAIIi1uOFqzVNv5O3hoDlJdB/39D5vX/Ys3XtxKF12Akg
         6pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685413421; x=1688005421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7yxoBalJu1ZCTXrRuET/e/J8+mI0agu1V6HCaCfZ5Y=;
        b=M5565DUxMrighgsV7TElOskyzUTx6IiziOvebndN7SWq29+t5Nk7DaDTWF1pRZFjNx
         jnRP31ybe+yltUJqjvbNWih8gNMO4K3P8BU5hjrYRQmyVuFieZdtM1YZcWGTqldfkNaE
         v4JOS1tLd4zexlLE9+jUT7z6g5aMgN8KLdQvTY6YE4QGprWj6qQ+dlyzdcGPnfJRDQes
         toWpusXStzEHv5HkGjO8Fso8hZpN2xtBH/fFDJ3TafmsQ9uVQCqougc3njbD2XKPtdv8
         S5qNUNYKo3Im0OQpqG57Rcd3c+Y9gZ1LAEA+75okRDjs+iKt0kEu1TlMh3/Gjn2dFeg+
         TdkQ==
X-Gm-Message-State: AC+VfDxs21kTOfV7dTVMLlg3FswjLcnO8uQDfJoyusOl/rHbbVDZgmT6
        rxNLRWE7HSI+4JX7SzHzklFBdm7fJdM=
X-Google-Smtp-Source: ACHHUZ4vB8xYir+2LzLQmGt/Drl5uVOTpk3tEFPqW+VM/JpJ/UJY9c9iUM6YYMknkbkVQS0OBTEOYA==
X-Received: by 2002:a17:903:124a:b0:1af:daf7:7240 with SMTP id u10-20020a170903124a00b001afdaf77240mr946768plh.58.1685413420941;
        Mon, 29 May 2023 19:23:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3801:cfd9:6060:fe9:235b])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001ae6b4b28adsm6236998plz.130.2023.05.29.19.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 19:23:40 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v4] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Tue, 30 May 2023 07:52:59 +0530
Message-Id: <20230530022259.24094-1-kartikey406@gmail.com>
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

Moved else statement to same line with else if,
this warning was given by checkpatch.pl

Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in V4:
	- Moved else to the same line with else if
	- Moved comment on else statement to inside of it
---
---
 drivers/staging/rts5208/rtsx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 2284a96abcff..47dacef0aaf8 100644
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
+			/* we've got a command, let's do it! */
 			scsi_show_command(chip);
 			rtsx_invoke_transport(chip->srb, chip);
 		}
-- 
2.25.1

