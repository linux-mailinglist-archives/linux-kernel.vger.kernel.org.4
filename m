Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7325BABBF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIPKyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIPKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:52 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E39ADCDA;
        Fri, 16 Sep 2022 03:37:00 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oZ8iN-005Gwa-Dv; Fri, 16 Sep 2022 20:36:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Sep 2022 18:36:55 +0800
Date:   Fri, 16 Sep 2022 18:36:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH 00/10] crypto: hisilicon - support get device information
 from registers
Message-ID: <YyRRx8G76mPxBo6W@gondor.apana.org.au>
References: <20220909094704.32099-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909094704.32099-1-qianweili@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:46:54PM +0800, Weili Qian wrote:
> This patchset supports obtaining device information from
> device registers, including the supported algorithms,
> device features, and so on.
> 
> Weili Qian (6):
>   crypto: hisilicon/qm - get hardware features from hardware registers
>   crypto: hisilicon/qm - get qp num and depth from hardware registers
>   crypto: hisilicon/qm - add UACCE_CMD_QM_SET_QP_INFO support
>   crypto: hisilicon/qm - get error type from hardware registers
>   crypto: hisilicon/qm - support get device irq information from
>     hardware registers
>   crypto: hisilicon/zip - support zip capability
> 
> Wenkai Lin (1):
>   crypto: hisilicon/sec - get algorithm bitmap from registers
> 
> Zhiqi Song (3):
>   crypto: hisilicon/hpre - support hpre capability
>   crypto: hisilicon/hpre - optimize registration of ecdh
>   crypto: hisilicon - support get algs by the capability register
> 
>  drivers/crypto/hisilicon/hpre/hpre.h        |   8 +-
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 250 ++++---
>  drivers/crypto/hisilicon/hpre/hpre_main.c   | 208 +++++-
>  drivers/crypto/hisilicon/qm.c               | 765 +++++++++++++-------
>  drivers/crypto/hisilicon/sec2/sec.h         |  34 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c  | 454 +++++++-----
>  drivers/crypto/hisilicon/sec2/sec_main.c    | 160 +++-
>  drivers/crypto/hisilicon/zip/zip.h          |   1 +
>  drivers/crypto/hisilicon/zip/zip_crypto.c   |  73 +-
>  drivers/crypto/hisilicon/zip/zip_main.c     | 256 +++++--
>  include/linux/hisi_acc_qm.h                 |  63 +-
>  include/uapi/misc/uacce/hisi_qm.h           |  17 +-
>  12 files changed, 1589 insertions(+), 700 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks. 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
