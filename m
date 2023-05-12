Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E577700FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbjELU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbjELU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:26:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B3B11572
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:25:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so7519943a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923080; x=1686515080;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL0Y7AcgIKWYgo3/+uocMBWRsQApCNigbVY517heGnU=;
        b=pQ1KCGwuoha6xq4gYQ4EL9rVYk9oxIQJaOktGLlY09APJIiwftPq7eIGybyc+qGYCW
         TgGLWLKFKVgjVsN17CJ2YLxAitqQBFmCL1dli5vSGjrcaItuYd8apSA/XFyDb8tn9vZZ
         p5VzapVPjKJw7pYdtK1ktLM6dgrFCY/I2LSQH5WGsJW1TO+6J/GzugFdaa8x6tHk9Xdj
         f5RRmiQF63sI8LPVW31BQKkHL8MJ0oGD+z/aOluHQV9pdO6SqhWQ67c+qtWEUxvX/sip
         kF7X616jE60PJKdoTU6oEaHZz5qgIYDit8g0liz0lfZaVqJjdZr/iALXeyIZk9n883uj
         VFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923080; x=1686515080;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL0Y7AcgIKWYgo3/+uocMBWRsQApCNigbVY517heGnU=;
        b=dG4LchACOVKUwfNXsuAIg5syhjNkBq2ywcZrzpTaV15idc2SRgKmaMMNHrw+H19wTG
         TEu2Mb6IORNRJ/pz2MPp2w+kgi9XSME0/jpCAr3mGY4e07gbjOCEbQMTRZt2lNA6+1xI
         BBQBZ5CZ+Wf64cdig0ZZ9A7UtFSEvPfpPbexlu1WXDmREK2W2TCqlZ7E8etYKXHtAwUx
         l6WTYCRDwdA0Hz9xrh4Cma9UkK1TPBzONPfLdrj6/lr7LvF6dJ6ESv4q4xIuTvBRbIQT
         oqcEK8PXTDedF2Lh0hJRr+LJUQBJenfRkMfpGyrJY6mslKXFBipP9h77ksfD5wS+4hhB
         OsPg==
X-Gm-Message-State: AC+VfDylpsCFPuMNh8p8EGM1tHf/gY9LNJRcqK/Z+XA+2tp97iVazmEb
        jNw20YflmGt7TM3A0ngdeVc=
X-Google-Smtp-Source: ACHHUZ7n0bNapAnUsn0KFnkeYXXyTUpNckwUxqzD90EgZH8oOuXSKkzz/hLUI/SvI8PlBHFRArhkjw==
X-Received: by 2002:a17:90a:fa91:b0:246:634d:a89c with SMTP id cu17-20020a17090afa9100b00246634da89cmr25214437pjb.41.1683923080114;
        Fri, 12 May 2023 13:24:40 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5d8c:29b4:3ace:81ca:10f])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a9f0c00b0024e05b7ba8bsm21081816pjp.25.2023.05.12.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:24:39 -0700 (PDT)
Date:   Sat, 13 May 2023 01:54:34 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: hw: amd: Fix debugfs_create_dir error checking
Message-ID: <ZF6ggnry8BVjQyYE@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04550b1f984c..05bdee1c78e6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -941,7 +941,7 @@ static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (!ndev->debugfs_dir)
+		if (IS_ERR(ndev->debugfs_dir))
 			ndev->debugfs_info = NULL;
 		else
 			ndev->debugfs_info =
-- 
2.34.1

