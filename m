Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4286AE64C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCGQWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjCGQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:21:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A330EBD;
        Tue,  7 Mar 2023 08:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7FB4B818F9;
        Tue,  7 Mar 2023 16:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F98C4339B;
        Tue,  7 Mar 2023 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206057;
        bh=wSv+wBvOxdbOX2CPseOOw50wCkRjkn87L3Cxx0Ykn7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsU7lagfmlFEbM5twUj624Gk1dHOUiGxus0K5XpvpJgIS+nVyqcZcoUBNDhV+FAKY
         zGRxdcBA+4MEHalFS+f9puYeyCVs8tNbk5NMOr2Q+RyixN512t7wEj5jqsNG5r2JIS
         kmpvSQ5I8+kzX3ueYQPIrahldymCx3RgNMQUaQmAwQcOCHdaT7sT+Fniggj9gbX0gZ
         nrLsMuHAiquJlrdsRNIPucdKZj9V7YlJ6C2LxNOh5uWVkzb+suVBHlg3dhVE7zKtWt
         NQePPBK33T81WwIqd0KpAoiN88Wd/+oR1R0DwrxzONHcOa0y/oatmysKQdslHihNr0
         hkUGCUASQs88A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH 6/6] crypto: hisilicon/zip - remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 10:19:47 -0600
Message-Id: <20230307161947.857491-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307161947.857491-1-helgaas@kernel.org>
References: <20230307161947.857491-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yang Shen <shenyang39@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Nick Terrell <terrelln@fb.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 1549bec3aea5..f3ce34198775 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/init.h>
-- 
2.25.1

