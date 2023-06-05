Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04B3722D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjFERBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjFERBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:01:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF530EA;
        Mon,  5 Jun 2023 10:01:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355H1Lgw079322;
        Mon, 5 Jun 2023 12:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685984481;
        bh=lSN/X+qqnpCellhQEw5dxATrMURNyrkvsY0vQP4ikJM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CBHT4DeI4oxj8DHwfolcqCHBUJ/FWs201zbAmJcO51B0D75zJ5USEON6d1ZleX8y2
         sQfbihKtUR40SD35q8WX2H32hjU6r5vpO5cOAVx6Mttrw9oVYcvxwxety9VUVqAJcJ
         7bB+5DYZwz59PvQ8cdNF6vu9LJdIaxIfvNLFRjB8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355H1L3d103642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 12:01:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 12:01:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 12:01:21 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355H1H5e104461;
        Mon, 5 Jun 2023 12:01:18 -0500
Message-ID: <f1e54167-15bd-8a0b-454d-53b90b18a343@ti.com>
Date:   Mon, 5 Jun 2023 22:31:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/12] arm64: dts: ti: k3-j721e-beagleboneai64: Fixup
 reference to phandles array
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Robert Nelson <robertcnelson@gmail.com>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-4-nm@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230601152636.858553-4-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 6/1/2023 8:56 PM, Nishanth Menon wrote:
> When referring to array of phandles, using <> to separate the array
> entries is better notation as it makes potential errors with phandle and
> cell arguments easier to catch. Fix the outliers to be consistent with
> the rest of the usage.
>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 29 ++++++++++---------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> index 37c24b077b6a..c13246a9ed8f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
> @@ -593,7 +593,7 @@ &main_i2c0 {
>   &main_i2c1 {
>   	status = "okay";
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&main_i2c1_pins_default &csi1_gpio_pins_default>;
> +	pinctrl-0 = <&main_i2c1_pins_default>, <&csi1_gpio_pins_default>;
>   	clock-frequency = <400000>;
>   };
>   
> @@ -623,7 +623,7 @@ &main_i2c4 {
>   &main_i2c5 {
>   	status = "okay";
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&main_i2c5_pins_default &csi0_gpio_pins_default>;
> +	pinctrl-0 = <&main_i2c5_pins_default>, <&csi0_gpio_pins_default>;
>   	clock-frequency = <400000>;
>   };
>   
> @@ -639,7 +639,7 @@ &main_i2c6 {
>   &wkup_i2c0 {
>   	status = "okay";
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&wkup_i2c0_pins_default &eeprom_wp_pins_default>;
> +	pinctrl-0 = <&wkup_i2c0_pins_default>, <&eeprom_wp_pins_default>;
>   	clock-frequency = <400000>;

Why we need more than 2 pio lines for i2c node ,


> [...]
>
