Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD361E047
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 05:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKFEf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFEf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 00:35:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1171641D;
        Sat,  5 Nov 2022 21:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F9E60BED;
        Sun,  6 Nov 2022 04:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E2AC433C1;
        Sun,  6 Nov 2022 04:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667709354;
        bh=kOngOvfZxwx9QxOuj1TrIm7cT3qvXl/KFNkdQIS7quI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRQEknKdx47ZVpK/iFTkqLOh0c9+4+dtd0GcrZwVYX4WP2QSyunnkONg9JH/JoJzO
         1cCVwZ2E4wE1bQxmX1JBVkAGGS2ZQUHl3xMuvtUypH0os03N2RdTwus2838GLWTww5
         e+mhYggFpiGAYVKxUQ3slDooeAzB24qGTMq95NELb8NBZhgzZBaH2+6H4Hz+m6F20k
         psrpV4nSwpq8KOqQWpkArcsNhUNP1ikCb4Rfs8ALmj5WjrhySQ1pUnMiS9yIFCO84m
         jwKfayvED/lXhiMHy0jr9AR0TcNuoqBI6w6v62VnaEUs1t+/ir+F0NJ2irYbaOzUel
         qjjKvGqZSCL0A==
Date:   Sat, 5 Nov 2022 23:35:52 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sc8280xp-x13s: Add
 PM8280_{1/2} ADC_TM5 channels
Message-ID: <20221106043552.f5vrtpzd3en2lauc@builder.lan>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
 <20221103095810.64606-12-manivannan.sadhasivam@linaro.org>
 <Y2Om1N8X/Qkr9rYI@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Om1N8X/Qkr9rYI@hovoldconsulting.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:32:36PM +0100, Johan Hovold wrote:
> On Thu, Nov 03, 2022 at 03:28:09PM +0530, Manivannan Sadhasivam wrote:
> > Add ADC_TM5 channels of PM8280_{1/2} for monitoring the temperature from
> > external thermistors connected to AMUX pins. The temperature measurements
> > are collected from the PMK8280's VADC channels that expose the
> > measurements from secondary PMICs PM8280_{1/2}.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 7677fe5cf28e..bdaacf1abf9f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -254,6 +254,74 @@ pmic-die-temp@403 {
> >  	};
> >  };
> >  
> > +&pmk8280_adc_tm {
> 
> Please try to keep the nodes sorted alphabetically (e.g. this one should
> go before &pmk8280_pon_pwrkey).
> 

Thanks for spotting that, I fixed up the order.

Regards,
Bjorn
