Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FD70945E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjESKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjESKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:02:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D286132
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:02:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso1271900b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684490558; x=1687082558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=b/fsbDPtKzkSjhJgYBibHq2FGgZEylRkGne9JM3bSu5YcnPkTHJwBC5AWTG1z7Zo/v
         PnRJb3YgltwgODJqQdXmY7di2wO+CKBmkCtEV5H9qHVbDgLaqS9b9KfPPSFYW2+4PRPY
         wLo0l4b1nR9LjZbB9QCsZaUyHFyniIfjFVftw//Hj+EhBdHntDeXTNNELfbpvQy1sXDt
         ccOd0RAOtOEwelVloU36T4pkF0HPVBSqijaNH7ZD5KqWoI7Vz9149hCpjEsn18bsyFUA
         oir4/aYRaplYGlf6ajbPLZQF8YIJWdMZ6Sgq5iFrtCVvoBxcJUSm85jVwa94/1Cr3Atj
         zofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684490558; x=1687082558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzq3Pqk8pZIS4OBKRNMcHxRAHqoQcIGGMgWTxxeCr8o=;
        b=SzfT4A51QClIr7MXeH9pr2F6AKMkWp1o7Eqigaxeg+G0JHgGsJz98uDc5FV7dHwaY6
         ZbvCbCmUghW14lgOa3IHc4b4XFcQBCKPOE9kTPdAyaPPKW+bkMbkQv5GWciD9N6/ntOB
         nh+UrdWgppfjcbzTJktZEi1HYp+cZ2GZ0e3f36jK7XvOXqYqT/6NYqUbAtknLvThe59O
         e+QSKfcV/O8qmNY2ntcV0TzJlBRD877Ra+w0KK5aWIYFcj51ZTN8TK4bb6XtqwZ6/YOB
         Hd5ZimmoqIhupoIqjVptUmXvnR6voTR1xggi2hHKJf7O90T+q6uNTy3vyjxWK1gpLB9a
         u/mw==
X-Gm-Message-State: AC+VfDy5remz3bcDb1hXlMPcMaUakRAkEeXVjsF+MCLxK8KAu5u0aqk6
        +LC+OiD6i4eNGWZ0xacTKseulliYGyk=
X-Google-Smtp-Source: ACHHUZ6TuoypXaIzwGV7YKg30OUvIQCRjONVjfDFaTmc/vZITR66LGJJYCushdEgWVyNpsMp66BPFg==
X-Received: by 2002:a05:6a20:9384:b0:105:b4e:ed71 with SMTP id x4-20020a056a20938400b001050b4eed71mr1939878pzh.32.1684490557737;
        Fri, 19 May 2023 03:02:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:92bc:26c4:ce02:816b])
        by smtp.gmail.com with ESMTPSA id i5-20020aa78b45000000b0064858e255d1sm2673663pfd.65.2023.05.19.03.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 03:02:37 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] [PATCH v2] Staging: rts5208: rtsx: Moved else statement to same line with else if
Date:   Fri, 19 May 2023 15:31:19 +0530
Message-Id: <20230519100119.25482-1-kartikey406@gmail.com>
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

...
Changes in V2:
    - Moved else to the same line with else if
    - Moved comment on else statement to inside of it
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

