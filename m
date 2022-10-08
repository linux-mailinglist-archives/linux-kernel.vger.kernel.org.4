Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BFA5F857B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJHNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJHNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 09:42:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1EB4F3A4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 06:42:05 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ml5p41PnXz1P6gY;
        Sat,  8 Oct 2022 21:37:32 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 21:42:00 +0800
Message-ID: <43ebb21e-a445-748f-f78b-51535a8384c1@huawei.com>
Date:   Sat, 8 Oct 2022 21:41:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Ping: [PATCH -next v3 0/2] Remove unused variables in x86/boot
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <kirill.shutemov@linux.intel.com>, <akpm@linux-foundation.org>,
        <michael.roth@amd.com>
CC:     <nathan@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <masahiroy@kernel.org>, <ndesaulniers@google.com>,
        <brijesh.singh@amd.com>, <peterz@infradead.org>,
        <keescook@chromium.org>, <venu.busireddy@oracle.com>,
        <linux-kernel@vger.kernel.org>
References: <20220927081512.2456624-1-lizetao1@huawei.com>
 <20220930032727.3451619-1-lizetao1@huawei.com>
Content-Language: en-US
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20220930032727.3451619-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml500024.china.huawei.com (7.185.36.10) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/30 11:27, Li Zetao wrote:
> This series removes some unused variables in x86/boot, and add the
> "-Wall" flag to Makefile, which is the old problem of x86 not sharing
> makefiles.
>
> Changes since v2:
> - Add "frame-address" flag and "-std=gnu11" to
>    x86/boot/compressed/Makefile to fix warnings when "-Wall" flag added.
> - Declare the variable "i" within the for loop to reslove unused
>    variable warning.
> - Delete __efi_get_rsdp_addr function when CONFIG_EFI is disabled to
>    resolve unused function warning.
>
> v2 at:
> https://lore.kernel.org/all/20220927081512.2456624-1-lizetao1@huawei.com/
>
> Changes since v1:
> - Add "-Wall" flag to x86/boot/compressed/Makefile
> - Remove unused variables "et" in efi_get_system_table() and "ret" in
>    efi_get_conf_table()
> - Remove unused variables "ret" in __efi_get_rsdp_addr() and
>    "nr_tables" in efi_get_rsdp_addr()
>
> v1 at:
> https://lore.kernel.org/all/20220923113209.3046960-1-lizetao1@huawei.com/
>
> Li Zetao (2):
>    x86/boot/compressed: Add "-Wall" flag to Makefile
>    x86/boot: Remove unused variables
>
>   arch/x86/boot/compressed/Makefile | 3 ++-
>   arch/x86/boot/compressed/acpi.c   | 7 +++----
>   arch/x86/boot/compressed/efi.c    | 2 --
>   arch/x86/boot/compressed/kaslr.c  | 3 +--
>   arch/x86/boot/compressed/sev.c    | 1 -
>   5 files changed, 6 insertions(+), 10 deletions(-)

PING.


Best regards,

Li Zetao

