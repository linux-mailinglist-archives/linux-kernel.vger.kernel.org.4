Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8C731354
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245497AbjFOJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbjFOJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:09:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B730CB;
        Thu, 15 Jun 2023 02:09:14 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q9iyU-003G7R-4O; Thu, 15 Jun 2023 17:09:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 15 Jun 2023 17:09:02 +0800
Date:   Thu, 15 Jun 2023 17:09:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Adam, Mahmoud" <mngyadam@amazon.de>
Cc:     Mahmoud Adam <mngyadam@amazon.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: use kfree_sensitive with key
Message-ID: <ZIrVLk73ulTPzOGq@gondor.apana.org.au>
References: <20230613160723.61729-1-mngyadam@amazon.com>
 <ZImNO0AijmNriZuL@gondor.apana.org.au>
 <CB10C1D8-BA86-4E1B-B9B7-FDF6AFD3E089@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB10C1D8-BA86-4E1B-B9B7-FDF6AFD3E089@amazon.de>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 01:32:51PM +0000, Adam, Mahmoud wrote:
>
> I think this holds for the other lines as well, I can use pkey->key_is_private to check for them also

That might be going a bit overboard.

So if the key is definitely public, then use kfree.  If we don't
know what it is (i.e., public or private), then just use kfree_sensitive.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
