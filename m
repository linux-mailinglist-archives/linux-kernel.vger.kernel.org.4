Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94C06AE648
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCGQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjCGQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3672AB;
        Tue,  7 Mar 2023 08:20:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63CABB81923;
        Tue,  7 Mar 2023 16:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0361C433D2;
        Tue,  7 Mar 2023 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206047;
        bh=Cp7E5FSLSZaUL/SqnknK8EgC65D/bG7PCojUaf5EAwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1Ux36CkdamqSgEkEqA/S38wrla2CNtuSPgUAda1NvSHF/OR3zDvSjfgjURLc9C7w
         S8dS5rdJ4puGUDRTQmm519yOuyhzuNhKF6PI/zHdGneZjG3hEppxYEv+kSP/ehaHfw
         LL45Rhk8MEjf8MkFji/OQExyUvdTov8+TkwC418CCjZnxL7Bx+7mfqPOqNQm8ZUNPq
         xlrfYpwrgBbNdeO+F1azghIOEma1yywwahWkViMzEnKiTPhakogL2DQEHkUSk7wDpR
         nhFUDxf+po250W1azmdRpft31tM0lEWunothnlASkUh8fhplkg7hEn25rFiD2+xys1
         K5PF5OHVF8UEA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Longfang Liu <liulongfang@huawei.com>
Subject: [PATCH 3/6] crypto: hisilicon/hpre - remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 10:19:44 -0600
Message-Id: <20230307161947.857491-4-helgaas@kernel.org>
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
Cc: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 923f9c279265..5d0adfb54a34 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018-2019 HiSilicon Limited. */
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/init.h>
-- 
2.25.1

