Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88D736699
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjFTIsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFTIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:48:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C2C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:48:04 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D8C91EC0501;
        Tue, 20 Jun 2023 10:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687250882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hlqv2LjqdROM+DT2kM0Js7XAxGDJkCC+FDB9YEGz2M8=;
        b=YLeRxOSD0RF6GgVFp1ndc+nnD0QVHB/DETWCs4sz2X0tmKRCfXef39GRqKP+t2BWEoagOc
        uS6uCAJZC9q9WqDk/x9t0SlNtNL/d9sqYPjzETuCfCt2cRNczXN3enqzk8SCQ1Rdby45wW
        9rz7rmjgIya86aXr/EtUhyk1sBeC7LY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T7VLpobmf2_L; Tue, 20 Jun 2023 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687250880; bh=Hlqv2LjqdROM+DT2kM0Js7XAxGDJkCC+FDB9YEGz2M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpVlB2PlPQ6vw7Z19+vlYjtmyjvR+Lphhotdz3C6mVWeVY9NySRcNupwMclNDgzro
         t8c+mOXeMyjmdZyECQ3qZDQ9IDUaowetwFwOkoB4+Zv2YC+gkSe3OU+lGJqv5m/XkN
         vrwuFNyhQDLDKxQ0uvzLjSZZCg96Zxx92gA4Rg45Z3NBIBweOMZzBxK44mE543mgyY
         nyyaFztQ/iW0ZdLWq5l+lQHHoeMDLUpF52x+4MK6WWD1shi2d6c2uq8+a00GKbBXa9
         nOaXqxe+esAGhFRCps+zD6xJC8Uglajf+abO0HuPlx5nmv7Kc8yI2iCV7LzDqPMJSh
         MWfZwqj3jCV/eHnwrs+MGcJJl8APPrY314mvWj2V66wU7O1rKwOuj5gDHA2UGJ2f52
         9hmXVtoPs/U8ILMP4UjnoZY6tPJ+aIuQ7ktw0gvvO7Rnqn/yhZI7d/B9tN1pSbWwD+
         rdlSygi0TxNV08nswZR7szV4Xo+upBv8B4efxMPm9HU24htSnclGFIfZ68iLSUQAmK
         nNptW3Eg1KtvCsDWfSZDs5U7CpnY0Z9l2hk3BqE9yI0auCIkVKfStdZbb7D5X2nfFk
         OeWVHihEOZfpHvNYF6MJ/vQFAhatnGfM/qHzpnUgz5ysWXUjCJkOZHB5I9QKR0htPy
         naUx2CBjksNDxaOprhKodkTE=
Received: from zn.tnic (p200300Ea971Dc5b2329c23FfFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BE5A40E0034;
        Tue, 20 Jun 2023 08:47:50 +0000 (UTC)
Date:   Tue, 20 Jun 2023 10:47:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch v3 3/7] x86/smp: Remove pointless wmb()s from
 native_stop_other_cpus()
Message-ID: <20230620084744.GUZJFnsClkvsGQmnRs@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.378358382@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.378358382@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:33:54PM +0200, Thomas Gleixner wrote:
> The wmb()s before sending the IPIs are not synchronizing anything.
> 
> If at all then the apic IPI functions have to provide or act as appropriate
> barriers.
> 
> Remove these cargo cult barriers which have no explanation of what they are
> synchronizing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Remove second instance and reword changelog - PeterZ
> ---
>  arch/x86/kernel/smp.c |    6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
