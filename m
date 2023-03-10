Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E16B424A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCJOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjCJOB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:01:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568CC114EF0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:01:23 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i3so5627299plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678456882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1E1H01G5yHTefNIXDYDwx8BnHam3cp9im/vl/s0zSJg=;
        b=paKTama3iHQUROKjuwszpwKu1vGrHb0C8kTFWk/OFl5k4xxjcPUQg3QwKohLz2Seva
         duc++0cFytkwWflXtPn99raoCbKXCbI+usvcgFDNWr8s3g34NPvLDYNJHUoCknWtNbov
         Mn+duwew2vbd4E2St/NsZ8go+P5EoxCFJSibkgrTPaqsKvcMVe8Lt4z/ERLyQqWhKCHV
         HV9sAJQX6BLcJnXcqH9qrmPLdbmChYsrXUNlPalBe9S18F556lyJY/ydflReQrNrtk1A
         W3axWXi56lbL+wQtT/BhwMAJBpVuwkmAw9kl2B6sXZSJyrlGEnrg1Yov4+O4YXYPxHEA
         XEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678456882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E1H01G5yHTefNIXDYDwx8BnHam3cp9im/vl/s0zSJg=;
        b=U66wmsG9cGXH0/XfQoIetLElli0NlBizDISEG98A8AzippJx+1lfdjlKysJ3BmZ83B
         R83t3xm70tO1GejGzlSq3n+Zmm6ClLoMFHeu+WTw3gF8Am7fkG3phsAaTL1QleRqE9JB
         vQ5DOc1pQ58kiGypXRx5ea/euqCmujRuZ4+IhZy5D9P0oJxqyN5ofNsvtp+hYpt/kj1Y
         85Xjf5hR+w8Dp+DTpTRNX60PbJH8O7ZiNoXRoMc4okK5Lx37xsZ6Bx6koXxwNXFN/0Nw
         Q61haqj1AjerxJiBPiiElBsOvOmQBuOf6E5pIrBmDLTFri7BPmNZUkebjpXVgY6U/jMY
         eRbw==
X-Gm-Message-State: AO0yUKXWYpWuMbuxckQhJDsZz6oAg5s1Z4lJNp6h5xemW/ePiLgUX6E2
        YsiY+VuNLkug/8csAubJKRoQgMiYbe1gzg==
X-Google-Smtp-Source: AK7set979+teWvE1FEu6RfhEUebp9t15CkaDEwF0V5DUouuImINlNm7Z+d+ZXPcWXwFfFUIbSmJjBw==
X-Received: by 2002:a17:902:e74d:b0:19a:a520:b1fc with SMTP id p13-20020a170902e74d00b0019aa520b1fcmr2087123plf.14.1678456882061;
        Fri, 10 Mar 2023 06:01:22 -0800 (PST)
Received: from ubuntu ([117.245.164.94])
        by smtp.gmail.com with ESMTPSA id km13-20020a17090327cd00b00194c2f78581sm47239plb.199.2023.03.10.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:01:21 -0800 (PST)
Date:   Fri, 10 Mar 2023 06:01:19 -0800
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        outreachy@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: drivers: ni_pcimio: Remove the code enclosed by #if
 0 and its #endif
Message-ID: <20230310140119.GA12544@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by checkpatch.pl:

WARNING: Consider removing the code enclosd by this #if 0 and its #endif
at line 482, 501, 570.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/comedi/drivers/ni_pcimio.c | 48 ------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/comedi/drivers/ni_pcimio.c b/drivers/comedi/drivers/ni_pcimio.c
index 0b055321023d..1603095f2ed9 100644
--- a/drivers/comedi/drivers/ni_pcimio.c
+++ b/drivers/comedi/drivers/ni_pcimio.c
@@ -479,43 +479,6 @@ static const struct ni_board_struct ni_boards[] = {
 		.ao_speed	= 250,
 		.caldac		= { ad8804, ad8804 },
 	},
-#if 0
-	/* The 6115 boards probably need their own driver */
-	[BOARD_PCI6115] = {	/* .device_id = 0x2ed0, */
-		.name		= "pci-6115",
-		.n_adchan	= 4,
-		.ai_maxdata	= 0x0fff,
-		.ai_fifo_depth	= 8192,
-		.gainlkup	= ai_gain_611x,
-		.ai_speed	= 100,
-		.n_aochan	= 2,
-		.ao_maxdata	= 0xffff,
-		.ao_671x	= 1,
-		.ao_fifo_depth	= 2048,
-		.ao_speed	= 250,
-		.reg_611x	= 1,
-		/* XXX */
-		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
-	},
-#endif
-#if 0
-	[BOARD_PXI6115] = {	/* .device_id = ????, */
-		.name		= "pxi-6115",
-		.n_adchan	= 4,
-		.ai_maxdata	= 0x0fff,
-		.ai_fifo_depth	= 8192,
-		.gainlkup	= ai_gain_611x,
-		.ai_speed	= 100,
-		.n_aochan	= 2,
-		.ao_maxdata	= 0xffff,
-		.ao_671x	= 1,
-		.ao_fifo_depth	= 2048,
-		.ao_speed	= 250,
-		.reg_611x	= 1,
-		/* XXX */
-		.caldac		= { ad8804_debug, ad8804_debug, ad8804_debug },
-	},
-#endif
 	[BOARD_PCI6711] = {
 		.name = "pci-6711",
 		.n_aochan	= 4,
@@ -567,17 +530,6 @@ static const struct ni_board_struct ni_boards[] = {
 		.reg_type	= ni_reg_6711,
 		.caldac		= { ad8804_debug },
 	},
-#if 0
-	[BOARD_PXI6731] = {	/* .device_id = ????, */
-		.name		= "pxi-6731",
-		.n_aochan	= 4,
-		.ao_maxdata	= 0xffff,
-		.ao_fifo_depth	= 8192,
-		.ao_range_table	= &range_bipolar10,
-		.reg_type	= ni_reg_6711,
-		.caldac		= { ad8804_debug },
-	},
-#endif
 	[BOARD_PCI6733] = {
 		.name		= "pci-6733",
 		.n_aochan	= 8,
-- 
2.25.1

