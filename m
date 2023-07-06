Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F574A370
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGFRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGFRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:49:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC62B7;
        Thu,  6 Jul 2023 10:49:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A197D75;
        Thu,  6 Jul 2023 10:50:21 -0700 (PDT)
Received: from [10.57.27.160] (unknown [10.57.27.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5D43F740;
        Thu,  6 Jul 2023 10:49:37 -0700 (PDT)
Message-ID: <9d9245fb-463f-c967-46e5-cfc0ac832792@arm.com>
Date:   Thu, 6 Jul 2023 18:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFT PATCH 1/3] arm64: dts: rockchip: correct audio-codec
 interrupt flag in eaidk-610
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
 <941ead9e-9e46-b5cb-0a8b-345df6606484@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <941ead9e-9e46-b5cb-0a8b-345df6606484@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-06 14:54, Krzysztof Kozlowski wrote:
> On 05/07/2023 08:48, Krzysztof Kozlowski wrote:
>> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
>> These are simple defines so they could be used in DTS but they will not
>> have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.
>>
>> Correct the interrupt flags, assuming the author of the code wanted same
>> logical behavior behind the name "ACTIVE_xxx", this is:
>>    ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
> 
> This should be HIGH in both cases. I will send a v2.

Also the titles say "audio-codec" but they're all touching SDIO WiFi 
modules ;)

Cheers,
Robin.

>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
>> index d1f343345f67..6464ef4d113d 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts
>> @@ -773,7 +773,7 @@ brcmf: wifi@1 {
>>   		compatible = "brcm,bcm4329-fmac";
>>   		reg = <1>;
>>   		interrupt-parent = <&gpio0>;
>> -		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
>> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
