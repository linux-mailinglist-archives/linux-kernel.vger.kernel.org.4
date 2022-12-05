Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE841642597
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLEJS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiLEJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:18:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2060120AE;
        Mon,  5 Dec 2022 01:18:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so17597456wrb.4;
        Mon, 05 Dec 2022 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sumSJif1KcV0FaN006UmFPaN/kz70g4clkF7zQg7tWQ=;
        b=V1AZLh9TcBMFoO9PVFvolh5beBynJUBr8pz9yxx1AVuoc0W/xkj+Nv0ZDG4g7BRZs+
         W8SNE3Gx/cK32LpZ3pJE7QchHqPVuxMOEFhD6J+xIGyD2lAjUailabRt/SFtNdUVdTfo
         L7H2+Ej4YVBqT5oRjxSwk7Gt6LrGB7CcyVNkbRrX9LcFBrg3Vn4VcU8JIKLB6GHzQR+N
         bp7A6lo0IiV4EUakrsyMhBNr6pocDjF4pmkdowKgXISCQSADvjKVYRfr9IlDIaX1T4pX
         kS7S1b2FgWV4di0mB6uqsFF6tRvvViAvuT1cSRXnrZyQXP/Z6EX5eH5isnqByeZ0nGiF
         xpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sumSJif1KcV0FaN006UmFPaN/kz70g4clkF7zQg7tWQ=;
        b=08UgOD+5Oa2SmdECh0CPbOcA+PniQc3eEM1rj7tfjKifmvR6jrhFbMC807MYhERF1D
         4i6NuyGEIIJxr7E+KIROmJm7jMoMQFJlGnuT5xEmjcuJkJ6EDaEDLuLc6b4mBjie6z8N
         RACn4aYA1uv+ltx+dr1yUMtOYxWeajX/yMvKTTayqL9Im+/GyVJSFd/ro8pIJVaAOoVL
         C2jqDpc4sL4NsuSSzCIEmJBUI32jS0DKFQ583DWlCefL1ePoI6PQVLUOWdY2tBcwqHBX
         XO7ehoME5aJGpcDviFcLqVc4lWlPA5bBnQaVxQbUK1ioFdh/++LLiKKtquc/Zls9Y0bs
         spsg==
X-Gm-Message-State: ANoB5pl6TljwZSCF/yVcHWzLSKtIsaWMF62kdpXu7T7e0/M/VGn4iH9s
        dVqsTu4cd+Zl/ifs2HsZsISlLCpeLpcSxw==
X-Google-Smtp-Source: AA0mqf6++JdyACBdUlXgN4/VDFM66EOmbwsu8lhVh9/BL4h5oEROpg95H6sFr4V9OYcfzkStrL/vrA==
X-Received: by 2002:a05:6000:501:b0:22c:d27d:12e4 with SMTP id a1-20020a056000050100b0022cd27d12e4mr48387454wrf.546.1670231901337;
        Mon, 05 Dec 2022 01:18:21 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003cff309807esm22571931wmq.23.2022.12.05.01.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:18:20 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/region: Fix spelling mistake "memergion" -> "memregion"
Date:   Mon,  5 Dec 2022 09:18:19 +0000
Message-Id: <20221205091819.1943564-1-colin.i.king@gmail.com>
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
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f75df35b9d3d..c56ddfed3393 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1969,7 +1969,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
 			dev_warn(
 				&cxlr->dev,
-				"Bypassing cpu_cache_invalidate_memergion() for testing!\n");
+				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 			return 0;
 		} else {
-- 
2.38.1

