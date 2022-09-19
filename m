Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5A5BD510
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiISTKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:10:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D767F237DC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:15 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e79d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC4751EC01D2;
        Mon, 19 Sep 2022 21:10:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663614609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mu2esohdM2sPF1b210YRZnBukLG7jBgVAsUUa3wE11E=;
        b=QLTTFmFiZtmxou/z76o527wSr6qZCJkH0qFFhBzI5BpmHtqIGuw/zQPA/v1DvgfSqcKY+V
        YBT9Iiu4FIfQnCerKuBmbTK+QShttbY4Cw5pIoA78zSEkHWB3oZx/xO76gi+VaVuxfdgrk
        6y43x6orRu6tHVz23i7XkbsSyaqpqTE=
Date:   Mon, 19 Sep 2022 21:10:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 03/10] x86/mtrr: replace use_intel() with a local flag
Message-ID: <Yyi+jYB//4v4vOxa@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-4-jgross@suse.com>
 <Yx21cizZHNzD38z7@nazgul.tnic>
 <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80085512-5783-7ea0-fb7d-6e852f8942e0@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:10:29AM +0200, Juergen Gross wrote:
> In the end this variable doesn't specify which caching types are available,
> but the ways to select/control the caching types.
> 
> So what about "memory_caching_select" or "memory_caching_control" instead?

_control sounds like the right thing. As in, which of the memory caching
things the kernel controls. Along with a comment above it what this
exactly is. Yap.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
