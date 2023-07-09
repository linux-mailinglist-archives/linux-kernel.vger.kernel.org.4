Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CBD74C061
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGICU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 22:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGICU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:20:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DAE4A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 19:20:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qz9pC6VhCzBJBgF
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:20:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688869219; x=1691461220; bh=OMj0mD7w63Eoj+ZmWte4KNF80np
        SnitFI2YY/qJPBFQ=; b=pZAr6KA98kD3UI8C3vRPP1Ky+uXrXCdHtWSGquofO5u
        jqoR1d6zHyC97uroeWQf11+AmtBTjKNFXOjyHX6Bqhi44PgYXk1ShOM6b9H2G9L4
        XsN7f6kIMPSZSCS4Z2/7ZF5fIcXq3SwFmWmEjSDFjaOu1qjwWmFNtSImgti3VvcB
        ffGiUY3DquKVgW754D+ZqEoHgsTD7QXav6iodYCcqpQWRJEfKmyWmWsjOt0hQuqP
        AhcQ/zX36YegcVe6eydP9EeX8Y4JHChhqKK4RaccgVvReKG5Z/kw/xjLZNhEov4d
        QM9cKKvLebvH8Uvx77trN3JF8Z1tvcj7ajYnf40DyDw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rXkZJqPm_KwN for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 10:20:19 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qz9pB4gcNzBHXR1;
        Sun,  9 Jul 2023 10:20:18 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 10:20:18 +0800
From:   xuanzhenggang001@208suo.com
To:     ardb@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, andy@infradead.org
Subject: [PATCH] efi: x86: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <tencent_513E2ED35A17B9569C91CF75664724C7620A@qq.com>
References: <tencent_513E2ED35A17B9569C91CF75664724C7620A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d60c850cbfa5a25fcf97eef724f5b701@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch warning:
arch/x86/platform/efi/efi_64.c:109: WARNING: Prefer 'unsigned int' to 
bare use of 'unsigned'
arch/x86/platform/efi/efi_64.c:177: WARNING: Prefer 'unsigned int' to 
bare use of 'unsigned'
arch/x86/platform/efi/efi_64.c:182: WARNING: Prefer 'unsigned int' to 
bare use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/x86/platform/efi/efi_64.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c 
b/arch/x86/platform/efi/efi_64.c
index 232acf418cfb..0f69bd6eb144 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -106,7 +106,7 @@ int __init efi_alloc_page_tables(void)
   */
  void efi_sync_low_kernel_mappings(void)
  {
-    unsigned num_entries;
+    unsigned int num_entries;
      pgd_t *pgd_k, *pgd_efi;
      p4d_t *p4d_k, *p4d_efi;
      pud_t *pud_k, *pud_efi;
@@ -174,12 +174,12 @@ virt_to_phys_or_null_size(void *va, unsigned long 
size)
  #define virt_to_phys_or_null(addr)                \
      virt_to_phys_or_null_size((addr), sizeof(*(addr)))

-int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned 
num_pages)
+int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned int 
num_pages)
  {
      extern const u8 __efi64_thunk_ret_tramp[];
      unsigned long pfn, text, pf, rodata, tramp;
      struct page *page;
-    unsigned npages;
+    unsigned int npages;
      pgd_t *pgd = efi_mm.pgd;

      /*
