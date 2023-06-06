Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5972363A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjFFE1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFFE1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:27:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344DE9;
        Mon,  5 Jun 2023 21:27:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3564R2G6011428;
        Mon, 5 Jun 2023 23:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686025622;
        bh=FIPNTJ55+O8pfA+2hNYmxOBP3WYDVOgIvEjnuDIr1lo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cgVyFAh1QtrdkfzGUkwqJzVspxDI24qfp+cYf6Ljp1iYVWVd3n9SccsbodAa0wUf+
         KUMFxcrCmUWrBIa8Rp3R2DH9KBAZHO0u8gDCuBGNnaxRwH1k9bHY956EpsNN8EBjN0
         JeuhsE0ny5WHK49X4LtvCorSA+eXsfxkaU6Xd0cs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3564R2sm032716
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 23:27:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 23:27:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 23:27:01 -0500
Received: from [172.24.156.168] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3564QwoE082232;
        Mon, 5 Jun 2023 23:26:59 -0500
Message-ID: <cbd314b6-08a9-7a07-7538-c2e3f1b333e9@ti.com>
Date:   Tue, 6 Jun 2023 09:56:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/12] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup
 reference to phandles array
To:     Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-4-nm@ti.com>
 <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com>
 <20230605204930.3hlg3d36zwtbkal7@scone>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230605204930.3hlg3d36zwtbkal7@scone>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 6/6/2023 2:19 AM, Nishanth Menon wrote:
> On 22:31-20230605, Kumar, Udit wrote:
> [...]
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
>>> index 37c24b077b6a..c13246a9ed8f 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> [...]
>>> @@ -639,7 +639,7 @@ &main_i2c6 {
>>>    &wkup_i2c0 {
>>>    	status = "okay";
>>>    	pinctrl-names = "default";
>>> -	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
>>> +	pinctrl-0 = <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default>;
>>>    	clock-frequency = <400000>;
>> Why we need more than 2 pio lines for i2c node ,
> pio lines? I am not sure I understand. If you are suggesting
> eeprom_wp_pins to be moved to the eeprom node, It is probably
> un-related to this series, but OK, i think it is probably a valid
> change (unless Robert sees a reason why he did it the way he did).

correct, I am suggesting to move  eeprom_wp_pins_default to eeprom node.

i2c needs 2 lines which are defined in wkup_i2c0_pins_default, Adding 
eeprom_wp_pins_default will not be true representation of i2c node.

It will be good to have similar changes in main_i2c1 and main_i2c5  node 
for csi0_gpio_pins_default and csi1_gpio_pins_default.


