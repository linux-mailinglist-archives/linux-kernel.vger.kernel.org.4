Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF245B409A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIIU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiIIU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:26:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E8ADCEB;
        Fri,  9 Sep 2022 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662755136; x=1694291136;
  h=from:to:cc:subject:date:message-id;
  bh=QeN4F4cFzKLhQRo19GZjextTR8X7sonKvPEkPOOmsDs=;
  b=iWUMCBFvAQ31a7MQeX39ouO43x6QQPAbR5IGZTuZFug6cSVhfUglAoVf
   NNadCn6ma3qpa8hNvQYCIFpvfAmtcoq/fxBK8Ym84G/xjFEv7I1//M5h1
   MwEfuCC0rSMt7FUJX6lHuihp9cMCFrfZqSI3ZxFV9p0OLRftLv9r/fZd/
   lE0Jyib2dSUsktDlAUVUHgSv3XLOJV7+bqPaex34c8VNwV0TUebqm6wX4
   qtDOLSfplUVT4MXWshGwzsHrDzvMVPzT3q7EgbflipFu+BsaSjbU5elzS
   xJeBGw4KNltgD349hDwGGTq41DR6i86jBT3XeHG709Pt/eNlo2X0ejTyf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="280584698"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="280584698"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 13:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="611162990"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2022 13:25:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v4 0/4] Documentation/x86: Improve the AMX documentation
Date:   Fri,  9 Sep 2022 13:15:36 -0700
Message-Id: <20220909201540.17705-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are the changes from the last version [1]:
* Add the motivation for the dynamic feature enabling.
* Add the description for the guest options back.

Thank you Tony for the review.

=== Cover Letter ===

When the AMX feature was supported in Linux, the dynamic feature enabling
model was introduced. The following documentation changes were considered
to help users to adopt this new enabling model:

(1) The AMX-enabling code example is expected to clarify the steps.
(2) Along with that, a couple of ABI constants may be useful for users.
(3) Also, describing the motiviation will provide the context of this.
(4) Lastly, the description of new guest options are added as missing.

If they are acceptable, the arch_prctl(2) manual page [2] will be followed
up separately with something similar to the kernel documentation.

These patches can be also found in this repository:
  git://github.com/intel/amx-linux.git amx-doc

And the compiled preview is available here:
  https://htmlpreview.github.io/?https://github.com/intel/amx-linux/doc-web/x86/xstate.html

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220711171347.27309-1-chang.seok.bae@intel.com/
[2] arch_prctl(2): https://man7.org/linux/man-pages/man2/arch_prctl.2.html

Chang S. Bae (4):
  Documentation/x86: Explain the purpose for dynamic features
  x86/arch_prctl: Add AMX feature numbers as ABI constants
  Documentation/x86: Add the AMX enabling example
  Documentation/x86: Explain the state component permission for guests

 Documentation/x86/xstate.rst      | 98 +++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |  3 +
 2 files changed, 101 insertions(+)


base-commit: 132bde89b5234d0ca8909775b354c48b214e1abc
-- 
2.17.1

