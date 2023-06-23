Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D373B294
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjFWIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjFWIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:21:09 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C92116;
        Fri, 23 Jun 2023 01:21:07 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qCc2P-006KTB-Oa; Fri, 23 Jun 2023 16:21:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jun 2023 16:21:01 +0800
Date:   Fri, 23 Jun 2023 16:21:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     meenakshi.aggarwal@nxp.com
Cc:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
Subject: Re: [PATCH] crypto: caam - add a test for the RNG
Message-ID: <ZJVV7UPuAx4a4wHZ@gondor.apana.org.au>
References: <20230612082842.1256507-1-meenakshi.aggarwal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612082842.1256507-1-meenakshi.aggarwal@nxp.com>
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

On Mon, Jun 12, 2023 at 10:28:42AM +0200, meenakshi.aggarwal@nxp.com wrote:
> From: "Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>
> 
> CAAM includes a Random Number Generator.  This change adds
> a kernel configuration option to test the RNG's capabilities via the
> hw_random framework.
> 
> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/Kconfig   |  9 +++++++
>  drivers/crypto/caam/caamrng.c | 48 +++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
