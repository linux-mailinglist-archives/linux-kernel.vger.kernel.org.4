Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3868C2AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjBFQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjBFQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:12:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2A25296;
        Mon,  6 Feb 2023 08:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675699923; x=1707235923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JiRT2vt59/STO2t8EvThP9xKhXUEY2lUBvuzaf6cklY=;
  b=BfErolaukxL0j6vtlIaSHtwPV5HIR92bQhReprzzMrDHIs1lsa8Z0t8J
   a8hNVlLlOsfj7U9wqthALF29oWEWCM2cgG8wcpeLHGJhp+r5mVlbp74vm
   5qbNCH/ac6uO+Ja1mQZvRhbmQ1/HNPl8vbRpDsTdYmUortB5WGOXWkKvk
   HRQwAk4GTQZFkfzf3ZMlBcHb+pfdUuwZbRETSLdUOyqS3TQWBJbcpdsT0
   8HQ7AdF+04i+aJGisJBVWQCkt4dfCTfPf4W49uvumTcGfmAx202WzCynz
   AK7SNcPZ9Cs8yFfANJgdDfySDs3hKOQ0iKW+XQ6SU5TV24/inYG7pnPJP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308887662"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308887662"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:10:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616485722"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616485722"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 08:10:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3956E1EA; Mon,  6 Feb 2023 18:10:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/7] xhci: mem: Short cleanup series
Date:   Mon,  6 Feb 2023 18:10:42 +0200
Message-Id: <20230206161049.13972-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up xhci-mem.c a bit using latest and greatest Linux kernel
features.

Andy Shevchenko (7):
  xhci: mem: Carefully calculate size for memory allocations
  xhci: mem: Use __GFP_ZERO instead of explicit memset() call
  xhci: mem: Get rid of redundant 'else'
  xhci: mem: Drop useless return:s
  xhci: mem: Use while (i--) pattern to clean up
  xhci: mem: Replace explicit castings with appropriate specifiers
  xhci: mem: Join string literals back

 drivers/usb/host/xhci-mem.c | 85 +++++++++++++++----------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

-- 
2.39.1

