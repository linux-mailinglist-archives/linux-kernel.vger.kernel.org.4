Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4906962A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjBNLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjBNLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:48:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5352365C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:48:11 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 539A51EC0682;
        Tue, 14 Feb 2023 12:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676375290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gdcUW1N1xDH4whoXDVHAwySXcy6aZnTXZ+K7yun4ADY=;
        b=eem5k7cog03QWUQyVndi3H8MrEZ5ykesLEwKsCvtamODxT4stQbPDIvTc9u7zDd9C4zk4A
        JL1/JEzz2dXRwGP9cjwSICP4pMX6RUao2aZxyP788cZYTL473+d0/o6XCbGOZFLN+J2o7N
        d99MBVoecdK9mQ2mhCywKjorwW7v9Ds=
Date:   Tue, 14 Feb 2023 12:48:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, Andrew.Cooper3@citrix.com,
        jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/4] x86/alternative: Make debug-alternative selective
Message-ID: <Y+t09k0Nulddm+lU@zn.tnic>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.253636689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208171431.253636689@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:10:51PM +0100, Peter Zijlstra wrote:
> Using debug-alternative generates a *LOT* of output, extend it a bit
> to select which of the many rewrites it reports on.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |   62 +++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 25 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
