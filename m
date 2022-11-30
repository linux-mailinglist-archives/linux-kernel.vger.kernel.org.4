Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60463D25D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiK3Jr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbiK3JrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:47:24 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A61D337;
        Wed, 30 Nov 2022 01:47:21 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D96A524E342;
        Wed, 30 Nov 2022 17:47:09 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 17:47:09 +0800
Received: from [192.168.125.106] (113.72.147.18) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 17:47:08 +0800
Message-ID: <768c2add-4c1f-0b36-5709-dbcdd560f504@starfivetech.com>
Date:   Wed, 30 Nov 2022 17:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 09/14] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-10-hal.feng@starfivetech.com>
 <1d62f95f-0edc-afd4-abb4-37fadc0b6a47@linaro.org>
 <72b3d10e-5a8e-ed42-6808-f53773913422@starfivetech.com>
In-Reply-To: <72b3d10e-5a8e-ed42-6808-f53773913422@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.18]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 14:41:12 +0800, Hal Feng wrote:
> On Mon, 21 Nov 2022 09:47:08 +0100, Krzysztof Kozlowski wrote:
> > On 18/11/2022 02:06, Hal Feng wrote:
> > > From: Emil Renner Berthing <kernel@esmil.dk>
> > > 
> > > Add bindings for the system clock and reset generator (SYSCRG) on the
> > > JH7110 RISC-V SoC by StarFive Ltd.
> > > 
> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > 
> > Binding headers are coming with the file bringing bindings for the
> > device, so you need to squash patches.
> 
> As we discussed in patch 7, could I merge patch 7, 8, 9, 10 and add the
> following files in one commit?
> 
> include/dt-bindings/clock/starfive,jh7110-crg.h
> include/dt-bindings/reset/starfive,jh7110-crg.h
> Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml

Hi, Krzysztof,

Could you please give me some suggestions?

Best regards,
Hal

> 
> > 
> > > ---
> > >  .../clock/starfive,jh7110-syscrg.yaml         | 80 +++++++++++++++++++
> > >  MAINTAINERS                                   |  2 +-
> > >  2 files changed, 81 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> 

