Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7235E8A14
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiIXITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIXITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:19:10 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CB1C40F;
        Sat, 24 Sep 2022 01:17:49 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oc0Lf-007wei-O2; Sat, 24 Sep 2022 18:17:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Sep 2022 16:17:19 +0800
Date:   Sat, 24 Sep 2022 16:17:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     dan.j.williams@intel.com, davem@davemloft.net, trix@redhat.com,
        jarkko@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: add __init/__exit annotations to init/exit funcs
Message-ID: <Yy69D5+TBEoHmmXP@gondor.apana.org.au>
References: <20220915033615.12478-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915033615.12478-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 11:36:15AM +0800, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to init/exit funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  crypto/async_tx/raid6test.c | 4 ++--
>  crypto/curve25519-generic.c | 4 ++--
>  crypto/dh.c                 | 4 ++--
>  crypto/ecdh.c               | 4 ++--
>  crypto/ecdsa.c              | 4 ++--
>  crypto/rsa.c                | 4 ++--
>  crypto/sm2.c                | 4 ++--
>  7 files changed, 14 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
