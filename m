Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A107E5F135C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiI3UMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiI3UM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:12:29 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC266CD3D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:10:55 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3B70320251;
        Fri, 30 Sep 2022 22:10:49 +0200 (CEST)
Message-ID: <baf046ab-eda2-e8ee-d87f-8d8340823f60@somainline.org>
Date:   Fri, 30 Sep 2022 22:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/8] arm64: dts: qcom: sdm845-tama: Add display nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
 <20220930191049.123256-2-konrad.dybcio@somainline.org>
 <2c1c5d8a-fb7f-bc98-ed6b-021eb00f990f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <2c1c5d8a-fb7f-bc98-ed6b-021eb00f990f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.2022 22:10, Krzysztof Kozlowski wrote:
> On 30/09/2022 21:10, Konrad Dybcio wrote:
>> Add required nodes to support display on XZ2/XZ2c. XZ3 has a
>> different power rail setup and needs to be handled separately.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> ---
>>  .../qcom/sdm845-sony-xperia-tama-akari.dts    |  4 +
>>  .../qcom/sdm845-sony-xperia-tama-akatsuki.dts | 44 ++++++++-
>>  .../qcom/sdm845-sony-xperia-tama-apollo.dts   |  6 ++
>>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 96 +++++++++++++++++++
>>  4 files changed, 149 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
>> index 34f84f1f1eb4..d97b7f1e7140 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dts
>> @@ -11,3 +11,7 @@ / {
>>  	model = "Sony Xperia XZ2";
>>  	compatible = "sony,akari-row", "qcom,sdm845";
>>  };
>> +
>> +&panel {
>> +	compatible = "sony,td4353-jdi-tama";
> 
> git grep suggests it is not documented. Is it coming via different patchset?
As mentioned in the cover letter, yes.

> 
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
>> index 2f5e12deaada..2a16305ac5da 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
>> @@ -10,9 +10,51 @@
>>  / {
>>  	model = "Sony Xperia XZ3";
>>  	compatible = "sony,akatsuki-row", "qcom,sdm845";
>> +
>> +	/* Fixed DCDC for the OLED panel */
>> +	ts_vddio_supply: ts-vddio-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ts_vddio";
>> +
>> +		regulator-min-microvolt = <1840000>;
>> +		regulator-max-microvolt = <1840000>;
>> +
>> +		gpio = <&tlmm 133 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		regulator-boot-on;
>> +	};
>> +};
>> +
>> +&ibb {
>> +	status = "disabled";
>> +};
>> +
>> +&lab {
>> +	status = "disabled";
>> +};
>> +
>> +&panel {
>> +	/* Akatsuki uses an OLED panel. */
>> +	/delete-property/ backlight;
>> +	/delete-property/ vsp-supply;
>> +	/delete-property/ vsn-supply;
>> +	/delete-property/ treset-gpios;
>> +};
>> +
>> +&pmi8998_wled {
>> +	status = "disabled";
>> +};
>> +
>> +&tlmm {
>> +	ts_vddio_en: ts-vddio-en {
> 
> ts-vddio-en-state
> 
> DT schema is coming:
> https://lore.kernel.org/linux-devicetree/20220930200529.331223-1-krzysztof.kozlowski@linaro.org/T/#t
Right, missed this one. Will fix.

Konrad
> 
>> +		pins = "gpio133";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +		output-high;
>> +	};
> 
> Best regards,
> Krzysztof
> 
