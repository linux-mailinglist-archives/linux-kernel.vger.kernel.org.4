Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDF5B6BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiIMKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:51:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CA558E8;
        Tue, 13 Sep 2022 03:51:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m3so10895258pjo.1;
        Tue, 13 Sep 2022 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pTq+Xcvl1e+n0GZWfkJLZOf0hA1PRIqXZ+u1gIefpbQ=;
        b=Ya0kIqgDDrO82P2h78KG8+d1B415TPWxWsDkhinAdRfIXjrX8+A16Pu3naqXU7tJ0O
         eMe9QEzme/5llJbsKFBA67s0a/mBDQ+TytyqB1YqUUN9xFxYSF7Ecfxtli5dbHVkSoLE
         sNaiP6OOQ+C+O61s6E6HXHZEzhOQmTVTNMLEmJq75BpAhXEc6OukJR5Ywn8zOAb1bdfD
         sNl1yknw3YTUATzQF5lBkNY/ajyirwefr+vmBQCgCkVVGFEbpg1c9d2DBueIDpcZRT2W
         +z8F1AIo9oncpO87g0SEKmIuAmHYn6V3qCNWlqsWbsCHwc72iXRJBcVCocuIOS9BVxyx
         BB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pTq+Xcvl1e+n0GZWfkJLZOf0hA1PRIqXZ+u1gIefpbQ=;
        b=gpqew2TVKqZ/0psLJ+rVl945vTyYV0VhpwpLAUWbuL+Hfd1AV4LtP+I1DvApyfJl9T
         maObdu5Nj6d4Wcu3dFfv6xQ/tTOXx/lMAyXEoqD83B5b2QpiXKk3dmC5FiyDM5HoDNq+
         Vu2umsDwZlvkfhICvnTjk1KYmTq3DDXC8V6txFG1NnkbBKP3HA21FvT0xcbu/F8F+jq3
         GwiQ2mOXwGJEaViDF5zVJkNlP6/z55DQHt11ywaJ6cmSnM9MTmJDBuYeb4HOrJHjRVwI
         q42yHuXiSL0shZckUlRtzbZ1SUKxbWR8DMW3uhP5Q4oOhZnwyMy3QdjQLMEnCyciiQ+h
         nwVw==
X-Gm-Message-State: ACgBeo235ZZMrkEjwArcs2OMqTpsPmiUsgLguXdYvWL8DHgE8mhdANdK
        Nv7J6EdN60YGbDI68ACxBr4=
X-Google-Smtp-Source: AA6agR7JRy1CB6HwnOulsAUVmkWiZPzRDj1RtUAvMDDFnvXBxi45n4XvBxLK0n2owS5wLFoj7L9a6A==
X-Received: by 2002:a17:90b:4c8f:b0:202:bcbb:1984 with SMTP id my15-20020a17090b4c8f00b00202bcbb1984mr3282768pjb.64.1663066267101;
        Tue, 13 Sep 2022 03:51:07 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id nd3-20020a17090b4cc300b00202df748e91sm3000651pjb.16.2022.09.13.03.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 03:51:06 -0700 (PDT)
From:   sunghwan jung <onenowy@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        sunghwan jung <onenowy@gmail.com>
Subject: [PATCH] Revert "usb: storage: Add quirk for Samsung Fit flash"
Date:   Tue, 13 Sep 2022 19:50:59 +0900
Message-Id: <20220913105059.10248-1-onenowy@gmail.com>
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

Signed-off-by: sunghwan jung <onenowy@gmail.com>
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

