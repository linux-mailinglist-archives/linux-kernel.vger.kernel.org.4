Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791A68F763
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjBHSsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBHSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:48:24 -0500
Received: from sender4-pp-f116.zoho.com (sender4-pp-f116.zoho.com [136.143.188.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60F3A866
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675882086; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Yb7SIoAqSyVUCaZACfI9Atv9XBR1dP0/ab5pS/fg/Y5Clw2zjBWaOoLwX8IY3Ltm1B/Z+bS7A0Mp/uG47u6AI0HzNoJ2571J52TQ9sJw7gSZQ2JrgdHyY5GeREKn7sJ+TvnMiCrCaPjD1IggkoAXzKnvvpPmXXD0NXWh6nuU5PQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675882086; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=IXicstjHuwguT8Fh/WIHS8GXjy088LWoEqhgeDrK+bQ=; 
        b=Kh7Kbga0w3wD1oYT+NldEN3IN/Rhhar+dTEcs9K/DrWrecnpxbB33b7qfuig5MKp9P71gkXFVZ7VXsjdVZFeeuR3WBKnGtmdIMQ+1pNoVLhzlxMUzdC/OK9O0MBoehSSbv/vudFzv8QGJGArphM7spOuBM3H8kLWvM/De1nBP2Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675882086;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=IXicstjHuwguT8Fh/WIHS8GXjy088LWoEqhgeDrK+bQ=;
        b=D7/BKwpBl6tH8oZ+dAgUFg8F/WEMSoy+7CXWhofQUay7oK8xHFWtxmY5RH8QJYTd
        nNIhhL7Uttbc8Ah8gOYXKZOVThWPP9+72CWqUEkTqgyl0tIkyLmLkqQzUGvoWnfLyj0
        dyG7VnROanuPJYSt38VeYnE3sskeXV0tXR+lKkGg=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1675882083870532.6421856450785; Wed, 8 Feb 2023 10:48:03 -0800 (PST)
Message-ID: <81ecea6c-210d-867d-7e96-25783c5e3d1d@arinc9.com>
Date:   Wed, 8 Feb 2023 21:47:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
 <20230201185656.17164-5-arinc.unal@arinc9.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230201185656.17164-5-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, hold this patch series, I'm going to send v3 soon with enabling both 
CPU ports to support changing the DSA master. We've got developments on 
the MediaTek ethernet driver and MT7530 DSA subdriver that surpassed my 
expectations.

Arınç

On 1.02.2023 21:56, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Mux the MT7530 switch's phy0 to gmac5 which is wired to the SoC's gmac1.
> This achieves 2 Gbps total bandwidth to the CPU using the second RGMII.
> 
> With this, the interface name to access phy0 changes from wan to eth1.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index dc9b4f99eb8b..64700253fd35 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -182,6 +182,12 @@ fixed-link {
>   	};
>   };
>   
> +&gmac1 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +};
> +
>   &eth {
>   	status = "okay";
>   
> @@ -189,6 +195,10 @@ mdio-bus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
>   
> +		ethphy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +
>   		switch@1f {
>   			compatible = "mediatek,mt7530";
>   			reg = <0x1f>;
> @@ -200,11 +210,6 @@ ports {
>   				#address-cells = <1>;
>   				#size-cells = <0>;
>   
> -				port@0 {
> -					reg = <0>;
> -					label = "wan";
> -				};
> -
>   				port@1 {
>   					reg = <1>;
>   					label = "lan0";
