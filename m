Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD14D5EC8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiI0PyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiI0Px0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:53:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA43FE070;
        Tue, 27 Sep 2022 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664294003; x=1695830003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NXWwUnJTuj8z+DvDLnt3SpkRiCmdJRviU5vQAyLI+Wk=;
  b=mAf+COenqNsLQhqlR7v5XiE07GvsRl+RU2fnYfiuMIGmIhJzMvJ8d2jc
   6ztwM/xdDb1qUGX4YlZGdBqEnyj7P2e1ZqrW5so+KBfPPC245uMuCL2Cl
   a0l6rfk27cYCuWZteDiA/lmACePgw4OlzvhW3R8Pgm/H4IjIlJ3c0TV93
   sTRpxG5fT6RxgYvpYe8YIS8LQk017aXgtusiYRBIqPU0yUhwybsuKaxLO
   Txyv54dydzYZu9OoG5JL4xl3ywmCPS9PH+OQSvKgHCgcHkc/TOoeajg5u
   9I8DdeTVn5WTgERC1OGRhHCUOp7J06uu+BoVUi/BXupqEGQ5p3Z8Xklmo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365395770"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365395770"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950335502"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="950335502"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2022 08:53:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D5337C; Tue, 27 Sep 2022 18:53:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v2 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
Date:   Tue, 27 Sep 2022 18:53:30 +0300
Message-Id: <20220927155332.10762-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As agreed with the author, the v5.19 change is going to be reverted by
this series, so we will collaborate on a new one in the future that
brings no regressions.

Changelog v2:
- added Cc: stable@ and Fixes tags (Greg)
- rewritten cover letter to point out what the version is touched and
  what the decision made with the author of the original change (Greg)
- fixed the placement of one piece of code (Andrey)
- added Tested-by tags (Ferry)

Andy Shevchenko (2):
  Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG
    -> peripheral if extcon is present""
  Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is
    present"

 drivers/usb/dwc3/core.c | 50 +----------------------------------------
 drivers/usb/dwc3/drd.c  | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.35.1

