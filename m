Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9A5B331A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIIJIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiIIJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:08:26 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5E4D4D7;
        Fri,  9 Sep 2022 02:08:24 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oWZzh-002oEa-LF; Fri, 09 Sep 2022 19:08:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Sep 2022 17:08:13 +0800
Date:   Fri, 9 Sep 2022 17:08:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     cgel.zte@gmail.com
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] crypto: octeontx: Remove the unneeded result
 variable
Message-ID: <YxsCfUxTD8vdrCnh@gondor.apana.org.au>
References: <20220901074349.313117-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074349.313117-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 07:43:48AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value cptvf_send_msg_to_pf_timeout() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  .../crypto/marvell/octeontx/otx_cptvf_mbox.c  | 20 +++++--------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Patch applied.  Thanks. 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
