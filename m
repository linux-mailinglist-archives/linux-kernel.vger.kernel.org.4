Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE487310FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245125AbjFOHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244920AbjFOHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:39:03 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61CB272A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:38:29 -0700 (PDT)
Date:   Thu, 15 Jun 2023 07:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686814647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHM5nN9Xo/TDGK3QI1A/B419EOZFjB7CwMKF8sVz5Io=;
        b=EW+OB1AR41NMhUT9apUn/Hs+/3gYPuHJdKfJ1UTfvCkeO6CSS57FZLXImHsqJn+3RkLTES
        CrtbbpOUInO7I+9CBX/yAta8NQCGmckm5bf4gct5cNJ6d5MkuJt2rkL6+i0cNsUx9xBSH3
        mC2J5m5vA9A9qYwbzFtVRe8z4sRE5O8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <ZIq/s8p10EGI9fqu@linux.dev>
References: <20230615124558.2cea58b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615124558.2cea58b3@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:45:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-arm tree got a conflict in:
> 
>   arch/arm64/kernel/kaslr.c
> 
> between commit:
> 
>   6e13b6b923b3 ("arm64: kaslr: split kaslr/module initialization")
>   e46b7103aef3 ("arm64: module: move module randomization to module.c")
> 
> from the arm64 tree and commit:
> 
>   0ddc312b7c73 ("arm64: Turn kaslr_feature_override into a generic SW feature override")
> 
> from the kvm-arm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This is
> now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your
> tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Diff LGTM, thanks Stephen.

Catalin, I'd like to resolve this in the kvmarm tree and merge
for-next/module-alloc. You alright with that?

-- 
Thanks,
Oliver
