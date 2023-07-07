Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B5074AFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGGL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGGL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:28:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886CB1FF7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:28:23 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 80E071EC074B;
        Fri,  7 Jul 2023 13:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688729300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RRlup4QyTsde4l1+VASushGOKbU8RgrMnrqMoqeT6Ks=;
        b=VuWGwIkwKE8ounvZstqK3BGWjlvqvSA8JjvkDNch5ZsMi2NQRb0OmXKMpFfLs5/C977INH
        dLm1lUa0OklwJ9B52l0avsFu+yegQz74jkF8lWcAyaYfs8o6jHAirwov34kN9Wns68n9s7
        q8fFAYGWnMDWVYGMm7FxIV1OTP1sqBo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2RRpQ8H0RUX3; Fri,  7 Jul 2023 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688729297; bh=RRlup4QyTsde4l1+VASushGOKbU8RgrMnrqMoqeT6Ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNPputwVsLIAKZCKFfbfU2U4JBN+ty/W3nCrAH3rkWnTHb/jnvQx5PBD/cqgiOuqO
         NtUnvNcPNg4v/bTWw96VBvbHsoF3sYJCAySqc6ECI0g8NLPYwbPEr/k/5V4Kq1qFQj
         /hGvfTGZ+9RSEWqD74qN+ILMYAIfcdasYiCD5MnZruJA68S/fHfU4QY3EV3S+gL/Ps
         FvEEPCOQ/cq7SzButC1OJmZ9/v4R5+/qDbiOW8ZHTUlMTFhl5Uhrd48D7QmLc/DY08
         75r48ef4bLAnXQTbZ2zvwWovrrJRJ25fv1WEjjv81bdkFri+MlxOFAUC4tKR5XW8XY
         09Z7MPoNUOUZxZm3F0l9/msI8kQAi20MHTrRWFd3epLySyecoBOL6GIQThwKDZtfpm
         BPo5eTwduqvJvnPdrM3y19jSjSNH7LmXL6QHIpAR4fKNtxOxijt4/8dVKtTY+zfWm1
         ivD3Gb6DlPI66odXcM54zhnkxMQG04NR8ts4eSJHGuKmFTBqkrRYPISMJbbjl9xoJ5
         /zRja6ItNZaV9nCzFab2TN3hdtrHwtmVp6C17JHltDdS/eNoCib4APcxOPCTeNneBB
         sHBgv83I3CqKtbM+kfYWDBVncHd3CL852uNkPw7Yg94jdFijzYgKO+WajOmOhm3e8S
         AVfVoG4OO8OoyPrBLHq8sEZo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89C9240E0140;
        Fri,  7 Jul 2023 11:28:10 +0000 (UTC)
Date:   Fri, 7 Jul 2023 13:28:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpu: Add support for modern x86-64-v* march
Message-ID: <20230707112805.GCZKf2xdf2kMJ/S1DU@fat_crate.local>
References: <20230707105601.133221-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707105601.133221-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 11:56:00AM +0100, Dimitri John Ledkov wrote:
> Add support for setting march to x86-64-v2, x86-64-v3, x86-64-v4 with
> tuning set to an early family of CPUs that support such instruction
> levels. By default gcc sets generic tuning for x86-64-v*, which is
> suboptimal for all brands of CPUs with such instruction set support.

Prove that it is suboptimal for the kernel. Numbers please.

And even if it shows on *some* uarch:

* we need a *single* setting for distro kernels - i.e.,
CONFIG_GENERIC_CPU and compilers do make sure that -mtune=generic does
the most optimal code generation for all uarches

* our Kconfig option set is abysmal so don't need any more if useless.

Yeah, a patch like that keeps popping up on a regular basis but no,
thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
