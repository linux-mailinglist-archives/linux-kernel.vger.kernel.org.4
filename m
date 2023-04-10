Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E106DC74D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDJNgA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 09:35:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE624C09;
        Mon, 10 Apr 2023 06:35:54 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EF6EC24E171;
        Mon, 10 Apr 2023 21:35:44 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 21:35:45 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX164.cuchost.com
 (172.16.6.74) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Apr
 2023 21:35:44 +0800
Received: from EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4]) by
 EXMBX168.cuchost.com ([fe80::3c2d:dee5:4938:3fc4%16]) with mapi id
 15.00.1497.044; Mon, 10 Apr 2023 21:35:44 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Thread-Topic: [PATCH v4 4/4] crypto: starfive - Add hash and HMAC support
Thread-Index: AQHZa3+jdYvISdTjqUmPzN0mADxyja8jpS2AgACU6YD//5HogIAAsqtQ//+FIACAAIes4A==
Date:   Mon, 10 Apr 2023 13:35:44 +0000
Message-ID: <2b33000067d54d9e83d5a81ef102d2a9@EXMBX168.cuchost.com>
References: <20230410073752.39506-1-jiajie.ho@starfivetech.com>
 <20230410073752.39506-5-jiajie.ho@starfivetech.com>
 <ZDO/z++4/TE6AiIz@gondor.apana.org.au>
 <6df549e9-d0f6-23ca-882f-527c4e40b553@starfivetech.com>
 <ZDPgXyGZtMZw5G4q@gondor.apana.org.au>
 <c1925af208b540c2bd78a16bc593ecae@EXMBX168.cuchost.com>
 <ZDQPLGG+DorFwZ+1@gondor.apana.org.au>
In-Reply-To: <ZDQPLGG+DorFwZ+1@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.156.149]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The sequence of event would be:
> > 1. Wait for DMA transfer to complete.
> > 2. Set bit in device CSR to indicate final block has been transferred.
> 
> OK, 2 should be done in the DMA callback function.
> 
> > 3. Device will send IRQ once result is ready.
> > 4. Read out final digest value from device.
> 
> 4 should be done from a tasklet scheduled from the IRQ handler.
> 

I'll update the driver accordingly. 
Thanks again for the advice.

Regards,
Jia Jie
