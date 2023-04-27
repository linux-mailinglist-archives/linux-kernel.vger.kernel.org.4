Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494D6F093C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbjD0QLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0QLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:11:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04B02709
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682611878; x=1714147878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WT17EN12I58ZSAp+uG1IXqZlMrM0WWAPtGlhqCyqwIY=;
  b=cCmOBlxNrMzthsY3kXzSkvU0LkFVVlA2ExGznML1mWuaZ5gBeGmRVHzV
   ldkvvq9+5VqBWDpWmuKcZT0R+zWtxFVJju5dAv8FgdTqCtzvMJeMuVQz9
   RShCyFbT5iN9Zh8bnTrXG1SWTgPlUq1zTNbZHRibcr4JZlJX5WkuHZp2H
   WC+UOovakt1cbanlYy4mEODqEa30apUrPBkTkuQbOBFh2tF8BMQouVYdW
   YCxFP7Zy1HHbc3g25sLDu0raWBv/PHpXpuzxOwUN6mA4bNeG9kgE7g6u0
   5FY4T70m2wuFyNWIY2M0q2a5Kh3EFLcyB/Na0AqnW9HXsFpbFeJZHu/1t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412838581"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="412838581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="838451121"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="838451121"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2023 09:10:23 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/fpu for 6.4
Date:   Thu, 27 Apr 2023 09:10:10 -0700
Message-Id: <20230427161010.1053561-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/fpu changes for 6.4. There's no _actual_ kernel
functionality here.  This expands the documentation around AMX support
including some code examples. The example code also exposed the fact
that hardware architecture constants as part of the ABI, but there's
no easy place that they get defined for apps.  Adding them to a uabi
header will eventually make life easier for consumers of the ABI.

--

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_6.4

for you to fetch changes up to 5fbff260755750559aa12a30f6fa7f8a863666f1:

  Documentation/x86: Explain the state component permission for guests (2023-03-22 13:08:02 -0700)

----------------------------------------------------------------
 * Improve AMX documentation along with example code
 * Explicitly make some hardware constants part of the uabi

----------------------------------------------------------------
Chang S. Bae (4):
      Documentation/x86: Explain the purpose for dynamic features
      x86/arch_prctl: Add AMX feature numbers as ABI constants
      Documentation/x86: Add the AMX enabling example
      Documentation/x86: Explain the state component permission for guests

 Documentation/x86/xstate.rst      | 100 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |   3 ++
 2 files changed, 103 insertions(+)
