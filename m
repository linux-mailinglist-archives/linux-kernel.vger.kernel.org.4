Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376C620C89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiKHJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiKHJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:42:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A930541
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:42:21 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E03971EC0391;
        Tue,  8 Nov 2022 10:42:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667900540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aLpFfV2D89BsWZs9Fn618JtVOW7PZU0ZA1fa1+VqPf8=;
        b=HZeoy2eYGNmQv7BqZpn/O0V+/41vMra0QIa9Kif7mCzgi1S6qe9NXX4m5l5kEct2bSo0R0
        1vYnED4PFPdhuwYOtrXeFXakSJKHiWs0iMBpKG3+Q/B/BK39hCeRV90sHo8jJEX/5FcuAH
        1zoZzUrykaRGsp3Cxk0b6TASVIB2Wk4=
Date:   Tue, 8 Nov 2022 10:42:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag
 testing macros do
Message-ID: <Y2okdzF60XHLCK2v@zn.tnic>
References: <20221107211505.8572-1-bp@alien8.de>
 <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:13:52PM -0800, Dave Hansen wrote:
> It seems to be mildly warning against using _static_cpu_has()
> indiscriminately.  Should we tone that down a bit if we're recommending
> implicit use of static_cpu_has() via cpu_feature_enabled() everywhere?

Yeah, that comment is mine AFAIR. I was thinking of simply removing
it as part of a long-term effort of converting everything to
cpu_feature_enabled() and hiding static_cpu_has() eventually...

> I was also thinking that some longer-form stuff in Documentation/ might
> be a good idea, along with some examples.  I'd be happy to follow this
> up with another patch that added Documentation/ like:

The problem with this is, it'll go out of sync with the code. So how
about we make this a kernel-doc thing so that it gets updated in
parallel?

Also look at Documentation/x86/cpuinfo.rst

It basically has most of what you wanna add.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
