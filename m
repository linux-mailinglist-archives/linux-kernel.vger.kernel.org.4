Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8F6425A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLEJVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiLEJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:20:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7E12763;
        Mon,  5 Dec 2022 01:20:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v7so8250151wmn.0;
        Mon, 05 Dec 2022 01:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nfqa1/DcZe0r0B/XaN6wGfaWPmJF2FQC9eWV8YducM0=;
        b=NcRefKO5GW2oc76+9SIi4DsNdkaAj2EDR7CgEibSGrRq2RjwAzFj2+bU2GBeo1NqkJ
         IBIuR1cSVd8mQoJVr0norXvfLhhBFizG0sUJZGF1VSUr3FxXx3wcJGN9mE7Kv42Uq7Rx
         ggejGZcAOaRWiqv3pt8qMG4p5G/1mWUuS7DGFNeA1I3kdJL8ToUy2TyXEddolA/iuyPC
         gbkwPK2GqpQ3MdRVUHdaZoeIQ8a6QuhLKzwoUz7dh8Qxe3OaEOdxrLqGOfOqIEJBimPz
         wfHtaVchIcpisbK0L8P0jzoikQMyrjZTYfou0O9yZvH2QtH9jb16ReY75JjcnvEAzaIQ
         grsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfqa1/DcZe0r0B/XaN6wGfaWPmJF2FQC9eWV8YducM0=;
        b=Q7dtvJ0BYFXRwbn5B3ZTpA1yqKHiahlYLSDewarBH+j0SvaYbZJRfZq79xGWrUqoc1
         f3AgAZ3wJg+tBjJdMIkCLUH6YGmb2ZPix/fPvd9hBIB6pm9Pw6cvIAIRk95EdA6ySrOY
         T0D6ArUroJga1KNlAVySi6xeoUTGKtQdG17gXOznNgiOLsrL4tSSUrsfS5jaa/YUtr0/
         yZxqzD2v4m+OZXwUOZJ6qlYi3sAQocsO72fWPJD0ICfyH4we1RhurClUmdZnRHiXaCUT
         7q+E/k4a+/1bfN1ER7NlGKH/4x6ZNINuhOMq7y/S1NikOuAdgPf/3ZPf9xtuDhi4r/rl
         ucVQ==
X-Gm-Message-State: ANoB5pm05/+q+fWNwUAAOTvLXNaIEyhifZTR3TFM4P0PrqCgf1MDKi8D
        g14laeH/TSf1usxJe6BxmNZfZLRoOo8w5Q==
X-Google-Smtp-Source: AA0mqf46joosKsrX7Xpeewt/KqZGUwqtd/jDSD8o4ItpKe7tKVyvz+U0nM1UYkbuk7wHDafiO9HL5w==
X-Received: by 2002:a7b:cd88:0:b0:3d0:87d5:9e6a with SMTP id y8-20020a7bcd88000000b003d087d59e6amr8944600wmj.56.1670232034802;
        Mon, 05 Dec 2022 01:20:34 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4402000000b00226dba960b4sm13531854wrq.3.2022.12.05.01.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:20:34 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvdimm/region: Fix spelling mistake "memergion" -> "memregion"
Date:   Mon,  5 Dec 2022 09:20:33 +0000
Message-Id: <20221205092033.1943769-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
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

There is a spelling mistake in a dev_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvdimm/region_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 83dbf398ea84..8f5274b04348 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -80,7 +80,7 @@ static int nd_region_invalidate_memregion(struct nd_region *nd_region)
 		if (IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST)) {
 			dev_warn(
 				&nd_region->dev,
-				"Bypassing cpu_cache_invalidate_memergion() for testing!\n");
+				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			goto out;
 		} else {
 			dev_err(&nd_region->dev,
-- 
2.38.1

