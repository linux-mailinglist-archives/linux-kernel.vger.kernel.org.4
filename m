Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC536EE94D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjDYVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDYVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:00:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0174216181
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TdT2UZzR9A9n67dtt71JYEAzsaqTilf9yuC7QKBKTEA=; b=RVhi0WATkrHIKyuO3eZVZUa2mg
        v+GxeskTpTkJ7FfePQwcGoaRWrdYn18I794GIl8xP6OLCP1H1AlZ2SbBze7vNhKf7Tal7qFhGJqtK
        /11fMl+Y2hZZIEyTbWaSCc3cM4FgVGIi9dRkWlm474jeJDzsUJuqliABBfOin5+RJzPOxK0CXM44a
        GeIx2efPByl1QyqXOShcqmri+20aQ9FYxdKYZi+UweF1Y+UpcQkYd3HBeoynF5RRVDZ5naDEjMWMd
        WOJfm5lKDND9MR1AblTvXtYMx2c0E093wIvMnwIBweyMFdlYp3ZBjcBH7ZV7NNgYqUmuk9Ym9PM7J
        G44t9UKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prPlK-009nKK-1W;
        Tue, 25 Apr 2023 20:59:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F09F0300244;
        Tue, 25 Apr 2023 22:59:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA1D3241BDB7C; Tue, 25 Apr 2023 22:59:44 +0200 (CEST)
Date:   Tue, 25 Apr 2023 22:59:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/CPU/AMD: Rename the spectral chicken
Message-ID: <20230425205944.GB1350354@hirez.programming.kicks-ass.net>
References: <20230425195024.17808-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425195024.17808-1-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:50:24PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> We've had enough fun with the spectral chicken bit - name it what it
> really does: it suppresses non-branch predictions.
> 
> Rename defines to make it clear that it is Zen2 only.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/msr-index.h |  6 ++++--
>  arch/x86/kernel/cpu/amd.c        | 22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index ad35355ee43e..0094e6a1b553 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -625,8 +625,10 @@
>  /* Fam 17h MSRs */
>  #define MSR_F17H_IRPERF			0xc00000e9
>  
> -#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
> -#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
> +/* Fam 17h, Zen2 MSRs */
> +#define MSR_ZEN2_DE_CFG2			0xc00110e3
> +#define MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED_BIT	1
> +#define MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED	BIT(MSR_ZEN2_DE_CFG2_SUPPRESS_NOBR_PRED_BIT)

NAK, I had to write all this without *any* official communication from
AMD, mostly on hear-say.

This gets to be the spectral chicken forever more as punishment. Next
time AMD can try again, and if they manage to get their act together and
publish something before I get to write the code and invent a name for a
magical bit, they get to name it how they like.
