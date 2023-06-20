Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E17366E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFTJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFTJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:02:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB21704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:02:19 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40DA1EC053F;
        Tue, 20 Jun 2023 11:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687251737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U/ITu7YSBRctWJGSVeKDZyTULBBGK/OSgHccOIhuCi0=;
        b=LEF1gwjFJliekBj/PpKzaaNK7nGSZP2G9LzyKvmZNE/xPglNi+zxBnNeJylranKivbyNAd
        r6P3D0k9aZgXUXe+NJih2VCFLvtF6xVK/ln9dOsPW/dGVqpxY3lIDxmVDihCjv0Ul+HuBg
        OjjYPPscA/Kea1VEOVxjuPfQV+wUnfY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T8d_W3I9tU3Z; Tue, 20 Jun 2023 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687251733; bh=U/ITu7YSBRctWJGSVeKDZyTULBBGK/OSgHccOIhuCi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxQ/0/Om61a2NxeH6rIadScSm/mp0GaLR9hPzGkxFuibtIjZrLg67XYR/fQaiBHok
         mU8w1vGVmgYPjnqcAnr6FsyEu1lw3wEA044cGTsweb9fHf8EDhlGjVm3sFNQM4FSb6
         rz69IN1YFARkJCNdpUfyBW7PbK0YPjoe4woEoz6ZbmJao1tMdBdYO2uimKdyqx0Siz
         feRA6onic/ET4q+3nSeMlnNMdRz0wJ1yy4QHn5CnUfPxuMJDjyBP/Wqfi7EM/gZW2c
         pLFfOv7zXiJZ+xUeD6Df8j1Qd3HrLEBKPe/zRqV4Q9JrAoidByXeTU1CBea5iiEWld
         PxFckMfLQJ4s1s5KT0KO8DNzMJB2g+6L4ydlDaCUtPbReRG/gfcjDriY6HS9oUwVlB
         5gaGgF2PWysQhP9iMGDQY9pOoLTNGarySHG74OzDzWd86smPtOIhJEOoEpWY6UuHk+
         AsZ3tIyP1uJ3SXRDtNTrOtzniNKmnmgdFgqSdVC7dHDexMSM/NJtwNmGLYY6i68N5B
         i9rItiF1Ix+dVf9tJKcE2ezRbucXpF9ygnBKGLVwuN7YyERiwbBkDkBofc+RS3cI/Y
         JezLJDTyNP11UUJs8eq46UDvllqnONKCII2hs3iYpXWPJ1p7cKTQangfkOKDyNPqXe
         j6OmbS1vKvvNQtHgxfF0dBto=
Received: from zn.tnic (p200300ea971dC5b2329c23fFFEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C19CF40E019B;
        Tue, 20 Jun 2023 09:02:02 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:01:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 4/7] x86/smp: Use dedicated cache-line for
 mwait_play_dead()
Message-ID: <20230620090157.GVZJFrBYuN/Wr/9N9L@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.434553750@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.434553750@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:33:55PM +0200, Thomas Gleixner wrote:
> Monitoring idletask::thread_info::flags in mwait_play_dead() has been an
> obvious choice as all what is needed is a cache line which is not written
> by other CPUs.
> 
> But there is a use case where a "dead" CPU needs to be brought out of that
> mwait(): kexec().

s/mwait()/wait state/

I guess.

> The CPU needs to be brought out of mwait before kexec() as kexec() can

Ditto.

> overwrite text, pagetables, stacks and the monitored cacheline of the
> original kernel.

Yikes.

> The latter causes mwait to resume execution which
> obviously causes havoc on the kexec kernel which results usually in triple
> faults.

This sounds like a stable fix, no?

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
