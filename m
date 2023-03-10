Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD96B3DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjCJLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCJLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:32:03 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2ADB9515;
        Fri, 10 Mar 2023 03:32:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paayU-002Y9V-85; Fri, 10 Mar 2023 19:31:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Mar 2023 19:31:50 +0800
Date:   Fri, 10 Mar 2023 19:31:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Antoine Tenart <atenart@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] crypto: inside-secure: Handle load errors better
Message-ID: <ZAsVJjmvefrfTHwr@gondor.apana.org.au>
References: <Y/fkOF31BTQVocSe@sevai.o362.us>
 <cover.1677608527.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677608527.git.noodles@earth.li>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 06:28:23PM +0000, Jonathan McDowell wrote:
> 2 minor patches to improve the error handling of the safexcel driver
> when it fails to load.
> 
> Firstly, make it clear when the reason for a load failure is because the
> firmware is not available.
> 
> Secondly, ensure we clean up the ring workqueues / IRQ affinity settings
> to avoid a kernel warning when the driver fails to load.
> 
> v2:
>  - Expand error clean up to cover ring initialisation failures
> 
> Jonathan McDowell (2):
>   crypto: inside-secure: Raise firmware load failure message to error
>   crypto: inside-secure - Cleanup ring IRQ workqueues on load failure
> 
>  drivers/crypto/inside-secure/safexcel.c | 39 ++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> -- 
> 2.39.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
