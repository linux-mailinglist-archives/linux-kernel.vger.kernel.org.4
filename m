Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915067E280
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjA0LAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjA0LAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:00:36 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8C8448F;
        Fri, 27 Jan 2023 03:00:36 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLMTB-004hGU-Ea; Fri, 27 Jan 2023 19:00:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 19:00:33 +0800
Date:   Fri, 27 Jan 2023 19:00:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>
Subject: Re: [PATCH] crypto: ccp - Add a firmware definition for EPYC gen 4
 processors
Message-ID: <Y9Ou0RtaQdLiii6E@gondor.apana.org.au>
References: <9a5c5b0e9611428b15d6039643730489d543bfad.1673899480.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5c5b0e9611428b15d6039643730489d543bfad.1673899480.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 02:04:40PM -0600, Tom Lendacky wrote:
> Add a new MODULE_FIRMWARE() entry for 4th generation EPYC processors.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
