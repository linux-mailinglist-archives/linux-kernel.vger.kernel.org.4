Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8E5B9D90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIOOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIOOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903BB8D;
        Thu, 15 Sep 2022 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IU+Vy0N15fZhJfU1yY5jatba4ZvCtVnu9ygPkLo6lyQ=; b=Q9hFJ6cTg3JyvOYK5+F4ElqCJr
        WM7sl+KOcFV/mFxIgbwkWajuwCq3EPpEfYdmS22DOWB7t++uXqXMPUsh4PFq595J4QCz8dgOxFK+n
        9VKBVyqDAQEyg2wE6dnTxuPXRghggN7gBNzysQpMqGMh1bAifX/xht8kagXz+sVTcaH1nnD1nuBFf
        g+CE08+sC9+/VSAXsTe0JT5KCGYDRaHBDbnaDtXeHO5ja2kc1u6jiDvre65yh30MgtewTjFY60kT1
        2DpeHN7jd3lWi8ODjp4HP5Hn8ffds94kkJ9HDSwDigoMXuC57znTaC+O+qD7zgo7wM+XIUz+s8Qkr
        ih5giFiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYq37-001A2f-5d; Thu, 15 Sep 2022 14:41:05 +0000
Date:   Thu, 15 Sep 2022 15:41:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tuo Cao <91tuocao@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: x86: replace do_IRQ int the entry_64.rst with
 common_interrupt
Message-ID: <YyM5gTgcvvFY7Oxk@casper.infradead.org>
References: <20220915135452.7901-1-91tuocao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915135452.7901-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 09:54:52PM +0800, Tuo Cao wrote:
> do_IRQ has been replaced by common_interrupt in commit
> fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
> 
> Signed-off-by: Tuo Cao <91tuocao@gmail.com>
> ---
>  Documentation/x86/entry_64.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
> index e433e08f7018..4f12152570e7 100644
> --- a/Documentation/x86/entry_64.rst
> +++ b/Documentation/x86/entry_64.rst
> @@ -33,8 +33,8 @@ Some of these entries are:
>   - interrupt: An array of entries.  Every IDT vector that doesn't
>     explicitly point somewhere else gets set to the corresponding
>     value in interrupts.  These point to a whole array of
> -   magically-generated functions that make their way to do_IRQ with
> -   the interrupt number as a parameter.
> +   magically-generated functions that make their way to common_interrupt

If we write common_interrupt() with the brackets, that'll get turned
into a nice link to the kernel-doc for common_interrupt().  If anyone
writes it ;-)

> +   with the interrupt number as a parameter.
>  
>   - APIC interrupts: Various special-purpose interrupts for things
>     like TLB shootdown.
> -- 
> 2.17.1
> 
