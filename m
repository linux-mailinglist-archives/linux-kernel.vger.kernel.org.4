Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA69695D75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjBNItK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjBNItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:49:07 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EE1D936;
        Tue, 14 Feb 2023 00:49:06 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pRqzl-00Ay0q-6u; Tue, 14 Feb 2023 16:49:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Feb 2023 16:49:01 +0800
Date:   Tue, 14 Feb 2023 16:49:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH v2 0/5] crypto: hisilicon/qm - some fixes and cleanups
Message-ID: <Y+tK/ewwAe3Wdwl1@gondor.apana.org.au>
References: <20230209123617.30545-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209123617.30545-1-qianweili@huawei.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:36:12PM +0800, Weili Qian wrote:
> Fix and clean up some issues in qm.c and sgl.c.
> 
> v1 -> v2:
> - Instead of changing the data type in min_t(),
> use min() instead of min_t().
> 
> Weili Qian (5):
>   crypto: hisilicon/qm - remove some unused defines
>   crypto: hisilicon/qm - use min() instead of min_t()
>   crypto: hisilicon/qm - change function names
>   crypto: hisilicon/qm - update comments to match function
>   crypto: hisilicon/qm - fix coding style issues
> 
>  drivers/crypto/hisilicon/qm.c  | 54 ++++++++++++----------------------
>  drivers/crypto/hisilicon/sgl.c |  1 -
>  include/linux/hisi_acc_qm.h    |  5 ++--
>  3 files changed, 21 insertions(+), 39 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
