Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C759666E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbjALJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjALJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:26:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDD2F7BE;
        Thu, 12 Jan 2023 01:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 72336CE1DB5;
        Thu, 12 Jan 2023 09:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D334EC433D2;
        Thu, 12 Jan 2023 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673514998;
        bh=ZLGBlhqw5hH+SxGqvaz0vux+DdR7ulM6iEJUTeGEBI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HyrCYlauX4PXXWG5WJaiDDyQ5apznezA6+yxRixMw+fXqLMA9iCiRDXMGTAO70fiA
         bz0Mg/CmqB+nGiH3/sPByRAk1piYnULBmzuDGgK1oFD44IJL/TjCwMr4VCBOo8j4CP
         UDT62N1CTljHSZgf8HbyBAjWE5JwhdziCHvDB8oxa8g9xuQkXvbSwuTLHfQfyvrHrs
         f3b3Rr7MKmE6O9KwPi9GE4xseySelMz+yRPsMpepqCiT5gG7S9cm7Y1TVV8KLV2Hbf
         BtmIJZ/lHJ30Lir8ygtARKpluG0sskKiXNHLpwFwqqOCKyTZpdeP7jfpj7TNGGGfAq
         6qu3FoZFr5R0Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/3] docs/mm: Page Reclaim: add page label to allow external references
Date:   Thu, 12 Jan 2023 11:16:15 +0200
Message-Id: <20230112091616.824565-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112091616.824565-1-rppt@kernel.org>
References: <20230112091616.824565-1-rppt@kernel.org>
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

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/page_reclaim.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
index 50a30b7f8ac3..3fccde066436 100644
--- a/Documentation/mm/page_reclaim.rst
+++ b/Documentation/mm/page_reclaim.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _page_reclaim:
+
 ============
 Page Reclaim
 ============
-- 
2.35.1

