Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621517476E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGDQjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGDQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:39:30 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506CBE7A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:39:26 -0700 (PDT)
Received: from i53875a33.versanet.de ([83.135.90.51] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qGj3k-0005wg-L7; Tue, 04 Jul 2023 18:39:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] mailmap: add entries for Heiko Stuebner
Date:   Tue,  4 Jul 2023 18:39:19 +0200
Message-Id: <20230704163919.1136784-3-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704163919.1136784-1-heiko@sntech.de>
References: <20230704163919.1136784-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

I am going to lose my vrull.eu address at the end of july, and while adding
it to mailmap I also realised that there are more old addresses from
me dangling, so update .mailmap for all of them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5788fe4371c1..36a9673d89b6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -178,6 +178,9 @@ Gustavo Padovan <padovan@profusion.mobi>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
 Heiko Carstens <hca@linux.ibm.com> <h.carstens@de.ibm.com>
 Heiko Carstens <hca@linux.ibm.com> <heiko.carstens@de.ibm.com>
+Heiko Stuebner <heiko@sntech.de> <heiko.stuebner@bqreaders.com>
+Heiko Stuebner <heiko@sntech.de> <heiko.stuebner@theobroma-systems.com>
+Heiko Stuebner <heiko@sntech.de> <heiko.stuebner@vrull.eu>
 Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
-- 
2.39.2

