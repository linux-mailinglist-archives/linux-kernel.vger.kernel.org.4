Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC16DBE65
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 05:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjDIDdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 23:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIDdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 23:33:39 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E94EC1;
        Sat,  8 Apr 2023 20:33:36 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1plLnn-00E1bO-2H; Sun, 09 Apr 2023 11:33:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Apr 2023 11:33:15 +0800
Date:   Sun, 9 Apr 2023 11:33:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yangfl <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] crypto: hisilicon/trng - add support for HiSTB TRNG
Message-ID: <ZDIx+wJUa8z+WUxD@gondor.apana.org.au>
References: <20230401164448.1393336-1-mmyangfl@gmail.com>
 <ZC6Ibor2aGR8D8fR@gondor.apana.org.au>
 <CAAXyoMMBWnqQGVWVOsEaKviukQJK1iyx+OAez0AQfKPL5b_UvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMMBWnqQGVWVOsEaKviukQJK1iyx+OAez0AQfKPL5b_UvQ@mail.gmail.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 12:06:06AM +0800, Yangfl wrote:
>
> Thanks for merging this patch. But after considering your former reply
> about drivers/char/hw_random , I'm thinking if that is a better place
> for this driver. If that is the case I'd like to post a new version of
> patch.
> 
> Sorry for late reply.

If you need to move it please send an incremental patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
