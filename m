Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E16C05CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCSWAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCSWAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:00:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C214239;
        Sun, 19 Mar 2023 15:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2187B80D2B;
        Sun, 19 Mar 2023 22:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F0AC433EF;
        Sun, 19 Mar 2023 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679263225;
        bh=tJwEQcdAqnhTzTScV6Pn/bPL/i/f+PX1TkWeIm6dtaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIhxwyq+GXe8QtD19WP50iL/3TUxA3hcV1snjRx1EWasCnQvoYx+gXOBmXwm96sg5
         idENCYSVuI/0QLkBoOaZNj9tcO/gbZY2CUvMAMKXzcdwumPoeqJyR1Y6YW7txiLZ5J
         jat66Riix/3x5oYZY3cKZZWbpV692n4fK9XW1YizM20xKlzR1YiSKExvkC/GQYJWsJ
         peMbK1qKOqSDBP7Eud05E+83vXAaT2/44N/PYn6gkj1wMfDX5vZEa3gxH1zlv1a7K/
         Ysj8PQvzdUTkMugRPxoUWcwQZ1qsM3Nf3O1tRTLj9G78Yr8WO3sYXC/zEmy9SPa3j2
         Hx+n+hHWWZHwA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 01/15] mips: fix comment about pgtable_init()
Date:   Sun, 19 Mar 2023 23:59:54 +0200
Message-Id: <20230319220008.2138576-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319220008.2138576-1-rppt@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
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

Comment about fixrange_init() says that its called from pgtable_init()
while the actual caller is pagetabe_init().

Update comment to match the code.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/mips/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
index beea14761cef..b037718d7e8b 100644
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -70,7 +70,7 @@ enum fixed_addresses {
 #include <asm-generic/fixmap.h>
 
 /*
- * Called from pgtable_init()
+ * Called from pagetable_init()
  */
 extern void fixrange_init(unsigned long start, unsigned long end,
 	pgd_t *pgd_base);
-- 
2.35.1

