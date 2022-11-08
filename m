Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2A62202D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKHXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKHXOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:14:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340618365
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:14:05 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D97A1EC059D;
        Wed,  9 Nov 2022 00:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667949244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2akfgDAHmn0YAlkNJ5w3wimtY2hrP/AIDjYRvUv/NXQ=;
        b=JNSFOdMRPWY+MPOFKfWvTzdW6UomNUEqX5jEaPEsle/JsAMIoTLRp+mJIp8x5suju4w51/
        iR2f0q6Wr8gSt1lMG3c7OSM2wt6b4FSQ9nYvNN6sAxu0/oFUttf2IVUnkxwwfYZdp3yr07
        FhDO9BILAOmi/vYsZ8+APylgqkRXavk=
Date:   Wed, 9 Nov 2022 00:14:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <Babu.Moger@amd.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Move MSR defines into msr-index.h
Message-ID: <Y2riuwu6vfzA07ul@zn.tnic>
References: <20221106212923.20699-1-bp@alien8.de>
 <542c4313-3833-bcae-10ae-005084d96ea1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542c4313-3833-bcae-10ae-005084d96ea1@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:59:12PM -0800, Reinette Chatre wrote:
> Not an objection, just an observation: the above is a significant
> change for a patch with the x86/resctrl prefix.

Yeah, I felt it is a small-enough change not to warrant a separate
patch.

> Is it important to distinguish between Intel and AMD?

Yeah, look at the rest of that file.

> All but one (MSR_IA32_MBA_THRTL_BASE) of the register values
> under the "Intel" heading are also used by AMD.

This basically says that AMD is using Intel's MSRs. Which is fine.

I'll fix the multiple blank lines.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
