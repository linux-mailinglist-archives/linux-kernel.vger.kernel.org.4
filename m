Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9BC65B426
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjABPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjABPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:24:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE3281;
        Mon,  2 Jan 2023 07:24:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0AD4B80D6E;
        Mon,  2 Jan 2023 15:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D95CC433F2;
        Mon,  2 Jan 2023 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672673065;
        bh=z2wbo0BYckjYxNRJK+DmkViPPIIVjWYOXOZGUJRF1YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rg8Q9tMPmK36pMExhsoGtsRmKepv9ptteyNso4nfGNSa9Z9eLGgZ6W1FIj0rn5+Bg
         vsqet2e8WFCK3OLemwJ47qHk1XhmKmg5JJg17c8FFE8wHHbNkHha57jsznkyOqt+Qh
         Kv2KwmqxtiQoFBnC0pldM99XRwFtFWmfSZ+Whn2L1W9LzPUFETJqvLo1/Mb/iaDubQ
         1qVyMWDTuHnSpkYfc9BE1hAV3XIJjLEroNGkbghqYH5ve/UcQglKKxbjIYpsBliyjk
         Y6stFTqgesFlq2ZrRWtE5XEHylvulyd+4sKr+VaeL8wi+uwTy0mM/pMcQ/VUPJfM54
         bE/UntAJpWOZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pCMg5-000813-Uf; Mon, 02 Jan 2023 16:24:42 +0100
Date:   Mon, 2 Jan 2023 16:24:41 +0100
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
Message-ID: <Y7L3OTs/u8FsH8o2@hovoldconsulting.com>
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
 <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
 <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
 <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:12:35PM +0100, Krzysztof Kozlowski wrote:
> On 02/01/2023 16:07, Johan Hovold wrote:
> > On Mon, Jan 02, 2023 at 01:25:38PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/01/2023 11:50, Johan Hovold wrote:
> >>> Driver support for the X13s soundcard is not yet in place so disable it
> >>> for now to avoid probe failures such as:
> >>>
> >>> [   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
> >>> [   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
> >>> [   21.221104] platform 3210000.soundwire-controller: deferred probe pending
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
> >>>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >>> index 0201c6776746..97ff74d5095e 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> >>> @@ -649,6 +649,8 @@ wcd938x: codec {
> >>>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> >>>  		qcom,rx-device = <&wcd_rx>;
> >>>  		qcom,tx-device = <&wcd_tx>;
> >>> +
> >>> +		status = "disabled";
> >>>  	};
> >>>  };
> >>>  
> >>> @@ -669,6 +671,8 @@ &sound {
> >>>  		"TX DMIC2", "MIC BIAS3",
> >>>  		"TX SWR_ADC1", "ADC2_OUTPUT";
> >>>  
> >>> +	status = "disabled";
> >>> +
> >>>  	wcd-playback-dai-link {
> >>>  		link-name = "WCD Playback";
> >>>  		cpu {
> >>> @@ -731,6 +735,8 @@ codec {
> >>>  };
> >>>  
> >>>  &swr0 {
> >>> +	status = "disabled";
> >>> +
> >>>  	left_spkr: wsa8830-left@0,1 {
> >>>  		compatible = "sdw10217020200";
> >>>  		reg = <0 1>;
> >>> @@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
> >>>  };
> >>>  
> >>>  &swr1 {
> >>> -	status = "okay";
> >>> +	status = "disabled";
> >>>  
> >>>  	wcd_rx: wcd9380-rx@0,4 {
> >>>  		compatible = "sdw20217010d00";
> >>> @@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
> >>>  };
> >>>  
> >>>  &swr2 {
> >>> -	status = "okay";
> >>> +	status = "disabled";
> >>
> >> That's a double disable.
> >>
> >>>  
> >>>  	wcd_tx: wcd9380-tx@0,3 {
> >>>  		compatible = "sdw20217010d00";
> >>> @@ -781,6 +787,8 @@ &vamacro {
> >>>  	pinctrl-names = "default";
> >>>  	vdd-micb-supply = <&vreg_s10b>;
> >>>  	qcom,dmic-sample-rate = <600000>;
> >>> +
> >>> +	status = "disabled";
> >>
> >> That's a double disable.
> > 
> > Yes, that's on purpose. We're temporarily disabling these nodes instead
> > of reverting the series which should not have been merged.
> 
> I don't get why disabling something twice is anyhow related to
> "temporarily disable". One disable is enough for temporary or permanent
> disables.

It clearly shows that this was done on purpose and indicates which
properties need to be changed to "okay" once we have actual support.
 
> > 
> > Once we have driver support, these properties will be updated again.
> 
> Linux kernel is not the only consumer of DTS, thus having or not having
> the support in the kernel is not reason to disable pieces of it.
> Assuming the DTS is correct, of course, because maybe that's the problem?

Okay, let's revert these sound dts changes then until we have support.
We have no idea if the dts changes are correct as sound still depends
on out-of-tree hacks.

People are using -next for development and I don't want to see them
toast their speakers because we failed get the dependencies merged
before merging the dts changes which is how we normally do this.

So shall I just send a revert instead? I really don't care as long as
this is disabled again today.

Johan
