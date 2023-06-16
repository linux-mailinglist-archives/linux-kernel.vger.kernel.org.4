Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B937330FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbjFPMR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjFPMRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:17:51 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5313D30DF;
        Fri, 16 Jun 2023 05:17:47 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA8OU-003oRS-HY; Fri, 16 Jun 2023 20:17:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 20:17:34 +0800
Date:   Fri, 16 Jun 2023 20:17:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     bagasdotme@gmail.com, davem@davemloft.net,
        franziska.naepelt@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2] crypto: crct10dif_common Add SPDX-License-Identifier
 tag
Message-ID: <ZIxS3pJ/GfTEGVtW@gondor.apana.org.au>
References: <ZH8ntoGLJHQpZriL@debian.me>
 <20230606180713.99460-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606180713.99460-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:07:13PM +0200, Franziska Naepelt wrote:
> Fix the following checkpatch warning:
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
> v2:
>  - Remove GPL license boilerplate
> ---
>  crypto/crct10dif_common.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
> index b2fab366f518..28a0cdde9449 100644
> --- a/crypto/crct10dif_common.c
> +++ b/crypto/crct10dif_common.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Cryptographic API.
>   *
> @@ -7,21 +8,6 @@
>   * Written by Martin K. Petersen <martin.petersen@oracle.com>
>   * Copyright (C) 2013 Intel Corporation
>   * Author: Tim Chen <tim.c.chen@linux.intel.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; either version 2 of the License, or (at your option)
> - * any later version.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> - * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> - * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> - * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> - * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - *
>   */

As the text you removed does not match GPLv2 exactly I'm dropping
this patch for now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
