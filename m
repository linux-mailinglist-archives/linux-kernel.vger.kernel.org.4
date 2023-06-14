Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C172D7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbjFMDLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbjFMDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:10:24 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DFF4487
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:08:15 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4QgD515r8pzdYM
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:07:49 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.36.20.94])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4QgD3G5HnJz4xD2l
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:06:18 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4QgD2g2nmPzB6TFN
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:05:47 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4QgD224jXpz5B151;
        Tue, 13 Jun 2023 11:05:14 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl2.zte.com.cn with SMTP id 35D34s1V090643;
        Tue, 13 Jun 2023 11:04:54 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 13 Jun 2023 11:04:55 +0800 (CST)
Date:   Tue, 13 Jun 2023 11:04:55 +0800 (CST)
X-Zmail-TransId: 2b036487dcd7685-e54ce
X-Mailer: Zmail v1.0
Message-ID: <202306131104554703428@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
Cc:     <imbrenda@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCB2MTAgMC81XSBrc206IHN1cHBvcnQgdHJhY2tpbmcgS1NNLXBsYWNlZCB6ZXJvLXBhZ2Vz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 35D34s1V090643
X-FangMail-Miltered: at esgde01-1.novalocal with ID 6487DD2A.000 by FangMail milter!
X-FangMail-Envelope: 1686625578/4QgD3G5HnJz4xD2l/6487DD2A.000/10.36.20.94/[10.36.20.94]/mxus.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6487DD84.000/4QgD515r8pzdYM
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The core idea of this patch set is to enable users to perceive the number
of any pages merged by KSM, regardless of whether use_zero_page switch has
been turned on, so that users can know how much free memory increase is
really due to their madvise(MERGEABLE) actions. But the problem is, when
enabling use_zero_pages, all empty pages will be merged with kernel zero
pages instead of with each other as use_zero_pages is disabled, and then
these zero-pages are no longer monitored by KSM.

The motivations to do this is seen at:
https://lore.kernel.org/lkml/202302100915227721315@zte.com.cn/

In one word, we hope to implement the support for KSM-placed zero pages
tracking without affecting the feature of use_zero_pages, so that app
developer can also benefit from knowing the actual KSM profit by getting
KSM-placed zero pages to optimize applications eventually when
/sys/kernel/mm/ksm/use_zero_pages is enabled.

Change log
----------
v9->v10:
-------
(1) Fix a compile error due to [PATCH v8 3/5] when CONFIG_KSM is not set.

(2) Rename the function 'ksm_notify_unmap_zero_page' as
    'ksm_might_unmap_zero_page'.

(3) In [PATCH 5/5], we get ksm_zero_pages from its own 'mm' instead of
	the global system.

(4) In [PATCH 5/5], we add a subject task of testing ksm zero pages when
	unmerging by triggering write fault.

v8->v9:
------
(1) The previous [PATCH v8 4/6] is squashed into the current [PATCH v9 2/5].

(2) Improve the codes as David's suggestions.

v7->v8:
-------
(1) Since [1] which fix the bug of pte_mkdirty on sparc64 that makes pte
    writable, then we can remove the architechture restrictions of our
	features.
(2) Improve the scheme of update ksm_zero_pages: add the handling case when
    khugepaged replaces a shared zeropage by a THP. 

[1] https://lore.kernel.org/all/20230411141529.428991-2-david@redhat.com/

v6->v7:
-------
This is an all-newed version which is different from v6 which relys on KSM's
rmap_item. The patch series don't rely on rmap_item but pte_dirty, so the
general handling of tracking KSM-placed zero-pages is simplified a lot.

For safety, we restrict this feature only to the tested and known-working
architechtures (ARM, ARM64, and X86) fow now.

xu xin (5):
  ksm: support unsharing KSM-placed zero pages
  ksm: count all zero pages placed by KSM
  ksm: add ksm zero pages for each process
  ksm: consider KSM-placed zeropages when calculating KSM profit
  selftest: add a testcase of ksm zero pages

 Documentation/admin-guide/mm/ksm.rst              | 25 ++++--
 fs/proc/base.c                                    |  1 +
 include/linux/ksm.h                               | 20 +++++
 include/linux/mm_types.h                          |  9 ++-
 mm/khugepaged.c                                   |  2 +
 mm/ksm.c                                          | 28 +++++--
 mm/memory.c                                       |  5 +-
 tools/testing/selftests/mm/ksm_functional_tests.c | 98 ++++++++++++++++++++++-
 8 files changed, 172 insertions(+), 16 deletions(-)

-- 
2.15.2
