Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF036646B95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiLHJKl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Dec 2022 04:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiLHJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:10:19 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88473F4C;
        Thu,  8 Dec 2022 01:09:48 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0CB9A24DFD7;
        Thu,  8 Dec 2022 17:09:47 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 17:09:47 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 17:09:46 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Thu, 8 Dec 2022 17:09:46 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH 0/6] crypto: starfive: Add driver for cryptographic engine
Thread-Topic: [PATCH 0/6] crypto: starfive: Add driver for cryptographic
 engine
Thread-Index: AQHZBH/pPWRKQfsetk2izJkM4PGjPq5jvsYw
Date:   Thu, 8 Dec 2022 09:09:46 +0000
Message-ID: <e1e9f1d19982493b89ae63f51e00a3bb@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
In-Reply-To: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
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
> From: JiaJie Ho <jiajie.ho@starfivetech.com>
> Sent: Wednesday, November 30, 2022 1:52 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-crypto@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org; JiaJie Ho
> <jiajie.ho@starfivetech.com>
> Subject: [PATCH 0/6] crypto: starfive: Add driver for cryptographic engine
> 
> This patch series adds kernel driver support for Starfive crypto engine.
> The engine supports hardware acceleration for HMAC/hash functions, AES
> block cipher operations and RSA. The first patch adds basic driver for device
> probe and DMA init. The subsequent patches adds supported crypto
> primitives to the driver which include hash functions, AES and RSA. Patch 5
> adds documentation to describe device tree bindings and the last patch adds
> device node to VisionFive 2 dts.
> 
> The driver has been tested with crypto selftest and additional test.
> 
> This patch series depends on the following patches:
> https://patchwork.kernel.org/project/linux-
> riscv/cover/20221118010627.70576-1-hal.feng@starfivetech.com/
> https://patchwork.kernel.org/project/linux-
> riscv/cover/20221118011714.70877-1-hal.feng@starfivetech.com/
> 
> Jia Jie Ho (6):
>   crypto: starfive - Add StarFive crypto engine support
>   crypto: starfive - Add hash and HMAC support
>   crypto: starfive - Add AES skcipher and aead support
>   crypto: starfive - Add Public Key algo support
>   dt-bindings: crypto: Add bindings for Starfive crypto driver
>   riscv: dts: starfive: Add crypto and DMA node for VisionFive 2
> 

Hi Herbert/David,

Could you please help to review and provide comments on this patch series?
Thank you in advance.

Best regards,
Jia Jie 


