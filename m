Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED086AE643
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCGQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCGQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBC92261;
        Tue,  7 Mar 2023 08:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99EDB614A0;
        Tue,  7 Mar 2023 16:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C5CC4339B;
        Tue,  7 Mar 2023 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206040;
        bh=dbyjoIVdZ4lBnTgQnn+nqKdpjYFtjMzQny5eKIQrvxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gl7v1xToC0Fj2VOhdrTtFXJm+3RndbJwJe1QiLn4pRlQvztRKlcUabxrkXwXOyOEx
         3dpzZA5qjcRVuN4HGF0RhO7p68uR41JEf5wjb4UZCy+lOo1iOGrLBZAkn5EQQrsbq0
         /vKkwUlwYap1A2rBi+3OpLRmHJWZth1DiCgHo3IOZm7WzYe0dsY9VJ0WwVNlYohIZH
         /WPM5TBTo9FGhi3aNO92dLN5c3QrMIhU05sY9LJXU2lmoa04EdD5J51MJNe3hMKRP2
         UZPu2YVaPIbi4r8V8Cr64dVHlDlW/fBnAB7IwG/5maTsn/AW8oB5R+XMX674ENM28g
         WhD1akfPc72iQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/6] crypto: cavium/nitrox - remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 10:19:43 -0600
Message-Id: <20230307161947.857491-3-helgaas@kernel.org>
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
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 432a61aca0c5..65114f766e7d 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/list.h>
-- 
2.25.1

