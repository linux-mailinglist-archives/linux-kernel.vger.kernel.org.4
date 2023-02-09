Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72E690C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBIPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBIPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:12:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B015BA44;
        Thu,  9 Feb 2023 07:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C602CB82197;
        Thu,  9 Feb 2023 15:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23088C433EF;
        Thu,  9 Feb 2023 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675955519;
        bh=cOBvqeLETPxLw9X8pX0kEtBQ+MndP6A5xsW9XnyXqbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i0s0rPrE0iNDl1FZat/nmx1kdTHck+jW4Y18/StgkfB2V0OOT2DwUHhTRZeNiA0oD
         kTGxR9/+i+0qReQ7adcg9g/NZSKvE3Rgt8RTDd3bIAuhTwvMdhSud9W9GN1SvukNSZ
         E3a9gyVmuQBmPVSU/eJxGNKcPbMhI0FtSCQBqh7VzXvEM/Qk9/QTN6KvcFckRAYH6G
         +WcRCzoxg1MR+TTJqhONa5Rb6wpToLlgG4fmlzabFi9eaoogaCWhlqibwqNSQ9O2RQ
         VocDTqiGrOLlTYhHpH+LUKgRIoFhA9FLrYLUzCehYpLgcaINLOLB/3cTBYEkr98YP5
         31ivfAo8uw/eg==
Message-ID: <c122426f-53d5-b5ee-9a15-0a735da4bc29@kernel.org>
Date:   Thu, 9 Feb 2023 16:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Add geni debug uart node for
 qup0
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 13:27, Bhupesh Sharma wrote:
> qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
> Add the debug uart node in sm6115 dtsi file.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Changes since v1:
>   - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221128171215.1768745-1-bhupesh.sharma@linaro.org/
>   - Addressed Konrad's review comments on v1.
>   - Rebased againt latest linux-next/master which now has the 'qupv3_id_0' node
>     already in the dtsi file, so just add the debug uart node in v2.
> 
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 50cb8a82ecd5..3eccfb8c16ce 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -963,6 +963,15 @@ spi4: spi@4a90000 {
>  				status = "disabled";
>  			};
>  
> +			uart4: serial@4a90000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0x04a90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>  			i2c5: i2c@4a94000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0x04a94000 0x4000>;
> @@ -992,7 +1001,6 @@ spi5: spi@4a94000 {
>  				dma-names = "tx", "rx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				status = "disabled";

Why do you enable SPI? The commit msg is not explaining it.

Best regards

