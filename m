Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99C690DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBIQAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBIQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:00:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB606199;
        Thu,  9 Feb 2023 08:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D604B8214B;
        Thu,  9 Feb 2023 16:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07163C433D2;
        Thu,  9 Feb 2023 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958409;
        bh=2qBfEXH1sysFsQEHBBrLRbJmDsQNAiiHqAZPuG0VX1g=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=d0UxyZG4a9phB5e+8r5b19rLlawNmw3xm9hRnpcHCd2N8I0QwjqCHM+F635cRp4/M
         0ENEdxt30XzkD56yPXNx/zLwbq7lAlyTGez3ny6JFnb44KhkauPkzgCytd6GeaLslq
         GbqyayTxU0J70CgWCquflyxQdBowha/YRkHMEpIKlUJRcC2hMBVd1q78PsE6pPZkKc
         aaWJY55MAprYDQHqxGzA6LMh1lKjzAIx1RYvcqgBgVaAFLrpjqYIgonCw4BoXcDLEZ
         j0fJy6+jubeex5/vqnRLfLvOrLEXk3H73SBePGGQ/6yVuSg2tCaOVA9SqTy/YZQ9+e
         DLryY43pVpRKA==
Message-ID: <757804b7-8a63-db1c-afab-3c0c1a602807@kernel.org>
Date:   Thu, 9 Feb 2023 17:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Add geni debug uart node for
 qup0
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
 <c122426f-53d5-b5ee-9a15-0a735da4bc29@kernel.org>
In-Reply-To: <c122426f-53d5-b5ee-9a15-0a735da4bc29@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 16:11, Krzysztof Kozlowski wrote:
> On 08/02/2023 13:27, Bhupesh Sharma wrote:
>> qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
>> Add the debug uart node in sm6115 dtsi file.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>  Changes since v1:
>>   - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221128171215.1768745-1-bhupesh.sharma@linaro.org/
>>   - Addressed Konrad's review comments on v1.
>>   - Rebased againt latest linux-next/master which now has the 'qupv3_id_0' node
>>     already in the dtsi file, so just add the debug uart node in v2.
>>
>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index 50cb8a82ecd5..3eccfb8c16ce 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -963,6 +963,15 @@ spi4: spi@4a90000 {
>>  				status = "disabled";
>>  			};
>>  
>> +			uart4: serial@4a90000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0x04a90000 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>>  			i2c5: i2c@4a94000 {
>>  				compatible = "qcom,geni-i2c";
>>  				reg = <0x04a94000 0x4000>;
>> @@ -992,7 +1001,6 @@ spi5: spi@4a94000 {
>>  				dma-names = "tx", "rx";
>>  				#address-cells = <1>;
>>  				#size-cells = <0>;
>> -				status = "disabled";
> 
> Why do you enable SPI? The commit msg is not explaining it.

Sent fixup:
https://lore.kernel.org/linux-arm-msm/20230209155831.100066-1-krzysztof.kozlowski@linaro.org/T/#u

Best regards,
Krzysztof

