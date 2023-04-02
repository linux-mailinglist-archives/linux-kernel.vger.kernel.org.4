Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB96D38C7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjDBPcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjDBPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:32:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311E9E042
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:32:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m8so4756248wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680449566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROdznGkDW/Cnxv1c0rSMvRWt/kX2WgW6XJagkUDkrao=;
        b=NjQ+bX2U5JDkfRb+BW+lAjJ83wvPvSfQf9bG+I45s2iP5SZIb3QfZ1AxXHrGNMnvlR
         PRuCMbszFMCwxrucLB99qJc29r+ScRN5UhbNJuyb+DuLC5m6m9bntuXnW1PItZfyjdPE
         4I6aevZXVZV6uFQTOj1wuvHLeg6c143QXQck9iN0J4eufQ1ahRDoBQS7rr7sm0JqKqMG
         YSKGDPFqTnaOgRg8jY4wMX8eCp1JLFoc5P0mbyUSvkHZiC0YdIMxUQfCW/E9JyEPHgih
         LCYv2zpCxGEwm5hJ4j/3RhO9s4F6PWBtkTo0HYE65ESvWbE5eRyB7FRAP67RmRHL7FIF
         EdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680449566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROdznGkDW/Cnxv1c0rSMvRWt/kX2WgW6XJagkUDkrao=;
        b=egMsF2E7CCNlUeIAO8sKfebGaz55Mf+6Urfs3VyolAVsDESIkfZNJCOILVF8YEmdIM
         Pi2ZqErgznJIBwKl/Ysz0f1gAq+jSzPSOPMdVl/IchiUwrfg6XTCF1qn4+wf9smFDFRp
         14nNbyouZ6kdswlWRHWOE7fS4+EwQS2Q5OKvqDIesMkB+sw9neS1C6s7KxmI+clY1bI2
         XcHFA2d5UjZs9J8YmDY3koTHqEygIO/P82AfHsaw7v/4jEfdl+QMzPfXPvA1vc5lKDBZ
         0XT8tPnnRfOlmA/JliIJ1qRxZXjR05tsgyCfJHBudk1geKbC1YfPMZfvW7ge12kXlXoU
         G5zQ==
X-Gm-Message-State: AO0yUKX/R/SKDPFVqnG34a4DL/ZG6rMM02eXFo7EXuaI+xZqnyqvNlmO
        YDwTCNlJ5a9PXp9vL6B+Fw==
X-Google-Smtp-Source: AK7set8v3PAD+xMYhMSx0hmgJk9LHrWsbe2xJjPqyspqOmodgzn2EpIAllkqSSRt8wHtc4VnnZWZug==
X-Received: by 2002:a7b:c4c6:0:b0:3ee:5754:f139 with SMTP id g6-20020a7bc4c6000000b003ee5754f139mr24350103wmk.13.1680449566619;
        Sun, 02 Apr 2023 08:32:46 -0700 (PDT)
Received: from koolguy (dslb-002-205-192-117.002.205.pools.vodafone-ip.de. [2.205.192.117])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b003ed2c0a0f37sm9321258wmj.35.2023.04.02.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 08:32:46 -0700 (PDT)
Date:   Sun, 2 Apr 2023 17:32:44 +0200
From:   Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: add comment to spinlock_t
Message-ID: <20230402153244.GA12609@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning: spinlock_t definition without comment in
drivers/staging/wlan-ng/hfa384x.h

Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
---
 drivers/staging/wlan-ng/hfa384x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index e33dd1b9c40e..fc6d67cec5b1 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1000,7 +1000,7 @@ struct hfa384x_usbctlx {
 };
 
 struct hfa384x_usbctlxq {
-	spinlock_t lock;
+	spinlock_t lock;	/* disable interrupts while working in hfa384 or hfa384x_usbctlx */
 	struct list_head pending;
 	struct list_head active;
 	struct list_head completing;
-- 
2.25.1

