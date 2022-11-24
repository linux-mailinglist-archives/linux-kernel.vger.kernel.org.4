Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAC637210
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXF4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXF4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:56:31 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097EC6884;
        Wed, 23 Nov 2022 21:56:19 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 886F424DECD;
        Thu, 24 Nov 2022 13:56:11 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 13:56:11 +0800
Received: from [192.168.125.106] (183.27.97.81) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 13:56:10 +0800
Message-ID: <ca3e341a-3dc3-39d6-7e26-89ba65aa9473@starfivetech.com>
Date:   Thu, 24 Nov 2022 13:56:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/8] dt-bindings: riscv: Add StarFive JH7110 SoC and
 VisionFive2 board
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-2-hal.feng@starfivetech.com>
 <202211190418.2AJ4IQjc072382@SH1-CSMTP-DB111.sundns.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <202211190418.2AJ4IQjc072382@SH1-CSMTP-DB111.sundns.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 01:28:48 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > From: Emil Renner Berthing <kernel@esmil.dk>
> >
> > Add device tree bindings for the StarFive JH7110 RISC-V SoC [1]
> > and the VisionFive2 board [2] equipped with it.
> >
> > [1]: https://doc-en.rvspace.org/Doc_Center/jh7110.html
> > [2]: https://doc-en.rvspace.org/Doc_Center/visionfive_2.html
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/starfive.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > index 5b36243fd674..64008c57e31f 100644
> > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > @@ -22,6 +22,10 @@ properties:
> >            - const: beagle,beaglev-starlight-jh7100-r0
> >            - const: starfive,jh7100
> >
> > +      - items:
> > +          - const: starfive,visionfive-v2
> 
> I think StarFive has switched to just calling it VisionFive 2 and not
> V2. Please check up on this before committing to the compatible
> string.
> 
> Also there are going to be different revisions of the VisionFive 2
> board, so maybe consider adding eg. starfive,visionfive-2-v1.1 and
> starfive,visionfive-2-v1,2b early.

I checked that the official name of this board is "VisionFive 2". The
board has version A and version B, which are different in gmac and phy
chip. The version A board has one 1000M and one 100M Ethernet ports
while the version B board has two 1000M Ethernet ports. In dts, they
have different configuration parameters for gmac. So I would like to
distinguish them by two compatibles as below in the next version.

      - items:
          - enum:
              - starfive,visionfive-2-va
              - starfive,visionfive-2-vb
          - const: starfive,jh7110

Best regards,
Hal

> 
> > +          - const: starfive,jh7110
> > +
> >  additionalProperties: true

