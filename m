Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E272738EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFUS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjFUS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:28:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9E1BFA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:28:05 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCDBE1EC05B8;
        Wed, 21 Jun 2023 20:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687372045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BABzfnxcpHaZ+PKnsfZgCNq/PGoS4hweuRO7XPBxZ00=;
        b=hCiutqVVvjj4Wj+098nbZ26dZ1Be9pLZouGPNU4PPTNOahe/g4ZdqHHZNLXN674WYVOfXe
        QCwA/leqhSB6icZNgQDExuvPp+ZbQzkafjNoQep2Z1cICTdAzsfZR8jWWHqNusjUnM6crv
        Hg+6WKrAy8jSQaoc06P7JCxeOEhLeDY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K9_-tdCl-d2P; Wed, 21 Jun 2023 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687372040; bh=BABzfnxcpHaZ+PKnsfZgCNq/PGoS4hweuRO7XPBxZ00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSYgQbT0By3fFjISNksucj4s1QKcWK14O5jR8Csr9tIgkE7SlvXosE22RCUZ+Mh3r
         dRkA9FgmUSN1mZMJiSC2ZyazIViEHhhnmtRhh2XvCCtoTP+b7+7oYedmpMZTKhX2UM
         88sSuDwsTLz9TNVv50b7s0j20fTFh8Cr1BEvz8ViGi8KY1OobUt2albFNZJXuKxkpK
         q19cwr27qiK+AaiX1mOLtJunx/lyq+J3JJKkeuwfV6Z42QwW0+rJz1ijywotGa6CpD
         nMSBVmlaXVfrcDsRs7Px3jIc+wbT/pcVNlF2SJ/gwmCcoZkuR6PwQ+13d0CHXyWnqU
         K7j3jS6JCQZp6Aa/EmkJnw4rXFRJnFT7DHNDPZYEXTOGsBmoY8G5Et/OLGQ4Xt313Y
         4pXk17wJRtOdcJQAcyUU9aaO/XtIeR0xg9UDCVI5FMwyOrYIeo88FLfYhDCUgKRroR
         RRH20WQ2t8VBKVHREgRVigDIrVjpvG1ANtPykaGnNTtL0+KgC+BYwRbk3X1P/nw8Tf
         wUWkELiLD8Yo0Ut3g3Xs+cr0TklKt0NduVwIsBLb82NfXQ+B/aGJM5lyy1XVIRnSHW
         E3H+urIp71kBXvHLiJlglUQBW8ZnmS0pPY3hhPDJmh//mzIau/8uA7SHUtISy6eIVD
         9uIr6AjH8S11sqGuQ2kN3X4c=
Received: from zn.tnic (p200300ea971dc565329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c565:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8D4A40E019B;
        Wed, 21 Jun 2023 18:27:15 +0000 (UTC)
Date:   Wed, 21 Jun 2023 20:27:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        jslaby@suse.cz
Subject: Re: [PATCH v3 1/5] x86: Make IA32_EMULATION boot time configurable
Message-ID: <20230621182710.GOZJNA/q4w1yniKeCr@fat_crate.local>
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-2-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616125730.1164989-2-nik.borisov@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:57:26PM +0300, Nikolay Borisov wrote:
> Distributions would like to reduce their attack surface as much as
> possible but at the same time they'd want to retain flexibility to cater
> to a variety of legacy software. One such avenue where a balance has to
> be struck is in supporting 32bit syscalls/processes on 64bit kernels. Ideally
> it should be possible for the distribution to set their own policy and
> give users the ability to override those policies as appropriate.
> 
> In order to support this usecase, introduce
> CONFIG_IA32_EMULATION_DEFAULT_DISABLED compile time option, which
> controls whether 32bit processes/syscalls should be allowed or not. This
> allows distributions to set their preferred default behavior in their
> kernel configs.
> 
> On the other hand, in order to allow users to override the distro's
> policy, introduce the 'ia32_mode' parameter which allows overriding
> CONFIG_IA32_EMULATION_DEFAULT_DISABLED state at boot time.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  arch/x86/Kconfig                                |  9 +++++++++
>  arch/x86/entry/common.c                         | 16 ++++++++++++++++
>  arch/x86/include/asm/ia32.h                     | 16 +++++++++++++++-
>  4 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..59b1e86ecd9d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1865,6 +1865,11 @@
>  			 0 -- machine default
>  			 1 -- force brightness inversion
>  
> +	ia32_mode=		[X86-64]
> +			Format: ia32_mode=disabled, ia32_mode=enabled

ia32_mode=(on|off)

is less typing. Especially if you're standing somewhere in a server room
and trying to type on some weird keyboard which always has the wrong
layout.

:-)

> +			Allows overriding the compile-time state of
> +			IA32_EMULATION_DEFAULT_DISABLED at boot time

Just say what "=on" and "=off" does here - loading of 32-bit programs
and 32-bit syscalls is enabled/disabled.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
