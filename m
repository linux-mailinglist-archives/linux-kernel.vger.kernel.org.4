Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC55969F046
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjBVIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:33:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F11C3609D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:33:26 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 01FA61EC0622;
        Wed, 22 Feb 2023 09:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677054805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Pwf1mVBeC8lifWJo57TbIJVle0b9fZlWLzD9yuuHPCg=;
        b=oLnr/n70JfA77+w1i4y/di8j+EQdJbMUdYB3MFMINKurVnCGsnxPCPsEF1+v+DzITU85rk
        YKGCEIhanKHUltjhnwNSZOZZn32L2MRctoVuUB9LnR0a4lPICksbR+0XMnP4Auq/Rh3yq0
        HQP5ZQXXcRqHY369AJAWH/tVRu3J8zg=
Date:   Wed, 22 Feb 2023 09:33:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tavis Ormandy <taviso@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/XTT59OrLw2as4R@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:40:07PM -0800, Tavis Ormandy wrote:
> Hello, I'm experiencing a serious bug on AMD Zen2 that is causing
> registers to "roll back" to previous values after a context switch.

It probably doesn't matter all too much but which kernel are you running
this on?

Latest and greatest I hope...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
