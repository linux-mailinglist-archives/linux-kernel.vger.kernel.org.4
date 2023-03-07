Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9DF6AE64A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCGQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCGQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299D2A989;
        Tue,  7 Mar 2023 08:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7709EB8196F;
        Tue,  7 Mar 2023 16:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD2C433EF;
        Tue,  7 Mar 2023 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206051;
        bh=Xe7gneFS+z8pJedFvsMRTePDLYZ/SalTvqSIYvsJA4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txX7GDJ6gMORqofygT6sYC8aNJfPQQVhACdjT60OUA1H8yjN97UACcqGmpwVfPIew
         yRie355zeNNYU4l56QI3C3rKUCZSXOKBZ3nWAb2RvbOs/hSoMv15zf8TosQ0yNsQQK
         XPYgp5sK2J07t5PPtfsJN1D4E3uP/kAujy4D+zxdo7Qd3JQ0sNZYRBCsDNS3y5u2If
         3EzpQzsLjK3K8OIg/jqDMUDTUn3OuwcoepBuJUCqpNo2M+F6kyIuv2od2znSljcGOA
         hiS+NkFibWpN9ttgmwq2VUJp1ffWNAqfY6EWGMIMqEWglQ3kkII2YQf4DyWWlb8nAT
         LZlGCK8PkrZQQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 4/6] crypto: hisilicon/qm - remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 10:19:45 -0600
Message-Id: <20230307161947.857491-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307161947.857491-1-helgaas@kernel.org>
References: <20230307161947.857491-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Weili Qian <qianweili@huawei.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/crypto/hisilicon/qm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index e4c84433a88a..8b563ab47484 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <asm/page.h>
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/bitmap.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
-- 
2.25.1

