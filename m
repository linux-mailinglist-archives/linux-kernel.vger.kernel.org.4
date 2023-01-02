Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C365B4E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjABQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbjABQLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:11:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F468264
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:10:47 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C46F11EC02FE;
        Mon,  2 Jan 2023 17:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672675843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w2HAVeUqIiOdbOEe58MHN4/7+KIBUrRgvfO2mBJX/Ag=;
        b=SBNb5I1B3PPDGn7iQG2GPiXjMdZX7uY699zBnypABvN5/uSZcFfRDCJ4h1gek0RcHrdBzp
        oKctWRuqTFlwhhTl9x4wLbf1aizLJr7eHGd0FlOIWv0MksMFnpxJXggEwQzI0cyy4gMgpY
        KUfAXEoE1VBG5LPeIoxdAZ3e1JIryrI=
Date:   Mon, 2 Jan 2023 17:10:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v9 0/4] Add throttling detection to sev-guest
Message-ID: <Y7MB/kEHlsaAeAJM@zn.tnic>
References: <20221207010210.2563293-1-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207010210.2563293-1-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 07, 2022 at 01:02:06AM +0000, Dionna Glaze wrote:
> Dionna Glaze (3):
>   x86/sev: Change snp_guest_issue_request's fw_err
>   virt: sev-guest: Remove err in handle_guest_request
>   virt: sev-guest: interpret VMM errors from guest request
> 
> Peter Gonda (1):
>   crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

can you please rebase those ontop of 6.2-rc2?

They conflict with Peter's IV reuse patch which is already upstream.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
