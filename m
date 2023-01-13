Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76422668AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAMESK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjAMEQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:16:48 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E353687B7;
        Thu, 12 Jan 2023 20:13:35 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pGBRM-00H5Jc-38; Fri, 13 Jan 2023 12:13:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 12:13:16 +0800
Date:   Fri, 13 Jan 2023 12:13:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add Aspeed ACRY driver for hardware acceleration
Message-ID: <Y8DaXA9X5Rp+3jCA@gondor.apana.org.au>
References: <20230104013436.203427-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104013436.203427-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 09:34:32AM +0800, Neal Liu wrote:
> Aspeed ACRY engine is designed to accelerate the throughput of
> ECDSA/RSA signature and verification.
> 
> These patches aim to add Aspeed ACRY RSA driver support.
> This driver also pass the run-time self tests that take place at
> algorithm registration on both big-endian/little-endian system
> in AST2600 evaluation board .
> 
> Tested-by below configs:
> - CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> - CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> - CONFIG_DMA_API_DEBUG=y
> - CONFIG_DMA_API_DEBUG_SG=y
> - CONFIG_CPU_BIG_ENDIAN=y
> 
> Change since v4:
> - Remove GFP_DMA flag since it's unnecessary.
> 
> Change since v3:
> - Revise aspeed,ast2600-ahbc.yaml dt-bindings description.
> 
> Change since v2:
> - Fix format and uninitialized warning.
> - Revise binding description.
> 
> Change since v1:
> - Fix dt-bindings description.
> - Refine the Makefile which has been addressed.
> 
> Neal Liu (4):
>   crypto: aspeed: Add ACRY RSA driver
>   ARM: dts: aspeed: Add ACRY/AHBC device controller node
>   dt-bindings: crypto: add documentation for Aspeed ACRY
>   dt-bindings: bus: add documentation for Aspeed AHBC
> 
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     |  37 +
>  .../bindings/crypto/aspeed,ast2600-acry.yaml  |  49 ++
>  MAINTAINERS                                   |   2 +-
>  arch/arm/boot/dts/aspeed-g6.dtsi              |  13 +
>  drivers/crypto/aspeed/Kconfig                 |  11 +
>  drivers/crypto/aspeed/Makefile                |   2 +
>  drivers/crypto/aspeed/aspeed-acry.c           | 828 ++++++++++++++++++
>  7 files changed, 941 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
>  create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2600-acry.yaml
>  create mode 100644 drivers/crypto/aspeed/aspeed-acry.c
> 
> -- 
> 2.25.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
