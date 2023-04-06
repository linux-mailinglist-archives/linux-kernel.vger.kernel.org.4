Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8656D9208
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjDFIxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDFIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:53:22 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764F90;
        Thu,  6 Apr 2023 01:53:20 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pkLMc-00D23Q-6T; Thu, 06 Apr 2023 16:53:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Apr 2023 16:53:02 +0800
Date:   Thu, 6 Apr 2023 16:53:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] crypto: hisilicon/trng - add support for HiSTB TRNG
Message-ID: <ZC6Ibor2aGR8D8fR@gondor.apana.org.au>
References: <20230401164448.1393336-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401164448.1393336-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 12:44:40AM +0800, David Yang wrote:
> HiSTB TRNG are found on some HiSilicon STB SoCs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v2: fix typo
> v3: add option for post process depth, adjust timeout
> v4: do not case to __iomem, as requested
> v5: do not use rng->priv at all
>  drivers/crypto/hisilicon/Kconfig         |   7 +
>  drivers/crypto/hisilicon/Makefile        |   2 +-
>  drivers/crypto/hisilicon/trng/Makefile   |   3 +
>  drivers/crypto/hisilicon/trng/trng-stb.c | 176 +++++++++++++++++++++++
>  4 files changed, 187 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/hisilicon/trng/trng-stb.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
