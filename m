Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3898B6E2491
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDNNsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:48:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0D3E4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:48:30 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF7961EC06BA;
        Fri, 14 Apr 2023 15:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681480108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sblj0wVPJVRQ23wXdNXTYFU86hWrZ9q3dMtSwDNtMsw=;
        b=igDne3ueaDCtgYF1+edWobaeL21l4Kk0tJvECQ2n0xJnLApnWtmSluHI2/csM7z2SoaiiT
        9uPOA0pbz6iL7Th5203sxDw77FnqaWRECkespTFgSMyeuhLCSb+dFh8zScDQAYJVvlERcK
        hw0s0oXq89aTyB90KcFGt1rGDMGmx/I=
Date:   Fri, 14 Apr 2023 15:48:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, seanjc@google.com, pbonzini@redhat.com,
        kim.phillips@amd.com, babu.moger@amd.com,
        pawan.kumar.gupta@linux.intel.com, sandipan.das@amd.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support
 for Zhaoxin
Message-ID: <20230414134824.GCZDlZqDWLl6A958SF@fat_crate.local>
References: <20230414095334.8743-1-TonyWWang-oc@zhaoxin.com>
 <20230414104808.GBZDkvaJechZSM+SI9@fat_crate.local>
 <7866e99a-df88-14fa-92ae-c5b5d176724b@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7866e99a-df88-14fa-92ae-c5b5d176724b@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:14:17PM +0800, Tony W Wang-oc wrote:
>  The instructions about these flags can be executed at any privilege
> level. I think using these flags in kernel mode is a case. This patch
> shows the statement of these flags to the user mode explicitly. So users
> can see and use these CPU features conveniently.
> 
> > If you want to dump them on the hardware to know what's set or not,
> > there's tools/arch/x86/kcpuid/ for that.

See this here. We have this tool exactly for users who wanna see CPU
features. All CPU features, as a matter of fact.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
