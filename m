Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587F60142A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJQRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJQRBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:01:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8AF6F56E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:01:49 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e793329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e793:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8AF11EC0682;
        Mon, 17 Oct 2022 19:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666026104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRbsyHvyA4OIDsg2Dzh8CYhxKvYWtgJA9qKqNFK15uE=;
        b=Np8vwR1ZqtYDEkjW0UyYIBToXtd0GABIySrilYus31feEDwIymB+M0T4qGDapC0cvO0DtI
        11DWm64ZbkuxewyDK9fffeBnuOx2IxmATMaG5dPKhLlG+hIpILNaKFFMeKGZTxunsGo/4f
        KkLDKbatWih8cH/jxp5IhMUPaLwwStM=
Date:   Mon, 17 Oct 2022 19:01:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        masahiroy@kernel.org, michael.roth@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nathan@kernel.org,
        ndesaulniers@google.com, brijesh.singh@amd.com,
        peterz@infradead.org, venu.busireddy@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH -next v4 2/2] x86/boot/compressed: Add "-Wall" flag to
 Makefile
Message-ID: <Y02KdJfTSFRlbnwn@zn.tnic>
References: <202210090815.526C76396@keescook>
 <20221011012904.2330473-1-lizetao1@huawei.com>
 <20221011012904.2330473-3-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221011012904.2330473-3-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:29:04AM +0000, Li Zetao wrote:
> This warning is disabled in the main Makefile for this reason so we

Who's "we"?

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

In any case, it is getting there but this is not how you structure a
patchset like this. The proper order is:

1st patch: Remove unused variables

2nd patch: Fix -Wframe-address warning and explain why

3rd patch: Fix arch/x86/boot/compressed/acpi.c:23:1: warning: unused function "__efi_get_rsdp_addr" [-Wunused-function]

Btw, I also get with -Wall

In function ‘find_trampoline_placement’,
    inlined from ‘paging_prepare’ at arch/x86/boot/compressed/pgtable_64.c:135:35:
arch/x86/boot/compressed/pgtable_64.c:60:30: warning: array subscript 0 is outside array bounds of ‘short unsigned int[0]’ [-Warray-bounds]
   60 |                 ebda_start = *(unsigned short *)0x40e << 4;
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/boot/compressed/pgtable_64.c:61:30: warning: array subscript 0 is outside array bounds of ‘short unsigned int[0]’ [-Warray-bounds]
   61 |                 bios_start = *(unsigned short *)0x413 << 10;
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~
In function ‘bios_get_rsdp_addr’,
    inlined from ‘get_rsdp_addr’ at arch/x86/boot/compressed/acpi.c:163:8:
arch/x86/boot/compressed/acpi.c:130:19: warning: array subscript 0 is outside array bounds of ‘u16[0]’ {aka ‘short unsigned int[]’} [-Warray-bounds]
  130 |         address = *(u16 *)ACPI_EBDA_PTR_LOCATION;

That should be a separate patch too.

Nth patch(es): Fix more warnings after building at least

	"allnoconfig" "defconfig" "allmodconfig" "allyesconfig"

for both 32-bit and 64-bit. A bunch of randconfigs on a big machine
would help a lot.

N + kth patch: Add -std=gnu11

X. Final patch: Add -Wall to compressed/Makefile.

In that order so that no warnings are seen when doing random builds.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
