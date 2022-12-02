Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F1640474
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiLBKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiLBKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:20:30 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A3CCFE3;
        Fri,  2 Dec 2022 02:20:28 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p139L-003CCn-SP; Fri, 02 Dec 2022 18:20:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:20:07 +0800
Date:   Fri, 2 Dec 2022 18:20:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Joe Fradley <joefradley@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kernel-team@android.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/curve25519 - disable gcov
Message-ID: <Y4nRV1u4ZU/WAa0X@gondor.apana.org.au>
References: <20221122225450.789234-1-joefradley@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122225450.789234-1-joefradley@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:54:49PM -0800, Joe Fradley wrote:
> curve25519-x86_64.c fails to build when CONFIG_GCOV_KERNEL is enabled.
> The error is "inline assembly requires more registers than available"
> thrown from the `fsqr()` function. Therefore, excluding this file from
> GCOV profiling until this issue is resolved. Thereby allowing
> CONFIG_GCOV_PROFILE_ALL to be enabled for x86.
> 
> Signed-off-by: Joe Fradley <joefradley@google.com>
> ---
>  arch/x86/crypto/Makefile | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
