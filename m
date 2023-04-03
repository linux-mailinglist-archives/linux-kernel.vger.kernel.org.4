Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9A6D3C63
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDCETX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjDCETV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:19:21 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014F65AE;
        Sun,  2 Apr 2023 21:19:18 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pjBej-00BbAq-2b; Mon, 03 Apr 2023 12:18:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 03 Apr 2023 12:18:57 +0800
Date:   Mon, 3 Apr 2023 12:18:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yangfl <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] crypto: hisilicon/trng - add support for HiSTB TRNG
Message-ID: <ZCpTsUf/8glcN1kS@gondor.apana.org.au>
References: <20230331101943.831347-1-mmyangfl@gmail.com>
 <ZCfmCmxobIKaBdT4@gondor.apana.org.au>
 <CAAXyoMN+eVLNeiDtkwSZC2gFUDsBwn8SFST1=Nrw-qNr-u3-5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMN+eVLNeiDtkwSZC2gFUDsBwn8SFST1=Nrw-qNr-u3-5w@mail.gmail.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 10:05:25PM +0800, Yangfl wrote:
>
> Which meson driver? I didn't find any rng module under amlogic/ dir.

drivers/char/hw_random/meson-rng.c 

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
