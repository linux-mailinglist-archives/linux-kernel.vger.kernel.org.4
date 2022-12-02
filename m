Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F264046B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiLBKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiLBKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:19:43 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEBCCFD6;
        Fri,  2 Dec 2022 02:19:42 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p138m-003CCI-ET; Fri, 02 Dec 2022 18:19:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:19:32 +0800
Date:   Fri, 2 Dec 2022 18:19:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     zys.zljxml@gmail.com
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH] crypto: marvell/octeontx - remove redundant NULL check
Message-ID: <Y4nRNCyUBBvseVF1@gondor.apana.org.au>
References: <20221122074900.3660531-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122074900.3660531-1-zys.zljxml@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:49:00PM +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> release_firmware() checks whether firmware pointer is NULL. Remove the redundant NULL check in release_tar_archive().
> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>  drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
