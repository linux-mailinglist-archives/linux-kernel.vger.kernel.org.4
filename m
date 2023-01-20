Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3C675411
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjATMED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjATMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:04:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F224EA24A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:03:59 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04E8F1EC04DA;
        Fri, 20 Jan 2023 13:03:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674216238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NPuCDXoWvAfmaixMXK9PMI9F3RemfhjCA13Vh2G+67U=;
        b=NkNb8TtxRuJA+KMsERhwZIvS52uLSTKQYVdlvpN12v3pray+8HatBkBv0hR9KskJbw5Obs
        H+eHKYemms2mxPPOGJIo4NMXcCbauqBhFUG+V+kdyrIdzEiYcLknMvqhrqYLR/hkrkCLic
        Oh/hHkMXCo+DCv8PuH5H7dFxQI/Otfo=
Date:   Fri, 20 Jan 2023 13:03:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>, mpohlack@amazon.de
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8qDLYylWCkHveTw@zn.tnic>
References: <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
 <IA1PR11MB6076660471E9C688E79A2B20FCC69@IA1PR11MB6076.namprd11.prod.outlook.com>
 <Y8mFBbWmpGvZy9dB@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8mFBbWmpGvZy9dB@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:59:33AM -0800, Ashok Raj wrote:
> Would you recommend resubmitting a new set with the fixes for the interim
> patch compile failures (for 32bit) and drop this last patch?

Sure.

> If you have any other comments would be great to hear now before I repost a
> new series to capture everything that's need to be addressed.

No, no more comments.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
