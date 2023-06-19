Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1AE7351AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFSKMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFSKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:12:35 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37FE412F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:12:31 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 19 Jun 2023 19:12:29 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.125 with ESMTP; 19 Jun 2023 19:12:29 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     elver@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gunho.lee@lge.com,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] kasan: fix mention for KASAN_HW_TAGS
Date:   Mon, 19 Jun 2023 19:12:24 +0900
Message-Id: <20230619101224.22978-1-chanho.min@lge.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes description of the KASAN_HW_TAGS's memory consumption.
KASAN_HW_TAGS does not set 1/32nd shadow memory.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 lib/Kconfig.kasan | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index fdca89c05745..5be1740234b9 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -124,8 +124,6 @@ config KASAN_HW_TAGS
 	  Supported only on arm64 CPUs starting from ARMv8.5 and relies on
 	  Memory Tagging Extension and Top Byte Ignore.
 
-	  Consumes about 1/32nd of available memory.
-
 	  May potentially introduce problems related to pointer casting and
 	  comparison, as it embeds a tag into the top byte of each pointer.
 
-- 
2.17.1

