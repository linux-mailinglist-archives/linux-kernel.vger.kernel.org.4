Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422B708E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjESDOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjESDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:14:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC6B1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:14:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2467d640so1350997b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684466069; x=1687058069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QgmUah9AmRN5xRowBiuNUq3Kw2yWXbCwwhfNF2+jE1U=;
        b=Uwnr/Cd4Xvb2Ky63sfePVNXU3kFgFG1/wrNqSEuO/4iWg7ZA6IBMa8efZLMRKXpfnH
         +bkG97pqyNUzJovNIWftt/hlmbV1oBDjOgPjc80b0TnFZHNJIuwWTlxdPrrIigJedcZQ
         nMKm3o/3PiWxySCiYxGH7/84cSRRoj70tE7oj8oSnsys6NcygPvstldAocSESH6ecXv0
         IgVgrdfWhHFq1rudPP3RcL5dbZqpCNWH4f5Hs1g/1Pwoju78KxEBW7yBv8sEAXqQHj1i
         1pdLao/l9QmHcqBCEFPcN3MBpt5n+molgfsSOrorMCAIcixI5wWGXdFFC9tdtXC8HHpS
         YnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684466069; x=1687058069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgmUah9AmRN5xRowBiuNUq3Kw2yWXbCwwhfNF2+jE1U=;
        b=FyxhEAD/KxKHuY8nbhdkN/T8zp09CEfNAhweIx7Dc7XGTcBW78IkMb9/031gPcihrj
         07EesLcPhhavBF6ja5m/NDvsZoAkbM4uS50+WwVc3YypDiUQ9s03V4uDZWZUvPGQlBrU
         vsLEaEPOIDLAXUJmo7ijk3EJ9r/2OG9rD3nRDsY2qke9KDXhQ59o5Jjo/AP7z8UBRT7g
         rTp8yP5JtMefu8jOC/OtO5F15z65XV/I5RkwMxw1bvtAKHo6/yxc4mFoLyPsOm7FaLkq
         T+m/YPVIzov9gUTc3cxcDSO+03HQuo57ziiVQXSRWBVFjAQpJ1LKjvZnTG24JZTsQvrS
         gTEA==
X-Gm-Message-State: AC+VfDx0GbOd5P7MEFoewzjvHGqqhETUpBzc6rvPiNiN1hbBxfe7BiOi
        CevOyHSjJOx3oc2whz6Y+vU6VHoolPs=
X-Google-Smtp-Source: ACHHUZ51LC78lb0BD6ilJInnWpzFy9kta4eIggJFnJtfgjbEAsfH0v7xKRdsV2kRwBv+CeixkyKiTw==
X-Received: by 2002:a05:6a00:1389:b0:623:8592:75c4 with SMTP id t9-20020a056a00138900b00623859275c4mr1543002pfg.29.1684466069333;
        Thu, 18 May 2023 20:14:29 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:682f:3808:8f78:7441:2406:8b26])
        by smtp.gmail.com with ESMTPSA id c8-20020a655a88000000b0051b4a163ccdsm1760024pgt.11.2023.05.18.20.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 20:14:28 -0700 (PDT)
From:   Deepanshu Kartikey <kartikey406@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] Staging: rts5208: rtsx: fixed unbalanced braces around else statement
Date:   Fri, 19 May 2023 08:42:03 +0530
Message-Id: <20230519031204.20058-1-kartikey406@gmail.com>
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

