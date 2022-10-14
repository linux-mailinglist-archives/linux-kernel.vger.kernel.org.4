Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E45FE62B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJNATh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJNATb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C591960BD;
        Thu, 13 Oct 2022 17:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DE89B8217C;
        Fri, 14 Oct 2022 00:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B8C433C1;
        Fri, 14 Oct 2022 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665706767;
        bh=UtqJe2yzr571hejGyzSnhfiu4QkOMjFvnI+iTOa/KcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE3Uc/CNWtRXjep3lCJtcXGzigxmiRm+vLpo+aJ5ZGQYg7E5EZoLj++x44PyUYQMP
         sS4nPKWm1G/lWydOA1j7tDWbLmRyBd9jpocLXHdA+PTUmex/u4wozh631ulG63PtNC
         zneflDJxF/Od95td0gQjsGqj/OwqUw49M9xDvDgorbMhzfZ0DH2WsWvHTUZA0zAq3J
         olRVZPWeYeX78GEIdT5LeaJwTxWTQrsulAZxsKAiR1qOwBFNbj66Ppcyv+FxPodLW8
         zAa7WI8dRcNjF5o2kEG9/MikbVSN1vIFE9c2QwZuDAibVla3+o/dJ0JBk+agnBIlqd
         9Y7oL/Mqe666Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-ia64@vger.kernel.org
Subject: [PATCH 2/3] ia64: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
Date:   Thu, 13 Oct 2022 19:19:10 -0500
Message-Id: <20221014001911.3342485-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014001911.3342485-1-helgaas@kernel.org>
References: <20221014001911.3342485-1-helgaas@kernel.org>
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

Remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/include/asm/io.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index ce66dfc0e719..83a492c8d298 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -23,10 +23,6 @@
 #include <asm/unaligned.h>
 #include <asm/early_ioremap.h>
 
-/* We don't use IO slowdowns on the ia64, but.. */
-#define __SLOW_DOWN_IO	do { } while (0)
-#define SLOW_DOWN_IO	do { } while (0)
-
 #define __IA64_UNCACHED_OFFSET	RGN_BASE(RGN_UNCACHED)
 
 /*
-- 
2.25.1

