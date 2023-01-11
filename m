Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38E665DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAKOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjAKObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:31:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C144C09
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:27:48 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B54721EC06C1;
        Wed, 11 Jan 2023 15:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673447264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Di+KUJ7ZMrDlRJJhrGMkpE3V2Jj2gvLaFGYLJfY64Jk=;
        b=Soax5AImlZpuQBH4vtoF2RcL+POpZom07s4VTJz3gP0IrHwhXw6gl14ETcF5J30uhWqop5
        5sTXDfn5wjNvm8zrHf58HCZx/vm6yTUYUmr8+5Vj8n/ZB8/9seG6pDXOGRUY6Gqti2dnn4
        U1XaWcu/Ka/5BDwFu2eIOZtjSPY3D48=
Date:   Wed, 11 Jan 2023 15:27:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com, chang.seok.bae@intel.com,
        jgross@suse.com
Subject: Re: [PATCH v5 1/5] x86/cpufeature: add the cpu feature bit for LKGS
Message-ID: <Y77HW/vBIv2BWJ8A@zn.tnic>
References: <20221128164028.4570-1-xin3.li@intel.com>
 <20221128164028.4570-2-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128164028.4570-2-xin3.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:40:24AM -0800, Xin Li wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Add the CPU feature bit for LKGS (Load "Kernel" GS).
> 
> LKGS instruction is introduced with Intel FRED (flexible return and
> event delivery) specificaton

Unknown word [specificaton] in commit message.
Suggestions: ['specification',

Please use a spellchecker for your commit messages.

> https://cdrdv2.intel.com/v1/dl/getContent/678938.

This URL is most likely going to be unstable.

Write instead

"Search for the latest spec in most search engines by doing:

site:intel.com FRED (flexible return and event delivery) specification"

Google etc has indexed it already so it should always pull out the newest
revision.

$ test-apply.sh /tmp/01-x86-cpufeature-add_the_cpu_feature_bit_for_lkgs-new.patch
checking file arch/x86/include/asm/cpufeatures.h
Hunk #1 FAILED at 311.
1 out of 1 hunk FAILED
checking file tools/arch/x86/include/asm/cpufeatures.h
Hunk #1 FAILED at 308.
1 out of 1 hunk FAILED
Apply? (y/n)

I guess you'd need to refresh the patchset against latest tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
