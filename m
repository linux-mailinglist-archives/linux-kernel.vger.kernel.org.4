Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0055BD9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 04:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiITCHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 22:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiITCHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 22:07:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB457226
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 19:07:14 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MWlF70qwGzlVys;
        Tue, 20 Sep 2022 10:03:07 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 10:07:11 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <peterz@infradead.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <cuigaosheng1@huawei.com>,
        <lukas.bulwahn@gmail.com>, <akpm@linux-foundation.org>,
        <pbonzini@redhat.com>, <anshuman.khandual@arm.com>,
        <namit@vmware.com>, <seanjc@google.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Remove orphan declarations for x86
Date:   Tue, 20 Sep 2022 10:07:07 +0800
Message-ID: <20220920020711.789296-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a few cleanup patches, to remove orphan
declarations which have been removed. Thanks!

Gaosheng Cui (4):
  x86/asm: remove orphan nx_enabled declaration
  x86/platform/intel-mid: remove orphan declarations from intel-mid.h
  x86: remove orphan ia32_setup_arg_pages() declaration
  x86/extable: remove orphan fixup_bug() declaration

 arch/x86/include/asm/extable.h       |  1 -
 arch/x86/include/asm/ia32.h          |  2 --
 arch/x86/include/asm/intel-mid.h     | 12 ------------
 arch/x86/include/asm/pgtable_types.h |  1 -
 4 files changed, 16 deletions(-)

-- 
2.25.1

