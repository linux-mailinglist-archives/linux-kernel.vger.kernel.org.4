Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E85F37C0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJCV3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJCV2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:28:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AAE205FC;
        Mon,  3 Oct 2022 14:20:08 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e751329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e751:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 38DD31EC04F0;
        Mon,  3 Oct 2022 23:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664832002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fbNSi/v14+901vFsAnl8/1DlUkDa+Lq06tjJP60k1+8=;
        b=LXjhsFt8EX9gCxNbzylgEg7Sg+OOriaw6t4GBWXfFxpNYKhaGBJyyTWzl/DsVMM/MdAU8p
        sizG0L3bjzoSVYtBnYMe2d0WscCeeDdobd57fDUcKz0rXLYxSAD6gSbjhOd+JJ89y4RjuO
        9c6jf+ItrZeRrLCY+HZOI0D4s+Zu3ew=
Date:   Mon, 3 Oct 2022 23:19:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: linux-next: Tree for Sep 30 (i386 non-SMP non-APIC w/
 IRQ_DOMAIN: build errors)
Message-ID: <YztR/qfmoFKND1ot@zn.tnic>
References: <20220930154710.548289-1-broonie@kernel.org>
 <bb1a7d75-521e-b578-f47f-e5bab652c2c7@infradead.org>
 <8635c4bw6i.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8635c4bw6i.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 07:26:29PM +0100, Marc Zyngier wrote:
> Can x86 practically deal with MSIs without the APIC? If not, we should
> instead find a way to forbid MSIs when APIC isn't selected. Or make
> APIC support mandatory.

Well, you need the local APIC in order to send MSIs, that's why
X86_LOCAL_APIC depends on PCI_MSI.

I'll have a look at that .config tomorrow.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
