Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADD623789
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiKIXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiKIXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3EE2E9D0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:34:42 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55AA91EC066B;
        Thu, 10 Nov 2022 00:34:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668036881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nUrkqfwst2gPF7A1qYXHvKbpu4a6Mwr08/hjTPPo2Uc=;
        b=QZ5yA9hW6wz71Mh/dDzG8hHrKfTPfg/mPFJ88It/yXHQmFJdTWvMWIWBkCqqF50L6lyw18
        xunYmBebtU0MACwEvvg+TK4sVG64+K/Fo65nUv5baPfK4tDRYB7+twYXxyIOby7ZsST/vY
        PdH+icLgZEixgXRVXFmkWsjhMMM6Gmo=
Date:   Thu, 10 Nov 2022 00:34:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [v2 03/13] x86/microcode/intel: Fix a hang if early loading
 microcode fails
Message-ID: <Y2w5DQLVBMCkMmTF@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-4-ashok.raj@intel.com>
 <Y2uODnpkSvQs/nbU@zn.tnic>
 <Y2vQRMyOndQtG/yJ@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2vQRMyOndQtG/yJ@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:07:32AM -0800, Ashok Raj wrote:
> - Take a microcode file from the distribution for a different fms that didn't
>   belong to the one you are testing.
> - You will have to fake the external header data and change it to the one
>   you want microcode match to work 
> - recompute all checksums and use that file instead of the original file.

This sounds like this cannot happen with officially released microcode -
only with something "hacked". If so, I'm not interested in such "fixes".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
