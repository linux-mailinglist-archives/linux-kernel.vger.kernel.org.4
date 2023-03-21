Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273F6C37CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCURHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCURHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:07:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5038A28D12;
        Tue, 21 Mar 2023 10:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33468B818B9;
        Tue, 21 Mar 2023 17:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA69C43443;
        Tue, 21 Mar 2023 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418383;
        bh=gZYmuZF4Wa4TQnlxf4knKHVZ8v3wOKjdrAB+ovQBwRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeoede4zIlueDGf7T5iTnzKG3tTXMvBICk8SDqhYvZZF5SJKb95ktCZ97DmB4Vj4b
         tmFgQrjHXzwokzsliceQ6wlLBhXWElddxRYlZ6/zlOEx3aF1TXa2uxjeWgDqU1Ll7R
         4de4hOqsUD4HqKNvZBcFbFytrvaycwSByhvSye7zv+5fGJ4DwtYbPa74dU8uxsCKYf
         6lQpoIzfX+kr70yQcszvpf8biu3YbSOREudnD+tioQm3tKB/JgRomqUbTFCdM1VZdJ
         qPnupjVSPPAQEv4o53lcqQ7/O9VWki1w50YwJBY2LmDcZDyoQoDx/UCPhPthb49goW
         PEpI2eWzC1Pwg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 14/14] MAINTAINERS: extend memblock entry to include MM initialization
Date:   Tue, 21 Mar 2023 19:05:13 +0200
Message-Id: <20230321170513.2401534-15-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230321170513.2401534-1-rppt@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

and add mm/mm_init.c to memblock entry in MAINTAINERS

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7002a5d3eb62..b79463ea1049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13368,13 +13368,14 @@ F:	arch/powerpc/include/asm/membarrier.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
 
-MEMBLOCK
+MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
 F:	include/linux/memblock.h
 F:	mm/memblock.c
+F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
 MEMORY CONTROLLER DRIVERS
-- 
2.35.1

