Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CDA73E8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjFZSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjFZSaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:30:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976B172E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687804213; x=1719340213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6wCp+iY2jLtglNEKCAZRgKw1YzPBg7/kB29FoaIR90I=;
  b=UkJ8uQog4JJux+bfMOD6DYt7rYVofgudx3nhJlOJP5Q+SCGHCZV//bBy
   3QhTdiL8sWFg+GozICoLxLNKUZSiFnnUE9XCfQ9IzzIujQJT+cIyhQLvu
   AW9sBpY3nqy6qkll5mfZZrzNdqlBUVuzUGGuNf4vrDRhQGE6mYiA+MIqJ
   4Bl2CK6n48f0xoRAzD4FdaOiW/LXM/+54Rm3PihZj32EC5E4c0aia0jKR
   kILr6cBfyaw2zDopSUagkP4E8jpfqv80euTeIuaIm7JK9i18YkhRj4f+1
   CH2gwne1LuSI9jCQv8vJtK5Ftr0OeKw8/rngLQd+N1V6Pa8Sr77yV6ixj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340939391"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340939391"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 11:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840381425"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="840381425"
Received: from viggo.jf.intel.com (HELO ray2.intel.com) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 11:30:13 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/irq for 6.5
Date:   Mon, 26 Jun 2023 11:30:11 -0700
Message-Id: <20230626183011.1516068-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a single x86/irq change for 6.5.  This ensures that
Hyper-V-specific interrupts are accounted for in /proc/stat.

--

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_irq_for_6.5

for you to fetch changes up to 504dba50b0c3fa02ec513d7d0405ddffba2d1c0a:

  x86/irq: Add hardcoded hypervisor interrupts to /proc/stat (2023-06-08 08:28:08 -0700)

----------------------------------------------------------------
Add Hyper-V interrupts to /proc/stat

----------------------------------------------------------------
Michael Kelley (1):
      x86/irq: Add hardcoded hypervisor interrupts to /proc/stat

 arch/x86/kernel/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)
