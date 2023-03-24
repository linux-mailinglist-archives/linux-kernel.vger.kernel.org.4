Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28EC6C7C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCXK2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCXK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:28:51 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F742201F;
        Fri, 24 Mar 2023 03:28:44 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfeeo-008FYb-Dn; Fri, 24 Mar 2023 18:28:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 18:28:26 +0800
Date:   Fri, 24 Mar 2023 18:28:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] async_tx: fix kernel-doc notation warnings
Message-ID: <ZB17Skb49gvoeth5@gondor.apana.org.au>
References: <20230314024734.9066-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314024734.9066-1-rdunlap@infradead.org>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:47:34PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings by adding "struct" keyword or "enum" keyword.
> Also fix 2 function parameter descriptions.
> Change some functions and structs from kernel-doc /** notation
> to regular /* comment notation.
> 
> async_pq.c:18: warning: cannot understand function prototype: 'struct page *pq_scribble_page; '
> async_pq.c:18: error: Cannot parse struct or union!
> async_pq.c:40: warning: No description found for return value of 'do_async_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'blocks' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'offsets' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'disks' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'len' not described in 'do_sync_gen_syndrome'
> async_pq.c:109: warning: Function parameter or member 'submit' not described in 'do_sync_gen_syndrome'
> 
> async_tx.c:136: warning: cannot understand function prototype: 'enum submit_disposition '
> async_tx.c:264: warning: Function parameter or member 'tx' not described in 'async_tx_quiesce'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
> v2: fix more warnings
> 
>  crypto/async_tx/async_pq.c |   10 +++++-----
>  crypto/async_tx/async_tx.c |    4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
