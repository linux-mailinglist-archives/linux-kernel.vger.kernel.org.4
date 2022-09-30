Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EED5F0358
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiI3Db1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiI3DbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:31:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB8DDDA2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:31:21 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mdwgc2KhnzHqMN;
        Fri, 30 Sep 2022 11:29:00 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 11:31:19 +0800
Received: from huawei.com (10.67.175.88) by kwepemm600017.china.huawei.com
 (7.193.23.234) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 11:31:18 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>,
        <michael.roth@amd.com>
CC:     <lizetao1@huawei.com>, <nathan@kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <masahiroy@kernel.org>, <ndesaulniers@google.com>,
        <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <keescook@chromium.org>, <venu.busireddy@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next v3 0/2] Remove unused variables in x86/boot
Date:   Fri, 30 Sep 2022 03:27:25 +0000
Message-ID: <20220930032727.3451619-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927081512.2456624-1-lizetao1@huawei.com>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some unused variables in x86/boot, and add the
"-Wall" flag to Makefile, which is the old problem of x86 not sharing
makefiles.

Changes since v2:
- Add "frame-address" flag and "-std=gnu11" to 
  x86/boot/compressed/Makefile to fix warnings when "-Wall" flag added.
- Declare the variable "i" within the for loop to reslove unused 
  variable warning.
- Delete __efi_get_rsdp_addr function when CONFIG_EFI is disabled to 
  resolve unused function warning.

v2 at:
https://lore.kernel.org/all/20220927081512.2456624-1-lizetao1@huawei.com/

Changes since v1:
- Add "-Wall" flag to x86/boot/compressed/Makefile
- Remove unused variables "et" in efi_get_system_table() and "ret" in
  efi_get_conf_table()
- Remove unused variables "ret" in __efi_get_rsdp_addr() and
  "nr_tables" in efi_get_rsdp_addr()

v1 at:
https://lore.kernel.org/all/20220923113209.3046960-1-lizetao1@huawei.com/

Li Zetao (2):
  x86/boot/compressed: Add "-Wall" flag to Makefile
  x86/boot: Remove unused variables

 arch/x86/boot/compressed/Makefile | 3 ++-
 arch/x86/boot/compressed/acpi.c   | 7 +++----
 arch/x86/boot/compressed/efi.c    | 2 --
 arch/x86/boot/compressed/kaslr.c  | 3 +--
 arch/x86/boot/compressed/sev.c    | 1 -
 5 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.34.1

