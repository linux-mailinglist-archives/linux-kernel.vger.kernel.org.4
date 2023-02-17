Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10B69A5FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBQHRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBQHRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:17:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537D4DE36
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:17:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f19so212149wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6BNOSoO+eqzIrGc5YjcQrtOV/AtVG7dChYQ+0FvYWU=;
        b=TrSAhZBPF86tNyg/885rPM42yd/1yTX/JCj8950pBROvXCcaEyVL1xvhIBRz5/3qmm
         C8sZoImPpifyoRDYb+gZ3fp87svz49OLgqYFt25pR5g5CT+mFpvLDSybvvmu2oIWvyUY
         o2BTAJfGud/HEVMPRxPcTB/01L9vGE2Fxm58bx8Hr5WPxN80hWFKkOZvU6M85BAlu2k+
         v54XbPoby3bbk+ZZbIB+5NVjSQlKwcOcwPabqFpA8wt57iyrMEdM1PO8MP+U+dfXYR9a
         lvbZTwkIXZdtLmymJuf1b2GurWLk9M3BStpTIlV+J+jAOf0h8SLzVYjQYENHMPc5ILOi
         58Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6BNOSoO+eqzIrGc5YjcQrtOV/AtVG7dChYQ+0FvYWU=;
        b=NxlnRix0POlOzF1uHInFQ/aXEx0FDEqTUmLUJvYfeq2TQilBRCo4a4GY+AgAC12CV0
         BVh5dWfM+KhsiI6QkJhIqWbewF83rIRC3qNHXNdbTFXqNZWLNnKXyFeblPEk0XwxS4qM
         KQ705UcklbGSgJlu7l/8t8Mr9uIQt7aLHTmYUpD4raqLiAT5VpL+JKk3ckmIGB4xl3hP
         lnRxkciBzaC2WhqBtjLHGzNfIbnv58L387cwsGZNFZdQrB+u8BTuhdFa98witBqW/yL2
         OKIfV6dJN/ihRmB2nYpr5ERdNBk6XbGtd/wVKJ0Mg1sMgNYaTuvrj9tZJ+pA1yd7Lnnd
         bhfQ==
X-Gm-Message-State: AO0yUKWqWppZvyLnhGsONodM68QM6SCquFBs6BAv0VEfI6G8fw/QZGJI
        bOee0cuWc9R/z623Bz4N4ksQRaqllp5bQSv8
X-Google-Smtp-Source: AK7set9ly1Ia+mXD/0+G0LftnFvvo5kcUZsWLkRQalwdQCTyCbPKucIXNoAJZ04MFCdv+PLnHFVYGA==
X-Received: by 2002:a05:600c:818:b0:3e1:97d:6134 with SMTP id k24-20020a05600c081800b003e1097d6134mr7476102wmp.37.1676618223659;
        Thu, 16 Feb 2023 23:17:03 -0800 (PST)
Received: from khadija-virtual-machine ([206.84.147.59])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d518b000000b002c55551e6e9sm3367053wrv.108.2023.02.16.23.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 23:17:03 -0800 (PST)
Date:   Fri, 17 Feb 2023 07:17:00 +0000
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org
Subject: [PATCH] Staging: r8188eu: Fixed block comment
Message-ID: <Y+8p7Hyaf4LhO/Sw@khadija-virtual-machine>
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

Fixed block comment by adding '*' in each line. The Check message was
shown by using checkpatch.pl script.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index a7c67014dde0..03025dc89533 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -36,15 +36,16 @@
 #define WAIT_TIME_PPPOE	5	/*  waiting time for pppoe server in sec */
 
 /*-----------------------------------------------------------------
-  How database records network address:
-	   0    1    2    3    4    5    6    7    8    9   10
-	|----|----|----|----|----|----|----|----|----|----|----|
-  IPv4  |type|                             |      IP addr      |
-  IPX   |type|      Net addr     |          Node addr          |
-  IPX   |type|      Net addr     |Sckt addr|
-  Apple |type| Network |node|
-  PPPoE |type|   SID   |           AC MAC            |
------------------------------------------------------------------*/
+ * How database records network address:
+ *	    0    1    2    3    4    5    6    7    8    9   10
+ *	 |----|----|----|----|----|----|----|----|----|----|----|
+ * IPv4  |type|                             |      IP addr      |
+ * IPX   |type|      Net addr     |          Node addr          |
+ * IPX   |type|      Net addr     |Sckt addr|
+ * Apple |type| Network |node|
+ * PPPoE |type|   SID   |           AC MAC            |
+ * ----------------------------------------------------------------
+ */
 
 /* Find a tag in pppoe frame and return the pointer */
 static unsigned char *__nat25_find_pppoe_tag(struct pppoe_hdr *ph, unsigned short type)
-- 
2.34.1

