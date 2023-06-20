Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4525173693F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFTK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFTK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:28:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D8E3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:28:04 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07E251EC0102;
        Tue, 20 Jun 2023 12:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687256883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WMa0LnZkBXxQNKLeNhC+gz8cv2VqKSrh+yg6hYUFUg4=;
        b=R4tJpPbdCVN266Ied84fmoxaVwu2bOc3Fg+zYwLowQF3GKJ6quoOG3idOsk4tKK6u7MbcT
        +aC9SkS+quy0BWEhS8uKRjzQ/dy58fJee6DBwE1rdSewgRaAtNoCxJzRBIs9YtSSDTYntu
        PxDFi+cVxs2GTD2o+Qd/lweMNdZd+4c=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hgt8RgwxcCut; Tue, 20 Jun 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687256880; bh=WMa0LnZkBXxQNKLeNhC+gz8cv2VqKSrh+yg6hYUFUg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUxofOom2X1lPZ8WiaT/q/i7IRU+MaXmxb8AS2/ZQYfgr2aEw6Y5Mkhfrab1vKQIr
         iRaS54eFjBR6BNkZb+PN9OahsfSTgJFyuFm37szS+ojvs/QpEBqm1FyiRWtBaklTsF
         V5aQUQewmQTg9+lGGPdc7u1RTsz4V1W6KZkMF1qdVBMxB8doeXonFw1BoonB7yPv9r
         fKCdui2Vvf/hRnr5VJhb5k7Ii4GBfecRYerf2XMctM9nu7mZgyGj8xXgTqJCaWBNnh
         4StDdN+Wl+lgEwJ3FxYeJPm2vpE1TYIO0eFU7gZUNKMVlEd7kUERH9pmQurozBkzgh
         zyBd90NrHSpHEiAOn0jIsx2+kX/mMed8qH2ZwotEt72rBlygnjhKm4cgV3Hamvu4fG
         GCBseTVY1jpc6ZNLQt4rAtsAFkc+kg0L4Gjj0Bithj4FwNYrHs0qwHBs+YvasGl/ya
         1/8LOAEPHjj3LuMU5IXLzG3CFQyr2fTORoLrb3Ymi24MEpcM0WfKcYMQj4EH/rFc8/
         XMdsX19tjUMmJNtuPFCDtWisU+1kxYAaEWNF2cSUuwdkJiPEGq2C3vKSmjtjtyqd0l
         UCO7Nuo9pX2Uskb9mUDQpz+m6bd3s8hOd4eksr2l7nXVroNAfMUUN+z7IqicngDp2j
         XK7Yqw6ePzOqCHoi8WjuL+AU=
Received: from zn.tnic (p200300Ea971dc5B2329c23FffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18B7740E01DE;
        Tue, 20 Jun 2023 10:27:49 +0000 (UTC)
Date:   Tue, 20 Jun 2023 12:27:43 +0200
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
Subject: Re: [patch v3 7/7] x86/smp: Put CPUs into INIT on shutdown if
 possible
Message-ID: <20230620102743.GYZJF/H4R1tYmsR/r6@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.608657211@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.608657211@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:34:00PM +0200, Thomas Gleixner wrote:
> @@ -202,7 +206,27 @@ static void native_stop_other_cpus(int w
>  			udelay(1);
>  	}
>  
> -	/* if the REBOOT_VECTOR didn't work, try with the NMI */
> +	/*
> +	 * Park all other CPUs in INIT including "offline" CPUs, if
> +	 * possible. That's a safe place where they can't resume execution
> +	 * of HLT and then execute the HLT loop from overwritten text or
> +	 * page tables.
> +	 *
> +	 * The only downside is a broadcast MCE, but up to the point where
> +	 * the kexec() kernel brought all APs online again an MCE will just
> +	 * make HLT resume and handle the MCE. The machine crashs and burns

"crashes"

With that

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
