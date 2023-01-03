Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3C65C5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbjACSIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjACSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:08:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C311837
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF1A614BE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB78C433F0;
        Tue,  3 Jan 2023 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769281;
        bh=ZGhrQ4NX9OMAiXDlUxIZQzQ+q2BaZWwXsSR4ZHKa+70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDi2uiCMEagSXJJpB3Ej0CNe2hTfvbMJsgcMyXzMtrHp8fBDYnFdCQpUe2WJGhjax
         JQl0xWrNL7RswsIkYdGipL42i9vDj/txPTnbuT0UR9UeJ0ocXqjhYqqdG8Qfyo5brk
         Ka7HIO9ltCR0t4mDgF83rCfAtNRShaAwlQDHTGBOW6xcdjcaXcs5HZNT3nVgdJXMZ5
         FrryFH9M6bjmqt5jHPXXwf+KLiW8uWB0fLRVZOI3sULYKWPMnHRYSYUfvSobA/0LJq
         PdOhdNTvGvD3tQIZWEYeBfIFs9tdzDuH+1LPgZoMtUhui9V79tJ2vpYkjPiRpm3QlR
         +PUvgZelexPxQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] MAINTAINERS: add types to akpm/mm git trees entries
Date:   Tue,  3 Jan 2023 18:07:50 +0000
Message-Id: <20230103180754.129637-2-sj@kernel.org>
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

Each SCM tree entry of MAINTAINERS file should have both type and
location, but akpm/mm git tree entries of 'MEMORY MANAGEMENT' and
'VMALLOC' sections of the file don't have the type.  Add the type.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..45977188ab5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13474,7 +13474,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-T:	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
@@ -13492,7 +13492,7 @@ R:	Christoph Hellwig <hch@infradead.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
-T:	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/vmalloc.h
 F:	mm/vmalloc.c
 
-- 
2.25.1

