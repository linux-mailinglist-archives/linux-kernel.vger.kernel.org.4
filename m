Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF5656E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiL0Tuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiL0Tuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:50:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5401A5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:50:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6DFE1EC050B;
        Tue, 27 Dec 2022 20:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672170630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V55Wh/03piRj+6m7ozsxHCv7rxip8aBdR5NiSD+/LnM=;
        b=A2fp2dKq7Ch9GWPkkYo+CVxuvTUb61iJrE9fio8MzAhQvQXBPP3RD72IkU/NnLCoS7eIVQ
        tHjawYX4PcDsVVCFc8TIA0clnnmkyddqO2rVz6fcNyH4DOdZ3ldblBWXU+6FGDAkQapE3B
        EEpgkK10T60ojCVd9wqc1uWMqB3T5Ig=
Date:   Tue, 27 Dec 2022 20:50:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 1/6] x86/microcode/core: Move microcode_check() to
 cpu/microcode/core.c
Message-ID: <Y6tMgcU2aGbx/6yt@zn.tnic>
References: <20221227192340.8358-1-ashok.raj@intel.com>
 <20221227192340.8358-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221227192340.8358-2-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 11:23:35AM -0800, Ashok Raj wrote:
> microcode_check() is only called from microcode/core.c. Move it and make
> it static to prepare for upcoming fix for false negative when checking CPU
> features after a microcode update. Also move get_cpu_cap() to processor.h
> for general use outside of arch/x86/kernel/cpu/cpu.h

I thought we agreed not to do this:

https://lore.kernel.org/r/Y44bbZMMf8I6Lzl/@zn.tnic

Or was this a misunderstanding?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
