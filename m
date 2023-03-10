Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A186B3DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCJL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCJL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:29:09 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE0F222B;
        Fri, 10 Mar 2023 03:29:06 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paavf-002Xzx-Mn; Fri, 10 Mar 2023 19:28:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:28:55 +0800
Date:   Fri, 10 Mar 2023 19:28:55 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     daniel.m.jordan@oracle.com, steffen.klassert@secunet.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use alignment when calculating the number of
 worker threads
Message-ID: <ZAsUd3Fg3A6pImbd@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677112392-17332-1-git-send-email-anthony.yznaga@oracle.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
> For multithreaded jobs the computed chunk size is rounded up by the
> caller-specified alignment. However, the number of worker threads to
> use is computed using the minimum chunk size without taking alignment
> into account. A sufficiently large alignment value can result in too
> many worker threads being allocated for the job.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
> kernel/padata.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
