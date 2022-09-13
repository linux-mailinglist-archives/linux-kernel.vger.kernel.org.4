Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6A5B6C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIMLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiIMLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:49:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DB3DFA;
        Tue, 13 Sep 2022 04:49:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m3so11052256pjo.1;
        Tue, 13 Sep 2022 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=paI+cYCqGHdRW7WJHsWMoltqh+MJU/tBCstn49ikwxE=;
        b=gjUL6CA/VN6jJZbTyjz05hxm+ffGdwUAjErTH54bYaOafFPeowuTd9pl10VLepigWc
         NKJN6DlgdfymhdvKVoL84WG7oID9Me6Ot55GolTemRzM64g30YUFP6n1GiCqebUt9DCc
         Key+K6AMbqtGzaBRfIR4eBKSkF81MlUnlmcvoCXB/nVHrGG/eolPfON3Ufpm/BclOtki
         KSrwZI2Ng6IS1sgwju5CXzMtZDUs6ODayh14LTWo24INfX7wzuVnAbcqmzRO1gxVpBgf
         MBivp5P46HZjqN5MLJ9dls5QIq9zZ9MClDmpeA0y18TuGGOhMQoCSDPD5CKOthKAKc7S
         ehmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=paI+cYCqGHdRW7WJHsWMoltqh+MJU/tBCstn49ikwxE=;
        b=iPlROBHy4k5J1EPbnxGuHxhIXo2Jk3kTSyALRpg9z3xdOjKFcG3T7kSwM74UdJYxnR
         dqyDoAJQI9MBdKkFDFrgsTRgtzFRdKtSOx+bl4unY01rLTS2f/LnrZPHzhSSVD7B5kSU
         3DK5rZCH5CMT/nLItUonbNA+/WysR6T8d9fNz8QvAcwVrmfFUlAAkDpJBR7OxQFck4DY
         YX6pQkeQfrVdhMUvG4ior7pk3lUbQvRt5GGyuapI8H9ejAXSTxnuq9CtGBrsygNww684
         Bmxr7a+oAHvzb8S6okFMhVOTCYtAHi2H+Ps7Mqd7zmEzhhchUUyQnef2i+CLSkKjzJlE
         XDeQ==
X-Gm-Message-State: ACgBeo3okrTIi2tczTxv0c+iLonYHT4kVKx5K1um/YZ/IMFN4g9wt/ae
        qJmj6ctm5xRSB0KvOxRxDSkgPJQBnFA=
X-Google-Smtp-Source: AA6agR7hs3vO3UW8d8NHgGFccTXi1qp6i/AMVFBq9knehQIQnZLxmOrRRal9MhwQZ9wryjgxecKzKw==
X-Received: by 2002:a17:90b:30d0:b0:200:22a4:bfcf with SMTP id hi16-20020a17090b30d000b0020022a4bfcfmr3516627pjb.181.1663069775570;
        Tue, 13 Sep 2022 04:49:35 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id t2-20020a634442000000b0043057fe66c0sm7480826pgk.48.2022.09.13.04.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:49:35 -0700 (PDT)
From:   sunghwan jung <onenowy@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        sunghwan jung <onenowy@gmail.com>
Subject: [PATCH v3] Revert "usb: storage: Add quirk for Samsung Fit flash"
Date:   Tue, 13 Sep 2022 20:49:13 +0900
Message-Id: <20220913114913.3073-1-onenowy@gmail.com>
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

This reverts commit 86d92f5465958752481269348d474414dccb1552,
which fix the timeout issue for "Samsung Fit Flash".

But the commit affects not only "Samsung Fit Flash" but also other usb
storages that use the same controller and causes severe performance
regression.

 # hdparm -t /dev/sda (without the quirk)
 Timing buffered disk reads: 622 MB in  3.01 seconds = 206.66 MB/sec

 # hdparm -t /dev/sda (with the quirk)
 Timing buffered disk reads: 220 MB in  3.00 seconds =  73.32 MB/sec

The commit author mentioned that "Issue was reproduced after device has
bad block", so this quirk should be applied when we have the timeout
issue with a device that has bad blocks.

We revert the commit so that we apply this quirk by adding kernel
paramters using a bootloader or other ways when we really need it,
without the performance regression with devices that don't have the
issue.

Signed-off-by: sunghwan jung <onenowy@gmail.com>
---
changes in v2 : add signed-off-by line
changes in v3 : wrap changelog at 72 columns
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

