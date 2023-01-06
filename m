Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A9660776
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjAFTyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjAFTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:54:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B081C0E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:54:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B51D1EC02DD;
        Fri,  6 Jan 2023 20:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673034875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bKpAdPgTL21cbanMLYLlA5RfwXZkWPUpv1AYeuHcLg8=;
        b=jSuN6uypI+FCtzlGpUGFx3jch2qypucZZVQgRvQstpIvpiR6HlNtKl/gagLWIDwDy3ISp+
        WDdSkj0YsU57+jZdTOHe0pHRhwYQgnNxMpz/eWwajpEFv7Xmvzus5v7xHxR/eZHMOC+61x
        dR4isTtZBa2HXAW0u03DQqBh/qEKbN0=
Date:   Fri, 6 Jan 2023 20:54:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/6] x86/microcode: Display revisions only when update
 is successful
Message-ID: <Y7h8dpIQHnL93RdC@zn.tnic>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-4-ashok.raj@intel.com>
 <Y7XMtWqSrs0uGkD7@zn.tnic>
 <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7h5qD43kdPeEgQ7@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 11:42:32AM -0800, Ashok Raj wrote:
> > 9bd681251b7c ("x86/microcode: Announce reload operation's completion")
> 
> Thanks.. yes I can add when I resent the series.

No, you should read the commit message:

"issue a single line to dmesg after the reload ... to let the user know that a
reload has at least been attempted."

and drop your patch.

We issue that line unconditionally to give feedback to the user that the attempt
was actually tried. Otherwise, you don't get any feedback and you wonder whether
it is doing anything.

The prev and next revision:

	"microcode revision: 0x%x -> 0x%x\n",

will tell you whether something got loaded or not.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
