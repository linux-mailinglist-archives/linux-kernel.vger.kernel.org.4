Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196670930E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjESJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjESJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:30:21 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71921A6;
        Fri, 19 May 2023 02:30:16 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pzwQW-00Aowi-Vt; Fri, 19 May 2023 17:29:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 May 2023 17:29:32 +0800
Date:   Fri, 19 May 2023 17:29:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/4] crypto: starfive - Add drivers for crypto engine
Message-ID: <ZGdBfPfL675OBcTS@gondor.apana.org.au>
References: <20230515125355.624250-1-jiajie.ho@starfivetech.com>
 <ZGc4Wv0SU59dyVWV@gondor.apana.org.au>
 <20230519-moodiness-backtalk-cc838c53e8b1@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519-moodiness-backtalk-cc838c53e8b1@wendy>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:24:28AM +0100, Conor Dooley wrote:
>
> Can you drop the ea1aeba1b2e07b82f9eb7cce5cb169263a77d046 ("riscv: dts:
> starfive: Add crypto and DMA node for VisionFive 2") please?
> It depends on a clock node that has not been added to the dts yet, and
> will break the dtb build:
> 
> Error: arch/riscv/boot/dts/starfive/jh7110.dtsi:505.22-23 syntax error
> FATAL ERROR: Unable to parse input tree

OK, I've dropped it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
