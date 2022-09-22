Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C885E6CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiIVUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiIVUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:08:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB55E7E1D;
        Thu, 22 Sep 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877311; x=1695413311;
  h=from:to:cc:subject:date:message-id;
  bh=1/UP5ggZVyEOLFcqk5IssnydM3WiXqVmzAT+4XSCr2g=;
  b=iVBdAjJ4vc0V8Pn+qrDdhbAloLZd/w3/o/GEVye5z2rQadLpv3t9ueXN
   poNvq8GvY3jdLt8rDc1Tu5obqBW5eIcDoy6ap37cfOYVNu83IpZSfaaNk
   N9b7TVhaDmn4ZpOiJFzA6/1GmuDlLo8nb3uwIc/4xuF7TACiJ6bA7lbhC
   l/8F7CsJ1NzYmPR6UbynBOXYUd5ucqWUviThCCxKgHRpyiy5L7JYe3kB5
   lSY+nWfDm0upfW5881IXqqTk8b14BnRxlonrcXbMPR0tXwwiejk0zIcCI
   PJFWblHNw5b34p6Z4OfKHDkTYN1VR6n+UQVBlibSbUC83z3lNeksyAfRb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362221572"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362221572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571117130"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 13:08:13 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, corbet@lwn.net, bagasdotme@gmail.com,
        tony.luck@intel.com, yang.zhong@intel.com,
        linux-doc@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [PATCH v5 0/4] Documentation/x86: Improve the AMX documentation
Date:   Thu, 22 Sep 2022 12:58:06 -0700
Message-Id: <20220922195810.23248-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The change from the last version [1]:
* Update the purpose part (patch1) by rewriting the altstack story and
  having it as the only reason.

Thanks Dave Hansen for the feedback.

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

[1] https://lore.kernel.org/lkml/20220909201540.17705-1-chang.seok.bae@intel.com/
[2] arch_prctl(2): https://man7.org/linux/man-pages/man2/arch_prctl.2.html

Chang S. Bae (4):
  Documentation/x86: Explain the purpose for dynamic features
  x86/arch_prctl: Add AMX feature numbers as ABI constants
  Documentation/x86: Add the AMX enabling example
  Documentation/x86: Explain the state component permission for guests

 Documentation/x86/xstate.rst      | 100 ++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/prctl.h |   3 +
 2 files changed, 103 insertions(+)


base-commit: 08ed00508bc1fa0a0bc6dd2420f982b55051de23
-- 
2.17.1

