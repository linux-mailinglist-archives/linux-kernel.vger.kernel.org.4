Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF663373F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiKVIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKVIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:35:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367744092E;
        Tue, 22 Nov 2022 00:35:20 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 716612D9;
        Tue, 22 Nov 2022 09:35:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669106118;
        bh=YlboxYqJIdlrRB8uXxg6m6iestgCL1+GiErR7mO0mFs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j8jGbyFXwpUXOcckyqpLUNJ1L68wSARaaiOrO/lF6xFvItrfAzyYe7m2X/Csj/oQb
         JG9iszc4aB+SQalK/L5TGWws+umdvdoJ7PAHD0nUyLSlYs6AnHKSEnyrJrEwlH9tUe
         yZpshEx8NCa/NWkh9etXXP8bu1HF/Witcbt81PjA=
Message-ID: <3c012152-a031-65ef-1fe7-9d8e690947fa@ideasonboard.com>
Date:   Tue, 22 Nov 2022 10:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 4/8] arm64: dts: renesas: r8a779g0: Add display related
 data
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-5-tomi.valkeinen@ideasonboard.com>
 <166869741913.50677.3537704052215375530@Monstersaurus>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <166869741913.50677.3537704052215375530@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 17:03, Kieran Bingham wrote:
> Quoting Tomi Valkeinen (2022-11-17 12:25:43)
>> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>>
>> Add DT nodes for components needed to get the DSI output working:
>> - FCPv
>> - VSPd
>> - DU
>> - DSI
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> ---
>>   arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 129 ++++++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> index 45d8d927ad26..31d4930c5adc 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
>> @@ -1207,6 +1207,135 @@ prr: chipid@fff00044 {
>>                          compatible = "renesas,prr";
>>                          reg = <0 0xfff00044 0 4>;
>>                  };
> 
> I think these nodes are supposed to be in sort order based on the
> register address in memory.

Ah, I didn't realize that.

> Disregarding sort order, I'll review the node contents.
> 
> I would probably s/data/nodes/ in $SUBJECT too.
> 
> 
>> +
>> +               fcpvd0: fcp@fea10000 {
>> +                       compatible = "renesas,fcpv";
>> +                       reg = <0 0xfea10000 0 0x200>;
>> +                       clocks = <&cpg CPG_MOD 508>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       resets = <&cpg 508>;
>> +               };
>> +
>> +               fcpvd1: fcp@fea11000 {
>> +                       compatible = "renesas,fcpv";
>> +                       reg = <0 0xfea11000 0 0x200>;
>> +                       clocks = <&cpg CPG_MOD 509>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       resets = <&cpg 509>;
>> +               };
> 
> I'm intrigued at the length of 0x200 as I only see 3 registers up to
> 0x0018 ..
> 
> But all existing platforms with fcpv* set 0x200 ... so lets cargo cult it up... :-)
> 
>> +
>> +               vspd0: vsp@fea20000 {
>> +                       compatible = "renesas,vsp2";
>> +                       reg = <0 0xfea20000 0 0x5000>;
> 
> """
> Below are the base addresses of each VSP unit. VSPX has 32Kbyte address
> space. VSPD has 28Kbyte address space.
> """
> 
> Hrm : 28K is 0x7000
> 
> RPf n OSD CLUT Table: H’4000 + H’0400*n to H’43fc + H’0400*n
> 
>   0x43fc+(0x400*5)
> 	22524	[0x57fc]
> 
> So this needs to be /at least/ 0x6000 (Would 0x5800 be odd?) and perhaps as it clearly states
> 28k, we should just set it to 0x7000.

Ok. These are identical to v3u, and I was just copying v3u's dts, 
assuming they're correct. We probably should fix the v3u dts files too.

> 
>> +                       interrupts = <GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpg CPG_MOD 830>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       resets = <&cpg 830>;
>> +
>> +                       renesas,fcp = <&fcpvd0>;
>> +               };
>> +
>> +               vspd1: vsp@fea28000 {
>> +                       compatible = "renesas,vsp2";
>> +                       reg = <0 0xfea28000 0 0x5000>;
> 
> Same here of course (reg = <0 0xfea28000 0 0x7000>)
> 
> 
>> +                       interrupts = <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpg CPG_MOD 831>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       resets = <&cpg 831>;
>> +
>> +                       renesas,fcp = <&fcpvd1>;
>> +               };
>> +
>> +               du: display@feb00000 {
>> +                       compatible = "renesas,du-r8a779g0";
>> +                       reg = <0 0xfeb00000 0 0x40000>;
>> +                       interrupts = <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
>> +                                    <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpg CPG_MOD 411>;
>> +                       clock-names = "du.0";
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       resets = <&cpg 411>;
>> +                       reset-names = "du.0";
>> +                       renesas,vsps = <&vspd0 0>, <&vspd1 0>;
>> +
>> +                       status = "disabled";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +                                       du_out_dsi0: endpoint {
>> +                                               remote-endpoint = <&dsi0_in>;
>> +                                       };
>> +                               };
>> +
>> +                               port@1 {
>> +                                       reg = <1>;
>> +                                       du_out_dsi1: endpoint {
>> +                                               remote-endpoint = <&dsi1_in>;
>> +                                       };
>> +                               };
>> +                       };
>> +               };
>> +
>> +               dsi0: dsi-encoder@fed80000 {
>> +                       compatible = "renesas,r8a779g0-dsi-csi2-tx";
>> +                       reg = <0 0xfed80000 0 0x10000>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       clocks = <&cpg CPG_MOD 415>,
>> +                                <&cpg CPG_CORE R8A779G0_CLK_DSIEXT>,
>> +                                <&cpg CPG_CORE R8A779G0_CLK_DSIREF>;
>> +                       clock-names = "fck", "dsi", "pll";
>> +                       resets = <&cpg 415>;
> 
> blank line here to separate it, and highlight that it's disabled? (Like
> is done for DU?

Ok.

>> +                       status = "disabled";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +                                       dsi0_in: endpoint {
>> +                                               remote-endpoint = <&du_out_dsi0>;
>> +                                       };
>> +                               };
>> +
>> +                               port@1 {
>> +                                       reg = <1>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               dsi1: dsi-encoder@fed90000 {
>> +                       compatible = "renesas,r8a779g0-dsi-csi2-tx";
>> +                       reg = <0 0xfed90000 0 0x10000>;
>> +                       power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
>> +                       clocks = <&cpg CPG_MOD 416>,
>> +                                <&cpg CPG_CORE R8A779G0_CLK_DSIEXT>,
>> +                                <&cpg CPG_CORE R8A779G0_CLK_DSIREF>;
>> +                       clock-names = "fck", "dsi", "pll";
>> +                       resets = <&cpg 416>;
> 
> Same.
> 
> With the VSPD register ranges increased accordingly:
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
>> +                       status = "disabled";
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +                                       dsi1_in: endpoint {
>> +                                               remote-endpoint = <&du_out_dsi1>;
>> +                                       };
>> +                               };
>> +
>> +                               port@1 {
>> +                                       reg = <1>;
>> +                               };
>> +                       };
>> +               };
>> +
>>          };
>>   
>>          timer {
>> -- 
>> 2.34.1
>>

