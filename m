Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9036C4BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCVNgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjCVNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:36:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B31CADF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:36:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d17so8666131wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679492166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Qcc01bThYgNN4EDH3PH3xQ8u1QU4sH2s8PABfTDu6Y=;
        b=J34H1SdbC/nCg/E/QjATqJYym9ALDDptxGYZd1j1eb0dYOENa62tJWHy9WD6GFbdO1
         bnrock3LLiOZy4DRZg3i2M9AmUktSR99PWNLoZJ0XXAiunQCDRso+N5YtRu4C8JrcwYF
         DLc0j3k3HipvC8V5BbNiRFL9zOu5kRf250ncc/BlscmMShbhb/PBZpileUDfRz18A7fy
         4OJJS6ItiZXXIdVdIS5mDwrYRYRsFBsKhABy9yCaTupX7Lm2Ch2YeihLrRYTWFAwY7Ee
         NWX/6etoOz0QcmRhvDjFRXpEj4TsltoTVhjSLV1C5Igt95lyUxR5TztF5eAbuAzUtnwV
         sXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679492166;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qcc01bThYgNN4EDH3PH3xQ8u1QU4sH2s8PABfTDu6Y=;
        b=yiGRy60fUqSapuJVigLFTHv1IpLuwDnvMa/cPpc3D9p+nl70asN+FZIVnlozHTH9RM
         uPxVOuwnpsAaNCLheRxyHYiZWXfmSOg+c3vMmvV1cVbZLC1YRoEos7vOqbO3cORQ0Ofy
         xZvM3AN8lpm/Pa/5vnsc4W7j1IPboxDdUw2CHZRcxgaTjA4NZ7XzbAqFHLYRH2o94yn+
         FwAQvmOtzS3CSLRI7bwYrWnWriEGqQ4a1boFYBhrUvVSQ1GVvwSB7wrwggVK6J79NUqV
         2RnmsKl9XlOGn60NwWtXG91FVFovB84EMG8NTfzOdJQSJvk31iyRlYFzqaWtywhK60Op
         evgg==
X-Gm-Message-State: AO0yUKWLCKDCgfJ3exPS9jwRuC5iJXr31Cc35b42be3hRLgTMf4EwkC6
        uHWxgqCTo3hY1J+RYL4GK6LnZquHHWOdv8pD
X-Google-Smtp-Source: AK7set8KIMT38ukGDMClhbdqjX5z9iqnZpWLMZU/Q0vufQSV+5lMMAXT0J35nXLEOWiTQ5oIJ0gL1Q==
X-Received: by 2002:adf:f5ca:0:b0:2d0:cf21:a40d with SMTP id k10-20020adff5ca000000b002d0cf21a40dmr4814231wrp.10.1679492165965;
        Wed, 22 Mar 2023 06:36:05 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm13831630wrt.110.2023.03.22.06.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:36:05 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:36:03 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: fix line ending with '('
Message-ID: <ZBsEQzL3Oidsmg/L@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the first parameter right after the '(' in the function call line.
Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/ks7010/ks_hostif.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 9429ee155910..af3825578d85 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -75,9 +75,8 @@ static void ks_wlan_hw_wakeup_task(struct work_struct *work)

 	if (ps_status == PS_SNOOZE) {
 		ks_wlan_hw_wakeup_request(priv);
-		time_left = wait_for_completion_interruptible_timeout(
-				&priv->psstatus.wakeup_wait,
-				msecs_to_jiffies(20));
+		time_left = wait_for_completion_interruptible_timeout(&priv->psstatus.wakeup_wait,
+								      msecs_to_jiffies(20));
 		if (time_left <= 0) {
 			netdev_dbg(priv->net_dev, "wake up timeout or interrupted !!!\n");
 			schedule_work(&priv->wakeup_work);
--
2.34.1

