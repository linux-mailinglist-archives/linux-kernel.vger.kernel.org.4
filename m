Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8396A0550
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjBWJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjBWJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:53:11 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CEA3580;
        Thu, 23 Feb 2023 01:53:08 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DC40724E2B4;
        Thu, 23 Feb 2023 17:53:00 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 17:53:00 +0800
Received: from [192.168.125.82] (113.72.147.165) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 17:53:00 +0800
Message-ID: <a97861d1-c20a-6c9b-82ac-8e6b72b6318e@starfivetech.com>
Date:   Thu, 23 Feb 2023 17:52:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud> <72953dc9371b87da8d03c63633d7d9dd.sboyd@kernel.org>
 <Y/VWNPfApsfm3/UD@spud>
 <c0472d7f-56fe-3e91-e0a0-49ee51700b5d@starfivetech.com>
 <Y/ZCRv3jHwFxN1Fo@spud>
 <63d0e2a9-84b9-6637-6bbf-dedb2527eaa5@starfivetech.com>
 <74F2E9C9-A606-4BCE-BB00-780619F851AE@kernel.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <74F2E9C9-A606-4BCE-BB00-780619F851AE@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 06:18:01 +0000, Conor Dooley wrote:
> On 23 February 2023 03:03:04 GMT, Hal Feng <hal.feng@starfivetech.com> wrote:
>>On Wed, 22 Feb 2023 16:26:46 +0000, Conor Dooley wrote:
>>> On Wed, Feb 22, 2023 at 09:27:37PM +0800, Hal Feng wrote:
>>>> On Tue, 21 Feb 2023 23:39:32 +0000, Conor Dooley wrote:
>>>> > On Tue, Feb 21, 2023 at 02:17:17PM -0800, Stephen Boyd wrote:
>>>> >> Quoting Conor Dooley (2023-02-16 10:20:34)
>>>> >> > On Thu, Feb 16, 2023 at 10:42:20PM +0800, Hal Feng wrote:
>>>> >> > > On Tue, 27 Dec 2022 20:15:20 +0000, Conor Dooley wrote:
>>>> >> > > > On Mon, Dec 26, 2022 at 12:26:32AM +0800, Hal Feng wrote:
>>>> >> > > Please see the picture of these external clocks in clock tree.
>>>> >> > > 
>>>> >> > > # mount -t debugfs none /mnt
>>>> >> > > # cat /mnt/clk/clk_summary
>>>> >> > >                                  enable  prepare  protect                                duty  hardware
>>>> >> > >    clock                          count    count    count        rate   accuracy phase  cycle    enable
>>>> >> > > -------------------------------------------------------------------------------------------------------
>>>> >> > >  *mclk_ext*                             0        0        0    12288000          0     0  50000         Y
>>>> >> > >  *tdm_ext*                              0        0        0    49152000          0     0  50000         Y
>>>> >> > >  *i2srx_lrck_ext*                       0        0        0      192000          0     0  50000         Y
>>>> >> > >  *i2srx_bclk_ext*                       0        0        0    12288000          0     0  50000         Y
>>>> >> > >  *i2stx_lrck_ext*                       0        0        0      192000          0     0  50000         Y
>>>> >> > >  *i2stx_bclk_ext*                       0        0        0    12288000          0     0  50000         Y
>>>> >> > >  *gmac1_rgmii_rxin*                     0        0        0   125000000          0     0  50000         Y
>>>> >> > >     gmac1_rx                          0        0        0   125000000          0     0  50000         Y
>>>> >> > >        gmac1_rx_inv                   0        0        0   125000000          0   180  50000         Y
>>>> >> > >  *gmac1_rmii_refin*                     0        0        0    50000000          0     0  50000         Y
>>>> >> > >     gmac1_rmii_rtx                    0        0        0    50000000          0     0  50000         Y
>>>> >> > >        gmac1_tx                       0        0        0    50000000          0     0  50000         N
>>>> >> > >           gmac1_tx_inv                0        0        0    50000000          0   180  50000         Y
>>>> >> > >  *osc*                                  4        4        0    24000000          0     0  50000         Y
>>>> >> > >     apb_func                          0        0        0    24000000          0     0  50000         Y
>>>> >> > >  ...
>>>> >> > > 
>>>> >> > > The clock "gmac1_rgmii_rxin" and the clock "gmac1_rmii_refin" are
>>>> >> > > actually used as the parent of other clocks.
>>>> >> > 
>>>> >> > > The "dummy" clocks
>>>> >> > > you said are all internal clocks.
>>>> >> > 
>>>> >> > No, what I meant by "dummy" clocks is that if you make clocks "required"
>>>> >> > in the binding that are not needed by the hardware for operation a
>>>> >> > customer of yours might have to add "dummy" clocks to their devicetree
>>>> >> > to pass dtbs_check.
>>>> >> 
>>>> >> They can set the phandle specifier to '<0>' to fill in the required
>>>> >> property when there isn't anything there. If this is inside an SoC, it
>>>> >> is always connected because silicon can't change after it is made
>>>> >> (unless this is an FPGA). Therefore, any and all input clocks should be
>>>> >> listed as required.
>>>> > 
>>>> >> If the clk controller has inputs that are
>>>> >> pads/balls/pins on the SoC then they can be optional if a valid design
>>>> >> can leave those pins not connected.
>>>> > 
>>>> > From the discussion on the dts patches, where the clocks have been put
>>>> > (intentionally) into board.dts, I've been under the impression that we
>>>> > are in this situation.
>>>> 
>>>> For the system (sys) clock controller, we are in this situation.
>>>> For the always-on (aon) clock controller, we are not, because some input
>>>> clocks are inside the SoC.
>>>> 
>>>> > Up to Hal to tell us if the hardware is capable of having those inputs
>>>> > left unfilled!
>>>> 
>>>> The situation is different for v1.2A and v1.3B boards.
>>>> 
>>>> For the v1.2A board,
>>>> gmac1 only requires "gmac1_rmii_refin", which support 100MHz
>>>> gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz
>>>> 
>>>> For the v1.3B board,
>>>> gmac1 only requires "gmac1_rgmii_rxin", which support 1000MHz
>>>> gmac0 only requires "gmac0_rgmii_rxin", which support 1000MHz
>>>> 
>>>> So we should set the "required" property depending on different
>>>> boards.
>>> 
>>> These were Krzk's suggestions:
>>> oneOf:
>>>  - clock-names:
>>>      minItems: 3
>>>      items:
>>>        - a
>>>        - b
>>>        - c
>>>        - d
>>>  - clock-names:
>>>      items:
>>>        - a
>>>        - b
>>>        - d
>>> 
>>> or maybe:
>>>  - clock-names:
>>>      minItems: 3
>>>      items:
>>>        - a
>>>        - b
>>>        - enum: [c, d]
>>>        - d
>>> 
>>> Might be making a mess here, but I think that becomes:
>>>   clock-names:
>>>     oneOf:
>>>       - items:
>>>           - const: osc
>>>           - enum:
>>>               - gmac1_rmii_refin
>>>               - gmac1_rgmii_rxin
>>>           - const: i2stx_bclk_ext
>>>           - const: i2stx_lrck_ext
>>>           - const: i2srx_bclk_ext
>>>           - const: i2srx_lrck_ext
>>>           - const: tdm_ext
>>>           - const: mclk_ext
>>> 
>>>       - items:
>>>           - const: osc
>>>           - const: gmac1_rmii_refin
>>>           - const: gmac1_rgmii_rxin
>>>           - const: i2stx_bclk_ext
>>>           - const: i2stx_lrck_ext
>>>           - const: i2srx_bclk_ext
>>>           - const: i2srx_lrck_ext
>>>           - const: tdm_ext
>>>           - const: mclk_ext
>>
>>Will modify it and improve the description of clock items for
>>pointing out which clock is required on different boards.
> 
> I don't think you need to mention the boards in it.

Got it. Thanks.

Best regards,
Hal

> 
>>Thank you all for your helpful suggestions.

