Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFA69DD90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjBUKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjBUKJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:09:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40645B8E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:09:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FAD11EC04CC;
        Tue, 21 Feb 2023 11:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676974160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jmxwxQ1kZ55yZkvtYfwEj6OMScS2SXYuu3Eo2bePkoE=;
        b=P+DBGiaYCUgdj3qp/PZScXDbRfwUDti5yRNyYS3f/FA9GJ3YvXJx/sBs+lsPg+hkCqI2p2
        5i+3p0JA0r0rB9Nr0A4oPWFRh9i/yPU6F14qe55NvsXO+5rWYORpR97kTwgcN6vCsZ3wcA
        3Hljh1tyEVcZ/N9qh3UI9YDbPuQ+t1c=
Date:   Tue, 21 Feb 2023 11:09:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Message-ID: <Y/SYS+LiPVKit4PR@zn.tnic>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <Y/NUni00nDuURT1H@hirez.programming.kicks-ass.net>
 <fe5059317c4f3cabeb86c388d547504b9b6ea581.camel@intel.com>
 <87edqkosty.ffs@tglx>
 <Y/SIRmCE1KJdsRBT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/SIRmCE1KJdsRBT@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:00:54AM +0100, Peter Zijlstra wrote:
> We really should have added that CPUID uniformity sanity check a long
> while ago :-(

We're pretty much there:

c0dd9245aa9e ("x86/microcode: Check CPU capabilities after late microcode update correctly")

(in tip currently)

It would need to get extended to do it on each CPU during SMP boot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
