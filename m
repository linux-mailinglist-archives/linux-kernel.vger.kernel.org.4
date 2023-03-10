Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759A6B3DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCJL3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCJL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:28:42 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BEA7E79B;
        Fri, 10 Mar 2023 03:28:39 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paav9-002Xzf-8Z; Fri, 10 Mar 2023 19:28:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:28:23 +0800
Date:   Fri, 10 Mar 2023 19:28:23 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com
Subject: Re: [RESEND PATCH v4 0/6] crypto: Accelerated AES/GCM stitched
 implementation
Message-ID: <ZAsUV4Nn6qrwA2am@gondor.apana.org.au>
References: <20230221034021.15121-1-dtsen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221034021.15121-1-dtsen@linux.ibm.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:40:15PM -0500, Danny Tsen wrote:
> This patch series enable an accelerated AES/GCM stitched implementation
> for Power10 or later CPU(ppc64le).  This module supports AEAD algorithm.
> The stitched implementation provides 3.5X+ better performance than the
> baseline.
> 
> This patch has been tested with the kernel crypto module tcrypt.ko and
> has passed the selftest.  The patch is also tested with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
> 
> Danny Tsen (6):
>   Glue code for AES/GCM stitched implementation.
>   An accelerated AES/GCM stitched implementation.
>   Supporting functions for AES.
>   Supporting functions for ghash.
>   A perl script to process PowerPC assembler source.
>   Update Kconfig and Makefile.
> 
>  arch/powerpc/crypto/aes-gcm-p10-glue.c |  345 ++++++
>  arch/powerpc/crypto/aes-gcm-p10.S      | 1521 ++++++++++++++++++++++++
>  arch/powerpc/crypto/aesp8-ppc.pl       |  585 +++++++++
>  arch/powerpc/crypto/ghashp8-ppc.pl     |  370 ++++++
>  arch/powerpc/crypto/ppc-xlate.pl       |  229 ++++
>  arch/powerpc/crypto/Kconfig            |   17 +
>  arch/powerpc/crypto/Makefile           |   13 +
>  7 files changed, 3080 insertions(+)
>  create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c
>  create mode 100644 arch/powerpc/crypto/aes-gcm-p10.S
>  create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
>  create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
>  create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
> 
> -- 
> 2.31.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
