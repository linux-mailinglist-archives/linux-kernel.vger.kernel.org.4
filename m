Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14A773F35A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjF0E1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjF0E1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:27:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7826B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 21:25:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD0F31EC0554;
        Tue, 27 Jun 2023 06:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687839953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hzDVdBhdNys9pV6QiY3Z0uMvbAzfRm6oKSslDQ0e7Mc=;
        b=GCU6YkEOCJNSp2oHaPrbo6/w+0hsKigI/5FW+gVfm6/dYh4ef2X6o4LOxVuJRbOhHm+hj9
        GKbLZC/SAhdWlKkLz26NLL6Sn9rKm1q9s0DZnmsbYlG7btABC800dXN4ci6qfeM0svBJkT
        +VahkM1vvOgnps0zF9DmWOMkcS+5stk=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7tJN9Fz33MtY; Tue, 27 Jun 2023 04:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687839950; bh=hzDVdBhdNys9pV6QiY3Z0uMvbAzfRm6oKSslDQ0e7Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLcfP7CQeIxQIuEUi0OCZJRLCj/bNkYgHjLQ4mlRMwxrA8jbJOTxcLIBbuaBLULP0
         M6nJ6PQ4cG+pYXa0ghxAZYSZEbZPBx4nq2AtaurrRtikIYWxFiDW4ylcsfr8PUaFDA
         Axl2tnpYbuEBE71NyJhVY8qpSCzfK6uaHv7EoZmlM9ui0nr6Z7uBzoqToA2+UaL3QB
         3vCRQZvW4+yK1Vm1lCGN+krxBTIeFBgcm4bKEBq+9bvsESplbjzX5mNR4Sd+HgweiK
         LLbYL8o+W6P1Jz9SIwHEuQ9ATckNuHC8cH8pDbIgA06MGngzEzO32V36RFu3CZvnDv
         e7+kiTmZpHr3DamNClagPmLVtj/T6cdU7v4J+HPEMrXZNfxuCELSLuzolZB3bkcZ+E
         kfB/v7mrXlzDY0UayZKuxyIUWBGUlJSnoFh3ZZily+bPRNEvvm3zXtq+JtL14GLQPB
         uJG4ELGwqeKe/EL15NgjsyL+bwx6w23smpRyGEIbQq5ZWaVxpTHA5z2Nh9+JHVdt70
         oJY4phPnWsAZprAA5SXzpWP7f/KuLaktZmtbnl1s8Cu2fSm1NaMhj2TXEM5vhSq4vJ
         ZCKCpqNGMCFalAcEG8gX0c/KSEBovl9Mkdf4//JQIyRPWEir/MHB935/V4luWw2nMm
         fXZgUoR4YrW1RMWUfaMvQo8E=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC23640E0033;
        Tue, 27 Jun 2023 04:25:42 +0000 (UTC)
Date:   Tue, 27 Jun 2023 06:25:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug report] __arch_hweight32/64 x86
Message-ID: <20230627042538.GAZJpkwldpkqTKeeDL@fat_crate.local>
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
 <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
 <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
 <02b36386-a18c-8bfb-2c70-c398f6fc964b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02b36386-a18c-8bfb-2c70-c398f6fc964b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 03:41:27PM -0700, Dave Hansen wrote:
> I'm not even sure that UML needs GENERIC_HWEIGHT.  From a quick glance,
> it looks like x86 used to use GENERIC_HWEIGHT, but got arch-specific
> versions later.  UML just never moved over to the arch-specific versions.

Thanks - that could very well be the explanation.

That bug report made me blink a couple of times since I did take extra
precaution to not clobber regs in arch/x86/lib/hweight.S as this was
part of the whole pain back then with calling a function from asm where
gcc doesn't even know we're calling a function, see:

f5967101e9de ("x86/hweight: Get rid of the special calling convention")

> I _think_ the attached patch might just fix the problems with the C
> version and bring the x86/UML implementation back in line with the rest
> of x86.
> 
> Thoughts?

> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 186f13268401..76d507860be4 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -44,6 +44,3 @@ config ARCH_HAS_SC_SIGNALS
>  
>  config ARCH_REUSE_HOST_VSYSCALL_AREA
>  	def_bool !64BIT
> -
> -config GENERIC_HWEIGHT
> -	def_bool y

Yeah, we should do it. UML should not do anything different wrt calling
conventions so it should be able to handle the arch/x86/lib/hweight.S
versions just fine.

Richi?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
