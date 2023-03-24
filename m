Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB46C76B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjCXEv5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 00:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:51:54 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E3B453;
        Thu, 23 Mar 2023 21:51:51 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9EEBD24DBFD;
        Fri, 24 Mar 2023 12:51:43 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 12:51:43 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX163.cuchost.com
 (172.16.6.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 12:51:43 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Fri, 24 Mar 2023 12:51:43 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v3 0/4] crypto: starfive - Add drivers for crypto engine
Thread-Topic: [PATCH v3 0/4] crypto: starfive - Add drivers for crypto engine
Thread-Index: AQHZVbQGpGqpyyNhMUOCrVA7ceGTta8JaAiQ
Date:   Fri, 24 Mar 2023 04:51:43 +0000
Message-ID: <734f3a559d28408fa5b95ade203626f2@EXMBX168.cuchost.com>
References: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
In-Reply-To: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jia Jie Ho <jiajie.ho@starfivetech.com>
> Sent: 13 March, 2023 9:57 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Emil Renner Berthing
> <kernel@esmil.dk>; Conor Dooley <conor.dooley@microchip.com>
> Cc: linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org
> Subject: [PATCH v3 0/4] crypto: starfive - Add drivers for crypto engine
> 
> This patch series adds kernel driver support for StarFive JH7110 crypto engine.
> The first patch adds Documentations for the device and Patch 2 adds device
> probe and DMA init for the module. Patch 3 adds crypto and DMA dts node
> for VisionFive 2 board. Patch 4 adds hash/hmac support to the module.
> 
> Patch 3 needs to be applied on top of:
> https://patchwork.kernel.org/project/linux-
> riscv/patch/20230221024645.127922-18-hal.feng@starfivetech.com/
> https://patchwork.kernel.org/project/linux-
> riscv/cover/20230120024445.244345-1-xingyu.wu@starfivetech.com/
> 
> Changes v2->v3:
> - Only implement digest and use fallback for other ops (Herbert)
> - Use interrupt instead of polling for hash complete (Herbert)
> - Remove manual data copy from out-of-bound memory location as it will
>   be handled by DMA API. (Christoph & Herbert)
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
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |   28 +
>  drivers/crypto/Kconfig                        |    1 +
>  drivers/crypto/Makefile                       |    1 +
>  drivers/crypto/starfive/Kconfig               |   21 +
>  drivers/crypto/starfive/Makefile              |    4 +
>  drivers/crypto/starfive/jh7110-cryp.c         |  239 ++++
>  drivers/crypto/starfive/jh7110-cryp.h         |  134 +++
>  drivers/crypto/starfive/jh7110-hash.c         | 1041 +++++++++++++++++
>  10 files changed, 1546 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
>  create mode 100644 drivers/crypto/starfive/Kconfig  create mode 100644
> drivers/crypto/starfive/Makefile  create mode 100644
> drivers/crypto/starfive/jh7110-cryp.c
>  create mode 100644 drivers/crypto/starfive/jh7110-cryp.h
>  create mode 100644 drivers/crypto/starfive/jh7110-hash.c
> 
> --
> 2.25.1


Hi Herbert/David,

Could you please help review this patch series?
Thanks in advance.

Best regards,
Jia Jie
