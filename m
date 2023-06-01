Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424671A258
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjFAPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjFAPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:18:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66D1A4;
        Thu,  1 Jun 2023 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=iPCuykgRySpw/ZXs6gCV41uTQU5aoInumgmYwwUYVaE=; b=Kt8PlBTkoFn5Hk4+RfJ/RZtJFg
        8hm0fAxzQ4lVW0dncyeHsIT2mZyPgRwjZQXdTuklUoGZNFmVmII3joLq0Y+GiOnzWeWmvQWxErxyZ
        8dpiZYBqVybeB2jfPeUHhvj+IBFPNSu362OvId3BNgbmZ2A8DOTReKojkgAmu4iqZrscidc2frTXK
        ugLjqcF5IGBTKJnIoEWDXpe6/MKgVQ3JWMteQyI9eRT+ZXKaT+QotJunBDuSIBkU5VLdx+/rPFb2O
        UUSGmtRbMITf6Yo8OZNwAiAaa6RMZQEVNR8dpM2qL3UXlHHglPYisJFafToVo1yMLpJTjp73mJaF6
        1VQGo2Ug==;
Received: from [2001:4bb8:182:6d06:eacb:c751:971:73eb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4k3s-003zx0-19;
        Thu, 01 Jun 2023 15:18:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com
Cc:     linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] openrisc: stop defining __KERNEL_SYSCALLS__
Date:   Thu,  1 Jun 2023 17:17:58 +0200
Message-Id: <20230601151758.1387016-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
defining it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index dfa558f98ed8c0..1e908ab10ada20 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -13,7 +13,6 @@
  * This file handles the architecture-dependent parts of process handling...
  */
 
-#define __KERNEL_SYSCALLS__
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
-- 
2.39.2

