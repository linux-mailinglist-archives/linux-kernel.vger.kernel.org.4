Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6387730635
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbjFNRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjFNRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:42:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8682110
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:42:04 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A421EC0758;
        Wed, 14 Jun 2023 19:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686764523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=3z3MKtktPipTbMT6FDWkS53LB65olic/LTA7JjPLGS4=;
        b=W1wHrjihlD6J5AGBhE3CMPJw71eldpg1oFRWgV9EbIRUDmwXzb4noEeC3iUzoFdTTZgU4E
        Mzg5stCWZxvBC3JVUciO6dlCpbxPn3mnkZA2HmTl/kEtBUr3dX4nh8uCssyGot4Oplx3jV
        r2AP/V0v1Tb+fKwk0YRMZlf/si3UnNc=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G3Qa-VRC4uQ0; Wed, 14 Jun 2023 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686764520; bh=PnUSMmI/UMKWMxp9iAR2+Lo0CSCvDctjlDJJNzAxRdE=;
        h=From:To:Cc:Subject:Date:From;
        b=inFYy5/84D3/T2SCKZlCOLXACW6YtXFTAZeTNNbMRHc7RaQUwjLgflOYxapmZMqZ7
         MVLu7kGhV4y0js6FSXvpRw9wK+IkP8J9V8mHZqx0Zvkd48uFfFmT1pn8/o6XLDkM00
         uAMA6cL98pknhsssh9H4e9dPp/0CIJqKNNt3ZtXnEVddGp7XIe7JYBYAW9f4eQ/++R
         K5mIGCcadluLJEc9P23QLkNkHuIN5iJT8NGuUmyDoTbz0xjTq4YXXj5+gzPGruMUHl
         qWjVeqS5+wU61rSJs8saTW/YZv/gPLzPxS7sB+G1y3hA2/xECwsAIS3de6eK6vsQ23
         CjdpSG7IyGewMaEJ2ipJVYs+B2TbirHVDBJi51VK7lEuI+dZu9ZWUcRNDWtOS3BHMH
         c8NACpAaBdpqPcLikQXCa2RBj6NhyBa+E7G+OiLAl3hQ8abUzbBOUWlCBUjJAhhZmS
         hlvXC0VRrgOPq6eLWWsk2u/MBHADrj21hVWe9Jpp9CipNMhDCSyhdUP1EWsFD1Div2
         izFwuPBvUxhZw1QIirWrQQu2lMb8r/1E0XGb/OYnEtl7jV5thmy2SI6uVBHytGTN8n
         kGd8C7QGKTOM5abeBn/dA4lEvrCXBNWD9omYTfU2Q1YJEyOMpNLal7lyrt7Bj8r24p
         CAmPXdVzUkXDt6oMKWocnIh8=
Received: from zn.tnic (p200300ea971dc522329c23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c522:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9562740E0185;
        Wed, 14 Jun 2023 17:41:57 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mm: Remove unused current_untag_mask()
Date:   Wed, 14 Jun 2023 19:41:48 +0200
Message-Id: <20230614174148.5439-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

e0bddc19ba95 ("x86/mm: Reduce untagged_addr() overhead for systems withou=
t LAM")

removed its only usage site so drop it.

Move the tlbstate_untag_mask up in the header and drop the ugly
ifdeffery as the unused declaration should be properly discarded.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/tlbflush.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbfl=
ush.h
index 75bfaa421030..80450e1d5385 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -14,6 +14,8 @@
 #include <asm/processor-flags.h>
 #include <asm/pgtable.h>
=20
+DECLARE_PER_CPU(u64, tlbstate_untag_mask);
+
 void __flush_tlb_all(void);
=20
 #define TLB_FLUSH_ALL	-1UL
@@ -54,15 +56,6 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
=20
-#ifdef CONFIG_ADDRESS_MASKING
-DECLARE_PER_CPU(u64, tlbstate_untag_mask);
-
-static inline u64 current_untag_mask(void)
-{
-	return this_cpu_read(tlbstate_untag_mask);
-}
-#endif
-
 #ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cac=
he
--=20
2.35.1

