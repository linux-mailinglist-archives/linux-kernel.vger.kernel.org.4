Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9B62F0DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiKRJSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbiKRJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:17:50 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F1D8B13B;
        Fri, 18 Nov 2022 01:17:37 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ovxV8-00FYZc-MJ; Fri, 18 Nov 2022 17:17:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Nov 2022 17:17:34 +0800
Date:   Fri, 18 Nov 2022 17:17:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] crypto: hisilicon/qm - reconstruct and optimize
 the debugfs code
Message-ID: <Y3dNrlQKTweq2kJk@gondor.apana.org.au>
References: <20221112021253.34862-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112021253.34862-1-yekai13@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 02:12:49AM +0000, Kai Ye wrote:
> Split a debugfs.c from qm to reduce the qm code complexity. And optimize the
> process of the command dumping. Some optimizations on command dumping in
> debugfs.c file code.
> 
> changes v1->v2:
> 	- delete a redundant line.
> changes v2->v3:
> 	- adjusting the patch sequence. modify a comment.
> 
> Kai Ye (4):
>   crypto: hisilicon/qm - delete redundant null assignment operations
>   crypto: hisilicon/qm - modify the process of regs dfx
>   crypto: hisilicon/qm - split a debugfs.c from qm
>   crypto: hisilicon/qm - the command dump process is modified
> 
>  drivers/crypto/hisilicon/Makefile         |    2 +-
>  drivers/crypto/hisilicon/debugfs.c        | 1147 +++++++++++++++++
>  drivers/crypto/hisilicon/hpre/hpre_main.c |    7 +-
>  drivers/crypto/hisilicon/qm.c             | 1360 ++-------------------
>  drivers/crypto/hisilicon/qm_common.h      |   87 ++
>  drivers/crypto/hisilicon/sec2/sec_main.c  |    7 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   |    7 +-
>  include/linux/hisi_acc_qm.h               |    8 +-
>  8 files changed, 1356 insertions(+), 1269 deletions(-)
>  create mode 100644 drivers/crypto/hisilicon/debugfs.c
>  create mode 100644 drivers/crypto/hisilicon/qm_common.h
> 
> -- 
> 2.17.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
