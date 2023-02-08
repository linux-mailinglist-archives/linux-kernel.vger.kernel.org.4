Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3CF68F1A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBHPKg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 10:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjBHPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:10:13 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4DC222CA;
        Wed,  8 Feb 2023 07:10:09 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D28A824E12B;
        Wed,  8 Feb 2023 23:10:01 +0800 (CST)
Received: from EXMBX064.cuchost.com (172.16.6.64) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Feb
 2023 23:10:01 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX064.cuchost.com
 (172.16.6.64) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 8 Feb
 2023 23:10:01 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Wed, 8 Feb 2023 23:10:01 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 0/4] crypto: starfive - Add drivers for crypto engine
Thread-Topic: [PATCH v2 0/4] crypto: starfive - Add drivers for crypto engine
Thread-Index: AQHZNMHj24kMYgm7ukiZl0u5RF7lfq7FM/vg
Date:   Wed, 8 Feb 2023 15:10:01 +0000
Message-ID: <685bf9174a354c5c9b2ada538a89b785@EXMBX168.cuchost.com>
References: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
In-Reply-To: <20230130154242.112613-1-jiajie.ho@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.190.105.77]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jia Jie Ho <jiajie.ho@starfivetech.com>
> Sent: 30 January, 2023 11:43 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Emil Renner Berthing
> <kernel@esmil.dk>; Conor Dooley <conor.dooley@microchip.com>
> Cc: linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> Subject: [PATCH v2 0/4] crypto: starfive - Add drivers for crypto engine
> 
> This patch series adds kernel driver support for StarFive JH7110 crypto engine.
> The first patch add Documentations for the device and Patch 2 adds device
> probe and DMA init for the module. Patch 3 adds crypto and DMA dts node
> for VisionFive 2 board. Patch 4 adds hash/hmac support to the module.
> 
> Patch 3 needs to be applied on top of:
> https://patchwork.kernel.org/project/linux-
> riscv/patch/20221220011247.35560-7-hal.feng@starfivetech.com/
> https://patchwork.kernel.org/project/linux-
> riscv/cover/20230120024445.244345-1-xingyu.wu@starfivetech.com/
> 
> Changes v1->v2:
> - Fixed yaml filename and format (Krzysztof)
> - Removed unnecessary property names in yaml (Krzysztof)
> - Moved of_device_id table close to usage (Krzysztof)
> - Use dev_err_probe for error returns (Krzysztof)
> - Dropped redundant readl and writel wrappers (Krzysztof)
> - Updated commit signed offs (Conor)
> - Dropped redundant node in dts, module set to on in dtsi (Conor)
> 
> Jia Jie Ho (4):
>   dt-bindings: crypto: Add StarFive crypto module
>   crypto: starfive - Add crypto engine support
>   riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
>   crypto: starfive - Add hash and HMAC support
> 
>  .../crypto/starfive,jh7110-crypto.yaml        |   70 ++
>  MAINTAINERS                                   |    7 +
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   27 +
>  drivers/crypto/Kconfig                        |    1 +
>  drivers/crypto/Makefile                       |    1 +
>  drivers/crypto/starfive/Kconfig               |   20 +
>  drivers/crypto/starfive/Makefile              |    4 +
>  drivers/crypto/starfive/starfive-cryp.c       |  238 ++++
>  drivers/crypto/starfive/starfive-hash.c       | 1095 +++++++++++++++++
>  drivers/crypto/starfive/starfive-regs.h       |   71 ++
>  drivers/crypto/starfive/starfive-str.h        |   99 ++
>  11 files changed, 1633 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
>  create mode 100644 drivers/crypto/starfive/Kconfig  create mode 100644
> drivers/crypto/starfive/Makefile  create mode 100644
> drivers/crypto/starfive/starfive-cryp.c
>  create mode 100644 drivers/crypto/starfive/starfive-hash.c
>  create mode 100644 drivers/crypto/starfive/starfive-regs.h
>  create mode 100644 drivers/crypto/starfive/starfive-str.h
> 
> --
> 2.25.1

Hi all,

Could you please review this patch series?
Or should I send a new version with Rob's sign-off on patch 1?
Thank you in advance.

Best regards,
Jia Jie

