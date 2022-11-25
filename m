Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7285763833E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 05:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKYEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 23:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYEqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:46:24 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6618A18E02;
        Thu, 24 Nov 2022 20:46:23 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyQb6-000dw5-Q5; Fri, 25 Nov 2022 12:45:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 12:45:56 +0800
Date:   Fri, 25 Nov 2022 12:45:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     robh+dt@kernel.org, akpm@linux-foundation.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        broonie@kernel.org, qyousef@layalina.io, arnd@arndb.de,
        atishp@atishpatra.org, anup@brainfault.org, tkhai@ya.ru,
        quic_abhinavk@quicinc.com, vasily.averin@linux.dev,
        baolin.wang@linux.alibaba.com, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Message-ID: <Y4BIhInFSg6F6nOV@gondor.apana.org.au>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122125244.175295-1-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:52:44PM +0200, Tudor Ambarus wrote:
> My professional email will change and the microchip one will bounce after
> mid-november of 2022.
> 
> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
> author mentions, and add an entry in the .mailmap file.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  .mailmap                                               |  1 +
>  .../bindings/crypto/atmel,at91sam9g46-aes.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-sha.yaml         |  2 +-
>  .../bindings/crypto/atmel,at91sam9g46-tdes.yaml        |  2 +-
>  .../devicetree/bindings/spi/atmel,at91rm9200-spi.yaml  |  2 +-
>  .../devicetree/bindings/spi/atmel,quadspi.yaml         |  2 +-
>  MAINTAINERS                                            | 10 +++++-----
>  drivers/crypto/atmel-ecc.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.c                             |  4 ++--
>  drivers/crypto/atmel-i2c.h                             |  2 +-
>  10 files changed, 16 insertions(+), 15 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
