Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE8668ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjAMEQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjAMEPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:15:38 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12CF65355;
        Thu, 12 Jan 2023 20:13:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pGBR0-00H5Ig-Q3; Fri, 13 Jan 2023 12:12:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 12:12:54 +0800
Date:   Fri, 13 Jan 2023 12:12:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/6] crypto: Accelerated AES/GCM stitched
 implementation
Message-ID: <Y8DaRph5Sv709m/m@gondor.apana.org.au>
References: <20221205003458.4182-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205003458.4182-1-dtsen@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 07:34:52PM -0500, Danny Tsen wrote:
> This patch series enable an accelerated AES/GCM stitched implementation for
> Power10+ CPU(ppc64le).  This module supports AEAD algorithm.  The stitched
> implementation provides 3.5X+ better performance than the baseline.
> 
> This patch has been tested with the kernel crypto module tcrypt.ko and has
> passed the selftest.  The patch is also tested with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled
> 
> Danny Tsen (6):
>   Patch1: Update Kconfig and Makefile.
>   Patch2: Glue code for AES/GCM stitched implementation.
>   Patch3: An accelerated AES/GCM stitched implementation.
>   Patch4: Supporting functions for AES.
>   Patch5: Supporting functions for ghash.
>   Patch6: A perl script to process PowerPC assembler source.
> 
>  arch/powerpc/crypto/Kconfig            |   11 +
>  arch/powerpc/crypto/Makefile           |   10 +
>  arch/powerpc/crypto/aesp8-ppc.pl       | 3846 ++++++++++++++++++++++++
>  arch/powerpc/crypto/ghashp8-ppc.pl     |  370 +++
>  arch/powerpc/crypto/p10-aes-gcm-glue.c |  345 +++
>  arch/powerpc/crypto/p10_aes_gcm.S      | 1519 ++++++++++
>  arch/powerpc/crypto/ppc-xlate.pl       |  229 ++
>  7 files changed, 6330 insertions(+)
>  create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
>  create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
>  create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
>  create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
>  create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
> 
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
