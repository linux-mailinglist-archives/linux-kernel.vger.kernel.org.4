Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D94E747FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjGEI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGEI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:28:28 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814EC1;
        Wed,  5 Jul 2023 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OKt1V04brGM7Posbev7dztO1VXnhUcqd3FOJehN7gl0=; b=LfTuMu+PUhXQToiktymAP/lblZ
        ar4jWeufCkxh7K26l1b1ANddYCn4hYs9irvqlo7mgMdT/t5g8pQF/t6T6VK2xe1tjDzPQog5OJjNX
        mSjalaRcpmEgnVNDu5pNBuEZjBN7OaqqRXakyv5zgmPWjkDE2V1+beLTLYqbfP+b08Z+lJekvFWzA
        M46a93g4j4jcLJ4xa8I4bM3GXXs1sZ2ZY7We/w6xPcUvzO71XkexZj7R+wyxiugX5mMmiIi7p2Eym
        OQ5ElnU9ErWoOehyZQXnLCZC5ZEOWUDV4HUCQbvDZw6LtWGbHet1JM1Tzac7CesUclbJ36IJ54Kyp
        aCbTWdJA==;
Received: from [89.212.21.243] (port=37270 helo=[192.168.69.84])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qGxs8-00DZRl-2x;
        Wed, 05 Jul 2023 10:28:23 +0200
Message-ID: <7ed6fde0-37a4-a667-2629-0a6b8a202a69@norik.com>
Date:   Wed, 5 Jul 2023 10:28:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] ARM: dts: imx6: pfla02: Fix SD card reboot problem
Content-Language: en-GB
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@phytec.de
References: <20230704080304.816942-1-andrej.picej@norik.com>
 <20230704080304.816942-3-andrej.picej@norik.com>
 <20230704081712.7dyj2mspj2m25rp7@pengutronix.de>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20230704081712.7dyj2mspj2m25rp7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 4. 07. 23 10:17, Marco Felsch wrote:
> On 23-07-04, Andrej Picej wrote:
>> If regulator is not marked as always-on the regulator gets disabled on
>> reboot breaking the next boot.
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> index 80adb2a02cc9..25d6a036d5b8 100644
>> --- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
>> @@ -192,6 +192,7 @@ vdd_3v3_pmic_io_reg: ldo6 {
>>   			vdd_sd0_reg: ldo9 {
>>   				regulator-min-microvolt = <3300000>;
>>   				regulator-max-microvolt = <3300000>;
>> +				regulator-always-on;
> 
> I think this is the supply for the sd-card, so you can make use of
> 'vmmc-supply'.

This is already the case:

> &usdhc3 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_usdhc3
> 		     &pinctrl_usdhc3_cdwp>;
> 	cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
> 	wp-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> 	vmmc-supply = <&vdd_sd0_reg>;
> 	status = "disabled";
> };

I think the main reason for a failed boot is that the PMIC doesn't get 
reset and that the bootloader doesn't specifically enable the SD card 
regulator.

Could this patch still be applied or should we put the fix in reset 
routine/bootloader?

Best regards,
Andrej

> 
> Regards,
>    Marco
> 
>>   			};
>>   
>>   			vdd_sd1_reg: ldo10 {
>> -- 
>> 2.25.1
>>
>>
>>
