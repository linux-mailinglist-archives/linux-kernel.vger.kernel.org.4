Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA836B3C24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCJKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCJKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:32:08 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D3D33E;
        Fri, 10 Mar 2023 02:32:05 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paa2W-002Wta-Vd; Fri, 10 Mar 2023 18:31:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 18:31:56 +0800
Date:   Fri, 10 Mar 2023 18:31:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harsha Harsha <harsha.harsha@amd.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michals@xilinx.com, saratcha@xilinx.com, git@amd.com,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: Re: [PATCH 3/4] crypto: xilinx: Add ZynqMP RSA driver
Message-ID: <ZAsHHOOpEzXVY23I@gondor.apana.org.au>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
 <20230218053809.1780-4-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218053809.1780-4-harsha.harsha@amd.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 11:08:08AM +0530, Harsha Harsha wrote:
>
> +			.cra_flags = CRYPTO_ALG_TYPE_AKCIPHER |
> +				     CRYPTO_ALG_KERN_DRIVER_ONLY |
> +				     CRYPTO_ALG_ALLOCATES_MEMORY |
> +				     CRYPTO_ALG_NEED_FALLBACK,

The driver appears to be async so you should set the flag
CRYPTO_ALG_ASYNC.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
