Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54CB643BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFDtF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 22:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFDtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:49:02 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D651ADBF;
        Mon,  5 Dec 2022 19:49:00 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B4A9A24DBE9;
        Tue,  6 Dec 2022 11:48:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 11:48:52 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Tue, 6 Dec 2022 11:48:52 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto
 driver
Thread-Topic: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive
 crypto driver
Thread-Index: AQHZBH/2P5dLP9b8iUC7OZp9LCFzsa5W9X0AgAlLclA=
Date:   Tue, 6 Dec 2022 03:48:52 +0000
Message-ID: <14a3facb1fe642cba0048f2f2d0eb2e9@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-6-jiajie.ho@starfivetech.com>
 <166981596611.1846501.537832446745968339.robh@kernel.org>
In-Reply-To: <166981596611.1846501.537832446745968339.robh@kernel.org>
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
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, November 30, 2022 9:48 PM
> To: JiaJie Ho <jiajie.ho@starfivetech.com>
> Cc: linux-crypto@vger.kernel.org; linux-riscv@lists.infradead.org; Rob
> Herring <robh+dt@kernel.org>; Herbert Xu
> <herbert@gondor.apana.org.au>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; David S . Miller <davem@davemloft.net>
> Subject: Re: [PATCH 5/6] dt-bindings: crypto: Add bindings for Starfive crypto
> driver
> 
> 
> On Wed, 30 Nov 2022 13:52:13 +0800, Jia Jie Ho wrote:
> > Add documentation to describe Starfive crypto driver bindings.
> >
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> > ---
> >  .../bindings/crypto/starfive-crypto.yaml      | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/crypto/starfive-crypto.yaml
> >
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/crypto/starfive-
> crypto.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No
> such file or directory
>    21 |         #include <dt-bindings/clock/starfive-jh7110.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:406:
> Documentation/devicetree/bindings/crypto/starfive-crypto.example.dtb]
> Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-
> bindings/patch/20221130055214.2416888-6-jiajie.ho@starfivetech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 

Hi Rob Herring,

The #include in example have dependencies on the following patches:
https://patchwork.kernel.org/project/linux-riscv/cover/20221118010627.70576-1-hal.feng@starfivetech.com/
https://patchwork.kernel.org/project/linux-riscv/cover/20221118011714.70877-1-hal.feng@starfivetech.com/
I've noted them in the cover letter.
How do I add them in this patch?

Thanks,
Jia Jie
