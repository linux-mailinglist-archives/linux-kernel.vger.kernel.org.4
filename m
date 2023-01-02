Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5965B3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjABPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjABPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B825D6;
        Mon,  2 Jan 2023 07:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80E660CEB;
        Mon,  2 Jan 2023 15:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3EEC433F1;
        Mon,  2 Jan 2023 15:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672672022;
        bh=NElXGm6hHy6K17n7JxUOZurHu/PkYIWVK3rpp2A5LMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGJf2GlhoU/N7/K+xRTawCJ/1vPblYadcHWbuVkpco2hZ1ZfKwe1TgXSj0R0L5paa
         gXG1LTxhw1Accg1+v32qDI/3/0zQPxqjRk89mcHhchxZdp6FpFblqqjlq1oPEt3BJT
         FB0h6cWlrMhsk2ZOfjNHHegwXbIUvPIQ+npxhFQ+RVwExocOd7DQterTkMv5V/97+u
         X07bUHsHLS3q5lff7MKTJ2QY6ProjN+QeL1eNUtwtRiJGd2qjm4eTbxIBNBnke6G7R
         hqBXsFmgF7iUK8ydeJ+an+RVGxHnvH+fr7S/0B6r26fmtbvFqZqcYsDT3En1+SQaH9
         r5QEunDRA1Emw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMPH-0007mK-4b; Mon, 02 Jan 2023 16:07:19 +0100
Date:   Mon, 2 Jan 2023 16:07:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Message-ID: <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
 <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 01:25:38PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 11:50, Johan Hovold wrote:
> > Driver support for the X13s soundcard is not yet in place so disable it
> > for now to avoid probe failures such as:
> > 
> > [   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
> > [   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
> > [   21.221104] platform 3210000.soundwire-controller: deferred probe pending
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 0201c6776746..97ff74d5095e 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -649,6 +649,8 @@ wcd938x: codec {
> >  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> >  		qcom,rx-device = <&wcd_rx>;
> >  		qcom,tx-device = <&wcd_tx>;
> > +
> > +		status = "disabled";
> >  	};
> >  };
> >  
> > @@ -669,6 +671,8 @@ &sound {
> >  		"TX DMIC2", "MIC BIAS3",
> >  		"TX SWR_ADC1", "ADC2_OUTPUT";
> >  
> > +	status = "disabled";
> > +
> >  	wcd-playback-dai-link {
> >  		link-name = "WCD Playback";
> >  		cpu {
> > @@ -731,6 +735,8 @@ codec {
> >  };
> >  
> >  &swr0 {
> > +	status = "disabled";
> > +
> >  	left_spkr: wsa8830-left@0,1 {
> >  		compatible = "sdw10217020200";
> >  		reg = <0 1>;
> > @@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
> >  };
> >  
> >  &swr1 {
> > -	status = "okay";
> > +	status = "disabled";
> >  
> >  	wcd_rx: wcd9380-rx@0,4 {
> >  		compatible = "sdw20217010d00";
> > @@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
> >  };
> >  
> >  &swr2 {
> > -	status = "okay";
> > +	status = "disabled";
> 
> That's a double disable.
> 
> >  
> >  	wcd_tx: wcd9380-tx@0,3 {
> >  		compatible = "sdw20217010d00";
> > @@ -781,6 +787,8 @@ &vamacro {
> >  	pinctrl-names = "default";
> >  	vdd-micb-supply = <&vreg_s10b>;
> >  	qcom,dmic-sample-rate = <600000>;
> > +
> > +	status = "disabled";
> 
> That's a double disable.

Yes, that's on purpose. We're temporarily disabling these nodes instead
of reverting the series which should not have been merged.

Once we have driver support, these properties will be updated again.

Johan
