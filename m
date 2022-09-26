Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1A5EB1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIZTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIZTyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:54:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2754A1D46
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664222050; x=1695758050;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=n122jQefl2vyB2r2hsFy/od0/VcS5amKBYR/Q/4AtjI=;
  b=E0cjJLvGKKhS4z25aFe58HhvsEV67UgWvWlaUgfZP6H6LzIkFqDvKSYv
   sARI5f9G9ZKvnqDX50khyQMmPpoKS+EkP44dHbnCPtLMIwxmWnI6aiITn
   Uj1jExAXmoQtBc6U5tFKESkj8rpOBst0GYAarsBEGtHT0aYMuGOckZUnh
   l00ZNd+V8WY67kuYF1l2ERCtWAvLHZIwaesDGhTKBacg4oXtKVFJO/fMO
   sS3++oyebJfvtT21zflRL2ti2IIC0IG2ubxFwTdorWmrz93zv8W/nhjuI
   sZbxFO+Ky+Rcdcwmgoo7Epe6zTrJR5M41tYflymRC4YVtvr40gqc1g7Qz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302599441"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="302599441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:54:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="689693126"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="689693126"
Received: from yzhou16-mobl.amr.corp.intel.com (HELO [10.209.44.81]) ([10.209.44.81])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:54:09 -0700
Message-ID: <67154681-0e0a-69d7-d4ee-21067c9b561c@intel.com>
Date:   Mon, 26 Sep 2022 12:54:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
Subject: [GIT PULL] x86/urgent for 6.0{,-rc8}
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a few urgent x86 fixes for the next -rc or final release.

--

The following changes since commit 00da0cb385d05a89226e150a102eb49d8abb0359:

  Documentation/ABI: Mention retbleed vulnerability info file for sysfs (2022-08-25 15:55:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0-rc8

for you to fetch changes up to e400ad8b7e6a1b9102123c6240289a811501f7d9:

  ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems (2022-09-23 15:24:10 -0700)

----------------------------------------------------------------

 * A performance fix for recent large AMD systems that avoids an ancient
   cpu idle hardware workaround.

 * A new Intel model number.  Folks like these upstream as soon as
   possible so that each developer doing feature development doesn't
   need to carry their own #define.

 * SGX fixes for a userspace crash and a rare kernel warning

----------------------------------------------------------------
Dave Hansen (1):
      ACPI: processor idle: Practically limit "Dummy wait" workaround to old Intel systems

Haitao Huang (1):
      x86/sgx: Handle VA page allocation failure for EAUG on PF.

Jarkko Sakkinen (1):
      x86/sgx: Do not fail on incomplete sanitization on premature stop of ksgxd

Tony Luck (1):
      x86/cpu: Add CPU model numbers for Meteor Lake

 arch/x86/include/asm/intel-family.h |  3 +++
 arch/x86/kernel/cpu/sgx/encl.c      |  5 ++++-
 arch/x86/kernel/cpu/sgx/main.c      | 15 +++++++++------
 drivers/acpi/processor_idle.c       | 23 ++++++++++++++++++++---
 4 files changed, 36 insertions(+), 10 deletions(-)

