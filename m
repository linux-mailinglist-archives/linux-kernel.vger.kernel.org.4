Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DA665C5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjACSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbjACSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308311811
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3018A614BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F8DC43392;
        Tue,  3 Jan 2023 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769281;
        bh=xXMTgaHBUsuYvrT8k9hzvrlkkYsSTm9k7enKirLP7lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8p9rPSJF8Ay9ZDLee+DKe4p3gXn9W587vthiPW3/4bFO/rLrhsXNTqOGn1GkOO0v
         NeTqIK41MRUWzw0vCb6T4kBhVyGVplpG0dv1FcZ2z0yXmVUUMA/CzaEkSlDaEcjZqM
         /jYde/4I5m6Es2tQoHW+V0mH6wbmwMS+6b/4JNKZZF7fbAB6FXS1nG1kAkQM4Shhdf
         mQZ3RonmRw1u/N4VR8MZkWfnWxLGH1N+C961ivdQuo3k5+CNlbVPmTyU9dHeL9113W
         GwPjQIrCRtRL3Bs3ENzBjGlouIBM0iN7wdq8FKHle3ubBYnnNnxL5GFL4Tv0geQLUH
         QeeOnGUQblnuQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] MAINTAINERS/MEMORY MANAGEMENT: Add tools/vm/ as managed files
Date:   Tue,  3 Jan 2023 18:07:51 +0000
Message-Id: <20230103180754.129637-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103180754.129637-1-sj@kernel.org>
References: <20230103180754.129637-1-sj@kernel.org>
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

'tools/vm/' directory should be a part of memory management subsystem,
but MAINTAINERS file doesn't mark the directory so.  Add one more 'F:'
entry for the directory to 'MEMORY MANAGEMENT' section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45977188ab5b..3073432ff0bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13484,6 +13484,7 @@ F:	include/linux/mmzone.h
 F:	include/linux/pagewalk.h
 F:	mm/
 F:	tools/testing/selftests/vm/
+F:	tools/vm/
 
 VMALLOC
 M:	Andrew Morton <akpm@linux-foundation.org>
-- 
2.25.1

