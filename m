Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1663233D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKUNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKUNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:14:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B8F1E3CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:14:49 -0800 (PST)
Received: from zn.tnic (p200300ea9733e725329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e725:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D6941EC053F;
        Mon, 21 Nov 2022 14:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669036487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MFdaqDAmTRkVcvyaAEXoPjrpdN5tXQFNi8Ir9CyZf3o=;
        b=GD9R37zu8EngY+977wQxDiI+qsfiRL/KtesNHix0eFZsf9Y7ziIflsn1hyvXTCFgtd+0qq
        94QhsJDsvyZvSKu1hGXIK6TfKVYOaQY/fgwPM9BfKLmIi4tVi8rhiHfWYxxL4OaTRcJdoK
        qipi9sYKMghf6LivZe5EGoB4uqCcy2w=
Date:   Mon, 21 Nov 2022 14:14:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/boot: fix relying on link order
Message-ID: <Y3t5wxKwIAycpDV8@zn.tnic>
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
 <20221107125528.543764-1-alexandr.lobakin@intel.com>
 <2993a60c-edaa-a29a-2644-3ee86c622847@intel.com>
 <20221121120918.388035-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221121120918.388035-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:09:18PM +0100, Alexander Lobakin wrote:
> > Things are a bit busy in the review queue at the moment.  As always,
> > we'd love help reviewing stuff.  So, while you're waiting for us to
> > review this, could you perhaps look around and find a series that's also
> > hurting for review tags?
> 
> I've got Reviewed-by and Tested-by from Jiri, isn't that enough? Or
> I need also some other group to get tags from?

What he actually means is if *you* yourself help out with patch review.
Like find a set on lkml which you're interested in - I believe there
will be no shortage of such sets - and poke at it, review it, ask
devil's advocate questions, etc.

The distribution of work - gazillion submitters vs a handful of
maintainers simply cannot scale and instead of submitters pinging
maintainers all the time when they can look at their set, submitters
could review other submitters' work in the meantime, while waiting.

I.e., a win-win-win situation. :-)

Makes more sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
