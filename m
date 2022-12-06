Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F95643C05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiLFDzi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 22:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLFDzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:55:36 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BB715807;
        Mon,  5 Dec 2022 19:55:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9655F24DFC2;
        Tue,  6 Dec 2022 11:55:27 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 11:55:27 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Dec
 2022 11:55:27 +0800
Received: from EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e]) by
 EXMBX068.cuchost.com ([fe80::c4da:cbc4:bb39:ca7e%16]) with mapi id
 15.00.1497.044; Tue, 6 Dec 2022 11:55:27 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Topic: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
 VisionFive 2
Thread-Index: AQHZBH/4vZHP2U3n+EalaiuTkXOjPK5WreUAgAHaqdCAAEbuAIAHdAQg
Date:   Tue, 6 Dec 2022 03:55:27 +0000
Message-ID: <39ac3ec838e94154b232617433910352@EXMBX068.cuchost.com>
References: <20221130055214.2416888-1-jiajie.ho@starfivetech.com>
 <20221130055214.2416888-7-jiajie.ho@starfivetech.com>
 <1673ef8b-179e-3b03-b3f8-8d347c70d8c3@microchip.com>
 <4ddddceba3dc437daca27374dd2f6fd7@EXMBX068.cuchost.com>
 <Y4jslJfTVtQ9cIGm@spud>
In-Reply-To: <Y4jslJfTVtQ9cIGm@spud>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Friday, December 2, 2022 2:04 AM
> To: JiaJie Ho <jiajie.ho@starfivetech.com>
> Cc: Conor.Dooley@microchip.com; robh+dt@kernel.org;
> herbert@gondor.apana.org.au; linux-crypto@vger.kernel.org;
> kernel@esmil.dk; davem@davemloft.net; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> krzysztof.kozlowski+dt@linaro.org
> Subject: Re: [PATCH 6/6] riscv: dts: starfive: Add crypto and DMA node for
> VisionFive 2
> 
> On Thu, Dec 01, 2022 at 06:17:26AM +0000, JiaJie Ho wrote:
> > > -----Original Message-----
> > > From: Conor.Dooley@microchip.com <Conor.Dooley@microchip.com>
> 
> In that case, the SoB block should look like:
> 
> Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> 
> Similarly for any other patches they may have co-developed :)
> 

I'll add these in the v2.

> If the hardware is always present, why not drop the "disabled" in jh7110.dtsi
> & these two entries marking them as "okay" in the .dts?
> 

Okay, I'll update these too. 
Thanks again for the suggestions.

Best regards,
Jia Jie
