Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16E617B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKCLdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:32:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C411A32;
        Thu,  3 Nov 2022 04:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27025CE257D;
        Thu,  3 Nov 2022 11:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E85BC433B5;
        Thu,  3 Nov 2022 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667475175;
        bh=uiqDMEcOZwxNGgwDvcubrHmOWMlm8hOhW9gFyMNNyPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0NkacfzR2k1n5fDpBBmGuncSGs0MH0QZrO5qNaUx3jd+LjIXankFdyHLEO68UxAG
         PK2IIKCwj7OOXynyd7o/b5XXseG5Nt1cEQyUE6cCHY6czxN/I7AYEXCM26IOQlRsWL
         900z0KtlkbOK6XwvYQKfk00GMMxvjeL7FyBb/cKkG7nI7K9TV7SPFpVX+Xzp/rF08N
         ySrkqOn1jEZL0HSsB9ldMPm37hDjwRtz/GCbrYCRO7VxjZjgrJGcL0NS70ZCUpyOeS
         kLK4QT4tTUDR6UrmydH4vkTqftGlU9M1Pg8u4g1xw94NpCY5XOuvoYfqxqoU++f29O
         IbaV7uK8L6XNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oqYSa-0006lO-TC; Thu, 03 Nov 2022 12:32:37 +0100
Date:   Thu, 3 Nov 2022 12:32:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johan+linaro@kernel.org, quic_jprakash@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sc8280xp-x13s: Add
 PM8280_{1/2} ADC_TM5 channels
Message-ID: <Y2Om1N8X/Qkr9rYI@hovoldconsulting.com>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
 <20221103095810.64606-12-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103095810.64606-12-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:28:09PM +0530, Manivannan Sadhasivam wrote:
> Add ADC_TM5 channels of PM8280_{1/2} for monitoring the temperature from
> external thermistors connected to AMUX pins. The temperature measurements
> are collected from the PMK8280's VADC channels that expose the
> measurements from secondary PMICs PM8280_{1/2}.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 7677fe5cf28e..bdaacf1abf9f 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -254,6 +254,74 @@ pmic-die-temp@403 {
>  	};
>  };
>  
> +&pmk8280_adc_tm {

Please try to keep the nodes sorted alphabetically (e.g. this one should
go before &pmk8280_pon_pwrkey).

Johan
