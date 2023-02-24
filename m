Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2801D6A240F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBXWJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXWJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:09:44 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36538628DB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:09:43 -0800 (PST)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id CB48F2244AB;
        Fri, 24 Feb 2023 23:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1677276581;
        bh=z5wVjlFzP6+7rcAdcOf5K1vLtbKr92VWi0iR167otfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPiyZ69+JY5nsXLhGsE5CjQzhKAimnKhdKLmupytNqF+53ODv3wP8ngrx23CSH9C1
         DQ9uYwueBQeFqr9gsEoY+Iecqfj5Y1+Q5+XeXmCo2suRserZlZ7983vjZ9X05KJuOf
         JcjjQVMNYA18LQ04HBMXrCJVMF3rbRSGQyiQthRM4w2cShqrapr+qi0qjVNRmcwRqZ
         5uGcFShnFCLAZv69/WDwTWUlnvMCIkFvU3uWfGt3emXOOqrhUOo/wXHgUKqhDY4pzQ
         qofgFiwJbgkECN69M3/ZelG5+c4T9yICzffjg5kmJjvnx+wmvmXNF3w8pC5XjcVHzC
         maXE3a4VMXLhg==
Date:   Fri, 24 Feb 2023 23:09:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [git pull] IOMMU Updates for Linux v6.3
Message-ID: <Y/k1pGjjRIznCIu2@8bytes.org>
References: <Y/SGAafMEGBn4fWy@8bytes.org>
 <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg71g9S0F8V-=97XQsaf6Edbxhfx-xS+x894w8sMZW+=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 01:46:47PM -0800, Linus Torvalds wrote:
> Ok. I wil be doing x86-64 and arm64 allmodconfig builds, but if there
> are any cases outside of that set that triggers, I won't norice.
> 
> That _should_ certainly cover the majority of any new code that might
> have a semantic conflict, though.

Aside from the conflicts with upstream, which I resolved in the merge
commit, the only other conflict that Stephen reported for linux-next was
in the rdma tree, iirc. So fingers crossed that this is the only one.

Regards,

	Joerg
