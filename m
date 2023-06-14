Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE072F9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjFNJu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjFNJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:49:41 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84A2940;
        Wed, 14 Jun 2023 02:49:15 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q9N7b-002omX-Tc; Wed, 14 Jun 2023 17:49:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 14 Jun 2023 17:48:59 +0800
Date:   Wed, 14 Jun 2023 17:48:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "meenakshi.aggarwal@nxp.com" <meenakshi.aggarwal@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "V.sethi@nxp.com" <V.sethi@nxp.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        lucas.segarra.fernandez@intel.com
Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Message-ID: <ZImNC6KUNHquVAnZ@gondor.apana.org.au>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com>
 <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
 <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 09:41:28AM +0100, Giovanni Cabiddu wrote:
>
> If you all agree, I can send a patch to remove CRYPTO_ALG_ALLOCATES_MEMORY
> from dm-integrity and update the documentation in crypto.h.

Yes please.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
