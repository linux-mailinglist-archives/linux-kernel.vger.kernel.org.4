Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1740607655
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJULg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJULgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:36:22 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B019262079;
        Fri, 21 Oct 2022 04:36:10 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olqHz-004dob-2Z; Fri, 21 Oct 2022 19:34:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:34:47 +0800
Date:   Fri, 21 Oct 2022 19:34:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        olivia@selenic.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rng: npcm: add Arbel NPCM8XX support
Message-ID: <Y1KD1zlz5WRVzN9k@gondor.apana.org.au>
References: <20220929133111.73897-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929133111.73897-1-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:31:09PM +0300, Tomer Maimon wrote:
> This patch set adds Arbel NPCM8XX Random Number Generator(RNG) support 
> to RNG NPCM driver.
> 
> The NPCM8XX RNG uses different prescalar clock value.
> 
> The NPCM RNG driver was tested on the NPCM845 evaluation board.
> 
> Addressed comments from:
>  - Krzysztof Kozlowski: https://www.spinics.net/lists/kernel/msg4523771.html
> 			https://www.spinics.net/lists/kernel/msg4523585.html
> 
> Changes since version 1:
>  - Fix dt-binding document warning.
>  - Use driver data to handle architecture specific clock prescaler.
> 
> Tomer Maimon (2):
>   dt-bindings: rng: nuvoton,npcm-rng: Add npcm845 compatible string
>   hwrng: npcm: Add NPCM8XX support
> 
>  .../devicetree/bindings/rng/nuvoton,npcm-rng.yaml  |  4 +++-
>  drivers/char/hw_random/npcm-rng.c                  | 14 ++++++++++----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.33.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
