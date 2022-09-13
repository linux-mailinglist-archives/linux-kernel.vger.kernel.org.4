Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F95B6BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiIMKhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiIMKhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:37:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1ED5E57C;
        Tue, 13 Sep 2022 03:37:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e68so11359739pfe.1;
        Tue, 13 Sep 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=N8hy1dIcQisjqhDY6MA/ldhQ7my+rp3krWj8FtUHCYU=;
        b=EyDg6zl+looJRDHYTzOUucuU/9llMVax1IVLY4AtStmbI6kvPG86p6XZ4S/l2JUG+p
         0aeUKVDxqs4as01tM1YPpXqtZZbGp8dyy+HMYDfUK4ePqD9jiEAuTyYS/0ksUWZJghS2
         ai5sydRMdjEvmybVKXnLzbiqzczQH0C7x6oQsPZEh6MEOrVSyx99yzMfzrZO9TLucPE5
         40sTL1zYam1Jnr6MIMJCF1+1EyJF6ALf7GoEgTi+2I1GPkuF3GFm0/+5ILlZBzVrBq4G
         v4ZUye684uD3kJbJeVDAwWMO1M//JvEe1N1mUwkRefgnl79MowcqNc63YwZt3Q7+5/HC
         wETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=N8hy1dIcQisjqhDY6MA/ldhQ7my+rp3krWj8FtUHCYU=;
        b=hnjEfnHhjHBMecZr1PqgZi/m9MjN5Y4GqM6KNUmsXLiI3JiCvA0XeXIlX7KwmEA0q1
         2h7rID71b9RTpK3yZ9dr/TnPARt/gGYlxY0s18fNbko+dgyyQ4KNRN7PiE6+UJzS5PWk
         Dpowo9PfkJa6aYywuRgwmMO1M4eTPlNr67sTeW1F7g1MqnUMYK25wcHPgTnnj3cPU4Uh
         eACY0SxSydM9Qhm+SAc6iJKYHq77iCmTOqUIBkAGU2IbzrW0R8PE0If+tTLN56vrLChK
         kUSoLdt0ipbCHcmhjLGEp5Ac/q6hgsyIxRCumQtkCSPVh/5tpTSnl4DkgUt7qC/9kpp0
         qShg==
X-Gm-Message-State: ACgBeo1aq/ajPHQ8FH64KmAnIcEEOSHcjTyX0jT41tUdwW3MTbOU2pGs
        66+AddRbtpcSmurqhjYhe8s=
X-Google-Smtp-Source: AA6agR6vLgkK7xyP6j4+MoVaHgh/OPwVYKN5g40CkYwrjVAbtELNB1mmw7JeKf1H6N4vVn3RlN54mw==
X-Received: by 2002:a63:1b21:0:b0:434:7610:11ba with SMTP id b33-20020a631b21000000b00434761011bamr27599552pgb.396.1663065465029;
        Tue, 13 Sep 2022 03:37:45 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id mn19-20020a17090b189300b001fbb6d73da5sm6944743pjb.21.2022.09.13.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:37:44 -0700 (PDT)
From:   sunghwan jung <onenowy@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        sunghwan jung <onenowy@gmail.com>
Subject: [PATCH] Revert "usb: storage: Add quirk for Samsung Fit flash"
Date:   Tue, 13 Sep 2022 19:37:12 +0900
Message-Id: <20220913103712.9267-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.37.3
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

This reverts commit 86d92f5465958752481269348d474414dccb1552, which fix the timeout issue for "Samsung Fit Flash".

But the commit affects not only "Samsung Fit Flash" but also other usb storages that use the same controller and causes severe performance regression.

 # hdparm -t /dev/sda (without the quirk)
 Timing buffered disk reads: 622 MB in  3.01 seconds = 206.66 MB/sec

 # hdparm -t /dev/sda (with the quirk)
 Timing buffered disk reads: 220 MB in  3.00 seconds =  73.32 MB/sec

The commit author mentioned that "Issue was reproduced after device has bad block", so this quirk should be applied when we have the timeout issue with a device that has bad blocks.

We revert the commit so that we apply this quirk by adding kernel paramters using a bootloader or other ways when we really need it, without the performance regression with devices that don't have the issue.
---
 drivers/usb/storage/unusual_devs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 4993227ab293..20dcbccb290b 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1275,12 +1275,6 @@ UNUSUAL_DEV( 0x090a, 0x1200, 0x0000, 0x9999,
 		USB_SC_RBC, USB_PR_BULK, NULL,
 		0 ),
 
-UNUSUAL_DEV(0x090c, 0x1000, 0x1100, 0x1100,
-		"Samsung",
-		"Flash Drive FIT",
-		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
-		US_FL_MAX_SECTORS_64),
-
 /* aeb */
 UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
 		"Feiya",
-- 
2.37.3

