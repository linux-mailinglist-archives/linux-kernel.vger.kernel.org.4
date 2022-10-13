Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964825FE546
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJMWcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJMWcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:32:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214A18D822;
        Thu, 13 Oct 2022 15:32:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so4244937wmr.2;
        Thu, 13 Oct 2022 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmLu5/VoD+O0UJu6VoLDdnrtTxKovAe8n1SjzXtC2Xs=;
        b=b7DBr9u1eaqWEAbv5Qbg/QNyboll+gHJXOnlDd/6Sb8TT8U/oXq177K6ef9HL9aVG5
         BHgyrWvnsWEi8CyoZp/n26mA4xSHw+GJEPPTlRnMC4tSuGw9fbTn78ZiOaAr1abfApHR
         zHaGplBXSq2rjsdJ9dCMEhdVT70dXV+6peKRPS8dConrKaRvWemUfWGUOHFwFN+wZ4jx
         6T9Nhf871eCwS5xD//AJxcL8R5yb5bWGtVu30oShYxJPVdiqzd8EsKWRN9tKMnMLDZ42
         IGelHqUbnJA2+bK7zHhRlAew2xZDRAZWc4VvwGyDNJOEhY4ujRO7Ss2SHwdbk0DAXpiU
         Z1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmLu5/VoD+O0UJu6VoLDdnrtTxKovAe8n1SjzXtC2Xs=;
        b=6lmN9MGuEaxxm2hkpM86AQ5fI4OzCWiXEs9/QVyll9fenxkQOSEBDJslzB/bMdAQzR
         Ed0D/H7jaE7avSAi0wxRjLxGcFQ99i4mWnplUW8X6InSQycX/pgoJ1LfkvblRlSX26YS
         tfXBIRaqFZ0hPqceIvWOSaIC1LBvubWr+z70f03icdtEpT+Rydq/iKCVbW4DGAxg9Gi7
         7mSHEa9UPPWx9k0YiNDAjyqDk5GvOIG/gWNzfKzMdrBWyGIJAXzRqsW3+rP4OTcVTKBQ
         ean+axS0InISjBod1eJw4t/N+GFDrL6fkpF/PvYtx3Ff8eWBxlSDen6p8jyIISil4TMF
         b0Qw==
X-Gm-Message-State: ACrzQf3eORQdt0W0lw3MCFZW/8rmkgS78DnmL1OtAWErYrvJhpU4qp7x
        2NE8K8F5Vn9auDr6JUU1m1Y=
X-Google-Smtp-Source: AMsMyM77thVePWoPhfex4il6b5GCYPnvQuwIdmlHmgZi42gv3PuduqSo5xmO3eAT9zGfb65CVQdWVg==
X-Received: by 2002:a05:600c:19ce:b0:3b9:c36f:f9e2 with SMTP id u14-20020a05600c19ce00b003b9c36ff9e2mr1394145wmq.110.1665700348341;
        Thu, 13 Oct 2022 15:32:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d6e5c000000b0022cd27bc8c1sm726789wrz.9.2022.10.13.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:32:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: Fix spelling mistake "mis-match" -> "mismatch"
Date:   Thu, 13 Oct 2022 23:32:27 +0100
Message-Id: <20221013223227.129440-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few spelling mistakes in dev_err messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c          | 4 ++--
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index c72d0e344671..90f25cc22227 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -3288,7 +3288,7 @@ int atomisp_css_cp_dvs2_coefs(struct atomisp_sub_device *asd,
 	if (!IS_ISP2401) {
 		if (sizeof(*cur) != sizeof(coefs->grid) ||
 		    memcmp(&coefs->grid, cur, sizeof(coefs->grid))) {
-			dev_err(asd->isp->dev, "dvs grid mis-match!\n");
+			dev_err(asd->isp->dev, "dvs grid mismatch!\n");
 			/* If the grid info in the argument differs from the current
 			grid info, we tell the caller to reset the grid size and
 			try again. */
@@ -3344,7 +3344,7 @@ int atomisp_css_cp_dvs2_coefs(struct atomisp_sub_device *asd,
 
 		if (sizeof(*cur) != sizeof(dvs2_coefs.grid) ||
 		    memcmp(&dvs2_coefs.grid, cur, sizeof(dvs2_coefs.grid))) {
-			dev_err(asd->isp->dev, "dvs grid mis-match!\n");
+			dev_err(asd->isp->dev, "dvs grid mismatch!\n");
 			/* If the grid info in the argument differs from the current
 			grid info, we tell the caller to reset the grid size and
 			try again. */
diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index fdc05548d972..b36cbde7036a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -3180,7 +3180,7 @@ static int atomisp_compare_dvs_grid(struct atomisp_sub_device *asd,
 	}
 
 	if (sizeof(*cur) != sizeof(*atomgrid)) {
-		dev_err(asd->isp->dev, "dvs grid mis-match!\n");
+		dev_err(asd->isp->dev, "dvs grid mismatch!\n");
 		return -EINVAL;
 	}
 
-- 
2.37.3

