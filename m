Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5660762C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJULc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJULcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:32:23 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473CF265C4D;
        Fri, 21 Oct 2022 04:32:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olqFX-004ddA-74; Fri, 21 Oct 2022 19:32:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:32:15 +0800
Date:   Fri, 21 Oct 2022 19:32:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhiqi Song <songzhiqi1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        fanghao11@huawei.com, liulongfang@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/hpre - fix resource leak in remove
 process
Message-ID: <Y1KDP6HuPrckDWFg@gondor.apana.org.au>
References: <20220924073831.38479-1-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924073831.38479-1-songzhiqi1@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 03:38:31PM +0800, Zhiqi Song wrote:
> In hpre_remove(), when the disable operation of qm sriov failed,
> the following logic should continue to be executed to release the
> remaining resources that have been allocated, instead of returning
> directly, otherwise there will be resource leakage.
> 
> Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
