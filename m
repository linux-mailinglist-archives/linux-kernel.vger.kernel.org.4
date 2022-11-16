Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95062B45C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKPH57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiKPH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:57:50 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2123175;
        Tue, 15 Nov 2022 23:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668585469; x=1700121469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KiJFxHg73UmbAysUoUdzQCgP2Xj1YpjVLLbX13coZBc=;
  b=epSkuVOhMEM8cejYioCxTlgAXcO7ftvT+P5aTum1VQHIek0JL3cUeOeC
   SrcsnY6+gd5tPO0yl1FgiGvPbElWl2SRKqOisTsoTPRkFj9B6lpusMYkH
   Se9k7pcrMyv/WJq+CW8jkCMzfjhL6TDtYTiXy94hfdEKRQDnBmRL6mBIW
   D+ARez2KaX6RYrJMA/nbBxw8Ntuso0eUTOFBnDOK7K1QZ7xFSi2DENcKz
   ecYdav4GtTmU6GiJnc9CIsZCPTbc6Yl+3cRd+6dDRluz2C1CU1MF/nwWQ
   rhvdNm1rykexMDkaz0U+Asi/DjGz96FnoedFKhAPfi98DISdhBgqU5LI4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398767159"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398767159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 23:57:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="702769364"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="702769364"
Received: from ake-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.189.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 23:57:48 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-acpi@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, liushixin2@huawei.com,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] ACPI: HMAT: remove unnecessary variable initialization
Date:   Wed, 16 Nov 2022 00:57:35 -0700
Message-Id: <20221116075736.1909690-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116075736.1909690-1-vishal.l.verma@intel.com>
References: <20221116075736.1909690-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; h=from:subject; bh=KiJFxHg73UmbAysUoUdzQCgP2Xj1YpjVLLbX13coZBc=; b=owGbwMvMwCXGf25diOft7jLG02pJDMkl0z8c2bBOhXPxhhcv27v8VlxRD5I49mFC+5c7y0NDmwr5 vVzPd5SyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAi5l8Z/ocvNH5QtEf3/525N/MSzF 9OCLPs6bb4nXLoWZLpm3m5WQ2MDJOd7b994WDqmGTY4Hjm3y0mnqA47QQfk7OVhVcu9lg2cgMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hmat_register_target_initiators(), the variable 'best' gets
initialized in the outer per-locality-type for loop. The initialization
just before setting up 'Access 1' targets was unnecessary. Remove it.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/numa/hmat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 23f49a2f4d14..144a84f429ed 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -644,7 +644,6 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	/* Access 1 ignores Generic Initiators */
 	bitmap_zero(p_nodes, MAX_NUMNODES);
 	list_sort(p_nodes, &initiators, initiator_cmp);
-	best = 0;
 	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
 		loc = localities_types[i];
 		if (!loc)
-- 
2.38.1

