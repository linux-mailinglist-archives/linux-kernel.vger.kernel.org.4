Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3459372FB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbjFNKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjFNKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:41:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621A2682;
        Wed, 14 Jun 2023 03:40:39 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D3B11EC072D;
        Wed, 14 Jun 2023 12:40:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686739238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l0wmUCOq08ocL9JWwuGeMkrv5XjoGiMDJp61EtBoHWU=;
        b=NtiUaYGB5+TIiR6764dKlyutinr0Ii2WHv1k1ezwxrjjQluavlkSikEJFCBE29+y/6mRd/
        9MUSBX1BWV2MDxyCbr2QzRorpbH40VaUbn3P++FsWlkUli8gdX+1wB1IMooeSaZUIQ00QY
        2Z4CIiA4TBNTNbI3FVrl+xBfD2lz8oY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pj0lafQrEqVp; Wed, 14 Jun 2023 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686739234; bh=l0wmUCOq08ocL9JWwuGeMkrv5XjoGiMDJp61EtBoHWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/bfHtEPP8YIugFtqP+tN7LuSStGm8cFiUrHxVXMD7P3bgirpEEolWPDL+G5Du0Ye
         oES6q+UTrgVC0XsCPnhHAnXrgeI74hSaa4liUMaygb/Qe6T0A1WExfifcs6O/SI6Hy
         UMJ7Ylo8gXm87tXLFG1dJLNFsdrX59AjRaa1KiXyl87SWoSzBeagPRa2apwt2nEakO
         e9VbO5ef2lKwu/7Bl6wRfn5UcrR3L58Vyjjqim1KInTv2VbqErVoEhQrLfTpdXcONy
         i8l0xguR7a/APu4Q5wiNXeUs1DhYdGfZpibapg0j34EWnXTfHRkimUnz2uqO5nbl1n
         WrKGDg1wRNEi6YV9N8ASx3Jkh1GEBSm3Iy47Rtq0mzqtK9wFgejzMmuWsq5rLDTnbu
         k476FnlY9Q03tTWlcNR0mwL0cltiNK+WzxryIwdyhXz79/U59j+aXRPE3226LH7nuR
         mPBd/hcumKwgUIW/y7r34xKEyDlXo1cCJDvrLyXetKh9urHMjgm/wmTfrBwkAQeXa7
         NV1zEAOAmoRv1ihD7AGnEoHuTT3zFe1Rlmdp4JaQPZMj9XyEbY87bxlzuUTxP4/HDP
         xLdf/AJlIV1769l55vJl2dl/9HW3PNJkuIUZVr1tn/7QIJCewdotxWz7PITPBacB/8
         mrNBtZfDh3ofu7rt5wUXClHo=
Received: from zn.tnic (p200300ea971dC5f7329c23ffFea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f7:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 511F740E018C;
        Wed, 14 Jun 2023 10:40:02 +0000 (UTC)
Date:   Wed, 14 Jun 2023 12:39:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [patch 02/17] x86/cpu: Switch to arch_cpu_finalize_init()
Message-ID: <20230614103955.GAZImY+6VF9oezn22m@fat_crate.local>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.019583869@linutronix.de>
 <87legm8j4h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87legm8j4h.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:53:50AM +0200, Thomas Gleixner wrote:
> That's the wrong order. mitigations must come before the smt
> update. Thanks to Boris for spotting it.

Right, with that fixed the ordering looks good now.

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
