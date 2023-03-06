Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC96AB937
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCFJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCFJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:04:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2BD507
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:04:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 621A71EC04F0;
        Mon,  6 Mar 2023 10:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678093478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YbGvwOqdiQDSX+zptL9wDdwfgRlKAJcOmsPB58v/Qac=;
        b=H6DHbZUdYRMQo0paIluIIb3O56Zj4imH4O4VhyiqpdGcwYBmqGblLyEim7FAj6K8TFnTfX
        pqMg2Why0X9/Jn4UJt0UCP08S1efMzdUOG3x2go2VgQupZkbc/jOwhfil4GUWbcXgJGuBM
        rEbCIiIeDimU/KvUa+5FqyDBirl8zUg=
Date:   Mon, 6 Mar 2023 10:04:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH -next 1/2] x86/mm/pat: Move follow_phys to pat-related
 file
Message-ID: <20230306090433.GBZAWsoQJKSpQ0AWYl@fat_crate.local>
References: <20230306084316.2275757-1-mawupeng1@huawei.com>
 <20230306084316.2275757-2-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306084316.2275757-2-mawupeng1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 04:43:15PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Since only PAT in x86 use follow_phys(), move this to from memory.c to
> memtype.c and make it static. Argument flags is always zero in caller
> untrack_pfn() and track_pfn_copy(). let's drop it.
> 
> Since config HAVE_IOREMAP_PROT is selected by x86, drop this config macro.

* first patch: *only* code movement, no other changes
* second patch: do semantic changes and explain *why* you do them
* third patch:...
*...

In that order please. Otherwise review is unnecessarily complicated.

Also, do not talk about *what* the patch is doing in the commit message
- that should be obvious from the diff itself. Rather, concentrate on
the *why* it needs to be done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
