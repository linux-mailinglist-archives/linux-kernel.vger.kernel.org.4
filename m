Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767EE5EE840
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiI1VXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1VXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:23:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EC1C901;
        Wed, 28 Sep 2022 14:23:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r6so4383914wru.8;
        Wed, 28 Sep 2022 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RKJihZXInDwBxEomtKl6Az8M+oPUit8VIlFYZspfnao=;
        b=qMNAPWI5Rty507mELvN/sikxmJQpM0MJemSYkRTGaiKkpUCgex86BEQaKtftHjss0v
         OmKQ6QYxGXXnehx5UmyPQXgD6vrM/up15PQ2liHul2gTCYom+FxXN0s1lf0euaqtnOi3
         cs3jPy9VwaYhqAiLbhPoxYAHZxOZUXMvAz0iE81XSZGe7HA2JM6SJEvZ9rZ7dmRqmYdd
         vrdVWVLrRQHMwtCS5ckos2GOqczowFdDbT8JBkh4mZy0zqVCbpNxpBpujPTDc7JSQ5mG
         19fwVtXb/eyPnrOf27hhF3XxBGbT2zeMgeso135GxGeaZ1CupzwlR8osKgUVIRXpVKNW
         51+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RKJihZXInDwBxEomtKl6Az8M+oPUit8VIlFYZspfnao=;
        b=j3o85ZAtg2vqglbTCOY9JrTsQajwHIi4qHmciSe//tIbU1lVwr6T7je5HliO9/gDsZ
         U+/gy19gmeTgq0eUI7UejR0/yncUasNrRdZ0u1ql3dpMwYy5pRmHEbQvIoF57qAp7C3A
         NLf1qtPenEGjZQCza5BNTU3U57o6tt/hFZA+QxKUXKniJXcMBdZofzsiy7OXGq+JYuCp
         ZYvBw/hAeCYPlMSszqRWyRLxDbCK8QT9HfWy5Qf1xwfYhXsg1+Y30bZRv6+qFUY6Hto0
         8pkC8+xyVy6qyI6w2+jKjgw6rAtd0WTts/bBL23qeDg84VWCWr6eRr4+0biV32JLSdSp
         sx4Q==
X-Gm-Message-State: ACrzQf1B7VdtpjsdqH3Ma7K/VPS5e/jioIEamFM7fYtD8+aiOTVw0qdB
        K4RELqq8Iy9Vqdxzft83VKA=
X-Google-Smtp-Source: AMsMyM4am5AztlrVRNurOLHerFO6XghKTW/DVdXKUKv1/aNV/R27JmHCjF03lBOV2jDvnAe8LolZ1w==
X-Received: by 2002:a5d:5f0a:0:b0:228:dff9:5f7e with SMTP id cl10-20020a5d5f0a000000b00228dff95f7emr20989786wrb.601.1664400178874;
        Wed, 28 Sep 2022 14:22:58 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003b27f644488sm2983684wmq.29.2022.09.28.14.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:22:58 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: pcc: Fix spelling mistake "Plaform" -> "Platform"
Date:   Wed, 28 Sep 2022 22:22:57 +0100
Message-Id: <20220928212257.63197-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ebfa33a40fce..3c2bc0ca454c 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -676,7 +676,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 		if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
 		    !pcc_mbox_ctrl->txdone_irq) {
-			pr_err("Plaform Interrupt flag must be set to 1");
+			pr_err("Platform Interrupt flag must be set to 1");
 			rc = -EINVAL;
 			goto err;
 		}
-- 
2.37.1

