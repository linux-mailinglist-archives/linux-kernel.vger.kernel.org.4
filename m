Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522A606D89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUCVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJUCVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:21:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB37E1F8100
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:21:12 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mtp6Y6tt8zDsKp;
        Fri, 21 Oct 2022 10:18:29 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:21:10 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:21:10 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Yipeng Zou <zouyipeng@huawei.com>
Subject: [PATCH stable 0/1] x86: aperfmperf: bug report
Date:   Fri, 21 Oct 2022 10:17:39 +0800
Message-ID: <20221021021740.137196-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently i was doing some work about calculating CPU frequency on x86 on
stable branch linux-5.10.y, and there is a problem which i descrip in
the commit message.

I've noticed that it has been abandoned on the mainline. On the mainline
it becomes to update [a,m]cnt in timer code with HZ frequency, and it is
actually calculated at the time of reading the cpu freqency. This solves
the problem above.

So, Are there other reasons why the stable branch doesn't have these
changes?, this patch is just to ask how we plan to fix it.

Yipeng Zou (1):
  x86: aperfmperf: fix overflow problem in the concurrency scenario

 arch/x86/kernel/cpu/aperfmperf.c | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.17.1

