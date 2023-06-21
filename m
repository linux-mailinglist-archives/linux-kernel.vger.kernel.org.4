Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43A0738B13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjFUQ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFUQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:26:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166B10DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687364795; x=1718900795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9qwoYapZpwMMsm49T+9E9pkufHxpAbl+dzHeAFwezxk=;
  b=GkSRvJTZU2thQcONm+2MVFCJrfaqPPACxmYrJSRlVOIc93WnsnAFrwV/
   +3oQQWvvA5vKxfipNRqpXS69LGAhddBCzNIOByXHcP5kbkvJxgDfKpOcd
   ByTaUdaI68gEAdViCXkSUWaFUlrSyTHMXQNW3t2MpJEldhvjdfYhvhd2K
   bPDsA1xxqsoV9CC3kWQSAae/N8kmX9xibFgqsSl3YZEHJfDhM5EPclf84
   Yu3cT2tnbqoXbqaYSNF5OFg17Azs4BtCsYQWQ4nscb+8Sh9YGHOxtjo42
   h6BU4yYO9iLCfivsVauUXigcaP7k1LBPOR2L4OeXJKfzeFnpNq2Cjjp82
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="426178623"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="426178623"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 09:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="804435801"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="804435801"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 09:26:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6137B1FD; Wed, 21 Jun 2023 19:26:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v1 0/2] bimap API: Add couple of files to MAINTAINERS
Date:   Wed, 21 Jun 2023 19:26:24 +0300
Message-Id: <20230621162626.86033-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During discussion
https://lore.kernel.org/r/20230509051403.2748545-1-lucas.demarchi@intel.com
I was started wondering why neither Yury nor Rasmus commented on that.

Hence I wanted to add some headers to the bitmap API MAINTAINERS for
watching the changes made elsewhere are they may correlate with bit
operations.

Cc: Lucas De Marchi <lucas.demarchi@intel.com>

Andy Shevchenko (2):
  MAINTAINERS: Add bits.h to the BITMAP API record
  MAINTAINERS: Add bitfield.h to the BITMAP API record

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.40.0.1.gaa8946217a0b

