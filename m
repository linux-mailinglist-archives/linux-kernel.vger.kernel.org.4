Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49436691B06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjBJJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjBJJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:13:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBE56EFC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:13:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB3FA61D19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB86C433EF;
        Fri, 10 Feb 2023 09:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676020402;
        bh=JzF5GrQUtb7ZIi35569kv92yKITXiEuDQ6xZFrBj/Z4=;
        h=From:To:Cc:Subject:Date:From;
        b=NtVlNXeUNOFNZsH74BszMlfcVvtiYY22SF6cOaND7LCbK5DKiufEkbFZa1QnuP9MH
         3OgBXCBa8MygrE+6zdialxx8Mto5it87n9GIvaMVQNLOstZsMQnhglns0ZVuW+pRm6
         h+5RxSxklBU6N7iJaJNyZWAVciD4OM1ZxMj0BZFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: update my copyright notice
Date:   Fri, 10 Feb 2023 10:13:18 +0100
Message-Id: <20230210091318.733561-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=788; i=gregkh@linuxfoundation.org; h=from:subject; bh=JzF5GrQUtb7ZIi35569kv92yKITXiEuDQ6xZFrBj/Z4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnPuNZ0MXGZSj4QrIv1F5PzdtZVtHr74sUeXqHtpQxvGddx hvd1xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwER+nGKYp1STnOz+bmUVW+N/sbWqi9 eoVlmUMsx3TbFxld7ZkW+ZsmaBSf+pGRuYby4AAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's been some work done recently to the drivers/base/bus.c file so
update the copyright notice in it to make those who track those types of
things have an easier job.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 301b9c6ece86..4ec6cfb5893c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2002-3 Open Source Development Labs
  * Copyright (c) 2007 Greg Kroah-Hartman <gregkh@suse.de>
  * Copyright (c) 2007 Novell Inc.
+ * Copyright (c) 2023 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  */
 
 #include <linux/async.h>
-- 
2.39.1

