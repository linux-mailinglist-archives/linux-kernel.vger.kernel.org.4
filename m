Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50066075E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJULPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJULPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:15:22 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E043FF33;
        Fri, 21 Oct 2022 04:14:24 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olpy3-004dKY-9b; Fri, 21 Oct 2022 19:14:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:14:11 +0800
Date:   Fri, 21 Oct 2022 19:14:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     'Guanjun' <guanjun@linux.alibaba.com>
Cc:     elliott@hpe.com, zelin.deng@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] crypto/ycc: Add YCC (Yitian Cryptography Complex)
 accelerator driver
Message-ID: <Y1J/A//it5SeNKeL@gondor.apana.org.au>
References: <1664350687-47330-1-git-send-email-guanjun@linux.alibaba.com>
 <1664350687-47330-2-git-send-email-guanjun@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1664350687-47330-2-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:37:59PM +0800, 'Guanjun' wrote:
>
> diff --git a/drivers/crypto/ycc/Makefile b/drivers/crypto/ycc/Makefile
> new file mode 100644
> index 00000000..7065273
> --- /dev/null
> +++ b/drivers/crypto/ycc/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-(CONFIG_CRYPTO_DEV_YCC) += ycc.o
> +ycc-objs := ycc_drv.o ycc_isr.o

This doesn't even compile.  When I fixed that it generates loads
of warnings with sparse turned on.  Please fix them all before you
resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
