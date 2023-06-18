Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE773461D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjFRMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 08:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjFRMWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 08:22:23 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0FD124;
        Sun, 18 Jun 2023 05:22:17 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DAC017FEF;
        Sun, 18 Jun 2023 20:22:08 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 18 Jun
 2023 20:22:08 +0800
Received: from [192.168.125.127] (113.72.145.217) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 18 Jun
 2023 20:22:07 +0800
Message-ID: <a91f4167-e797-435f-8867-dbef4b109df8@starfivetech.com>
Date:   Sun, 18 Jun 2023 20:22:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-6-minda.chen@starfivetech.com>
 <20230525-shopper-handbrake-27fc06aede32@spud>
 <5124e6a8-8ca6-71a5-19d6-8c15e954c458@starfivetech.com>
 <20230526-grain-cubical-e0af96202007@wendy>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230526-grain-cubical-e0af96202007@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.217]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 21:13, Conor Dooley wrote:
> On Fri, May 26, 2023 at 06:24:48PM +0800, Minda Chen wrote:
> 
>> >> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD controller
>> > 
>> > I think you told Krzysztof you'd rename this to "StarFive JH7110 Cadence
>> > USBSS-DRD SoC controller"?
>> > 
>> The previous title describe whole USB controller for previous dts node is
>> merged. Now the dts node is split. 
>> "starfive,jh7110-usb" just contain starfive wrapper layer dts configuration.
> 
> Okay, I must have misunderstood the conversation on the previous
> version. Sorry about that.
> 
>> > Otherwise, it looks like all the stuff from him and Rob have been sorted
>> > out, so other than $title this is
>> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

Hi Greg
Can this patch can be applied to Linux-USB-next tree? Since this patch is reviewed by Conor.

List Below is Conor's previous E-mail.

   I think I missed this mail somehow. 5/7 had the binding for the driver
   so probably that should've gone via the USB tree too?
   Should apply on its own (no deps on the phy patches) & has dt-binding
   maintainer reviews.

   `b4 am -P 5 20230518112750.57924-6-minda.chen@starfivetech.com` if
   that's your cup of tea.
