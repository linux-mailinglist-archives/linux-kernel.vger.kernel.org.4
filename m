Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EF35E7FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiIWQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIWQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:30:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F71332EE;
        Fri, 23 Sep 2022 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663950642; x=1695486642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/RfVsnD7hy2PrDScTV1+ibJddNVHM8cRBSmvIOOou8A=;
  b=kxYk9FwyCeWWJKKzYx3m13trKifpxF8fcsAg1LMsILMQCfAfVu91xn9F
   mJQex/nDUEHAOoHTyuBMbRJRMrkjgB+9RY4JltVMvPsR41bja6kQlT7N4
   gWLlD6hCmoD9oJSdJTOD/rAxPmWSHi/+4lU3mn1LLoadPtTQQstTl5frF
   Q8gHUx2/wq0L9/68ir6RNMYNwRcKE/6dSC6JJNRIHHL/hdB2fF0kLB0xM
   4wt3NYTBec/cOi+ioMfKlVc0djIBGKSUUuXBiQG/1Ku7BfI8raukEJHk8
   dXNJh1Q2eKqUZ52BJSDNw+SZeEimKXxuIN3ZhCdIQj4q2CAVp5SUaF0Iq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="287747433"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="287747433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 09:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="745847526"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Sep 2022 09:30:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A711CF7; Fri, 23 Sep 2022 19:30:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>
Subject: [PATCH v1 0/2] usb: dwc3: revert OTG changes for Intel Merrifield
Date:   Fri, 23 Sep 2022 19:30:49 +0300
Message-Id: <20220923163051.36288-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's late in the cycle, that's why I send these reverts, so we will have a
full new cycle for testing a better solution if any.

So this is just a proactive move if we have no solution in the nearest days.

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

