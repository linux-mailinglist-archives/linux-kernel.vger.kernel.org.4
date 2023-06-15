Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F16732256
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbjFOWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjFOWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:01:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C802943;
        Thu, 15 Jun 2023 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866466; x=1718402466;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=U9rnqtpmVZUt30zvfvx/p0VOOSSlAU3FkBQboHUpz0E=;
  b=JMQf/c3ItfiQ3GTN3o4+ONX2IbrwQ2xRfZxmw5wEIBbxoarPUjd5rwwG
   PmsWZApXoDwyC6Wp/ngYFxDdrVeGp2lky0mUdR8GIqNSomMfjpPdKm1Cy
   FNgHItHOgJ9HTjC4pc5QZX0Ircq0jz8yJVQrdOsktUVLWVHiWUNrWf6AP
   +onmqCYlRuhCyfkJ+szM3XrVThrQ+9SxWv2k8oP0MmyIyIWHf8hP1gBJe
   mql6zvVTl0GYTyjWU8NL7LWHefg/62h5cb/F8WmlJGBDMqKBPJP2+2KGY
   xkfEMrVA2G1TckVe2dV2KfYio6dXJ7CYh3IiXrzSE9LAPmGSIutSTrJe9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343791146"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343791146"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715770100"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715770100"
Received: from smaurice-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.120.175])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:01:01 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 15 Jun 2023 16:00:24 -0600
Subject: [PATCH 2/3] mm/memory_hotplug: Export symbol
 mhp_supports_memmap_on_memory()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230613-vv-kmem_memmap-v1-2-f6de9c6af2c6@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
In-Reply-To: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=U9rnqtpmVZUt30zvfvx/p0VOOSSlAU3FkBQboHUpz0E=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCndXdJPCib2Sa5SyA1aNe/Q/VXJhzimiG36Itn24UN9e
 H7A1vBbHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZiIryzD/3jW5j0urffjip8t
 rp3lFbThsIdtc7BdjespQffltSv0mBj+ir6LTXEoMz7Re1bMx3xRREVS1t8keY4Wzldm89w9ctL
 5AQ==
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the dax/kmem driver, which can be built as a module,
to use this interface, export it with EXPORT_SYMBOL_GPL().

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bb3845830922..92922080d3fa 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1328,6 +1328,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags)
 		       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
 	return false;
 }
+EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
 
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug

-- 
2.40.1

