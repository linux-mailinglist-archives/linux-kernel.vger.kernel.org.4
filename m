Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C7708E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjESDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjESDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:14:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C3C10F8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:14:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so644470b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684466079; x=1687058079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgmUah9AmRN5xRowBiuNUq3Kw2yWXbCwwhfNF2+jE1U=;
        b=D64F5dRY7u3AeUP6pEbj8K96JscgeJMVDPx4KZyPdOelgF9W5afgjuXpUHuwMBBCCi
         iT2g4+KIjZDXysy4nwCE7+Y9E0ZbJxu33hRE4VKcQHogU/tVyNseIbPOWYpbAYkpuQjB
         EMjwG8ka8XXp7Zioa59Sy6C8oTEsHr7+yd5JGAS/V0y33KMm+JhBUmXaNpSt8SJLc7EW
         CnRHJ995dpZ+NsQZI+GNTGEnTBLNo1VKK4IuHnM/C2UOUa+QMLvsGdw+VjFKttKKgfCw
         r7ol1E3Uzj9pXh5U86JTQ7ichXIY7uLJ4imDydFQ5r6TVltxMc/Y/783WHtdTdPXM+RS
         titA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684466079; x=1687058079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgmUah9AmRN5xRowBiuNUq3Kw2yWXbCwwhfNF2+jE1U=;
        b=Q+6uft7kdlTI9F032srbkOnszYKaSJ4lygTGTjtz6sAAS4CzyO9j/jUaRl3dug10Yy
         E6oRmfGA2s//DiSzcXD8gY7SjrDsLRyeinQEtwZqisZuPQDyHZIYMzswBsUBkW8VJfeJ
         PTqDH8LnT+FrFkEG/XfIuclg7WNomC2/LzMNLjIZ4KMnCX4FWHwJpcpGqB0iYXwk5ank
         zz8oxskzmO8gdWh3LHgpfA1QtHif4hPTRy6tuxMJEQNB3o/x39oZRbp/iGSeujEZvcz1
         nwaLjC3G6za/iBvhTJkLS0myqiRk6N2kkdOsda5KpuJYdFaahoXtxxUXsQdS9M2xC+CB
         079g==
X-Gm-Message-State: AC+VfDyKv1yV0DZOene4sAmC9Di4+1pO7xIHdo7+VKN+aUDqsz/9eMlJ
        AQ8o+iSSO1GSMyJsYsWdNl8RXyUXMoI=
X-Google-Smtp-Source: ACHHUZ6i+rL5NFRjTiY5g++pjsUENZPlcZ9PWvqV05KoSpCrCW8pe2e8BFqkBlNZl+hWTAYgvl38iA==
X-Received: by 2002:a05:6a00:22d4:b0:64d:3227:b806 with SMTP id f20-20020a056a0022d400b0064d3227b806mr1025838pfj.33.1684466079529;
        Thu, 18 May 2023 20:14:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:8f78:7441:2406:8b26])
        by smtp.gmail.com with ESMTPSA id c8-20020a655a88000000b0051b4a163ccdsm1760024pgt.11.2023.05.18.20.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 20:14:39 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] Staging: rts5208: rtsx: fixed unbalanced braces around else statement
Date:   Fri, 19 May 2023 08:42:04 +0530
Message-Id: <20230519031204.20058-2-kartikey406@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519031204.20058-1-kartikey406@gmail.com>
References: <20230519031204.20058-1-kartikey406@gmail.com>
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

