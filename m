Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA56548AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLVWnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLVWn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE0235
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:43:27 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C1CC1EC0716;
        Thu, 22 Dec 2022 23:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671749006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EobdnPjjP9RlYsD52myVc5wKOjcNXd2E/KiOadx4Il4=;
        b=eiI4OnStGYAl8TpjWPiWDAmq9Ds/Ve8lc7jPdd/WYsmRcO3/wydZiRnxQ8EiF7wF5I144w
        3H7isE/gP54gqx/fPy2Cq+MACpHlaVYFVrJxMEE7Bw2+EvCNo3y6OS+t7VZZ252zC2/iLa
        rMR8CUHOAzBHQp+5fo9eyGOAh+DdHhk=
Date:   Thu, 22 Dec 2022 23:43:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: amdgpu refcount saturation
Message-ID: <Y6TdiG5atyse+5De@zn.tnic>
References: <Y52tzASAKNAJEER3@zn.tnic>
 <0ac03934-27dc-e045-fece-5a4b4328de6c@amd.com>
 <20221222212037.bynlebvgt6ejehut@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222212037.bynlebvgt6ejehut@lion.mk-sys.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:20:37PM +0100, Michal Kubecek wrote:
> Unfortunately, just like Boris, I always seem to have multiple stack
> traces tangled together.

See if this fixes it:

https://lore.kernel.org/r/20221219104718.21677-1-christian.koenig@amd.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
